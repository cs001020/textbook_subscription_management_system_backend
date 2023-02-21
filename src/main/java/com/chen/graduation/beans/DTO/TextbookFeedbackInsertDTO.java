package com.chen.graduation.beans.DTO;

import com.chen.graduation.beans.VO.SimpleUserInfoVO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;


/**
 * 教科书反馈VO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("教材反馈新增dto")
public class TextbookFeedbackInsertDTO implements Serializable {

    @ApiModelProperty("教材id")
    @NotNull(message = "参数异常")
    private Long textbookId;
    @ApiModelProperty("图片路径")
    private String images;
    @ApiModelProperty("反馈信息")
    @NotBlank(message = "反馈消息不能为空")
    private String message;

    private static final long serialVersionUID = 1L;
}
