package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.OperationLog;
import com.cqcskj.blog.mapper.OperationLogMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.OperationLogService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OperationLogServiceImpl extends ServiceImpl<OperationLogMapper, OperationLog>implements OperationLogService {
    @Resource
    private OperationLogMapper operationLogMapper;
    @Override
    public void insertOperationLogService(OperationLog operationLog){
        operationLogMapper.insert(operationLog);
    }
    @Override
    public ResultDeal getLogService(String operationType){
        QueryWrapper<OperationLog> queryWrapper=new QueryWrapper<>();
        if(operationType!=null&& !operationType.isEmpty()){
            queryWrapper.like("operation_type",operationType);
        }
        List<OperationLog> operationLogList= operationLogMapper.selectList(queryWrapper);
        return ResultDeal.success(operationLogList);
    }
}
