package com.chen.graduation.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.SecondaryCollegeDTO;
import com.chen.graduation.beans.PO.*;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;
import com.chen.graduation.converter.SecondaryCollegeConverter;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.service.MajorService;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.service.SecondaryCollegeService;
import com.chen.graduation.mapper.SecondaryCollegeMapper;
import com.chen.graduation.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
* @author 10065
* @description 针对表【tb_secondary_college(教学组)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
@Slf4j
public class SecondaryCollegeServiceImpl extends ServiceImpl<SecondaryCollegeMapper, SecondaryCollege>
    implements SecondaryCollegeService{

    @Resource
    private SecondaryCollegeConverter secondaryCollegeConverter;
    @Resource
    private UserService userService;
    @Resource
    private OpeningPlanService openingPlanService;
    @Resource
    private MajorService majorService;

    @Override
    public AjaxResult<List<SecondaryCollegeVO>> getList() {
        List<SecondaryCollege> list = this.list();
        List<SecondaryCollegeVO> secondaryCollegeVOList = secondaryCollegeConverter.po2vos(list);
        log.info("SecondaryCollegeServiceImpl.getList业务结束，结果:{}",secondaryCollegeVOList);
        return AjaxResult.success(secondaryCollegeVOList);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> deleteById(Long id) {
        //检查
        if (checkForMajorPresence(id)){
            throw new ServiceException("该二级学院下存在专业，无法删除！");
        }
        if (checkForOpeningPlanPresence(id)){
            throw new ServiceException("该二级学院下存在开课计划，无法删除！");
        }
        if (checkForUserPresence(id)){
            throw new ServiceException("该二级学院下存在用户，无法删除！");
        }
        //校验通过
        //删除该班级
        boolean remove = this.removeById(id);
        //日志
        log.info("SecondaryCollegeServiceImpl.deleteById业务结束，结果:{}",remove);
        //响应
        if (!remove){
            throw new ServiceException("删除发生未知异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> add(SecondaryCollegeDTO secondaryCollegeDTO) {
        //转换
        SecondaryCollege secondaryCollege = secondaryCollegeConverter.dto2po(secondaryCollegeDTO);
        //插入
        boolean save = this.save(secondaryCollege);
        //打印日志
        log.info("SecondaryCollegeServiceImpl.add业务结束，结果:{}",save);
        //响应
        if (!save){
            throw new ServiceException("新增异常");
        }
        return AjaxResult.success();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> updateById(SecondaryCollegeDTO secondaryCollegeDTO, Long id) {
        //封装
        SecondaryCollege secondaryCollege = secondaryCollegeConverter.dto2po(secondaryCollegeDTO);
        secondaryCollege.setId(id);
        //更新
        boolean update = this.updateById(secondaryCollege);
        //日志
        log.info("SecondaryCollegeServiceImpl.updateById业务结束，结果:{}",update);
        //响应
        if (!update){
            throw new ServiceException("更新发生未知异常，请稍后再试！");
        }
        return AjaxResult.success();
    }

    @Override
    public AjaxResult<List<SecondaryCollege>> getGrade() {
        //查询
        List<SecondaryCollege> secondaryCollegeList=baseMapper.getGrade();
        //遍历 设置班级名
        for (SecondaryCollege secondaryCollege : secondaryCollegeList) {
            for (Major major : secondaryCollege.getChildren()) {
                List<Grade> gradeList = major.getChildren();
                if (CollUtil.isNotEmpty(gradeList)){
                    for (Grade grade : gradeList) {
                        grade.setName(grade.getYear()+"级"+grade.getNumber()+"班");
                    }
                }
            }
        }
        //响应
        return AjaxResult.success(secondaryCollegeList);
    }

    /**
     * 检查用户是否存在
     *
     * @param id id
     * @return 存在返回true 不存在返回false
     */
    private boolean checkForUserPresence(Long id) {
        Page<User> page = userService.lambdaQuery().eq(User::getSecondaryCollegeId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }

    /**
     * 检查计划存在
     *
     * @param id id
     * @return 存在返回true 不存在返回false
     */
    private boolean checkForOpeningPlanPresence(Long id) {
        Page<OpeningPlan> page = openingPlanService.lambdaQuery().eq(OpeningPlan::getSecondaryCollegeId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }

    /**
     * 检查专业存在
     *
     * @param id id 存在返回true 不存在返回false
     * @return boolean
     */
    private boolean checkForMajorPresence(Long id) {
        Page<Major> page = majorService.lambdaQuery().eq(Major::getSecondaryCollegeId, id).page(new Page<>(1, 1));
        return CollUtil.isNotEmpty(page.getRecords());
    }
}




