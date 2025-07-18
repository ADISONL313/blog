package com.cqcskj.blog.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Map;
@Component
public class JWTUtil {
    private static final String KEY="BLOG";
    public static String genToken(Map<String,Object> map){
        return JWT.create().withClaim("claims",map).withExpiresAt(new Date(System.currentTimeMillis()+1000*60*60*12)).sign(Algorithm.HMAC256(KEY));
    }
    public static Map<String,Object> verifyToken(String token){
        return JWT.require(Algorithm.HMAC256(KEY)).build().verify(token).getClaim("claims").asMap();
    }
}
