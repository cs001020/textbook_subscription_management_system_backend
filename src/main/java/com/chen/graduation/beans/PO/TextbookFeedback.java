package com.chen.graduation.beans.PO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName tb_textbook_feedback
 */
@TableName(value ="tb_textbook_feedback")
@Data
public class TextbookFeedback implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    private Long studentId;

    private Long textbookId;

    private String images;

    private String message;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    @TableField(exist = false)
    private User user;

    private static final long serialVersionUID = 1L;
}
