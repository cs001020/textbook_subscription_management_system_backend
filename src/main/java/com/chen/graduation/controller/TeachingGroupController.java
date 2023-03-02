package com.chen.graduation.controller;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.graduation.beans.DTO.TeachingGroupDTO;
import com.chen.graduation.beans.PO.Major;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.service.MajorService;
import com.chen.graduation.service.OpeningPlanService;
import com.chen.graduation.service.TeachingGroupService;
import com.chen.graduation.service.UserService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * teaching组控制器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Slf4j
@Api(tags = "教学组")
@ApiSupport(author = "1006596474@qq.com", order = 7)
@RestController
@RequestMapping("/teachingGroup")
public class TeachingGroupController {
    @Resource
    private TeachingGroupService teachingGroupService;

    @GetMapping("/list")
    @ApiOperation(value = "获取教学组列表")
    public AjaxResult<List<TeachingGroupVO>> list() {
        return teachingGroupService.getList();
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "根据id删除教学组")
    public AjaxResult<Object> deleteById(@PathVariable Long id) {
        return teachingGroupService.deleteById(id);
    }

    @PostMapping("/add")
    @ApiOperation(value = "添加教学组")
    public AjaxResult<Object> add(@Validated @RequestBody TeachingGroupDTO teachingGroupDTO) {
        return teachingGroupService.add(teachingGroupDTO);
    }

    @PutMapping("/update/{id}")
    @ApiOperation(value = "根据id跟新教学组")
    public AjaxResult<Object> updateById(@Validated @RequestBody TeachingGroupDTO teachingGroupDTO, @PathVariable Long id) {
        return teachingGroupService.updateById(teachingGroupDTO, id);
    }
}
