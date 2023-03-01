package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.Permission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_permission(权限)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.Permission
*/
public interface PermissionMapper extends BaseMapper<Permission> {

    /**
     * 通过用户id获取权
     *
     * @param userId 用户id
     * @return {@link List}<{@link Permission}>
     */
    List<Permission> getPermissionByUserId(@Param("userId") Long userId);
}




