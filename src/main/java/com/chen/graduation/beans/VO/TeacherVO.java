package com.chen.graduation.beans.VO;

import com.chen.graduation.beans.PO.UserInfo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;


/**
 * 老师VO
 *
 * @author CHEN
 * @date 2023/02/24
 */
@Data
@ApiModel("教师")
public class TeacherVO implements Serializable {

    @ApiModelProperty("id")
    private Long id;
    @ApiModelProperty("昵称")
    private String name;
    @ApiModelProperty("手机号")
    private String phoneNumber;
    @ApiModelProperty("头像url")
    private String avatar;
    @ApiModelProperty("用户详细信息")
    private UserInfo userInfo;

    private static final long serialVersionUID = 1L;
}
