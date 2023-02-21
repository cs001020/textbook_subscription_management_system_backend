package com.chen.graduation.interceptor;

import com.chen.graduation.exception.UnAuthenticationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;

/**
 * 登录认证拦截器
 *
 * @author CHEN
 * @date 2023/02/20
 */
@Slf4j
public class LoginAuthenticationInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取用户
        if (Objects.isNull(UserHolderContext.getUserId())) {
            log.info("LoginAuthenticationInterceptor.preHandle业务结束，结果:{}未登录用户进行了访问",request.getRequestURI());
            //不存在用户 拦截
            throw new UnAuthenticationException();
        }
        //存在用户放行
        return true;
    }
}
