package com.chen.graduation.beans.DTO;

import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.enums.UserTypeEnums;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


/**
 * 用户搜索dto
 *
 * @author CHEN
 * @date 2023/03/10
 */
@EqualsAndHashCode(callSuper = true)
@ApiModel("用户搜索dto")
@Data
public class UserSearchDTO extends PageParamDTO implements Serializable{
    @ApiModelProperty("用户名")
    private String account;
    @ApiModelProperty("手机号码")
    private String phoneNumber;
    @ApiModelProperty("用户类型")
    private UserTypeEnums type;
    @ApiModelProperty("用户状态")
    private UserStateEnums state;

    private static final long serialVersionUID = 1L;
}
