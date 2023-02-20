package com.chen.graduation.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.crypto.digest.MD5;
import cn.hutool.jwt.JWT;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.DTO.SmsLoginDTO;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SimpleUserInfoVO;
import com.chen.graduation.beans.VO.TokenVO;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.UserService;
import com.chen.graduation.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * @author 10065
 * @description 针对表【tb_user_faculty(教职工用户)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, User>
        implements UserService {
    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Value("${jwt.key}")
    private String jwtKet;

    @Override
    public AjaxResult<TokenVO> accountLogin(AccountLoginDTO accountLoginDTO) {
        //验证码校验
        //获取验证码
        String captchaCode = stringRedisTemplate.opsForValue().get(RedisConstants.IMG_CAPTCHA_KEY + accountLoginDTO.getCaptchaUid());
        if (StrUtil.isBlank(captchaCode) || !captchaCode.equals(accountLoginDTO.getCaptcha())) {
            //验证码错误抛出异常
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "验证码错误");
            throw new ServiceException("验证码错误");
        }
        //数据库查询用户
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getAccount, accountLoginDTO.getAccount());
        User user = getOne(wrapper);
        //判断是否存在用户
        if (Objects.isNull(user)) {
            //用户不存在
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "用户不存在");
            throw new ServiceException("用户名或密码错误");
        }
        //判断用户是否被封禁
        if (UserStateEnums.BAN.equals(user.getState())){
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "用户不存在");
            throw new ServiceException("当前用户已被封禁");
        }
        //判断密码是否正确
        String encodePassword = SecureUtil.md5(accountLoginDTO.getPassword() + SystemConstants.PASSWORD_MD5_SALT);
        if (!encodePassword.equals(user.getPassword())) {
            //密码错误
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "密码错误");
            throw new ServiceException("用户名或密码错误");
        }
        //生成token
        String token = JWT.create()
                .setPayload(SystemConstants.JWT_ID_PAYLOAD_KEY, user.getId())
                .setKey(jwtKet.getBytes())
                .sign();
        //存入redis
        stringRedisTemplate.opsForValue().set(RedisConstants.USER_TOKEN_KEY + user.getId(), token, RedisConstants.USER_TOKEN_TTL, TimeUnit.MINUTES);
        log.info("UserServiceImpl.accountLogin业务结束，结果:{}，登陆成功",user.getName());
        return AjaxResult.success(new TokenVO(token));
    }

    @Override
    public AjaxResult<TokenVO> smsLogin(SmsLoginDTO smsLoginDTO) {
        //验证码校验
        //获取验证码
        String smsCode = stringRedisTemplate.opsForValue().get(RedisConstants.SMS_CAPTCHA_KEY + smsLoginDTO.getPhoneNumber());
        if (StrUtil.isBlank(smsCode) || !smsCode.equals(smsLoginDTO.getCode())) {
            //验证码错误抛出异常
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "验证码错误");
            throw new ServiceException("验证码错误");
        }
        //数据库查询用户
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getPhoneNumber, smsLoginDTO.getPhoneNumber());
        User user = getOne(wrapper);
        //判断是否存在用户
        if (Objects.isNull(user)) {
            //用户不存在
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "用户不存在");
            throw new ServiceException("用户名或密码错误");
        }
        //判断用户是否被封禁
        if (UserStateEnums.BAN.equals(user.getState())){
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "用户不存在");
            throw new ServiceException("当前用户已被封禁");
        }
        //生成token
        String token = JWT.create()
                .setPayload(SystemConstants.JWT_ID_PAYLOAD_KEY, user.getId())
                .setKey(jwtKet.getBytes())
                .sign();
        //存入redis
        stringRedisTemplate.opsForValue().set(RedisConstants.USER_TOKEN_KEY + user.getId(), token, RedisConstants.USER_TOKEN_TTL, TimeUnit.MINUTES);
        log.info("UserServiceImpl.accountLogin业务结束，结果:{}，登陆成功",user.getName());
        return AjaxResult.success(new TokenVO(token));
    }

    @Override
    public AjaxResult<SimpleUserInfoVO> info() {
        //获取用户id
        Long userId = UserHolderContext.getUserId();
        //查询数据可
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        lambdaQuery().eq(User::getId, userId);
        User user = getOne(wrapper);
        //封装vo
        SimpleUserInfoVO simpleUserInfoVO = new SimpleUserInfoVO();
        simpleUserInfoVO.setName(user.getName());
        simpleUserInfoVO.setAvatar(user.getIcon());
        simpleUserInfoVO.setIntroduction(user.getIntroduction());
        simpleUserInfoVO.setRoles(Collections.singletonList("[admin]"));
        //响应结果
        log.info("UserServiceImpl.info业务结束，结果:{}",simpleUserInfoVO);
        return AjaxResult.success(simpleUserInfoVO);
    }
}




