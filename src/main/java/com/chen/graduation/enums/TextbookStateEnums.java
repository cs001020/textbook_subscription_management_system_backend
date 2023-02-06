package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Data;
import lombok.Getter;

/**
 * 教科书状态枚举
 *
 * @author CHEN
 * @date 2023/02/06
 */
@Getter
public enum TextbookStateEnums {
    /**
     * 正常
     */
    NORMAL(0,"正常");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    TextbookStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
