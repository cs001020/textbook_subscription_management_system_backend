package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import com.chen.graduation.enums.TextbookOrderStateEnums;
import lombok.Data;

/**
 * @TableName tb_textbook_order
 */
@TableName(value ="tb_textbook_order")
@Data
public class TextbookOrder implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long gradeId;
    private String textbookIds;

    private TextbookOrderStateEnums state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}
