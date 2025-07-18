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
@TableName("message")
public class Message {
    @TableId("message_id")
    private String messageId;
    private String senderEmail;
    private String messageContent;
    private String messageType;
    private String receiverEmail;
    private String messageTime;
    private Boolean isRead;
}