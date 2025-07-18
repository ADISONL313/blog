package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.Blog;
import com.cqcskj.blog.entity.BlogLike;
import com.cqcskj.blog.entity.Message;
import com.cqcskj.blog.entity.OperationLog;
import com.cqcskj.blog.mapper.BlogLikeMapper;
import com.cqcskj.blog.mapper.BlogMapper;
import com.cqcskj.blog.mapper.MessageMapper;
import com.cqcskj.blog.mapper.OperationLogMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogLikeService;
import com.cqcskj.blog.utils.EntityToJsonString;
import com.cqcskj.blog.utils.IpUtil;
import com.cqcskj.blog.utils.TimeUtil;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class BlogLikeServiceImpl extends ServiceImpl<BlogLikeMapper, BlogLike> implements BlogLikeService {
    @Resource
    private BlogLikeMapper blogLikeMapper;
    @Resource
    private BlogMapper blogMapper;
    @Resource
    private TimeUtil timeUtil;
    @Resource
    private OperationLogMapper operationLogMapper;
    @Resource
    private MessageMapper messageMapper;
    @Override
    public ResultDeal likeBlogService(BlogLike blogLike) {
        // 查询博客是否存在
        Blog blog = blogMapper.selectById(blogLike.getBlogId());
        if (blog == null) {
            return ResultDeal.error("操作失败");
        }

        // 检查用户是否已经喜欢该博客
        BlogLike existingLike = blogLikeMapper.selectOne(
                new QueryWrapper<BlogLike>()
                        .eq("mail", blogLike.getMail())
                        .eq("blog_id", blogLike.getBlogId())
        );

        try {
            if (existingLike != null) {
                // 用户已喜欢，执行取消喜欢操作
                int deleteCount = blogLikeMapper.delete(
                        new QueryWrapper<BlogLike>()
                                .eq("mail", blogLike.getMail())
                                .eq("blog_id", blogLike.getBlogId())
                );
                if (deleteCount == 0) {
                    OperationLog operationLog=new OperationLog(
                            UUID.randomUUID().toString(),
                            blogLike.getMail(),
                            "取消喜欢",
                            EntityToJsonString.toJson(blogLike),
                            timeUtil.getYMDHMS(),
                            IpUtil.getLocalIp(),
                            "执行取消喜欢操作",
                            "fail",
                            "取消喜欢失败");
                    operationLogMapper.insert(operationLog);
                    throw new RuntimeException("取消喜欢失败");
                }

                int updateCount = blogMapper.update(
                        null,
                        new UpdateWrapper<Blog>()
                                .set("likes", blog.getLikes() - 1)
                                .eq("blog_id", blog.getBlogId())
                );
                if (updateCount == 0) {
                    OperationLog operationLog=new OperationLog(
                            UUID.randomUUID().toString(),
                            blogLike.getMail(),
                            "更新点赞数量",
                            EntityToJsonString.toJson(blog),
                            timeUtil.getYMDHMS(),
                            IpUtil.getLocalIp(),
                            "执行更新点赞数量",
                            "fail",
                            "更新博客点赞数失败");
                    operationLogMapper.insert(operationLog);
                    throw new RuntimeException("更新博客点赞数失败");
                }
                OperationLog operationLog=new OperationLog(
                        UUID.randomUUID().toString(),
                        blogLike.getMail(),
                        "取消喜欢",
                        EntityToJsonString.toJson(blog),
                        timeUtil.getYMDHMS(),
                        IpUtil.getLocalIp(),
                        "执行取消喜欢",
                        "success",
                        "取消喜欢成功");
                operationLogMapper.insert(operationLog);
                return ResultDeal.success("取消成功", (blog.getLikes()-1)+"");
            } else {
                // 用户未喜欢，执行喜欢操作
                blogLike.setLikeTime(timeUtil.getYMDHMS());
                blogLike.setLikeId(UUID.randomUUID().toString());

                int insertCount = blogLikeMapper.insert(blogLike);
                if (insertCount == 0) {
                    OperationLog operationLog=new OperationLog(
                            UUID.randomUUID().toString(),
                            blogLike.getMail(),
                            "喜欢博客",
                            EntityToJsonString.toJson(blogLike),
                            timeUtil.getYMDHMS(),
                            IpUtil.getLocalIp(),
                            "执行喜欢",
                            "fail",
                            "喜欢失败");
                    operationLogMapper.insert(operationLog);
                    throw new RuntimeException("喜欢失败");
                }

                int updateCount = blogMapper.update(
                        null,
                        new UpdateWrapper<Blog>()
                                .set("likes", blog.getLikes() + 1)
                                .eq("blog_id", blog.getBlogId())
                );
                if (updateCount == 0) {
                    OperationLog operationLog=new OperationLog(
                            UUID.randomUUID().toString(),
                            blogLike.getMail(),
                            "更新喜欢数量",
                            EntityToJsonString.toJson(blogLike),
                            timeUtil.getYMDHMS(),
                            IpUtil.getLocalIp(),
                            "执行更新喜欢数量",
                            "fail",
                            "更新博客点赞数失败");
                    operationLogMapper.insert(operationLog);
                    throw new RuntimeException("更新博客点赞数失败");
                }
                messageMapper.insert(new Message(
                        UUID.randomUUID().toString(),
                        blogLike.getMail(),
                        "用户"+blogLike.getMail()+"赞了您的博客："+blog.getTitle(),
                        "点赞",
                        blog.getMail(),
                        timeUtil.getYMDHMS(),
                        false
                ));
                OperationLog operationLog=new OperationLog(
                        UUID.randomUUID().toString(),
                        blogLike.getMail(),
                        "更新喜欢数量",
                        EntityToJsonString.toJson(blogLike),
                        timeUtil.getYMDHMS(),
                        IpUtil.getLocalIp(),
                        "执行更新喜欢数量",
                        "success",
                        "喜欢成功");
                operationLogMapper.insert(operationLog);
                return ResultDeal.success("喜欢成功", (blog.getLikes()+1)+"");
            }
        } catch (Exception e) {
            OperationLog operationLog=new OperationLog(
                    UUID.randomUUID().toString(),
                    blogLike.getMail(),
                    "喜欢操作",
                    EntityToJsonString.toJson(blogLike),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行喜欢",
                    "fail",
                    e.toString());
            operationLogMapper.insert(operationLog);
            // 统一异常处理
            return ResultDeal.error(e.getMessage());
        }
    }
    @Override
    public  ResultDeal getBlogLikesService(String mail, String blogId){
        List list= blogLikeMapper.getBlogLikesMapper(mail,blogId);
        return ResultDeal.success(list);
    }
}
