package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_role
 */
@TableName(value ="tb_role")
@Data
public class Role implements Serializable {
    private Long id;

    private String name;

    private String description;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}