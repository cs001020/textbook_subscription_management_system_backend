package com.chen.graduation.beans.VO;

import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.enums.UserTypeEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 用户VO
 *
 * @author CHEN
 * @date 2023/03/10
 */
@ApiModel("用户VO")
@Data
public class UserVO implements Serializable {
    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("用户名")
    private String account;
    @ApiModelProperty("手机号码")
    private String phoneNumber;
    @ApiModelProperty("昵称")
    private String name;
    @ApiModelProperty("用户类型")
    private UserTypeEnums type;
    @ApiModelProperty("状态")
    private UserStateEnums state;
    @ApiModelProperty("创建时间")
    private Date createTime;


    private static final long serialVersionUID = 1L;
}
