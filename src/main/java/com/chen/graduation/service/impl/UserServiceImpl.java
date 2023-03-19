package com.chen.graduation.service.impl;

import cn.hutool.core.util.DesensitizedUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.crypto.digest.MD5;
import cn.hutool.jwt.JWT;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.DTO.SmsLoginDTO;
import com.chen.graduation.beans.DTO.UserSearchDTO;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.*;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.converter.UserConverter;
import com.chen.graduation.enums.LoginLogStateEnums;
import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.service.UserService;
import com.chen.graduation.mapper.UserMapper;
import com.chen.graduation.utils.AsyncFactory;
import com.chen.graduation.utils.AsyncManager;
import com.chen.graduation.utils.RouterUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * @author 10065
 * @description 针对表【tb_user_faculty(教职工用户)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, User>
        implements UserService {
    @Resource
    private PermissionService permissionService;
    @Resource
    private StringRedisTemplate stringRedisTemplate;
    @Resource
    private UserConverter userConverter;

    @Value("${jwt.key}")
    private String jwtKey;
    @Value("${jwt.hand}")
    private String requestHand;

    // TODO: 2023/2/20 登陆日志
    @Override
    public AjaxResult<TokenVO> accountLogin(AccountLoginDTO accountLoginDTO) {
        //验证码校验
        //获取验证码
        String captchaCode = stringRedisTemplate.opsForValue().get(RedisConstants.IMG_CAPTCHA_KEY + accountLoginDTO.getCaptchaUid());
        if (StrUtil.isBlank(captchaCode)) {
            //异步登陆日志
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(accountLoginDTO.getAccount(), LoginLogStateEnums.FAIL, "验证码过期"));
            //验证码过期抛出异常
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "验证码过期");
            throw new ServiceException("验证码过期，请重新获取");
        }
        if (!captchaCode.equals(accountLoginDTO.getCaptcha())) {
            //异步登陆日志
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(accountLoginDTO.getAccount(), LoginLogStateEnums.FAIL, "验证码错误"));
            //验证码错误抛出异常
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "验证码错误");
            throw new ServiceException("验证码错误");
        }
        //数据库查询用户
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getAccount, accountLoginDTO.getAccount());
        User user = getOne(wrapper);
        //判断是否存在用户
        if (Objects.isNull(user)) {
            //异步登陆日志
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(accountLoginDTO.getAccount(), LoginLogStateEnums.FAIL, "用户名或密码错误"));
            //用户不存在
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "用户不存在");
            throw new ServiceException("用户名或密码错误");
        }
        //判断用户是否被封禁
        if (UserStateEnums.BAN.equals(user.getState())) {
            //异步登陆日志
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(accountLoginDTO.getAccount(), LoginLogStateEnums.FAIL, "当前用户已被封禁"));
            //当前用户已被封禁
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "当前用户已被封禁");
            throw new ServiceException("当前用户已被封禁");
        }
        //判断密码是否正确
        String encodePassword = SecureUtil.md5(accountLoginDTO.getPassword() + SystemConstants.PASSWORD_MD5_SALT);
        if (!encodePassword.equals(user.getPassword())) {
            //异步登陆日志
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(accountLoginDTO.getAccount(), LoginLogStateEnums.FAIL, "用户名或密码错误"));
            //密码错误
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "密码错误");
            throw new ServiceException("用户名或密码错误");
        }
        //异步登陆日志
        AsyncManager.me().execute(AsyncFactory.recordLoginLog(accountLoginDTO.getAccount(), LoginLogStateEnums.SUCCESS, "登陆成功"));
        //生成token
        String token = JWT.create()
                .setPayload(SystemConstants.JWT_ID_PAYLOAD_KEY, user.getId())
                .setPayload("hello", IdUtil.simpleUUID())
                .setKey(jwtKey.getBytes())
                .sign();
        //存入redis
        stringRedisTemplate.opsForValue().set(RedisConstants.USER_TOKEN_KEY + user.getId(), token, RedisConstants.USER_TOKEN_TTL, TimeUnit.MINUTES);
        log.info("UserServiceImpl.accountLogin业务结束，结果:{}，登陆成功", user.getName());
        return AjaxResult.success(new TokenVO(token, requestHand));
    }

    @Override
    public AjaxResult<TokenVO> smsLogin(SmsLoginDTO smsLoginDTO) {
        //验证码校验
        //获取验证码
        String smsCode = stringRedisTemplate.opsForValue().get(RedisConstants.SMS_CAPTCHA_KEY + smsLoginDTO.getPhoneNumber());
        if (StrUtil.isBlank(smsCode) || !smsCode.equals(smsLoginDTO.getCode())) {
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(DesensitizedUtil.mobilePhone(smsLoginDTO.getPhoneNumber()), LoginLogStateEnums.FAIL, "验证码错误"));
            //验证码错误抛出异常
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "验证码错误");
            throw new ServiceException("验证码错误");
        }
        //数据库查询用户
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getPhoneNumber, smsLoginDTO.getPhoneNumber());
        User user = getOne(wrapper);
        //判断是否存在用户
        if (Objects.isNull(user)) {
            //异步登陆日志
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(DesensitizedUtil.mobilePhone(smsLoginDTO.getPhoneNumber()), LoginLogStateEnums.FAIL, "用户不存在"));
            //用户不存在
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "用户不存在");
            throw new ServiceException("用户名或密码错误");
        }
        //判断用户是否被封禁
        if (UserStateEnums.BAN.equals(user.getState())) {
            //异步登陆日志
            AsyncManager.me().execute(AsyncFactory.recordLoginLog(DesensitizedUtil.mobilePhone(smsLoginDTO.getPhoneNumber()), LoginLogStateEnums.FAIL, "当前用户已被封禁"));
            log.info("UserServiceImpl.accountLogin业务结束，结果:{}", "用户不存在");
            throw new ServiceException("当前用户已被封禁");
        }
        //异步登陆日志
        AsyncManager.me().execute(AsyncFactory.recordLoginLog(DesensitizedUtil.mobilePhone(smsLoginDTO.getPhoneNumber()), LoginLogStateEnums.SUCCESS, "登陆成功"));
        //生成token
        String token = JWT.create()
                .setPayload(SystemConstants.JWT_ID_PAYLOAD_KEY, user.getId())
                .setPayload("hello", IdUtil.simpleUUID())
                .setKey(jwtKey.getBytes())
                .sign();
        //存入redis
        stringRedisTemplate.opsForValue().set(RedisConstants.USER_TOKEN_KEY + user.getId(), token, RedisConstants.USER_TOKEN_TTL, TimeUnit.MINUTES);
        log.info("UserServiceImpl.accountLogin业务结束，结果:{}，登陆成功", user.getName());
        return AjaxResult.success(new TokenVO(token, requestHand));
    }

    @Override
    public AjaxResult<SimpleUserInfoVO> info() {
        //获取用户id
        Long userId = UserHolderContext.getUserId();
        //查询数据
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getId, userId);
        User user = getOne(wrapper);
        //查询权限
        List<Permission> permissionList = permissionService.getPermissionByUserId(userId);
        //封装vo
        SimpleUserInfoVO simpleUserInfoVO = new SimpleUserInfoVO();
        simpleUserInfoVO.setName(user.getName());
        simpleUserInfoVO.setAvatar(user.getIcon());
        simpleUserInfoVO.setIntroduction(user.getIntroduction());
        simpleUserInfoVO.setRoles(Collections.singletonList("[admin]"));
        simpleUserInfoVO.setRouters(RouterUtils.buildRouterTree(permissionList));
        //响应结果
        log.info("UserServiceImpl.info业务结束，结果:{}", simpleUserInfoVO);
        return AjaxResult.success(simpleUserInfoVO);
    }

    @Override
    public AjaxResult<List<TeacherVO>> teacher() {
        //数据库查询
        List<User> teachList = baseMapper.getTeacherList();
        //转换对象
        List<TeacherVO> teacherVOList = userConverter.po2teachers(teachList);
        //打印日志
        log.info("UserServiceImpl.teacher业务结束，结果:{}", teacherVOList);
        //响应
        return AjaxResult.success(teacherVOList);
    }

    @Override
    public AjaxResult<Object> logout() {
        //获取用户id
        Long userId = UserHolderContext.getUserId();
        //删除token
        stringRedisTemplate.delete(RedisConstants.USER_TOKEN_KEY + userId);
        //响应
        return AjaxResult.success();
    }

    @Override
    public AjaxResult<List<UserVO>> selectUserList(UserSearchDTO userSearchDTO) {
        //查询数据库
        Page<User> userPageList = baseMapper.selectUserList(new Page<User>(userSearchDTO.getPage(), userSearchDTO.getSize()), userSearchDTO);
        //转换对象
        List<UserVO> userVOList = userConverter.po2vos(userPageList.getRecords());
        //封装结果
        AjaxResult<List<UserVO>> success = AjaxResult.success(userVOList);
        success.setTotal(userPageList.getTotal());
        //响应
        return success;
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> changeState(User user) {
        //参数校验
        if (Objects.isNull(user.getId())||Objects.isNull(user.getState())){
            throw new ServiceException("参数异常");
        }
        //禁止修改本人
        if (user.getId().equals(UserHolderContext.getUserId())){
            throw new ServiceException("参数异常");
        }
        //更新状态
        boolean update = lambdaUpdate().eq(User::getId, user.getId()).set(User::getState, user.getState()).update();
        //响应结果
        if (!update){
            throw new ServiceException("发生未知异常，请稍后再试！");
        }
        log.info("UserServiceImpl.changeState业务结束，结果:{}", user);
        // FIXME: 2023/3/19 用户下线
        return AjaxResult.success();
    }

}




