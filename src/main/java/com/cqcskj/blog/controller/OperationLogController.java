package com.cqcskj.blog.controller;

import com.cqcskj.blog.mapper.OperationLogMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.OperationLogService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/blog/Log")
public class OperationLogController {
    @Resource
    private OperationLogService operationLogService;
    @GetMapping("/getLog")
    public ResultDeal getLogAPI(@RequestParam(value = "operationType",required = false)String operationType){
        System.out.println(operationType);
        return operationLogService.getLogService(operationType);
    }
}
