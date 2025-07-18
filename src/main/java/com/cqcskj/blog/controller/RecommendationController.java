package com.cqcskj.blog.controller;

import com.cqcskj.blog.entity.Blog;
import com.cqcskj.blog.entity.UserBehavior;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.RecommendationService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/blog/recommend")
public class RecommendationController {
    @Resource
    private RecommendationService recommendationService;

    // 获取个性化推荐
    @GetMapping("/personalized")
    public ResultDeal getPersonalized(
            @RequestParam("mail") String userMail
    ) {
        List<Map<String, Object>> list = recommendationService.getPersonalizedRecommendations(userMail);
        return ResultDeal.success(list); // 假设Result是你的统一返回格式
    }

    // 获取相关文章（如博客详情页推荐）
    @GetMapping("/related/{blogId}")
    public ResultDeal getRelated(
            @PathVariable String blogId,
            @RequestParam(defaultValue = "5") int count
    ) {
        List<Blog> list = recommendationService.getSimilarBlogs(blogId, count);
        return ResultDeal.success(list);
    }

    // 记录用户行为（浏览/点赞/评论后调用）
    @PostMapping("/behavior")
    public ResultDeal recordBehavior(@RequestBody UserBehavior behavior) {
        recommendationService.updateUserInterests(behavior.getMail(), behavior.getBlogId());
        return ResultDeal.success();
    }
}
