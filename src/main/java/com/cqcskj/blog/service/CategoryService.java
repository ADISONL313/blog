package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.Category;
import com.cqcskj.blog.rs.ResultDeal;

public interface CategoryService extends IService<Category> {
    ResultDeal addCategoryService(Category category);

    ResultDeal getCategoryService(String name);

    ResultDeal selectCategoriesWithBlogCountService(String name);

    ResultDeal updateCategoryService(Category category);

    ResultDeal delCategoryService(String categoryId);
}
