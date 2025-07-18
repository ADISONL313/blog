package com.cqcskj.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cqcskj.blog.entity.BlogViewRecord;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BlogViewRecordMapper extends BaseMapper<BlogViewRecord> {
    List selectAllViewRecordsMapper(String mail);
}
