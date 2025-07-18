package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.Message;
import com.cqcskj.blog.rs.ResultDeal;

public interface MessageService extends IService<Message> {
    ResultDeal getMessageService(String receiverEmail, String messageType);

    ResultDeal readMessageService(String messageId);

    ResultDeal deleteMessageService(String messageId);
}
