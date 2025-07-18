package com.cqcskj.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqcskj.blog.entity.BlogComment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BlogCommentMapper extends BaseMapper<BlogComment> {
    List selectCommentsByBlogIdMapper(@Param("blogId") String blogId,@Param("mail")String mail);
}
