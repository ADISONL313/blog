package com.cqcskj.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqcskj.blog.entity.User;
import com.cqcskj.blog.mapper.UserMapper;
import com.cqcskj.blog.rs.ResultDeal;
import com.cqcskj.blog.service.UserService;
import com.cqcskj.blog.utils.JWTUtil;
import com.cqcskj.blog.utils.MinIOUtil;
import jakarta.annotation.Resource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Resource
    private PasswordEncoder passwordEncoder;
    @Resource
    private UserMapper userMapper;
    @Override
    public ResultDeal userSignUpService(User user){
        Long i=userMapper.selectCount(new QueryWrapper<User>().eq("mail",user.getMail()));
        if(i==0){
            user.setUserId(UUID.randomUUID().toString());
            user.setIntroduce("");
            user.setGender(user.getGender());
            user.setNickname("默认用户");
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setIntroduce("这个人很高冷，什么都没写");
            user.setPhoto("");
            int tf=userMapper.insert(user);
            if(tf==0){
                return ResultDeal.error("注册失败");
            }else {
                return ResultDeal.success();
            }
        }else {
            return ResultDeal.error("账号已存在");
        }
    }
    @Override
    public ResultDeal userSignInService(User user){
        User verifyUser= userMapper.selectOne(new QueryWrapper<User>().eq("mail",user.getMail()));
        if(verifyUser==null){
            return ResultDeal.error("账号不存在");
        }else {
            if(passwordEncoder.matches(user.getPassword(),verifyUser.getPassword())){
                Map<String,Object> map=new HashMap<>();
                map.put("mail",verifyUser.getMail());
                String token=JWTUtil.genToken(map);
                Map<String,Object> loginData=new HashMap<>();
                loginData.put("mail",verifyUser.getMail());
                loginData.put("gender",verifyUser.getGender());
                loginData.put("introduce",verifyUser.getIntroduce());
                loginData.put("photo",verifyUser.getPhoto());
                loginData.put("nickname",verifyUser.getNickname());
                loginData.put("userId",verifyUser.getUserId());
                loginData.put("token",token);
                return ResultDeal.success(loginData);
            }else {
                return ResultDeal.error("密码错误");
            }
        }
    }
    @Override
    public ResultDeal getUserService(User user){
        QueryWrapper queryWrapper=new QueryWrapper();
        if(user.getMail()!=null){
            queryWrapper.like("mail",user.getMail());
        }
        if(user.getNickname()!=null){
            queryWrapper.like("nickname",user.getNickname());
        }
        List<User> userList= userMapper.selectList(queryWrapper);
        return ResultDeal.success(userList);
    }
    @Resource
    private MinIOUtil minIOUtil;
    @Override
    public ResultDeal updatePersonalInfoService(MultipartFile multipartFile, User user){
        if(user.getPassword()!=null){
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        if(multipartFile==null){

            int i= userMapper.updateById(user);
            if(i==0){
                return ResultDeal.error("修改失败");
            }else {
                return ResultDeal.success();
            }
        }else {
            try {
                boolean tf= minIOUtil.delFolder("bloguser",user.getUserId());
                if(tf){
                    String fileName= minIOUtil.uploadFile(multipartFile,"bloguser",user.getUserId());
                    if(fileName.equals("错误")){
                        return ResultDeal.error("修改失败");
                    }else {
                        user.setPhoto(fileName);
                        int a= userMapper.updateById(user);
                        if(a==0){
                            return ResultDeal.error("修改失败");
                        }else {
                            return ResultDeal.success();
                        }
                    }
                }
            } catch (Exception e) {
                return ResultDeal.error("修改失败");
            }
        }
        return ResultDeal.success();
    }
}
