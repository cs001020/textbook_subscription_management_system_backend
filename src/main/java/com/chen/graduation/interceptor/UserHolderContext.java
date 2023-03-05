package com.chen.graduation.interceptor;

import org.springframework.core.NamedThreadLocal;

/**
 * 用户持有人上下文
 *
 * @author CHEN
 * @date 2023/02/20
 */
public class UserHolderContext {
    private static final ThreadLocal<Long> LONG_THREAD_LOCAL = new NamedThreadLocal<>("userId");

    public static void saveUserId(Long userId){
        LONG_THREAD_LOCAL.set(userId);
    }

    public static Long getUserId(){
        return LONG_THREAD_LOCAL.get();
    }

    public static void removeUserId(){
        LONG_THREAD_LOCAL.remove();
    }
}
