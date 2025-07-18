package com.cqcskj.blog.controller;

import com.cqcskj.blog.entity.BlogLike;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogLikeService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog/like")
public class BlogLikeController {
    @Resource
    private BlogLikeService blogLikeService;
    @PostMapping("/likeBlog")
    public ResultDeal likeBlogAPI(@RequestBody BlogLike blogLike){
        return blogLikeService.likeBlogService(blogLike);
    }
    @GetMapping("/getBlogLikes")
    public ResultDeal getBlogLikesService(@RequestParam(value = "mail",required = false)String mail,@RequestParam(value = "blogId",required = false)String blogId){
        return blogLikeService.getBlogLikesService(mail,blogId);
    }
}
