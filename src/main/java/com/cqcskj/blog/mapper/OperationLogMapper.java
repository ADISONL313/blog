package com.cqcskj.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqcskj.blog.entity.OperationLog;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OperationLogMapper extends BaseMapper<OperationLog> {
}
