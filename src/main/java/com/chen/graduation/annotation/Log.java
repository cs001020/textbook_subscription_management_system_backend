package com.chen.graduation.annotation;

import com.chen.graduation.enums.BusinessTypeEnums;

import java.lang.annotation.*;

/**
 * 自定义操作日志记录注解
 *
 * @author ruoyi
 */
@Target({ ElementType.PARAMETER, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log
{
    /**
     * 模块
     */
    public String title() default "";

    /**
     * 功能
     */
    public BusinessTypeEnums businessTypeEnums() default BusinessTypeEnums.OTHER;

}
