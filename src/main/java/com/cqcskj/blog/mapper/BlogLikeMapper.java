package com.cqcskj.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqcskj.blog.entity.BlogLike;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BlogLikeMapper extends BaseMapper<BlogLike> {
    List getBlogLikesMapper(@Param("mail")String mail,@Param("blogId")String blogId);
}
