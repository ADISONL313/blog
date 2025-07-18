package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.BlogLike;
import com.cqcskj.blog.rs.ResultDeal;

public interface BlogLikeService extends IService<BlogLike> {
    ResultDeal likeBlogService(BlogLike blogLike);

    ResultDeal getBlogLikesService(String mail, String blogId);
}
