package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.GradeDTO;
import com.chen.graduation.beans.PO.Grade;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.GradeVO;
import com.chen.graduation.converter.GradeConverter;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.GradeService;
import com.chen.graduation.mapper.GradeMapper;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_grade(班级)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class GradeServiceImpl extends ServiceImpl<GradeMapper, Grade>
    implements GradeService{

    @Resource
    private GradeConverter gradeConverter;
    @Resource
    private UserService userService;
    @Resource
    private OpeningPlanService openingPlanService;

    // TODO: 2023/2/23 缓存 日志
    @Override
    public AjaxResult<List<GradeVO>> listByMajorId(Long id) {
        List<Grade> list = lambdaQuery().eq(Grade::getMajorId, id).list();
        List<GradeVO> gradeVOList = gradeConverter.po2vos(list);
        log.info("GradeServiceImpl.listByMajorId业务结束，结果:{}",gradeVOList);
        return AjaxResult.success(gradeVOList);
    }

    @Override
    public AjaxResult<List<GradeVO>> listAll() {
        List<GradeVO> gradeVOList= baseMapper.listAll();
        log.info("GradeServiceImpl.listAll业务结束，结果:{}",gradeVOList);
        return AjaxResult.success(gradeVOList);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> add(GradeDTO gradeDTO) {
        //转换
        Grade grade = gradeConverter.dto2po(gradeDTO);
        //插入
        boolean save = this.save(grade);
        //打印日志
        log.info("GradeServiceImpl.add业务结束，结果:{}",save);
        //响应
        if (!save){
            throw new ServiceException("新增异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> delete(Long id) {
        //判断是否存在该班级用户
        if (checkForUserPresence(id)){
            throw new ServiceException("该班级下存在学生，无法删除");
        }
        //判断是否存在该班级的开课计划
        if (checkForOpeningPlanPresence(id)){
            throw new ServiceException("该班级下存在开课计划，无法删除");
        }
        //校验通过
        //删除该班级
        boolean remove = this.removeById(id);
        //日志
        log.info("GradeServiceImpl.delete业务结束，结果:{}",remove);
        //响应
        if (!remove){
            throw new ServiceException("删除发生未知异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> update(Long id, GradeDTO gradeDTO) {
        //封装
        Grade grade = gradeConverter.dto2po(gradeDTO);
        grade.setId(id);
        //更新
        boolean update = this.updateById(grade);
        //日志
        log.info("GradeServiceImpl.update业务结束，结果:{}",update);
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
        Page<User> page = userService.lambdaQuery().eq(User::getGradeId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }

    /**
     * 检查计划存在
     *
     * @param id id
     * @return 存在返回true 不存在返回false
     */
    private boolean checkForOpeningPlanPresence(Long id){
        Page<OpeningPlan> page = openingPlanService.lambdaQuery().eq(OpeningPlan::getGradeId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }
}




