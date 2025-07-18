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
@TableName("blog_comment")
public class BlogComment {
    @TableId("comment_id")
    private String commentId;
    private String mail;
    private String blogId;
    private String parentCommentId;
    private String content;
    private String commentTime;
}