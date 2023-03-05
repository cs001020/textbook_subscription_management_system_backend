package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Getter;


/**
 * 登录日志状态枚举
 *
 * @author CHEN
 * @date 2023/03/05
 */
@Getter
public enum LoginLogStateEnums {
    /**
     * 登陆成功
     */
    SUCCESS(0, "登陆成功"),
    /**
     * 登陆成功
     */
    FAIL(1, "登陆失败");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    LoginLogStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
