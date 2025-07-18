package com.cqcskj.blog.controller;

import com.cqcskj.blog.entity.User;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.UserService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/blog/user")
public class UserController {
    @Resource
    private UserService userService;
    @PostMapping("/signUp")
    public ResultDeal UserSignUpAPI(@RequestBody User user){
        return userService.userSignUpService(user);
    }
    @PostMapping("/signIn")
    public ResultDeal UserSignInAPI(@RequestBody User user){
        return userService.userSignInService(user);
    }
    @PostMapping("/getUser")
    public ResultDeal getUserAPI(@RequestBody User user){
        return userService.getUserService(user);
    }
    @PostMapping("/updatePersonalInfo")
    public ResultDeal updatePersonalInfoAPI(@RequestParam(value = "file",required = false)MultipartFile multipartFile, @ModelAttribute User user){
        return userService.updatePersonalInfoService(multipartFile,user);
    }
}
