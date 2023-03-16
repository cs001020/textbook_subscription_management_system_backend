package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Getter;


/**
 * 教科书订单状态枚举
 *
 * @author CHEN
 * @date 2023/03/16
 */
@Getter
public enum TextbookOrderStateEnums {
    /**
     * 正常
     */
    WAIT_GRANT(0, "代发放"),
    /**
     * 停用
     */
    GRANTED(1, "已发放");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    TextbookOrderStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
