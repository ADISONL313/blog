package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.*;
import com.cqcskj.blog.mapper.*;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.CategoryService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category>implements CategoryService {
    @Resource
    private CategoryMapper categoryMapper;
    @Override
    @Transactional
    public ResultDeal addCategoryService(Category category){
        Long tf= categoryMapper.selectCount(new QueryWrapper<Category>().eq("name",category.getName()));
        if(tf>0){
            return ResultDeal.error("标签已存在");
        }else {
            category.setCategoryId(UUID.randomUUID().toString());
            int i=categoryMapper.insert(category);
            if(i==0){
                return ResultDeal.error("添加失败");
            }else {
                return ResultDeal.success();
            }
        }
    }
    @Override
    public ResultDeal getCategoryService(String name){
        QueryWrapper queryWrapper=new QueryWrapper();
        if(!name.isEmpty()){
            queryWrapper.like("name",name);
        }
        List<Category> categoryList= categoryMapper.selectList(queryWrapper);
        return ResultDeal.success(categoryList);
    }
    @Override
    @Transactional
    public ResultDeal selectCategoriesWithBlogCountService(String name){
        List list= categoryMapper.selectCategoriesWithBlogCountMapper(name);
        return ResultDeal.success(list);
    }
    @Override
    @Transactional
    public ResultDeal updateCategoryService(Category category){
        Category thisCategory= categoryMapper.selectOne(new QueryWrapper<Category>().eq("name",category.getName()));
        if(thisCategory!=null){
            if(category.getCategoryId().equals(thisCategory.getCategoryId())){
                int tf=categoryMapper.updateById(category);
                if(tf==0){
                    return ResultDeal.error("修改失败");
                }else {
                    return ResultDeal.success();
                }
            }else {
                return ResultDeal.error("标签名已存在");
            }
        }else {
            int tf=categoryMapper.updateById(category);
            if(tf==0){
                return ResultDeal.error("修改失败");
            }else {
                return ResultDeal.success();
            }
        }
    }
    @Resource
    private BlogMapper blogMapper;
    @Resource
    private BlogCommentMapper blogCommentMapper;
    @Resource
    BlogTagMapper blogTagMapper;
    @Resource
    private BlogViewRecordMapper blogViewRecordMapper;
    @Override
    @Transactional
    public ResultDeal delCategoryService(String categoryId) {
        List<Blog> blogList = blogMapper.selectList(new QueryWrapper<Blog>().eq("category_id", categoryId));
        // 修复：增加列表非空检查
        if (blogList != null && !blogList.isEmpty()) {
            for (Blog blog : blogList) {
                // 递归删除评论，修复参数传递
                deleteCommentsRecursively(null, blog.getBlogId());

                // 删除浏览记录
                blogViewRecordMapper.delete(new QueryWrapper<BlogViewRecord>().eq("blog_id", blog.getBlogId()));

                // 删除博客标签关联
                List<BlogTag> blogTagList = blogTagMapper.selectList(new QueryWrapper<BlogTag>().eq("blog_id", blog.getBlogId()));
                blogTagMapper.deleteByIds(blogTagList);
            }
            // 删除博客
            blogMapper.deleteByIds(blogList);
        }

        // 删除分类
        int rows = categoryMapper.deleteById(categoryId);
        if (rows == 0) {
            return ResultDeal.error("删除失败，分类不存在");
        } else {
            return ResultDeal.success();
        }
    }

    private void deleteCommentsRecursively(String parentCommentId, String blogId) {
        QueryWrapper<BlogComment> queryWrapper = new QueryWrapper<>();
        // 确保每次查询都限定blogId
        queryWrapper.eq("blog_id", blogId);

        if (parentCommentId != null) {
            // 查询指定父评论下的子评论
            queryWrapper.eq("parent_comment_id", parentCommentId);
        } else {
            // 查询该博客下的根评论
            queryWrapper.isNull("parent_comment_id");
        }

        List<BlogComment> comments = blogCommentMapper.selectList(queryWrapper);
        for (BlogComment comment : comments) {
            // 修复：递归调用时传递正确的blogId
            deleteCommentsRecursively(comment.getCommentId(), blogId);
            // 删除当前评论
            blogCommentMapper.deleteById(comment.getCommentId());
        }
    }
}
