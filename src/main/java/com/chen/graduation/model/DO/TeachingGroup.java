package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_teaching_group
 */
@TableName(value ="tb_teaching_group")
@Data
public class TeachingGroup implements Serializable {
    private Long id;

    private String name;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}