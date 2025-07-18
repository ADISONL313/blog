package com.cqcskj.blog.service;

import com.cqcskj.blog.config.NotificationHandler;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {
    @Resource
    private NotificationHandler notificationHandler;

    public void sendCommentNotification(String authorId, String commentContent) {
        String message = "{\"type\":\"comment\",\"content\":\"" + commentContent + "\"}";
        System.out.println("准备发送给用户 " + authorId + " 的消息: " + message); // 添加日志
        System.out.println("当前存储的会话: " + notificationHandler.getSessions().keySet()); // 添加日志
        notificationHandler.sendNotification(authorId, message);
    }
}
