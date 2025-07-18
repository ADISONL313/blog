package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.Blog;
import com.cqcskj.blog.entity.BlogViewRecord;
import com.cqcskj.blog.mapper.BlogMapper;
import com.cqcskj.blog.mapper.BlogViewRecordMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.BlogViewRecordService;
import com.cqcskj.blog.utils.TimeUtil;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.List;
import java.util.UUID;

@Service
public class BlogViewRecordServiceImpl extends ServiceImpl<BlogViewRecordMapper, BlogViewRecord>implements BlogViewRecordService {
    @Resource
    private BlogViewRecordMapper blogViewRecordMapper;
    @Resource
    private TimeUtil timeUtil;
    @Resource
    private BlogMapper blogMapper;
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResultDeal addBlogViewRecordService(BlogViewRecord blogViewRecord){
        try {
            blogViewRecord.setViewTime(timeUtil.getYMDHMS());
            blogViewRecord.setViewRecordId(UUID.randomUUID().toString());
            Long a= blogViewRecordMapper.selectCount(new QueryWrapper<BlogViewRecord>().eq("mail",blogViewRecord.getMail()).eq("blog_id",blogViewRecord.getBlogId()));
            if(a!=0){
                throw new BusinessException("已浏览");
            }
            Blog blog= blogMapper.selectById(blogViewRecord.getBlogId());
            blog.setViews(blog.getViews() +1);
            int b= blogMapper.update(new UpdateWrapper<Blog>().set("views",blog.getViews()).eq("blog_id",blog.getBlogId()));
            if(b==0){
                throw new BusinessException("增加点击量失败");
            }
            int c= blogViewRecordMapper.insert(blogViewRecord);
            if(c==0){
                throw new BusinessException("浏览失败");
            }
            return ResultDeal.success();
        }catch (BlogServiceImpl.BusinessException e) {
            // 回滚事务
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultDeal.error(e.getMessage());
        } catch (Exception e) {
            // 回滚事务
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultDeal.error("失败");
        }
    }

    public static class BusinessException extends RuntimeException {
        public BusinessException(String message) {
            super(message);
        }
    }
    @Override
    public ResultDeal selectAllViewRecordsService(String mail){
        List list= blogViewRecordMapper.selectAllViewRecordsMapper(mail);
        return ResultDeal.success(list);
    }
    @Override
    public ResultDeal deleteBlogViewRecordService(String blogViewRecordId){
        int i= blogViewRecordMapper.deleteById(blogViewRecordId);
        if(i==0){
            return ResultDeal.error("删除失败");
        }else {
            return ResultDeal.success();
        }
    }

}
