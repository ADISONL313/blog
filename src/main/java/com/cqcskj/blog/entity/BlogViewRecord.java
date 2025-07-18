package com.cqcskj.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName("blog_view_record")
public class BlogViewRecord {
    @TableId("view_record_id")
    private String viewRecordId;
    private String blogId;
    private String mail;
    private String viewTime;
}
