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
public enum PermissionTypeEnums {
    /**
     * 目录
     */
    DIRECTORY(0, "目录"),
    /**
     * 路由
     */
    ROUT(1, "路由"),
    /**
     * 按钮or请求
     */
    BUTTON_REQUEST(2, "按钮or请求");

    /**
     * 类型码
     */
    @EnumValue
    private final Integer code;
    /**
     * 类型名
     */
    private final String typeName;

    PermissionTypeEnums(Integer code, String typeName) {
        this.code = code;
        this.typeName = typeName;
    }

}
