package com.chen.graduation.converter;

import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.TeacherVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;


/**
 * 专业转换器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Mapper(componentModel = "spring")
public interface UserConverter {


    /**
     * po2teacher
     *
     * @param user 用户
     * @return {@link TeacherVO}
     */
    @Mapping(target = "avatar",expression = "java(user.getIcon())")
    TeacherVO po2teacher(User user);


    /**
     * po2teachers
     *
     * @param userList 用户列表
     * @return {@link List}<{@link TeacherVO}>
     */
    List<TeacherVO> po2teachers(List<User> userList);

}
