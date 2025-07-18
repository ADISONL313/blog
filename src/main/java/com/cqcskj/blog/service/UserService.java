package com.cqcskj.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cqcskj.blog.entity.User;
import com.cqcskj.blog.rs.ResultDeal;
import org.springframework.web.multipart.MultipartFile;

public interface UserService extends IService<User> {
    ResultDeal userSignUpService(User user);

    ResultDeal userSignInService(User user);

    ResultDeal getUserService(User user);

    ResultDeal updatePersonalInfoService(MultipartFile multipartFile, User user);
}
