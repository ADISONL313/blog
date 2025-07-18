package com.cqcskj.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName("operation_log")
public class OperationLog {

    /**
     * 操作 ID，作为主键
     */
    @TableId("operation_id")
    private String operationId;

    /**
     * 外键，关联 user 表的 mail 字段
     */
    private String mail;

    /**
     * 操作类型
     */
    private String operationType;

    /**
     * 操作数据
     */
    private String operationData;

    /**
     * 操作时间
     */
    private String operationTime;

    /**
     * 操作 IP
     */
    private String operationIp;

    /**
     * 操作描述
     */
    private String operationDescription;

    /**
     * 操作结果，使用枚举类型，这里简单用字符串表示 'success' 或 'fail'
     */
    private String operationResult;

    /**
     * 错误信息
     */
    private String errorMessage;

}
