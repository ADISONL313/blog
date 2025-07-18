package com.cqcskj.blog.config;

import lombok.Getter;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@Getter
@Component
public class NotificationHandler extends TextWebSocketHandler {
    private final ConcurrentHashMap<String, WebSocketSession> sessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 从URL参数获取用户ID（需在前端连接时携带）
        String userId = session.getUri().getQuery().split("=")[1];
        if (sessions.containsKey(userId)) {
            System.err.println("警告: 用户 " + userId + " 已经连接，尝试关闭旧连接");
            try {
                sessions.get(userId).close();
            } catch (IOException e) {
                System.err.println("关闭用户 " + userId + " 的旧连接时出错: " + e.getMessage());
            }
        }
        sessions.put(userId, session);
        System.out.println("用户 " + userId + " 已连接");
        System.out.println("存储的 userId: " + userId);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 处理客户端发送的消息（可选）
        String payload = message.getPayload();
        System.out.println("收到消息: " + payload);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 移除断开的会话
        String userIdToRemove = null;
        for (String userId : sessions.keySet()) {
            if (sessions.get(userId).getId().equals(session.getId())) {
                userIdToRemove = userId;
                break;
            }
        }
        if (userIdToRemove != null) {
            sessions.remove(userIdToRemove);
        }
        System.out.println("会话已关闭: " + status);
    }

    // 向特定用户发送消息
    public void sendNotification(String userId, String message) {
        WebSocketSession session = sessions.get(userId);
        if (session != null && session.isOpen()) {
            try {
                System.out.println("正在向用户 " + userId + " 发送消息: " + message);
                session.sendMessage(new TextMessage(message));
            } catch (IOException e) {
                System.err.println("向用户 " + userId + " 发送消息时出错: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.err.println("用户 " + userId + " 的会话未找到或已关闭");
        }
    }
}