package com.chen.graduation.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.graduation.beans.DTO.UserSearchDTO;
import com.chen.graduation.beans.PO.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_user_faculty(教职工用户)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.UserFaculty
*/
public interface UserMapper extends BaseMapper<User> {

    /**
     * 得到老师名单
     *
     * @return {@link List}<{@link User}>
     */
    List<User> getTeacherList();


    /**
     * 获取用户列表
     *
     * @param userPage      用户页面
     * @param userSearchDTO 用户搜索dto
     * @return {@link Page}<{@link User}>
     */
    Page<User> selectUserList(Page<User> userPage, @Param("dto") UserSearchDTO userSearchDTO);

    /**
     * 查询已分配用户角色列表
     *
     * @param objectPage 对象页面
     * @param user       用户
     * @param roleId     角色id
     * @return {@link Page}<{@link User}>
     */
    Page<User> selectAllocatedList(Page<User> objectPage,@Param("user") User user, @Param("roleId") Long roleId);

    /**
     * 查询未分配用户角色列表
     *
     * @param objectPage 对象页面
     * @param user       用户
     * @param roleId     角色id
     * @return {@link Page}<{@link User}>
     */
    Page<User> selectUnallocatedList(Page<User> objectPage, @Param("user") User user, @Param("roleId") Long roleId);
}




