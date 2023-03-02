package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.TeachingGroupDTO;
import com.chen.graduation.beans.PO.Grade;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.TeachingGroup;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.converter.TeachingGroupConverter;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.service.TeachingGroupService;
import com.chen.graduation.mapper.TeachingGroupMapper;
import com.chen.graduation.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_teaching_group】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class TeachingGroupServiceImpl extends ServiceImpl<TeachingGroupMapper, TeachingGroup>
    implements TeachingGroupService{
    @Resource
    private TeachingGroupConverter teachingGroupConverter;
    @Resource
    private UserService userService;
    @Resource
    private OpeningPlanService openingPlanService;

    // TODO: 2023/2/23 缓存
    @Override
    public AjaxResult<List<TeachingGroupVO>> getList() {
        List<TeachingGroup> list = this.list();
        List<TeachingGroupVO> teachingGroupVOList = teachingGroupConverter.po2vos(list);
        log.info("TeachingGroupServiceImpl.getList业务结束，结果:{}",teachingGroupVOList);
        return AjaxResult.success(teachingGroupVOList);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> deleteById(Long id) {
        //判断是否存在该班级用户
        if (checkForUserPresence(id)){
            throw new ServiceException("该教学组下存在教师，无法删除");
        }
        //判断是否存在该班级的开课计划
        if (checkForOpeningPlanPresence(id)){
            throw new ServiceException("该教学组下存在开课计划，无法删除");
        }
        //校验通过
        //删除该班级
        boolean remove = this.removeById(id);
        //日志
        log.info("TeachingGroupServiceImpl.deleteById业务结束，结果:{}",remove);
        //响应
        if (!remove){
            throw new ServiceException("删除发生未知异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> add(TeachingGroupDTO teachingGroupDTO) {
        //转换
        TeachingGroup teachingGroup = teachingGroupConverter.dto2po(teachingGroupDTO);
        //插入
        boolean save = this.save(teachingGroup);
        //打印日志
        log.info("TeachingGroupServiceImpl.add业务结束，结果:{}",save);
        //响应
        if (!save){
            throw new ServiceException("新增异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> updateById(TeachingGroupDTO teachingGroupDTO, Long id) {
        //封装
        TeachingGroup teachingGroup = teachingGroupConverter.dto2po(teachingGroupDTO);
        teachingGroup.setId(id);
        //更新
        boolean update = this.updateById(teachingGroup);
        //日志
        log.info("TeachingGroupServiceImpl.updateById业务结束，结果:{}",update);
        //响应
        if (!update){
            throw new ServiceException("更新发生未知异常，请稍后再试！");
        }
        return AjaxResult.success();
    }

    /**
     * 检查用户是否存在
     *
     * @param id id
     * @return 存在返回true 不存在返回false
     */
    private boolean checkForUserPresence(Long id){
        Page<User> page = userService.lambdaQuery().eq(User::getTeachingGroupId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }

    /**
     * 检查计划存在
     *
     * @param id id
     * @return 存在返回true 不存在返回false
     */
    private boolean checkForOpeningPlanPresence(Long id){
        Page<OpeningPlan> page = openingPlanService.lambdaQuery().eq(OpeningPlan::getTeacherId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }
}




