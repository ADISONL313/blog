package com.cqcskj.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName("blog_tag")

public class BlogTag {
    @TableId("blog_tag_id")
    private String BlogTagId;
    private String blogId;
    private String tagId;
}
