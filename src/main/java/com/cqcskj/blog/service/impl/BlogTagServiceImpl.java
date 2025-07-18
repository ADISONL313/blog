package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.BlogTag;
import com.cqcskj.blog.mapper.BlogTagMapper;
import com.cqcskj.blog.service.BlogTagService;
import org.springframework.stereotype.Service;

@Service
public class BlogTagServiceImpl extends ServiceImpl<BlogTagMapper, BlogTag>implements BlogTagService {
}
