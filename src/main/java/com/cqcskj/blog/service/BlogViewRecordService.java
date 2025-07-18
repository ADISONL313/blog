package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.BlogViewRecord;
import com.cqcskj.blog.rs.ResultDeal;

public interface BlogViewRecordService extends IService<BlogViewRecord> {
    ResultDeal addBlogViewRecordService(BlogViewRecord blogViewRecord);

    ResultDeal selectAllViewRecordsService(String mail);

    ResultDeal deleteBlogViewRecordService(String blogViewRecordId);
}
