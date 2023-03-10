package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Getter;


/**
 * 用户类型枚举
 *
 * @author CHEN
 * @date 2023/03/10
 */
@Getter
public enum UserTypeEnums {


    /**
     * 学生
     */
    STUDENT(0, "学生"),
    /**
     * 教师
     */
    TEACHER(1, "教师");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String typeName;

    UserTypeEnums(Integer code, String typeName) {
        this.code = code;
        this.typeName = typeName;
    }
}
