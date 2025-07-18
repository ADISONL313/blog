package com.cqcskj.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqcskj.blog.entity.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CategoryMapper extends BaseMapper<Category> {
    List selectCategoriesWithBlogCountMapper(String name);
    @Select("SELECT * FROM category WHERE category_id = #{categoryId}")
    Category selectById(String categoryId);
}
