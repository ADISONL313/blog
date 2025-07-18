package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.Blog;
import com.cqcskj.blog.rs.ResultDeal;
import org.springframework.web.multipart.MultipartFile;

public interface BlogService extends IService<Blog> {
    ResultDeal releaseBlogService(Blog blog,String TagJSONString);

    ResultDeal getBlogService(String categoryName, String mail, String status, String searchKey,String outStatus,String blogId);

    ResultDeal deleteBlogService(String blogId,String mail);

    ResultDeal updateBlogService(Blog blog, String TagJSONString);

    ResultDeal deleteBlogImagesService(String fileName, String blogId);

    ResultDeal rejectBlogService(Blog blog);

    ResultDeal uploadBlogImgService(MultipartFile multipartFile, String fileId,String mail);

    ResultDeal blogStatusCountService();
}
