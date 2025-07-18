package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.Tag;
import com.cqcskj.blog.rs.ResultDeal;

public interface TagService extends IService<Tag> {
    ResultDeal addTagService(Tag tag);

    ResultDeal getTagService(String name);

    ResultDeal selectTagsWithBlogCountService(String name);

    ResultDeal updateTagService(Tag tag);

    ResultDeal deleteTagService(String tagId);
}
