package com.cqcskj.blog.controller;

import com.cqcskj.blog.entity.Category;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.CategoryService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog/category")
public class    CategoryController {
    @Resource
    private CategoryService categoryService;
    @PostMapping("/addCategory")
    public ResultDeal addCategoryAPI(@RequestBody Category category){
        return categoryService.addCategoryService(category);
    }
    @GetMapping("/getCategory")
    public ResultDeal getCategoryAPI(@RequestParam(value = "name",required = false)String name){
        return categoryService.getCategoryService(name);
    }
    @GetMapping("/countCategory")
    public ResultDeal selectCategoriesWithBlogAPI(@RequestParam(value = "name",required = false)String name){
        return categoryService.selectCategoriesWithBlogCountService(name);
    }
    @PostMapping("/updateCategory")
    public ResultDeal updateCategoryAPI(@RequestBody Category category){
        return categoryService.updateCategoryService(category);
    }
    @DeleteMapping("/delCategory")
    public ResultDeal delCategoryAPI(@RequestParam("categoryId")String categoryId){
        return categoryService.delCategoryService(categoryId);
    }
}
