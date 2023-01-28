package com.chen.graduation.model.DO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_secondary_college
 */
@TableName(value ="tb_secondary_college")
@Data
public class SecondaryCollege implements Serializable {
    private Long id;

    private String name;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}