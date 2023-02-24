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
public enum ApprovalTotalStateEnums {
    /**
     * 待教学组审批
     */
    WAIT_GROUP(0, "待教学组审批"),
    /**
     * 待二级学院审批
     */
    WAIT_SECONDARY(1, "待二级学院审批"),
    /**
     * 待教务处审批
     */
    WAIT_OFFICE(2, "待教务处审批"),
    /**
     * 审批通过
     */
    ADOPT(3, "审批通过"),
    /**
     * 驳回
     */
    REJECT(4, "驳回");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    ApprovalTotalStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
