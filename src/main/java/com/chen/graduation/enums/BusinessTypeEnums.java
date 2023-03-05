package com.chen.graduation.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import lombok.Getter;

/**
 * 业务类型枚举
 *
 * @author CHEN
 * @date 2023/03/05
 */
@Getter
public enum BusinessTypeEnums {


    /**
     * 其他
     */
    OTHER(0, "其他"),
    /**
     * 新增
     */
    INSERT(1, "新增"),
    /**
     * 更新
     */
    UPDATE(2,"修改"),
    /**
     * 删除
     */
    DELETE(3,"删除");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    BusinessTypeEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }
}
