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
@TableName("blog")
public class Blog {
    @TableId("blog_id")
    private String blogId;
    private String mail;
    private String title;
    private String content;
    private String summary;
    private String categoryId;
    private int status;
    private int views;
    private int likes;
    private int comments;
    private String createdAt;
    private String publishedAt;
    private String customTags;
    private String images;
    private String rejectReason;
}
