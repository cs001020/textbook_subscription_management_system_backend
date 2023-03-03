package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Getter;


/**
 * 批准状态枚举
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Getter
public enum PermissionStateEnums {
    /**
     * 正常
     */
    NORMAL(0, "正常"),
    /**
     * 停用
     */
    DISABLE(1, "停用");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    PermissionStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
