package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_textbook_order
 */
@TableName(value ="tb_textbook_order")
@Data
public class TextbookOrder implements Serializable {
    private Long id;

    private Long textbookId;

    private Long supplierId;

    private Integer state;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}