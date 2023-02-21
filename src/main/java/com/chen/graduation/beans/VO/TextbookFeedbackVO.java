package com.chen.graduation.beans.VO;

import com.chen.graduation.beans.PO.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 教科书反馈VO
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Data
@ApiModel("教材反馈vo")
public class TextbookFeedbackVO implements Serializable {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("反馈人信息(只包含头像,姓名)")
    private SimpleUserInfoVO simpleUserInfoVO;
    @ApiModelProperty("图片路径")
    private String images;
    @ApiModelProperty("反馈信息")
    private String message;
    @ApiModelProperty("创建时间")
    private Date createTime;


    private static final long serialVersionUID = 1L;
}
