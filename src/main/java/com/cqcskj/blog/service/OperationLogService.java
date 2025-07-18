package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.OperationLog;
import com.cqcskj.blog.rs.ResultDeal;

public interface OperationLogService extends IService<OperationLog> {
    void insertOperationLogService(OperationLog operationLog);

    ResultDeal getLogService(String operationType);
}
