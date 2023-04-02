package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.GradeDTO;
import com.chen.graduation.beans.DTO.group.GradeInsterGroup;
import com.chen.graduation.beans.DTO.group.GradeUpdateGroup;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.GradeVO;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.GradeService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


/**
 * 班级控制器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Slf4j
@Api(tags = "班级")
@ApiSupport(author = "1006596474@qq.com", order = 7)
@RestController
@RequestMapping("/grade")
public class GradeController {
    @Resource
    private GradeService gradeService;

    @Auth({"academic:grade:list"})
    @GetMapping("/list")
    @ApiOperation(value = "获取所有班级信息")
    public AjaxResult<List<GradeVO>> listAll() {
        return gradeService.listAll();
    }

    @Auth({"academic:grade:add"})
    @Log(title = "班级管理",businessTypeEnums = BusinessTypeEnums.INSERT)
    @PostMapping("/add")
    @ApiOperation(value = "新增班级")
    public AjaxResult<Object> add(@Validated(GradeInsterGroup.class) @RequestBody GradeDTO gradeDTO) {
        return gradeService.add(gradeDTO);
    }

    @Auth({"academic:grade:remove"})
    @Log(title = "班级管理",businessTypeEnums = BusinessTypeEnums.DELETE)
    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "删除班级")
    public AjaxResult<Object> delete(@PathVariable Long id) {
        return gradeService.delete(id);
    }

    @Auth({"academic:grade:edit"})
    @Log(title = "班级管理",businessTypeEnums = BusinessTypeEnums.UPDATE)
    @PutMapping("/update/{id}")
    @ApiOperation(value = "修改班级")
    public AjaxResult<Object> update(@PathVariable Long id, @Validated(GradeUpdateGroup.class) @RequestBody GradeDTO gradeDTO) {
        return gradeService.update(id,gradeDTO);
    }
}
