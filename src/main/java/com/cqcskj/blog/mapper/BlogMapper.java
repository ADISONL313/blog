package com.cqcskj.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqcskj.blog.entity.Blog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface BlogMapper extends BaseMapper<Blog> {
    List getBlogMapper(@Param("categoryName") String categoryName,@Param("mail") String mail,@Param("status") String status,@Param("searchKey") String searchKey,@Param("outStatus")String outStatus,@Param("blogId")String blogId);
    List<Map<String,Object>> recommendBlogMapper(Map<String, Object> params);
}
