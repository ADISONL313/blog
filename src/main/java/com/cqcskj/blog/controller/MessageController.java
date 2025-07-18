package com.cqcskj.blog.controller;

import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.MessageService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog/message")
public class MessageController {
    @Resource
    private MessageService messageService;
    @GetMapping("/getMessage")
    public ResultDeal getMessageAPI(@RequestParam("receiverEmail")String receiverEmail,@RequestParam(value = "messageType",required = false)String messageType){
        return messageService.getMessageService(receiverEmail,messageType);
    }
    @GetMapping("/readMessage")
    public ResultDeal readMessageAPI(@RequestParam("messageId")String messageId){
        return messageService.readMessageService(messageId);
    }
    @DeleteMapping("/deleteMessage")
    public ResultDeal deleteMessageAPI(@RequestParam("messageId")String messageId){
        return messageService.deleteMessageService(messageId);
    }
}
