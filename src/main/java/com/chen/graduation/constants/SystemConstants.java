package com.chen.graduation.constants;

import java.util.Arrays;
import java.util.List;

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

    /**
     * md5密码盐
     */
    public static final String PASSWORD_MD5_SALT="salt";
    /**
     * jwt id载荷key
     */
    public static final String JWT_ID_PAYLOAD_KEY="id";

    /**
     * 图片类型
     */
    public static final List<String> IMG_TYPE= Arrays.asList("jpg","png");
}
