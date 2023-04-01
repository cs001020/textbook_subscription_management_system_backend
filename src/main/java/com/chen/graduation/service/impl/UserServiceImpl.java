package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.DesensitizedUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.extra.spring.SpringUtil;
import cn.hutool.jwt.JWT;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.AccountLoginDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.DTO.SmsLoginDTO;
import com.chen.graduation.beans.DTO.UserSearchDTO;
import com.chen.graduation.beans.PO.*;
import com.chen.graduation.beans.VO.*;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.converter.UserConverter;
import com.chen.graduation.enums.LoginLogStateEnums;
import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.*;
import com.chen.graduation.mapper.UserMapper;
import com.chen.graduation.utils.AsyncFactory;
import com.chen.graduation.utils.AsyncManager;
import com.chen.graduation.utils.PermissionUtils;
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
    private UserRoleService userRoleService;
    @Resource
    private RoleService roleService;
    @Resource
    private StringRedisTemplate stringRedisTemplate;
    @Resource
    private UserConverter userConverter;

    @Value("${jwt.key}")
    private String jwtKey;
    @Value("${jwt.hand}")
    private String requestHand;

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
        simpleUserInfoVO.setPermissions(PermissionUtils.getButtonOrRequestPermission(permissionList));
        //响应结果
        log.info("UserServiceImpl.info业务结束，结果:{}", simpleUserInfoVO);
        return AjaxResult.success(simpleUserInfoVO);
    }

    @Override
    public AjaxResult<List<User>> teacher(PageParamDTO pageParamDTO, User user) {
        //数据库查询
        Page<User> page = baseMapper.getTeacherList(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()),user);
        //构建响应对象
        AjaxResult<List<User>> success = AjaxResult.success(page.getRecords());
        success.setTotal(page.getTotal());
        //打印日志
        log.info("UserServiceImpl.teacher业务结束，结果:{}", success);
        //响应
        return success;
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
        //如果为封禁 强制下线
        if (UserStateEnums.BAN.equals(user.getState())){
            kickUser(user.getId());
        }
        //响应结果
        if (!update){
            throw new ServiceException("发生未知异常，请稍后再试！");
        }
        //日志
        log.info("UserServiceImpl.changeState业务结束，结果:{}", user);
        //响应
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> updateUser(User user) {
        //检查账号是否存在
        if (!checkAccountUnique(user)){
            throw new ServiceException("修改失败，登录账号已存在");
        }
        //检查手机号是否存在
        if (StrUtil.isNotBlank(user.getPhoneNumber())&&!checkPhoneUnique(user)){
            throw new ServiceException("修改失败，手机号码已存在");
        }
        //密码加盐
        if (StrUtil.isNotBlank(user.getPassword())){
            user.setPassword(SecureUtil.md5(user.getPassword() + SystemConstants.PASSWORD_MD5_SALT));
        }
        //更新
        boolean update = updateById(user);
        //用户下线
        if (StrUtil.isNotBlank(user.getPassword())||UserStateEnums.BAN.equals(user.getState())){
            kickUser(user.getId());
        }
        //日志
        log.info("UserServiceImpl.updateUser业务结束，结果:{}",update);
        //响应
        return AjaxResult.success(update);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> deleteUser(Long id) {
        //判断是否为当前登陆用户
        if (id.equals(UserHolderContext.getUserId())){
            throw new ServiceException("当前账户无法删除");
        }
        //是否存在开课计划
        if (checkHasOpeningPlan(id)){
            throw new ServiceException("该用户存在开课计划,暂时无法删除!");
        }
        //删除用户反馈
        SpringUtil.getBean(TextbookFeedbackService.class).lambdaUpdate().eq(TextbookFeedback::getStudentId,id).remove();
        //删除用户信息
        SpringUtil.getBean(UserInfoService.class).lambdaUpdate().eq(UserInfo::getUserFacultyId,id).remove();
        //删除用户角色关联表
        userRoleService.lambdaUpdate().eq(UserRole::getUserId,id).remove();
        //删除用户
        boolean remove = this.lambdaUpdate().eq(User::getId, id).remove();
        //强制下线
        kickUser(id);
        //日志
        log.info("UserServiceImpl.deleteUser业务结束，结果:{}",remove);
        //响应
        return AjaxResult.success(remove);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> resetPwd(User user) {
        //参数校验
        if (Objects.isNull(user.getId())||StrUtil.isBlank(user.getPassword())){
            throw new ServiceException("参数异常");
        }
        //构建对象
        User newPwdUser = new User();
        newPwdUser.setId(user.getId());
        newPwdUser.setPassword(SecureUtil.md5(user.getPassword() + SystemConstants.PASSWORD_MD5_SALT));
        //更新
        boolean update = updateById(newPwdUser);
        //下线
        kickUser(user.getId());
        //日志
        log.info("UserServiceImpl.resetPwd业务结束，结果:{}",update);
        //响应
        return AjaxResult.success(update);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> insertUserAuth(Long userId, Long[] roleIds) {
        //参数校验
        if (Objects.isNull(userId)||Objects.isNull(roleIds)){
            throw new ServiceException("参数异常");
        }
        //删除原角色
        userRoleService.lambdaUpdate().eq(UserRole::getUserId,userId).remove();
        //新角色id不为空插入新数据
        if (CollUtil.isNotEmpty(Arrays.asList(roleIds))){
            //构建对象
            List<UserRole> userRoleList=new ArrayList<>();
            for (Long roleId : roleIds) {
                UserRole userRole = new UserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(roleId);
                userRoleList.add(userRole);
            }
            //插入新数据
            userRoleService.saveBatch(userRoleList);
        }
        //响应
        return AjaxResult.success();
    }

    @Override
    public AjaxResult<UserRoleVo> authRole(Long userId) {

        User user = this.getById(userId);
        List<Role> roles = roleService.selectRolesByUserId(userId);
        //封装对象
        UserRoleVo userRoleVo = new UserRoleVo();
        userRoleVo.setUser(user);
        userRoleVo.setRoleList(roles);
        //日志
        log.info("UserServiceImpl.authRole业务结束，结果:{}",userRoleVo);
        //响应
        return AjaxResult.success(userRoleVo);
    }

    @Override
    public AjaxResult<List<UserVO>> selectAllocatedList(PageParamDTO pageParamDTO, User user, Long roleId) {
        //查询数据库
        Page<User> page=baseMapper.selectAllocatedList(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()),user,roleId);
        //封装对象
        List<UserVO> userVOList = userConverter.po2vos(page.getRecords());
        AjaxResult<List<UserVO>> success = AjaxResult.success(userVOList);
        success.setTotal(page.getTotal());
        //日志
        log.info("UserServiceImpl.selectUnallocatedList业务结束，结果:{}",success);
        //响应
        return success;
    }

    @Override
    public AjaxResult<List<UserVO>> selectUnallocatedList(PageParamDTO pageParamDTO, User user, Long roleId) {
        //查询数据库
        Page<User> page=baseMapper.selectUnallocatedList(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()),user,roleId);
        //封装对象
        List<UserVO> userVOList = userConverter.po2vos(page.getRecords());
        AjaxResult<List<UserVO>> success = AjaxResult.success(userVOList);
        success.setTotal(page.getTotal());
        //日志
        log.info("UserServiceImpl.selectUnallocatedList业务结束，结果:{}",success);
        //响应
        return success;
    }

    /**
     * 检查账号码唯一性
     *
     * @param user 用户
     * @return boolean 唯一返回true
     */
    private boolean checkAccountUnique(User user){
        if (StrUtil.isBlank(user.getAccount())){
            return true;
        }
        Page<User> page = this.lambdaQuery().eq(User::getAccount, user.getAccount()).page(new Page<>(1, 1));
        List<User> userList = page.getRecords();
        return !CollectionUtil.isNotEmpty(userList) || userList.get(0).getId().equals(user.getId());
    }

    /**
     * 检查手机号码唯一性
     *
     * @param user 用户
     * @return boolean 唯一返回true
     */
    private boolean checkPhoneUnique(User user){
        if (StrUtil.isBlank(user.getPhoneNumber())){
            return true;
        }
        Page<User> page = this.lambdaQuery().eq(User::getPhoneNumber,user.getPhoneNumber()).page(new Page<>(1,1));
        List<User> userList = page.getRecords();
        return !CollectionUtil.isNotEmpty(userList) || userList.get(0).getId().equals(user.getId());
    }

    /**
     * 检查是否存在开课计划
     *
     * @param id id
     * @return boolean 存在返回true
     */
    private boolean checkHasOpeningPlan(Long id){
        Long count = SpringUtil.getBean(OpeningPlanService.class).lambdaQuery().eq(OpeningPlan::getTeacherId, id).count();
        return count>0;
    }

    private void kickUser(Long id){
        if (!Objects.isNull(id)){
            stringRedisTemplate.delete(RedisConstants.USER_TOKEN_KEY+id);
        }
    }

    // TODO: 2023/3/20 关于鉴权

}




