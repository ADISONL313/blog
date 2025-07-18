package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.Message;
import com.cqcskj.blog.mapper.MessageMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.MessageService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message>implements MessageService {
    @Resource
    private MessageMapper messageMapper;
    @Override
    public ResultDeal getMessageService(String receiverEmail, String messageType){
        QueryWrapper queryWrapper=new QueryWrapper();
        if(messageType!=null&& !messageType.isEmpty()){
            queryWrapper.eq("message_type",messageType);
        }
        queryWrapper.eq("receiver_email",receiverEmail);
        queryWrapper.orderByAsc("is_read");
        queryWrapper.orderByDesc("message_time");
        List<Message> messageList= messageMapper.selectList(queryWrapper);
        return ResultDeal.success(messageList);
    }
    @Override
    public ResultDeal readMessageService(String messageId){
        int i= messageMapper.update(new UpdateWrapper<Message>().set("is_read",true).eq("message_id",messageId));
        if(i==0){
            return ResultDeal.error("已读失败");
        }else {
            return ResultDeal.success();
        }
    }

    @Override
    public ResultDeal deleteMessageService(String messageId){
        int i=messageMapper.deleteById(messageId);
        if(i==0){
            return ResultDeal.error("删除失败");
        }else {
            return ResultDeal.success();
        }
    }
}
