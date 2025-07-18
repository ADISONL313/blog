package com.cqcskj.blog.controller;

import com.cqcskj.blog.entity.BlogViewRecord;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogViewRecordService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog/blogRecord")
public class BlogViewRecordController {
    @Resource
    private BlogViewRecordService blogViewRecordService;
    @PostMapping("/addBlogViewRecord")
    public ResultDeal addBlogViewRecordAPI(@RequestBody BlogViewRecord blogViewRecord){
        return blogViewRecordService.addBlogViewRecordService(blogViewRecord);
    }
    @GetMapping("/getBlogViewRecord")
    public ResultDeal selectAllViewRecordsAPI(@RequestParam(value = "mail",required = false)String mail){
        return blogViewRecordService.selectAllViewRecordsService(mail);
    }
    @DeleteMapping("/deleteBlogViewRecord")
    public ResultDeal deleteBlogViewRecordAPI(@RequestParam("blogViewRecordId")String blogViewRecordId){
        return blogViewRecordService.deleteBlogViewRecordService(blogViewRecordId);
    }
}
