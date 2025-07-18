package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.*;
import com.cqcskj.blog.mapper.*;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogService;
import com.cqcskj.blog.utils.EntityToJsonString;
import com.cqcskj.blog.utils.IpUtil;
import com.cqcskj.blog.utils.MinIOUtil;
import com.cqcskj.blog.utils.TimeUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.annotation.Resource;
import org.apache.ibatis.executor.BatchResult;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class BlogServiceImpl extends ServiceImpl<BlogMapper, Blog>implements BlogService {
    @Resource
    private BlogMapper blogMapper;
    @Resource
    private TimeUtil timeUtil;
    @Resource
    private MinIOUtil minIOUtil;
    @Resource
    private BlogTagMapper blogTagMapper;
    @Resource
    private OperationLogMapper operationLogMapper;
    @Override
    public ResultDeal releaseBlogService(Blog blog,String TagJSONString){
        blog.setPublishedAt(null);
        ObjectMapper objectMapper=new ObjectMapper();
        blog.setCreatedAt(timeUtil.getYMDHMS());
        List<BlogTag> blogTagList=new ArrayList<>();
        try {
            blogTagList=((List<Map<String, Object>>)objectMapper.readValue(TagJSONString, List.class))
                    .stream()
                    .map(item -> {
                        BlogTag blogTag = new BlogTag();
                        blogTag.setTagId((String)item.get("tagId"));
                        blogTag.setBlogId(blog.getBlogId());
                        blogTag.setBlogTagId(UUID.randomUUID().toString());
                        return blogTag;
                    })
                    .collect(Collectors.toList());
            int i=blogMapper.insert(blog);
            if(i==0){
                OperationLog operationLog=new OperationLog(
                        UUID.randomUUID().toString(),
                        blog.getMail(),
                        "上传博客",
                        EntityToJsonString.toJson(blog),
                        timeUtil.getYMDHMS(),
                        IpUtil.getLocalIp(),
                        "执行上传博客",
                        "fail",
                        "上传博客失败");
                operationLogMapper.insert(operationLog);
                return ResultDeal.error("上传失败");
            }else {
                operationLogMapper.insert(new OperationLog(
                        UUID.randomUUID().toString(),
                        blog.getMail(),
                        "上传博客",
                        EntityToJsonString.toJson(blog),
                        timeUtil.getYMDHMS(),
                        IpUtil.getLocalIp(),
                        "执行上传博客",
                        "success",
                        "博客上传成功"));
                List<BatchResult> tagTF=blogTagMapper.insert(blogTagList);
                if(tagTF==null){
                    OperationLog operationLog=new OperationLog(
                            UUID.randomUUID().toString(),
                            blog.getMail(),
                            "关联博客与标签",
                            EntityToJsonString.toJson(blogTagList),
                            timeUtil.getYMDHMS(),
                            IpUtil.getLocalIp(),
                            "执行关联博客与标签",
                            "fail",
                            "关联博客与标签失败");
                    operationLogMapper.insert(operationLog);
                    blogMapper.deleteById(blog.getBlogId());
                    return ResultDeal.error("上传失败");
                }else {

                    operationLogMapper.insert(new OperationLog(
                            UUID.randomUUID().toString(),
                            blog.getMail(),
                            "关联博客与标签",
                            EntityToJsonString.toJson(blogTagList),
                            timeUtil.getYMDHMS(),
                            IpUtil.getLocalIp(),
                            "执行关联博客与标签",
                            "success",
                            "关联博客与标签成功"));
                    return ResultDeal.success();
                }

            }
        } catch (Exception e) {
            operationLogMapper.insert(new OperationLog(
                    UUID.randomUUID().toString(),
                    blog.getMail(),
                    "上传博客",
                    EntityToJsonString.toJson(blog),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行上传博客",
                    "success",
                    "执行上传博客失败"));
            return ResultDeal.error("上传失败");
        }
    }
    @Override
    public ResultDeal getBlogService( String categoryName, String mail, String status, String searchKey,String outStatus,String blogId){
        List list= blogMapper.getBlogMapper(categoryName,mail,status,searchKey,outStatus,blogId);
        return ResultDeal.success(list);
    }

    @Resource
    private MessageMapper messageMapper;
    @Resource
    private BlogCommentMapper blogCommentMapper;
    @Resource
    private BlogViewRecordMapper blogViewRecordMapper;
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResultDeal deleteBlogService(String blogId,String mail) {
        try {
            // 1. 删除博客标签关联
            List<BlogTag> blogTagList=blogTagMapper.selectList(new QueryWrapper<BlogTag>().eq("blog_id", blogId));
            blogTagMapper.delete(new QueryWrapper<BlogTag>().eq("blog_id", blogId));
            operationLogMapper.insert(new OperationLog(
                    UUID.randomUUID().toString(),
                    mail,
                    "删除博客标签关联",
                    EntityToJsonString.toJson(blogTagList),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行删除关联",
                    "success",
                    "删除关联成功"));
            // 2. 递归删除评论
            List<BlogComment> blogCommentList=blogCommentMapper.selectList(new QueryWrapper<BlogComment>().eq("blog_id",blogId));

            blogCommentMapper.delete(new QueryWrapper<BlogComment>().eq("blog_id",blogId));

            operationLogMapper.insert(new OperationLog(
                    UUID.randomUUID().toString(),
                    mail,
                    "删除博客评论",
                    blogCommentList.isEmpty() ?"博客无评论":EntityToJsonString.toJson(blogCommentList),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行删除博客评论",
                    "success",
                    "执行删除博客评论成功"));

            blogViewRecordMapper.delete(new QueryWrapper<BlogViewRecord>().eq("blog_id",blogId));
            // 3. 删除 MinIO 文件
            minIOUtil.delFolder("blog", blogId);
            // 4. 删除博客
            Blog blog=blogMapper.selectById(blogId);

            int count = blogMapper.deleteById(blogId);
            if (count == 0) {
                operationLogMapper.insert(new OperationLog(
                        UUID.randomUUID().toString(),
                        mail,
                        "删除博客",
                        EntityToJsonString.toJson(blog),
                        timeUtil.getYMDHMS(),
                        IpUtil.getLocalIp(),
                        "执行删除博客",
                        "fail",
                        "执行删除博客失败"));
                return ResultDeal.error("博客不存在或已删除");
            }
            if(mail.equals("admin")){
                messageMapper.insert(new Message(
                        UUID.randomUUID().toString(),
                        "admin",
                        "管理员删除了您的博客："+blog.getTitle(),
                        "删除",
                        blog.getMail(),
                        timeUtil.getYMDHMS(),
                        false
                ));
            }
            operationLogMapper.insert(new OperationLog(
                    UUID.randomUUID().toString(),
                    mail,
                    "删除博客",
                    EntityToJsonString.toJson(blog),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行删除博客",
                    "success",
                    "执行删除博客成功"));
            return ResultDeal.success();
        } catch (Exception e) {
            // 事务会自动回滚
            return ResultDeal.error("删除失败：" + e.getMessage());
        }
    }

    // 递归删除评论（修正版）
    private void deleteCommentsRecursively(String parentCommentId, String blogId) {
        QueryWrapper<BlogComment> queryWrapper = new QueryWrapper<>();
        if (parentCommentId != null) {
            // 查询子评论
            queryWrapper.eq("parent_comment_id", parentCommentId);
        } else {
            // 查询根评论（顶级评论）
            queryWrapper.eq("blog_id", blogId).isNull("parent_comment_id");
        }

        List<BlogComment> comments = blogCommentMapper.selectList(queryWrapper);
        for (BlogComment comment : comments) {
            // 递归删除子评论
            deleteCommentsRecursively(comment.getCommentId(), null);
            // 删除当前评论
            blogCommentMapper.deleteById(comment.getCommentId());
        }
    }
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResultDeal updateBlogService(Blog blog, String TagJSONString){
        try {
            if(blog.getStatus()==1){
                blog.setPublishedAt(timeUtil.getYMDHMS());
            }
            // 解析标签JSON
            ObjectMapper objectMapper = new ObjectMapper();
            List<BlogTag> blogTagList = ((List<Map<String, Object>>) objectMapper.readValue(TagJSONString, List.class))
                    .stream()
                    .map(item -> {
                        BlogTag blogTag = new BlogTag();
                        blogTag.setTagId((String) item.get("tagId"));
                        blogTag.setBlogId(blog.getBlogId());
                        blogTag.setBlogTagId(UUID.randomUUID().toString());
                        return blogTag;
                    })
                    .collect(Collectors.toList());

            // 删除旧的标签关联
            int deleteCount = blogTagMapper.delete(new QueryWrapper<BlogTag>().eq("blog_id", blog.getBlogId()));
            if (deleteCount == 0) {
                throw new BusinessException("删除关联标签失败");
            }

            // 插入新的标签关联
            List<BatchResult> batchResultList = blogTagMapper.insert(blogTagList);
            if (batchResultList == null) {
                throw new BusinessException("插入新关联标签失败");
            }
            // 更新博客信息
            int updateCount = blogMapper.updateById(blog);
            if (updateCount == 0) {
                operationLogMapper.insert(new OperationLog(
                        UUID.randomUUID().toString(),
                        blog.getMail(),
                        "修改博客",
                        EntityToJsonString.toJson(blog),
                        timeUtil.getYMDHMS(),
                        IpUtil.getLocalIp(),
                        "执行博客修改",
                        "fail",
                        "执行修改博客失败"));
                throw new BusinessException("修改博客内容失败");
            }
            if(blog.getStatus()==1){
                messageMapper.insert(new Message(
                        UUID.randomUUID().toString(),
                        "admin",
                        "管理员通过了您的博客："+blog.getTitle(),
                        "通过",
                        blog.getMail(),
                        timeUtil.getYMDHMS(),
                        false
                ));
            }
            operationLogMapper.insert(new OperationLog(
                    UUID.randomUUID().toString(),
                    blog.getMail(),
                    "修改博客",
                    EntityToJsonString.toJson(blog),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行博客修改",
                    "success",
                    "执行修改博客成功"));
            return ResultDeal.success();
        } catch (BusinessException e) {
            // 回滚事务
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultDeal.error(e.getMessage());
        } catch (Exception e) {
            operationLogMapper.insert(new OperationLog(
                    UUID.randomUUID().toString(),
                    blog.getMail(),
                    "修改博客",
                    EntityToJsonString.toJson(blog),
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行博客修改",
                    "fail",
                    "执行修改博客失败"));
            // 回滚事务
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultDeal.error("上传失败");
        }

    }
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResultDeal deleteBlogImagesService(String fileName, String blogId){
        try {
            boolean tf= minIOUtil.deleteFile("blog",blogId+'/'+fileName);
            if(!tf){
                throw new BusinessException("删除文件失败");
            }
            Blog blog=new Blog();
            blog=blogMapper.selectById(blogId);
            if(blog==null){
                throw new BusinessException("查询blog事变");
            }
            blog.setImages(blog.getImages().replace(fileName+";",""));
            int i=blogMapper.updateById(blog);
            if(i==0){
                throw new BusinessException("更新文件名失败");
            }
            return ResultDeal.success();
        }catch (Exception e){
            // 回滚事务
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultDeal.error("删除失败");
        }

    }
    @Override
    public ResultDeal rejectBlogService(Blog blog){
        Blog one=blogMapper.selectById(blog.getBlogId());
        int i=blogMapper.update(new UpdateWrapper<Blog>().set("reject_reason",blog.getRejectReason()).set("status",2).eq("blog_id",blog.getBlogId()));
        if(i==0){
            return ResultDeal.error("驳回失败");
        }else {
            if(one!=null){
                messageMapper.insert(new Message(
                        UUID.randomUUID().toString(),
                        "admin",
                        "管理员驳回了您的博客："+blog.getTitle(),
                        "驳回",
                        one.getMail(),
                        timeUtil.getYMDHMS(),
                        false
                ));
            }
            return ResultDeal.success();
        }
    }
    public static class BusinessException extends RuntimeException {
        public BusinessException(String message) {
            super(message);
        }
    }
    @Override
    public ResultDeal uploadBlogImgService(MultipartFile multipartFile, String fileId,String mail){
        String fileName= minIOUtil.uploadFile(multipartFile,"blog",fileId);
        if(fileName.equals("错误")){
            operationLogMapper.insert(new OperationLog(
                    UUID.randomUUID().toString(),
                    mail,
                    "上传博客图片",
                    fileName,
                    timeUtil.getYMDHMS(),
                    IpUtil.getLocalIp(),
                    "执行上传",
                    "fail",
                    "执行上传失败"));
            return ResultDeal.error(fileName);
        }else {
            operationLogMapper.insert(new OperationLog(
                UUID.randomUUID().toString(),
                mail,
                "上传博客图片",
                fileName,
                timeUtil.getYMDHMS(),
                IpUtil.getLocalIp(),
                "执行上传",
                "success",
                "执行上传成功"));
            return ResultDeal.success("http://47.108.29.91:9000/blog/"+fileId+'/'+fileName);
        }
    }
    @Resource
    private UserMapper userMapper;
    @Override
    public ResultDeal blogStatusCountService(){
        Long a= blogMapper.selectCount(new QueryWrapper<Blog>().eq("status",0));
        Long b= blogMapper.selectCount(new QueryWrapper<Blog>().eq("status",1));
        Long c= blogMapper.selectCount(new QueryWrapper<Blog>().eq("status",2));
        Long d= blogMapper.selectCount(new QueryWrapper<Blog>().eq("status",3));
        Map<String,Object> map=new HashMap<>();
        map.put("waitPass",a);
        map.put("passed",b);
        map.put("unPass",c);
        map.put("caogao",d);
        return ResultDeal.success(map);
    }
}
