package com.chen.graduation.beans.DTO;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

/**
 * 用户重置密码DTO
 *
 * @author CHEN
 * @date 2023/04/03
 */
@Data
@ApiModel("用户重置密码DTO")
public class UserRestPasswordDTO {
    @ApiModelProperty("旧密码")
    private String oldPassword;
    @ApiModelProperty("新密码")
    @Length(min = 6,max = 20,message = "非法请求")
    private String newPassword;
}
