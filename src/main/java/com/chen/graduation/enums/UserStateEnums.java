package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Getter;


/**
 * 用户状态枚举
 *
 * @author CHEN
 * @date 2023/02/20
 */
@Getter
public enum UserStateEnums {
    /**
     * 正常
     */
    NORMAL(0, "正常"),
    /**
     * 封禁
     */
    BAN(1, "封禁");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    UserStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
