package com.chen.graduation.constants;

/**
 * 系统常量
 *
 * @author CHEN
 * @date 2023/01/28
 */
public class SystemConstants {

    /**
     * 短信验证码重复发送间隔（毫秒）
     */
    public static final Long SMS_CAPTCHA_REPEAT= 60 * 1000L;

    /**
     * 密码最大长度
     */
    public static final int PASSWORD_MAX_SIZE=20;

    /**
     * 手机号码正则
     */
    public static final String PHONE_REGEXP="0?(13|14|15|18|17)[0-9]{9}";
}
