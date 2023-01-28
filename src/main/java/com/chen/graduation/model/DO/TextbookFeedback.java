package com.chen.graduation.model.DO;

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
    private Long id;

    private Long studentId;

    private Long textbookId;

    private String images;

    private String message;

    private Integer type;

    private Date createTime;

    private Date updateTime;

    private Long isDeleted;

    private static final long serialVersionUID = 1L;
}