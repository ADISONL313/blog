package com.cqcskj.blog.controller;

import com.cqcskj.blog.entity.Blog;
import com.cqcskj.blog.mapper.BlogMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/blog")
public class BlogController {
    @Resource
    private BlogService blogService;
    @PostMapping("/releaseBlog")
    public ResultDeal releaseBlogAPI(@ModelAttribute Blog blog,@RequestParam("tagList")String tagList){
        return blogService.releaseBlogService(blog,tagList);
    }
    @GetMapping("/getBlog")
    public ResultDeal getBlogAPI(@RequestParam(value = "categoryName",required = false)String categoryName,
                                 @RequestParam(value = "mail",required = false) String mail,
                                 @RequestParam(value = "status",required = false) String status,
                                 @RequestParam(value = "searchKey",required = false) String searchKey,
                                 @RequestParam(value = "outStatus",required = false)String outStatus,
                                 @RequestParam(value = "blogId",required = false)String blogId){

        return blogService.getBlogService(categoryName,mail,status,searchKey,outStatus,blogId);
    }
    @DeleteMapping("/deleteBlog")
    public ResultDeal deleteBlogAPI(@RequestParam("blogId")String blogId,@RequestParam("mail")String mail){
        return blogService.deleteBlogService(blogId,mail);
    }
    @PostMapping("/updateBlog")
    public ResultDeal updateBlogAPI(@ModelAttribute Blog blog,@RequestParam("tagList")String tagList){
        System.out.println(tagList);
        System.out.println(blog);
        return blogService.updateBlogService(blog,tagList);
    }
    @DeleteMapping("/deleteBlogImages")
    public ResultDeal deleteBlogImagesAPI(@RequestParam("fileName")String fileName,@RequestParam("blogId")String blogId){
        return blogService.deleteBlogImagesService(fileName,blogId);
    }
    @PostMapping("/rejectBlog")
    public ResultDeal rejectBlogAPI(@RequestBody Blog blog){
        return blogService.rejectBlogService(blog);
    }
    @PostMapping("/uploadBlogImg")
    public ResultDeal uploadBlogImgAPI(@RequestParam("file")MultipartFile multipartFile,@RequestParam("fileId") String fileId,@RequestParam("mail")String mail){
        return blogService.uploadBlogImgService(multipartFile,fileId,mail);
    }
    @GetMapping("/blogStatusCount")
    public ResultDeal blogStatusCountAPI(){
        return blogService.blogStatusCountService();
    }
}
