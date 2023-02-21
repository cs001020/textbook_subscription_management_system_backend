package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.DTO.SmsLoginDTO;
import com.chen.graduation.beans.PO.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SimpleUserInfoVO;
import com.chen.graduation.beans.VO.TokenVO;

/**
* @author 10065
* @description 针对表【tb_user_faculty(教职工用户)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface UserService extends IService<User> {

    /**
     * 账户登录
     *
     * @param accountLoginDTO 账户登录dto
     * @return {@link AjaxResult}<{@link TokenVO}>
     */
    AjaxResult<TokenVO> accountLogin(AccountLoginDTO accountLoginDTO);

    /**
     * 短信登录
     *
     * @param smsLoginDTO 短信登录dto
     * @return {@link AjaxResult}<{@link TokenVO}>
     */
    AjaxResult<TokenVO> smsLogin(SmsLoginDTO smsLoginDTO);

    /**
     * 个人简易信息
     *
     * @return {@link AjaxResult}<{@link SimpleUserInfoVO}>
     */
    AjaxResult<SimpleUserInfoVO> info();
}
