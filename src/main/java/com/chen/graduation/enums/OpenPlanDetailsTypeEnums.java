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
public enum OpenPlanDetailsTypeEnums {
    /**
     * 等待教师选定教材
     */
    EXAMINATION(0, "考试"),
    /**
     * 等待审批
     */
    INVESTIGATE(1, "考察");

    /**
     * 类型
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String typeName;

    OpenPlanDetailsTypeEnums(Integer code, String typeName) {
        this.code = code;
        this.typeName = typeName;
    }

}
