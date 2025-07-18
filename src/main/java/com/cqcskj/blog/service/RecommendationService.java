package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cqcskj.blog.entity.Blog;
import com.cqcskj.blog.entity.BlogLike;
import com.cqcskj.blog.mapper.*;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

//智能推荐（系统过滤，redis收集用户行为）
@Service
public class RecommendationService {
    @Resource
    private BlogMapper blogMapper;
    @Resource
    private BlogLikeMapper blogLikeMapper;
    @Resource
    private BlogCommentMapper blogCommentMapper;
    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    @Resource
    private CategoryMapper categoryMapper;
    @Resource
    private TagMapper tagMapper;
    private List<String> getUserInterestsFromCache(String userMail) {
        String key = "user_interests:" + userMail;
        // 使用 Redis 的 ZRANGE 命令获取所有标签（按分数从低到高排序）
        Set<String> tags = redisTemplate.opsForZSet()
                .range(key, 0, -1)
                .stream()
                .map(obj -> (String) obj)
                .collect(Collectors.toSet());

        // 添加日志输出，检查Redis获取的数据
        System.out.println("User interests from Redis for " + userMail + ": " + tags);

        return tags != null ? new ArrayList<>(tags) : Collections.emptyList();
    }

    public List<Map<String, Object>> getPersonalizedRecommendations(String userMail) {
        List<String> userInterests = getUserInterestsFromCache(userMail); // 从Redis获取兴趣标签
        Map<String, Object> params = new HashMap<>();

        // 条件1：匹配兴趣标签或分类
        if (!userInterests.isEmpty()) {
            params.put("searchKey", String.join("|", userInterests));
        }

        // 条件2：排除用户已点赞的博客（可选，避免重复推荐）
        List<String> likedBlogIds = blogLikeMapper.selectList(
                new QueryWrapper<BlogLike>().eq("mail", userMail)
        ).stream().map(BlogLike::getBlogId).collect(Collectors.toList());
        if (!likedBlogIds.isEmpty()) {
            params.put("excludeBlogIds", likedBlogIds);
        }

        // 排序：热度优先（点赞数+浏览量）
        params.put("orderBy", "b.likes DESC, b.views ASC");

        List<Map<String, Object>> result = blogMapper.recommendBlogMapper(params);

        // 如果没有结果，尝试不排除已点赞的博客
        if (result.isEmpty() && !likedBlogIds.isEmpty()) {
            params.remove("excludeBlogIds");
            result = blogMapper.recommendBlogMapper(params);
        }
    System.out.println(params);
        return result;
    }

    // 2. 更新用户兴趣标签（核心逻辑）
    public void updateUserInterests(String userMail, String blogId) {
        Blog blog = blogMapper.selectById(blogId);
        if (blog == null) return;

        // 获取分类名称
        String categoryName = categoryMapper.selectById(blog.getCategoryId()).getName();
        redisTemplate.opsForZSet().incrementScore("user_interests:" + userMail, categoryName, 1.0);

        // 获取标签名称
        List<String> tagNames = tagMapper.selectTagNamesByBlogId(blogId);
        for (String tagName : tagNames) {
            redisTemplate.opsForZSet().incrementScore("user_interests:" + userMail, tagName, 1.0);
        }
    }

    // 3. 相似内容推荐（基于标签和分类）
    public List<Blog> getSimilarBlogs(String blogId, int count) {
        Blog targetBlog = blogMapper.selectById(blogId);
        if (targetBlog == null) return Collections.emptyList();

        return blogMapper.selectList(new QueryWrapper<Blog>()
                .like("custom_tags", targetBlog.getCustomTags())
                .or()
                .eq("category_id", targetBlog.getCategoryId())
                .ne("blog_id", blogId) // 排除自身
                .last("LIMIT " + count));
    }


    // 辅助方法：根据标签获取分类ID（需根据业务逻辑实现）
    private List<Integer> getCategoryIdsByTags(List<String> tags) {
        // 示例：假设标签和分类通过字典表关联，此处需查询你的业务数据
        return Arrays.asList(1, 2); // 模拟返回分类ID列表
    }
}
