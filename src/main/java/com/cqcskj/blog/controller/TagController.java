package com.cqcskj.blog.controller;

import com.cqcskj.blog.entity.Tag;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.TagService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog/tag")
public class TagController {
    @Resource
    private TagService tagService;

    @PostMapping("/addTag")
    public ResultDeal addTagAPI(@RequestBody Tag tag){
        return tagService.addTagService(tag);
    }
    @GetMapping("/getTag")
    public ResultDeal getTagAPI(@RequestParam("name")String name){
        return tagService.getTagService(name);
    }
    @GetMapping("/countTag")
    public ResultDeal selectTagsWithBlogCountAPI(@RequestParam(value = "name",required = false)String name){
        return tagService.selectTagsWithBlogCountService(name);
    }
    @PostMapping("/updateTag")
    public ResultDeal updateTagAPI(@RequestBody Tag tag){
        return tagService.updateTagService(tag);
    }
    @DeleteMapping("/deleteTag")
    public ResultDeal deleteTagAPI(@RequestParam("tagId")String tagId){
        return tagService.deleteTagService(tagId);
    }
}
