package com.chen.graduation.interceptor;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.exception.AuthorizationException;
import com.chen.graduation.service.PermissionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Objects;

/**
 * 鉴权拦截器拦截器
 *
 * @author CHEN
 * @date 2023/04/02
 */
@Slf4j
public class AuthorizeInterceptor implements HandlerInterceptor {

    private final PermissionService permissionService;

    public AuthorizeInterceptor(PermissionService permissionService) {
        this.permissionService = permissionService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取注解
        HandlerMethod handlerMethod= (HandlerMethod) handler;
        Auth auth = handlerMethod.getMethodAnnotation(Auth.class);
        // 无注解 直接放行
        if (Objects.isNull(auth)){
            log.warn("{}接口未定义权限",request.getRequestURI());
            return true;
        }
        //获取用户权限字符
        Long userId = UserHolderContext.getUserId();
        List<String> perms = permissionService.getPermissionPermsByUserId(userId);
        //获取方法需要的权限
        String[] value = auth.value();
        //权限判断
        for (String s : value) {
            if (perms.contains(s)){
                return true;
            }
        }
        // 无权限异常
        throw new AuthorizationException();
    }
}
