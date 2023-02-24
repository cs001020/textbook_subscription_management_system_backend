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
public enum ApprovalStateEnums {
    /**
     * 未审批
     */
    UNAPPROVED(0, "未审批"),
    /**
     * 审批通过
     */
    ADOPT(1, "审批通过"),
    /**
     * 驳回
     */
    REJECT(2, "驳回");

    /**
     * 状态码
     */
    @EnumValue
    private final Integer code;
    /**
     * 状态名称
     */
    private final String stateName;

    ApprovalStateEnums(Integer code, String stateName) {
        this.code = code;
        this.stateName = stateName;
    }

}
