package com.cqcskj.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqcskj.blog.entity.Tag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TagMapper extends BaseMapper<Tag> {
    List selectTagsWithBlogCountMapper(String name);
    @Select("SELECT t.name FROM tag t JOIN blog_tag bt ON t.tag_id = bt.tag_id WHERE bt.blog_id = #{blogId}")
    List<String> selectTagNamesByBlogId(String blogId);
}
