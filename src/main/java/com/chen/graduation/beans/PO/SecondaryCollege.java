package com.chen.graduation.beans.PO;

import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * @TableName tb_secondary_college
 */
@TableName(value ="tb_secondary_college")
@Data
public class SecondaryCollege implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    private Date createTime;

    private Date updateTime;
    @JSONField(serialize = false)
    private Long isDeleted;
    @TableField(exist = false)
    private List<Major> children;

    private static final long serialVersionUID = 1L;
}
