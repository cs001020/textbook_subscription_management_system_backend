package com.chen.graduation.controller;

import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.OpeningPlanDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.OpeningPlanDetail;
import com.chen.graduation.beans.PO.SecondaryCollege;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OpeningPlanVO;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.OpeningPlanService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 开课计划控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "开课计划")
@ApiSupport(author = "1006596474@qq.com", order = 2)
@RestController
@RequestMapping("/plan")
public class OpeningPlanController {

    @Resource
    private OpeningPlanService openingPlanService;

    @ApiOperation("查看开课计划(属于当前登录用户的开课计划)")
    @GetMapping("/me")
    public AjaxResult<List<OpeningPlanVO>> getPlanByUser() {
        return openingPlanService.getPlan();
    }

    @ApiOperation("查看所有开课计划")
    @GetMapping("/list")
    public AjaxResult<List<OpeningPlanVO>> getAllPlanList() {
        return openingPlanService.getAllPlanList();
    }

    @ApiOperation("根据id查看开课计划")
    @GetMapping("/{id}")
    public AjaxResult<OpeningPlanVO> getPlanById(@PathVariable Long id) {
        return openingPlanService.getPlanById(id);
    }

    @ApiOperation("查询课程")
    @GetMapping("/course")
    public AjaxResult<List<OpeningPlanDetail>> course(@Validated PageParamDTO pageParamDTO, OpeningPlanDetail openingPlanDetail) {
        return openingPlanService.selectCourse(pageParamDTO, openingPlanDetail);
    }

    @ApiOperation("获取班级(树形结构)")
    @GetMapping("/garde")
    public AjaxResult<List<SecondaryCollege>> getGrade() {
        return openingPlanService.getGrade();
    }

    @ApiOperation("获取教学组")
    @GetMapping("/teachingGroup")
    public AjaxResult<List<TeachingGroupVO>> getTeachingGroup() {
        return openingPlanService.getTeachingGroup();
    }

    @Log(title = "开课计划管理", businessTypeEnums = BusinessTypeEnums.INSERT)
    @ApiOperation("导入开课计划")
    @PostMapping("/import")
    public AjaxResult<Object> addPlan(@Validated @RequestBody OpeningPlanDTO openingPlanDTO) {
        return openingPlanService.addPlan(openingPlanDTO);
    }

    @Log(title = "开课计划管理", businessTypeEnums = BusinessTypeEnums.DELETE)
    @ApiOperation("删除开课计划")
    @DeleteMapping("/{id}")
    public AjaxResult<Object> deleteById(@PathVariable Long id) {
        return openingPlanService.deleteById(id);
    }
}
