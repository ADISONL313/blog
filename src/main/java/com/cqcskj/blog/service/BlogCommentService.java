package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.BlogComment;
import com.cqcskj.blog.rs.ResultDeal;

public interface BlogCommentService extends IService<BlogComment> {
    ResultDeal sendBlogCommentService(BlogComment blogComment);

    ResultDeal answerCommentService(BlogComment blogComment);

    ResultDeal getComment(String blogId,String mail);

    ResultDeal deleteCommentService(String commentId,String mail);
}
