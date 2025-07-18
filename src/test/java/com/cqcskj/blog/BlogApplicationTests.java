package com.cqcskj.blog;

import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootTest
class BlogApplicationTests {
    @Resource
    private PasswordEncoder passwordEncoder;
    @Test
    void contextLoads() {
        String aa=passwordEncoder.encode("123456");
        System.out.println(aa);
    }

}
