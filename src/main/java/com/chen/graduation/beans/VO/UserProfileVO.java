package com.chen.graduation.beans.VO;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.chen.graduation.constants.SystemConstants;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * 用户资料VO
 *
 * @author CHEN
 * @date 2023/04/03
 */
@Data
@ApiModel("用户资料VO")
public class UserProfileVO {

    @ApiModelProperty("用户账号")
    private String account;

    @ApiModelProperty("用户昵称")
    private String name;

    @ApiModelProperty("手机号码")
    private String phoneNumber;

    @ApiModelProperty("二级学院")
    private String secondaryCollege;

    @ApiModelProperty("性别")
    private Integer sex;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("创建时间")
    private Date createTime;
}
