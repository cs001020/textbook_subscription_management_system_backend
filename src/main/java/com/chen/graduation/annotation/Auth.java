package com.chen.graduation.annotation;

import java.lang.annotation.*;

/**
 * 接口方法需要的权限
 *
 * @author CHEN
 * @date 2023/04/02
 */
@Target({ ElementType.PARAMETER, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Auth {

    /**
     * 该接口方法需要的权限
     *
     * @return {@link String[]}
     */
    public String[] value();
}
