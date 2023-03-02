package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.GradeDTO;
import com.chen.graduation.beans.DTO.group.GradeInsterGroup;
import com.chen.graduation.beans.DTO.group.GradeUpdateGroup;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.GradeVO;
import com.chen.graduation.beans.VO.MajorVO;
import com.chen.graduation.service.GradeService;
import com.chen.graduation.service.MajorService;
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

    @GetMapping("/list/{id}")
    @ApiOperation(value = "根据专业获取班级业列表")
    public AjaxResult<List<GradeVO>> list(@PathVariable Long id) {
        return gradeService.listByMajorId(id);
    }

    @GetMapping("/list")
    @ApiOperation(value = "获取所有班级信息")
    public AjaxResult<List<GradeVO>> listAll() {
        return gradeService.listAll();
    }

    @PostMapping("/add")
    @ApiOperation(value = "新增班级")
    public AjaxResult<Object> add(@Validated(GradeInsterGroup.class) @RequestBody GradeDTO gradeDTO) {
        return gradeService.add(gradeDTO);
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "删除班级")
    public AjaxResult<Object> delete(@PathVariable Long id) {
        return gradeService.delete(id);
    }

    @DeleteMapping("/update/{id}")
    @ApiOperation(value = "修改班级")
    public AjaxResult<Object> update(@PathVariable Long id, @Validated(GradeUpdateGroup.class) @RequestBody GradeDTO gradeDTO) {
        return gradeService.update(id,gradeDTO);
    }
}
