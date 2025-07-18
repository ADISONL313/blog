package com.cqcskj.blog.controller;
import com.cqcskj.blog.entity.BlogComment;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogCommentService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog/blogComment")
public class BlogCommentController {
    @Resource
    private BlogCommentService blogCommentService;
    @PostMapping("/sendBlogComment")
    public ResultDeal sendBlogCommentAPI(@RequestBody BlogComment blogComment){
        return blogCommentService.sendBlogCommentService(blogComment);
    }
    @PostMapping("/answerComment")
    public ResultDeal answerCommentAPI(@RequestBody BlogComment blogComment){
        return blogCommentService.answerCommentService(blogComment);
    }
    @GetMapping("/getComment")
    public ResultDeal getCommentAPI(@RequestParam(value = "blogId",required = false)String blogId,@RequestParam(value = "mail",required = false)String mail){
        return blogCommentService.getComment(blogId,mail);
    }
    @DeleteMapping("/deleteComment")
    public ResultDeal deleteCommentAPI(@RequestParam("commentId")String commentId,@RequestParam("mail")String mail){
        return blogCommentService.deleteCommentService(commentId,mail);
    }
}
