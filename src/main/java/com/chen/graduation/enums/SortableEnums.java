package com.chen.graduation.enums;

import lombok.Getter;


/**
 * 可分类枚举
 *
 * @author CHEN
 * @date 2023/02/22
 */
@Getter
public enum SortableEnums {
    /**
     * 不排序
     */
    NONE(0, "不排序"),
    /**
     * 升序
     */
    ASC(1, "升序"),
    /**
     * 降序
     */
    DESC(2, "降序");

    /**
     * 类型码
     */
    private final Integer code;
    /**
     * 类型名
     */
    private final String name;

    SortableEnums(Integer code, String name) {
        this.code = code;
        this.name = name;
    }

}
