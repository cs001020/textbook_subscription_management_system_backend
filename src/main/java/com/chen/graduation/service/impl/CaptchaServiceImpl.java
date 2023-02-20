package com.chen.graduation.service.impl;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.RandomUtil;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.CaptchaVO;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.CaptchaService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.Objects;
import java.util.concurrent.TimeUnit;

import static com.chen.graduation.constants.RedisConstants.*;
import static com.chen.graduation.constants.SystemConstants.*;

/**
 * 验证码服务impl
 *
 * @author CHEN
 * @date 2023/02/03
 */
@Service
@Slf4j
public class CaptchaServiceImpl implements CaptchaService {

    @Resource
    private StringRedisTemplate stringRedisTemplate;
    @Resource
    private Snowflake snowflake;

    // FIXME: 2023/2/3 防刷 for cs
    @Override
    public AjaxResult<CaptchaVO> getImgCaptcha() {
        //生成验证码
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(200, 100);
        String captchaCode = lineCaptcha.getCode();
        //生成id
        long id = snowflake.nextId();
        //封装vo
        CaptchaVO captchaVO = new CaptchaVO();
        captchaVO.setUid(id);
        captchaVO.setCaptcha(lineCaptcha.getImageBase64Data());
        //存入redis
        stringRedisTemplate.opsForValue().set(IMG_CAPTCHA_KEY + id, captchaCode, IMG_CAPTCHA_TTL, TimeUnit.MINUTES);
        //返回
        return AjaxResult.success(captchaVO);
    }

    @Override
    public AjaxResult<Object> sendSmsCaptcha(String phoneNumber) {
        //上次验证码发送时候超过1分钟
        Long expireTime = stringRedisTemplate.getExpire(SMS_CAPTCHA_KEY+phoneNumber,TimeUnit.MILLISECONDS);
        if (!Objects.isNull(expireTime)&&(expireTime>=SMS_CAPTCHA_TTL-SMS_CAPTCHA_REPEAT)){
            throw new ServiceException("请勿重复发送");
        }
        //生成随机验证码
        String smsCode = RandomUtil.randomNumbers(6);
        //存入redis
        stringRedisTemplate.opsForValue().set(SMS_CAPTCHA_KEY+phoneNumber,smsCode,SMS_CAPTCHA_TTL,TimeUnit.MILLISECONDS);
        // TODO: 2023/2/3 发送验证码 for cs
        //返回
        return AjaxResult.success();
    }
}
