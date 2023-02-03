package com.chen.graduation.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import com.chen.graduation.model.DTO.PhoneNumberDTO;
import com.chen.graduation.model.VO.AjaxResult;
import com.chen.graduation.model.VO.CaptchaVO;
import com.chen.graduation.service.CaptchaService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 验证码控制器
 *
 * @author CHEN
 * @date 2023/02/03
 */
@Api(tags = "验证码")
@ApiSupport(author = "1006596474@qq.com")
@RestController
@RequestMapping("/captcha")
public class CaptchaController {

    @Resource
    private CaptchaService captchaService;
    @ApiOperation("获取图片验证码")
    @GetMapping("/img")
    public AjaxResult<CaptchaVO> captcha() {
        return captchaService.getImgCaptcha();
    }

    @ApiOperation("发送短信验证码")
    @GetMapping("/sms")
    public AjaxResult<Object> smsCaptcha(PhoneNumberDTO phoneNumberDTO) {
        return captchaService.sendSmsCaptcha(phoneNumberDTO.getPhoneNumber());
    }

}
