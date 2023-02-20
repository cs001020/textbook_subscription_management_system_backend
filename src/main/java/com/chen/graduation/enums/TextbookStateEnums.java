package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
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
    NORMAL(0, "正常"),
    /**
     * 存货不足
     */
    UNDER_STOCK(1, "库存不足"),
    /**
     * 审核中
     */
    AUDIT(2, "审核中"),
    /**
     * 弃用
     */
    DISCARD(3, "弃用");

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
