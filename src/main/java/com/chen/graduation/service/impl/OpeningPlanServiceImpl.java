package com.chen.graduation.service.impl;

import cn.hutool.core.util.BooleanUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.OpeningPlanDTO;
import com.chen.graduation.beans.DTO.OpeningPlanDetailDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.*;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OpeningPlanVO;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.converter.OpeningPlanConverter;
import com.chen.graduation.enums.OpenPlanDetailsTypeEnums;
import com.chen.graduation.enums.OpenPlanStateEnums;
import com.chen.graduation.enums.UserTypeEnums;
import com.chen.graduation.exception.ServiceException;
import com.chen.graduation.interceptor.UserHolderContext;
import com.chen.graduation.service.*;
import com.chen.graduation.mapper.OpeningPlanMapper;
import com.chen.graduation.utils.AsyncFactory;
import com.chen.graduation.utils.AsyncManager;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author 10065
 * @description 针对表【tb_opening_plan(开课计划)】的数据库操作Service实现
 * @createDate 2023-01-27 17:06:37
 */
@Service
@Slf4j
public class OpeningPlanServiceImpl extends ServiceImpl<OpeningPlanMapper, OpeningPlan>
        implements OpeningPlanService {
    @Resource
    private UserService userService;
    @Resource
    private OpeningPlanConverter openingPlanConverter;
    @Resource
    private OpeningPlanDetailService openingPlanDetailService;

    @Override
    public AjaxResult<List<OpeningPlanVO>> getPlan() {
        //查询当前登陆用户
        Long userId = UserHolderContext.getUserId();
        User user = userService.getById(userId);
        //查询开课计划
        List<OpeningPlanVO> openingPlanVOList = baseMapper.getPlanByUser(user);
        //打印日志
        log.info("OpeningPlanServiceImpl.getPlan业务结束，结果:{}", openingPlanVOList);
        //返回结果
        return AjaxResult.success(openingPlanVOList);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> addPlan(OpeningPlanDTO openingPlanDTO) {
        // 参数校验
        if (!idsCheck(openingPlanDTO)){
            throw new ServiceException("参数异常");
        }
        //分解参数
        OpeningPlan openingPlan = openingPlanConverter.dto2po(openingPlanDTO);
        List<OpeningPlanDetail> openingPlanDetails = openingPlan.getOpeningPlanDetails();
        //添加开课计划(返回id)
        boolean save1 = this.save(openingPlan);
        //开课计划详情设置开课计划id
        openingPlanDetails.forEach(openingPlanDetail -> {
            openingPlanDetail.setOpeningPlanId(openingPlan.getId());
        });
        //添加开课计划详情
        boolean save2 = openingPlanDetailService.saveBatch(openingPlanDetails);
        //判断结果
        boolean success = (BooleanUtil.isTrue(save1) && save1 == save2);
        //打印日志
        log.info("OpeningPlanServiceImpl.addPlan业务结束，结果:{}", success);
        //返回结果
        if (success) {
            return AjaxResult.success();
        }
        return AjaxResult.error();
    }

    @Override
    public AjaxResult<List<OpeningPlanVO>> getAllPlanList() {
        //查询开课计划
        List<OpeningPlanVO> openingPlanList = baseMapper.getAllPlanList();
        //打印日志
        log.info("OpeningPlanServiceImpl.getPlan业务结束，结果:{}", openingPlanList);
        //返回结果
        return AjaxResult.success(openingPlanList);
    }

    @Override
    public AjaxResult<OpeningPlanVO> getPlanById(Long id) {
        //查询开课计划
        OpeningPlanVO planVO = baseMapper.getPlanById(id);
        //打印日志
        log.info("OpeningPlanServiceImpl.getPlan业务结束，结果:{}", planVO);
        //返回结果
        return AjaxResult.success(planVO);
    }

    @Override
    public AjaxResult<List<OpeningPlanDetail>> selectCourse(PageParamDTO pageParamDTO, OpeningPlanDetail openingPlanDetail) {
        //获取参数
        String courseName = openingPlanDetail.getCourseName();
        OpenPlanDetailsTypeEnums type = openingPlanDetail.getType();
        //数据库查询
        Page<OpeningPlanDetail> page = openingPlanDetailService
                .lambdaQuery()
                .like(StrUtil.isNotBlank(courseName),OpeningPlanDetail::getCourseName,courseName)
                .eq(!Objects.isNull(type),OpeningPlanDetail::getType,type)
                .page(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()));
        //封装响应对象
        AjaxResult<List<OpeningPlanDetail>> success = AjaxResult.success(page.getRecords());
        success.setTotal(page.getTotal());
        //日志
        log.info("OpeningPlanServiceImpl.selectCourse业务结束，结果:{}",success);
        //响应
        return success;
    }

    @Override
    public AjaxResult<List<SecondaryCollege>> getGrade() {
        return SpringUtil.getBean(SecondaryCollegeService.class).getGrade();
    }

    @Override
    public AjaxResult<List<TeachingGroupVO>> getTeachingGroup() {
        return SpringUtil.getBean(TeachingGroupService.class).getList();
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> deleteById(Long id) {
        //查询开课计划
        OpeningPlan openingPlan = getById(id);
        //完成审核 无法删除
        if (OpenPlanStateEnums.APPROVAL_COMPLETED.equals(openingPlan.getState())){
            throw new ServiceException("该开课计划已经完成教材审核,无法删除");
        }
        //获取审核
        ApprovalService approvalService = SpringUtil.getBean(ApprovalService.class);
        Approval approval = approvalService.lambdaQuery().eq(Approval::getOpeningPlanId, id).one();
        //存在审核 删除
        if (!Objects.isNull(approval)){
            //删除审核
            approvalService.removeById(approval.getId());
            //异步删除审核中图书
            AsyncManager.me().execute(AsyncFactory.deleteAuditTextbook(approval.getTextbookIds()));
        }

        //删除课程
        openingPlanDetailService.lambdaUpdate().eq(OpeningPlanDetail::getOpeningPlanId,openingPlan.getId()).remove();
        //删除开课计划
        boolean remove = removeById(id);
        return AjaxResult.success(remove);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public AjaxResult<Object> updateOpeningPlan(OpeningPlanDTO openingPlanDTO, Long id) {
        //查询开课计划
        OpeningPlan openingPlan = getById(id);
        //选定教材后 无法修改
        if (!OpenPlanStateEnums.TEXTBOOKS_TO_BE_SELECT.equals(openingPlan.getState())){
            throw new ServiceException("该开课计划已经选择教材,无法修改");
        }
        //构建课程
        List<OpeningPlanDetail> openingPlanDetails = new ArrayList<>();
        for (OpeningPlanDetailDTO openingPlanDetailDTO : openingPlanDTO.getOpeningPlanDetailDTOList()) {
            OpeningPlanDetail openingPlanDetail = new OpeningPlanDetail();
            openingPlanDetail.setOpeningPlanId(openingPlan.getId());
            openingPlanDetail.setCourseName(openingPlanDetailDTO.getCourseName());
            openingPlanDetail.setCredit(openingPlanDetailDTO.getCredit());
            openingPlanDetail.setTeachingHours(openingPlanDetailDTO.getTeachingHours());
            openingPlanDetail.setWeeksTeach(openingPlanDetailDTO.getWeeksTeach());
            openingPlanDetail.setType(openingPlanDetailDTO.getType());
            openingPlanDetails.add(openingPlanDetail);
        }
        //删除旧课程
        openingPlanDetailService.lambdaUpdate().eq(OpeningPlanDetail::getOpeningPlanId,openingPlan.getId()).remove();
        //添加新课程
        openingPlanDetailService.saveBatch(openingPlanDetails);
        //更新开课计划
        openingPlan.setSecondaryCollegeId(openingPlanDTO.getSecondaryCollegeId());
        openingPlan.setTeacherId(openingPlanDTO.getTeacherId());
        openingPlan.setGradeId(openingPlanDTO.getGradeId());
        openingPlan.setTeachingGroupId(openingPlanDTO.getTeachingGroupId());
        openingPlan.setCreateTime(null);
        boolean update = updateById(openingPlan);
        //日志
        log.info("OpeningPlanServiceImpl.updateOpeningPlan业务结束，结果:{}",update);
        //响应
        return AjaxResult.success(update);
    }

    @Override
    public AjaxResult<List<OpeningPlanDetail>> getCourseById(Long id) {
        List<OpeningPlanDetail> list = openingPlanDetailService.lambdaQuery().eq(OpeningPlanDetail::getOpeningPlanId, id).list();
        return AjaxResult.success(list);
    }

    /**
     * ids检查
     * 不通过返回false
     *
     * @param openingPlanDTO 开放计划dto
     * @return boolean
     */
    private boolean idsCheck(OpeningPlanDTO openingPlanDTO) {
        // id 获取
        Long teacherId = openingPlanDTO.getTeacherId();
        Long teachingGroupId = openingPlanDTO.getTeachingGroupId();
        Long secondaryCollegeId = openingPlanDTO.getSecondaryCollegeId();
        Long gradeId = openingPlanDTO.getGradeId();
        //获取教师
        User user = userService.getById(teacherId);
        if (Objects.isNull(user)|| !UserTypeEnums.TEACHER.equals(user.getType())){
            return false;
        }
        // 教学组
        TeachingGroup teachingGroup = SpringUtil.getBean(TeachingGroupService.class).getById(teachingGroupId);
        if (Objects.isNull(teachingGroup)){
            return false;
        }
        // 二级学院
        SecondaryCollege secondaryCollege = SpringUtil.getBean(SecondaryCollegeService.class).getById(secondaryCollegeId);
        if (Objects.isNull(secondaryCollege)){
            return false;
        }
        //班级
        Grade grade = SpringUtil.getBean(GradeService.class).getById(gradeId);
        if (Objects.isNull(grade)){
            return false;
        }
        return true;
    }
}




