package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.Permission;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.PO.RolePermission;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.constants.RedisConstants;
import com.chen.graduation.enums.PermissionStateEnums;
import com.chen.graduation.enums.PermissionTypeEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.PermissionService;
import com.chen.graduation.mapper.PermissionMapper;
import com.chen.graduation.service.RolePermissionService;
import com.chen.graduation.utils.PermissionUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * @author 10065
 * @description 针对表【tb_permission(权限)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission>
        implements PermissionService {

    @Resource
    private RolePermissionService rolePermissionService;

    @Override
    public List<Permission> getPermissionByUserId(Long userId) {
        return baseMapper.getPermissionByUserId(userId);
    }

    @Override
    public List<Permission> selectPermissionTreeByRoleId(Long roleId) {
        //查询所有权限
        List<Permission> allPermissionList = lambdaQuery().orderByAsc(Permission::getSortValue).list();
        //查询角色拥有的权限
        List<Permission> rolePermissionList = baseMapper.getPermissionByRoleId(roleId);
        //遍历
        for (Permission permission : allPermissionList) {
            for (Permission rolePermission : rolePermissionList) {
                if (permission.getId().longValue() == rolePermission.getId().longValue()) {
                    permission.setFlag(true);
                    break;
                }
            }
        }
        //树化 返回
        return PermissionUtils.buildTree(allPermissionList);
    }

    @Override
    public AjaxResult<List<Permission>> treeList(Permission permission) {
        //参数获取
        String name = permission.getName();
        PermissionStateEnums state = permission.getState();
        //查询
        List<Permission> list = this.lambdaQuery()
                .like(StrUtil.isNotBlank(name), Permission::getName, name)
                .eq(!Objects.isNull(state), Permission::getState, state)
                .orderByAsc(Permission::getSortValue)
                .list();
        //构建树形结构
        List<Permission> permissionList = PermissionUtils.buildTree(list);
        //日志
        log.info("PermissionServiceImpl.treeList业务结束，结果:{}", permissionList);
        //响应
        return AjaxResult.success(permissionList);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> insertPermission(Permission permission) {
        //合理性检查
        checkRationality(permission);
        //检查权限名唯一
        if (!checkPermissionNameUnique(permission)) {
            throw new ServiceException("新增权限'" + permission.getName() + "'失败，权限名称已存在");
        }
        //新增
        boolean save = save(permission);
        //日志
        log.info("PermissionServiceImpl.insertPermission业务结束，结果:{}", permission);
        //响应
        return AjaxResult.success(save);
    }

    @Override
    public AjaxResult<Permission> getPermissionByPermissionId(Long id) {
        //查询
        Permission permission = getById(id);
        //日志
        log.info("PermissionServiceImpl.getPermissionByPermissionId业务结束，结果:{}", permission);
        //响应
        return AjaxResult.success(permission);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> updatePermission(Permission permission) {
        //参数检查
        if (Objects.isNull(permission.getId())) {
            throw new ServiceException("参数异常");
        }
        //合理性检查
        checkRationality(permission);
        //检查权限名唯一
        if (!checkPermissionNameUnique(permission)) {
            throw new ServiceException("修改权限'" + permission.getName() + "'失败，权限名称已存在");
        }
        //更新
        boolean update = updateById(permission);
        //日志
        log.info("PermissionServiceImpl.updatePermission业务结束，结果:{}", permission);
        //响应
        return AjaxResult.success(update);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> deletePermissionById(Long id) {
        //子权限检查
        if (checkHasChildById(id)) {
            throw new ServiceException("存在子权限,不允许删除");
        }
        //角色分配检查
        if (checkMenuExistRole(id)) {
            throw new ServiceException("权限已分配,不允许删除");
        }
        //删除权限
        boolean remove = removeById(id);
        //日志
        log.info("PermissionServiceImpl.deletePermissionById业务结束，结果:{}", remove);
        //返回
        return AjaxResult.success(remove);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> changeState(Permission permission) {
        //参数获取
        Long id = permission.getId();
        PermissionStateEnums state = permission.getState();
        //校验
        if (Objects.isNull(id) || Objects.isNull(state)) {
            throw new ServiceException("参数异常");
        }
        //修改
        boolean update = lambdaUpdate().eq(Permission::getId, id).set(Permission::getState, state).update();
        //日志
        log.info("PermissionServiceImpl.changeState业务结束，结果:{}", update);
        //响应
        return AjaxResult.success(update);
    }

    /**
     * 通过用户id获得拥有的权限字符
     *
     * @param userId 用户id
     * @return {@link List}<{@link String}>
     */
    //@Cacheable(value = RedisConstants.USER_PERMISSION_KEY,key = "#userId.longValue()")
    @Override
    public List<String> getPermissionPermsByUserId(Long userId) {
        List<Permission> permissionByUserId = baseMapper.getPermissionByUserId(userId);
        return PermissionUtils.getButtonOrRequestPermission(permissionByUserId);
    }

    /**
     * 对权限的合理性检查
     * 不合理则会抛出业务异常
     *
     * @param permission 权限
     */
    private void checkRationality(Permission permission) {
        //空值判断
        if (Objects.isNull(permission) || Objects.isNull(permission.getParentId())) {
            throw new ServiceException("参数异常");
        }
        //通用检查
        if (!Objects.isNull(permission.getId())&&permission.getId().equals(permission.getParentId())) {
            throw new ServiceException("修改权限'" + permission.getName() + "'失败，上级权限不能选择自己");
        }
/*        // 获取上级权限
        Permission parentPermission=new Permission();
        if (!Objects.isNull(permission.getId())){
            parentPermission = lambdaQuery().eq(Permission::getId, permission.getParentId()).one();
        }
        //目录权限合理性检查
        if (PermissionTypeEnums.DIRECTORY.equals(permission.getType())){
            if (!permission.getParentId().equals(0L)) {
                throw new ServiceException("仅主目录可添加目录权限");
            }
            if (StrUtil.isNotBlank(permission.getComponent())) {
                throw new ServiceException("请勿给目录权限添加组件");
            }
            if (StrUtil.isNotBlank(permission.getPerms())) {
                throw new ServiceException("请勿给目录权限添加权限字符");
            }
            if (StrUtil.isBlank(permission.getIcon())) {
                throw new ServiceException("请选择图标");
            }
            if (StrUtil.isBlank(permission.getPath())) {
                throw new ServiceException("请输入路由路径");
            }
        }
        //路由权限合理性检查
        if (PermissionTypeEnums.ROUT.equals(permission.getType())){
            if (PermissionTypeEnums.BUTTON_REQUEST.equals(parentPermission.getType())){
                throw new ServiceException("按钮权限下禁止添加路由权限");
            }
            if (StrUtil.isBlank(permission.getIcon())) {
                throw new ServiceException("请选择图标");
            }
            if (StrUtil.isBlank(permission.getPath())) {
                throw new ServiceException("请输入路由路径");
            }
            if (StrUtil.isBlank(permission.getPerms())) {
                throw new ServiceException("请输入权限字符");
            }
        }
        //按钮权限合理性检查
        if (PermissionTypeEnums.DIRECTORY.equals(permission.getType())){
            if (!PermissionTypeEnums.ROUT.equals(parentPermission.getType())){
                throw new ServiceException("仅路由权限下可添加按钮权限");
            }
            if (StrUtil.isNotBlank(permission.getIcon())) {
                throw new ServiceException("请勿给按钮权限添加图标");
            }
            if (StrUtil.isNotBlank(permission.getPath())) {
                throw new ServiceException("请勿给按钮权限添加路径");
            }
            if (StrUtil.isNotBlank(permission.getComponent())) {
                throw new ServiceException("请勿给按钮权限添加组建");
            }
            if (StrUtil.isBlank(permission.getPerms())) {
                throw new ServiceException("请输入权限字符");
            }
        }*/
    }

    /**
     * 检查权限名唯一性
     *
     * @param permission 权限
     * @return boolean 唯一返回true
     */
    private boolean checkPermissionNameUnique(Permission permission) {
        Page<Permission> page = this.lambdaQuery().eq(Permission::getName, permission.getName()).page(new Page<>(1, 1));
        List<Permission> permissionList = page.getRecords();
        return CollUtil.isEmpty(permissionList) || permissionList.get(0).getId().equals(permission.getId());
    }

    /**
     * 检查是否存在子权限
     *
     * @param id id
     * @return boolean 存在子权限返回true
     */
    private boolean checkHasChildById(Long id) {
        List<Permission> permissionList = lambdaQuery().eq(Permission::getParentId, id).list();
        return CollUtil.isNotEmpty(permissionList);
    }

    /**
     * 检查菜单存在角色使用
     *
     * @param id id
     * @return boolean 存在返回true
     */
    private boolean checkMenuExistRole(Long id) {
        List<RolePermission> rolePermissionList = rolePermissionService.lambdaQuery().eq(RolePermission::getPermissionId, id).list();
        return CollUtil.isNotEmpty(rolePermissionList);
    }
    // TODO: 2023/3/22 关于鉴权
}




