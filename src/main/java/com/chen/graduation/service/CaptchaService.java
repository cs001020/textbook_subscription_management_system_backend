package com.chen.graduation.service;

import com.chen.graduation.model.VO.AjaxResult;
import com.chen.graduation.model.VO.CaptchaVO;

/**
 * 验证码服务
 *
 * @author CHEN
 * @date 2023/02/03
 */
public interface CaptchaService {

    /**
     * 获取图片验证码
     *
     * @return {@link AjaxResult}<{@link CaptchaVO}>
     */
    AjaxResult<CaptchaVO> getImgCaptcha();

    /**
     * 发送短信验证码
     *
     * @param phoneNumber 电话号码
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> sendSmsCaptcha(String phoneNumber);
}
