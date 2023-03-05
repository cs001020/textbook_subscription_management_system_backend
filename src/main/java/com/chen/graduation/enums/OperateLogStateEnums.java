package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Getter;


/**
 * 操作日志状态
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Getter
public enum OperateLogStateEnums {
    /**
     * 成功
     */
    SUCCESS(0, "成功"),
    /**
     * 失败
     */
    FAIL(1, "失败");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    OperateLogStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
