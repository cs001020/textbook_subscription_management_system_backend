package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_major
 */
@TableName(value ="tb_major")
@Data
public class Major implements Serializable {
    private Long id;

    private String name;

    private String description;

    private Long secondaryCollegeId;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}