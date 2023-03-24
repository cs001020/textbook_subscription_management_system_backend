package com.chen.graduation.beans.VO;

import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.PO.Role;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.List;

/**
 * 角色权限VO
 *
 * @author CHEN
 * @date 2023/03/21
 */
@Data
@ApiModel("角色权限VO")
public class RolePermissionVo {
    private Role role;
    private List<Permission> permissionList;
}
