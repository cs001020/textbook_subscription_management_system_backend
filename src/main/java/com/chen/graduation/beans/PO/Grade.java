package com.chen.graduation.beans.PO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_grade
 */
@TableName(value ="tb_grade")
@Data
public class Grade implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long majorId;

    private Integer year;

    private String number;

    private Date createTime;

    private Date updateTime;
    @TableField(exist = false)
    private String name;
    @JSONField(serialize = false)
    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}
