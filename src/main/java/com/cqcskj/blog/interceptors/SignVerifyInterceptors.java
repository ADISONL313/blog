package com.cqcskj.blog.interceptors;

import com.cqcskj.blog.utils.JWTUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import java.util.Map;
@Component
public class SignVerifyInterceptors implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String token=request.getHeader("Authorization");
        System.out.println(token);
        System.out.println(request.getMethod());
        if (HttpMethod.OPTIONS.toString().equals(request.getMethod())) {
            return true;
        }
        try {
            Map<String, Object> map = JWTUtil.verifyToken(token);
            return true;
        } catch (Exception e) {
            response.setStatus(401);
            return false;
        }
    }
}
