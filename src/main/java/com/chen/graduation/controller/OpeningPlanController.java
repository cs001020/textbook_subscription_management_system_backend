package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.OpeningPlanDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.OpeningPlanVO;
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

    @ApiOperation("导入开课计划")
    @PostMapping("/import")
    public AjaxResult<Object> addPlan(@Validated @RequestBody OpeningPlanDTO openingPlanDTO) {
        return openingPlanService.addPlan(openingPlanDTO);
    }

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
    public AjaxResult<List<OpeningPlanVO>> getPlanById(@PathVariable Long id) {
        return openingPlanService.getPlanById(id);
    }
}
