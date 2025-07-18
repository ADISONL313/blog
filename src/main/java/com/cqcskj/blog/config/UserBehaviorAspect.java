package com.cqcskj.blog.config;

import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.RecommendationService;
import jakarta.annotation.Resource;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class UserBehaviorAspect {
    @Resource
    private RecommendationService recommendationService;

    // 监听点赞成功事件
    @AfterReturning(
            pointcut = "execution(* com.cqcskj.blog.service.BlogLikeService.likeBlogService(..))", // 替换为你的点赞服务方法
            returning = "result"
    )
    public void afterLike(JoinPoint joinPoint, Object result) {
        if (result instanceof ResultDeal && ((ResultDeal) result).getCode() == 700) {
            Object[] args = joinPoint.getArgs(); // 确保这里不报错
            if (args.length >= 2 && args[0] instanceof String && args[1] instanceof String) {
                String userMail = (String) args[0];
                String blogId = (String) args[1];
                recommendationService.updateUserInterests(userMail, blogId);
            }
        }
    }

    // 监听评论成功事件（同理）
    @AfterReturning(
            pointcut = "execution(* com.cqcskj.blog.service.BlogCommentService.sendBlogCommentService(..))", // 替换为你的评论服务方法
            returning = "result"
    )
    public void afterComment(JoinPoint joinPoint, Object result) {
        // 类似点赞的处理逻辑，提取userMail和blogId
    }
}
