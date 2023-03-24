package com.chen.graduation.beans.VO;

import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.PO.User;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.List;

/**
 * 用户角色VO
 *
 * @author CHEN
 * @date 2023/03/20
 */
@Data
@ApiModel("用户角色VO")
public class UserRoleVo {
    private User user;
    private List<Role> roleList;
}
