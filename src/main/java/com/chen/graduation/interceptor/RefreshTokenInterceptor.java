package com.chen.graduation.interceptor;

import cn.hutool.core.util.StrUtil;
import cn.hutool.jwt.JWT;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.constants.SystemConstants;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.TimeUnit;

/**
 * redis令牌拦截器
 *
 * @author CHEN
 * @date 2023/02/20
 */
public class RefreshTokenInterceptor implements HandlerInterceptor {
    private final StringRedisTemplate stringRedisTemplate;
    private final String tokenRequestHand;
    private final String jwtKey;

    public RefreshTokenInterceptor(StringRedisTemplate stringRedisTemplate, String tokenRequestHand, String jwtKey) {
        this.stringRedisTemplate = stringRedisTemplate;
        this.tokenRequestHand = tokenRequestHand;
        this.jwtKey = jwtKey;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取token
        String token = request.getHeader(tokenRequestHand);
        if (StrUtil.isBlank(token)) {
            //不存在token
            return true;
        }
        //解析token
        JWT jwt = JWT.of(token);
        //校验jwt
        boolean verify = jwt.setKey(jwtKey.getBytes()).verify();
        if (!verify){
            //校验失败
            return true;
        }
        //获取载荷
        Long userId = ((Integer) jwt.getPayload(SystemConstants.JWT_ID_PAYLOAD_KEY)).longValue();
        //从redis获取数据
        String redisToken = stringRedisTemplate.opsForValue().get(RedisConstants.USER_TOKEN_KEY + userId);
        //校验
        if (StrUtil.isBlank(redisToken)||!redisToken.equals(token)){
            return true;
        }
        //hash转UserDTO存入ThreadLocal
        UserHolderContext.saveUserId(userId);
        //token续命
        stringRedisTemplate.expire(RedisConstants.USER_TOKEN_KEY + userId, RedisConstants.USER_TOKEN_TTL, TimeUnit.MINUTES);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        //清空上下文
        UserHolderContext.removeUserId();
    }
}
