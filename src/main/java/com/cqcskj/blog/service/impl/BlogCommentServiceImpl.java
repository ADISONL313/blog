package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.Blog;
import com.cqcskj.blog.entity.BlogComment;
import com.cqcskj.blog.entity.Message;
import com.cqcskj.blog.entity.OperationLog;
import com.cqcskj.blog.mapper.BlogCommentMapper;
import com.cqcskj.blog.mapper.BlogMapper;
import com.cqcskj.blog.mapper.MessageMapper;
import com.cqcskj.blog.mapper.OperationLogMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogCommentService;
import com.cqcskj.blog.service.NotificationService;
import com.cqcskj.blog.utils.EntityToJsonString;
import com.cqcskj.blog.utils.IpUtil;
import com.cqcskj.blog.utils.TimeUtil;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class BlogCommentServiceImpl extends ServiceImpl<BlogCommentMapper, BlogComment>implements BlogCommentService {
    @Resource
    private BlogCommentMapper blogCommentMapper;
    @Resource
    private TimeUtil timeUtil;
    @Resource
    private OperationLogMapper operationLogMapper;
    @Resource
    private NotificationService notificationService;
    @Resource
    private BlogMapper blogMapper;
    @Resource
    private MessageMapper messageMapper;
    @Override
    public ResultDeal sendBlogCommentService(BlogComment blogComment){
        blogComment.setCommentId(UUID.randomUUID().toString());
        blogComment.setCommentTime(timeUtil.getYMDHMS());
        int i=blogCommentMapper.insert(blogComment);
        Blog blog=blogMapper.selectById(blogComment.getBlogId());
        if(i==0){
            OperationLog operationLog=new OperationLog(
                    UUID.randomUUID().toString(),
                    blogComment.getMail(),
                    "添加评论",
                    EntityToJsonString.toJson(blogComment),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行添加评论操作",
                    "fail",
                    "评论失败");
            operationLogMapper.insert(operationLog);
            return ResultDeal.error("评论失败");
        }else {
            messageMapper.insert(new Message(
               UUID.randomUUID().toString(),
                    blogComment.getMail(),
                    "用户"+blogComment.getMail()+"评论了您的博客："+blog.getTitle()+"。他说："+blogComment.getContent(),
                    "评论",
                    blog.getMail(),
                    timeUtil.getYMDHMS(),
                    false
            ));
            OperationLog operationLog=new OperationLog(
                    UUID.randomUUID().toString(),
                    blogComment.getMail(),
                    "添加评论",
                    EntityToJsonString.toJson(blogComment),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行添加评论操作",
                    "success",
                    "");
            operationLogMapper.insert(operationLog);
            return ResultDeal.success();
        }
    }
    @Override
    public ResultDeal answerCommentService(BlogComment blogComment){
        blogComment.setCommentId(UUID.randomUUID().toString());
        blogComment.setCommentTime(timeUtil.getYMDHMS());
        int i=blogCommentMapper.insert(blogComment);
        if(i==0){
            return ResultDeal.error("评论失败");
        }else {
            return ResultDeal.success();
        }
    }
    @Override
    public ResultDeal getComment(String blogId,String mail){
        List list=blogCommentMapper.selectCommentsByBlogIdMapper(blogId,mail);
        return ResultDeal.success(list);
    }
    @Override
    public ResultDeal deleteCommentService(String commentId,String mail){
        List<BlogComment> blogCommentList= blogCommentMapper.selectList(new QueryWrapper<BlogComment>().eq("comment_id",commentId).or().eq("parent_comment_id",commentId));

        int i= blogCommentMapper.deleteById(commentId);
        if(i==0){
            OperationLog operationLog=new OperationLog(
                    UUID.randomUUID().toString(),
                    mail,
                    "删除评论",
                    EntityToJsonString.toJson(blogCommentList),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行添加评论操作",
                    "fail",
                    "删除评论失败");
            operationLogMapper.insert(operationLog);
            return ResultDeal.error("删除失败");
        }else {
            OperationLog operationLog=new OperationLog(
                    UUID.randomUUID().toString(),
                    mail,
                    "删除评论",
                    EntityToJsonString.toJson(blogCommentList),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行添加评论操作",
                    "success",
                    "");
            operationLogMapper.insert(operationLog);
            return ResultDeal.success();
        }
    }
}
