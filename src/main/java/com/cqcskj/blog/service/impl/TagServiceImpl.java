package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.BlogTag;
import com.cqcskj.blog.entity.Tag;
import com.cqcskj.blog.mapper.BlogTagMapper;
import com.cqcskj.blog.mapper.TagMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.TagService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class TagServiceImpl extends ServiceImpl<TagMapper, Tag>implements TagService {
    @Resource
    private TagMapper tagMapper;
    @Override
    public ResultDeal addTagService(Tag tag){
        Long i= tagMapper.selectCount(new QueryWrapper<Tag>().eq("name",tag.getName()));
        if(i==0){
            tag.setTagId(UUID.randomUUID().toString());
            int tf= tagMapper.insert(tag);
            if(tf==1){
                return ResultDeal.success();
            }else {
                return ResultDeal.error("添加失败");
            }
        }else {
            return ResultDeal.error("标签已存在");
        }
    }
    @Override
    public ResultDeal getTagService(String name){
        QueryWrapper queryWrapper=new QueryWrapper();
        if(!name.isEmpty()){
            queryWrapper.like("name",name);
        }
        List<Tag> tagList= tagMapper.selectList(queryWrapper);
        return ResultDeal.success(tagList);
    }
    @Override
    public ResultDeal selectTagsWithBlogCountService(String name){
        List list= tagMapper.selectTagsWithBlogCountMapper(name);
        return ResultDeal.success(list);
    }
    @Override
    public ResultDeal updateTagService(Tag tag){
        Tag thisTag= tagMapper.selectOne(new QueryWrapper<Tag>().eq("name",tag.getName()));
        if(thisTag!=null){
            if(tag.getTagId().equals(thisTag.getTagId())){
                int i= tagMapper.updateById(tag);
                if(i==0){
                    return ResultDeal.error("修改失败");
                }else {
                    return ResultDeal.success();
                }
            }else {
                return ResultDeal.error("标签已存在");
            }
        }else {
            int i= tagMapper.updateById(tag);
            if(i==0){
                return ResultDeal.error("修改失败");
            }else {
                return ResultDeal.success();
            }
        }
    }
    @Resource
    private BlogTagMapper blogTagMapper;
    @Override
    public ResultDeal deleteTagService(String tagId){
        blogTagMapper.delete(new QueryWrapper<BlogTag>().eq("tag_id",tagId));
        int i=tagMapper.deleteById(tagId);
        if(i==0){
            return ResultDeal.error("删除失败");
        }else {
            return ResultDeal.success();
        }
    }
}
