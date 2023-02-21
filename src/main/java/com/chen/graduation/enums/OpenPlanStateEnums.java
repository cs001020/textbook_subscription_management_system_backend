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
public enum OpenPlanStateEnums {
    /**
     * 等待教师选定教材
     */
    TEXTBOOKS_TO_BE_SELECT(0, "等待教师选定教材"),
    /**
     * 等待审批
     */
    WAITING_FOR_APPROVAL(1, "已经选定教材，等待审批"),
    /**
     * 审批完成
     */
    APPROVAL_COMPLETED(2, "审批完成");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    OpenPlanStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
