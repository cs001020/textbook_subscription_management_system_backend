package com.chen.graduation.constants;

/**
 * redis常量
 *
 * @author CHEN
 * @date 2023/01/28
 */
public class RedisConstants {
    /**
     * 教材分页缓存key
     */
    public static final String TEXTBOOK_PAGE_CACHE_KET="textbook.page";

    /**
     * 图片验证码key
     */
    public static final String IMG_CAPTCHA_KEY="captcha.img.";

    /**
     * 图形验证码缓存时间（分钟）
     */
    public static final Long IMG_CAPTCHA_TTL=5L;

    /**
     * 图片验证码key
     */
    public static final String SMS_CAPTCHA_KEY="captcha.sms.";

    /**
     * 图形验证码缓存时间（毫秒）
     */
    public static final Long SMS_CAPTCHA_TTL=5*60*1000L;

    /**
     * 用户令牌key
     */
    public static final String USER_TOKEN_KEY="user.token.";
    /**
     * 用户令牌ttl(分钟)
     */
    public static final Long USER_TOKEN_TTL=30L;
}
