package com.cqcskj.blog.config;

import com.cqcskj.blog.interceptors.SignVerifyInterceptors;
import jakarta.annotation.Resource;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;
@Configuration
public class InterceptorsConfig implements WebMvcConfigurer {
    @Resource
    private SignVerifyInterceptors signVerifyInterceptors;
    @Override
    public void addInterceptors(InterceptorRegistry interceptorRegistry){
        List<String> list=new ArrayList<>();
        list.add("/blog/user/signUp");
        list.add("/blog/user/signIn");
        list.add("/blog/blogComment/getComment");
        list.add("/blog/getBlog");
        interceptorRegistry.addInterceptor(signVerifyInterceptors).addPathPatterns("/**").excludePathPatterns(list);
    }
}