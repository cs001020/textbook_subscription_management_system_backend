package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.MajorDTO;
import com.chen.graduation.beans.DTO.SecondaryCollegeDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.MajorVO;
import com.chen.graduation.beans.VO.SecondaryCollegeVO;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.service.MajorService;
import com.chen.graduation.service.TeachingGroupService;
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
@Api(tags = "专业")
@ApiSupport(author = "1006596474@qq.com",order = 7)
@RestController
@RequestMapping("/major")
public class MajorController {
    @Resource
    private MajorService majorService;

    @GetMapping("/list/{id}")
    @ApiOperation(value = "根据二级学院获取专业列表")
    public AjaxResult<List<MajorVO>> list(@PathVariable Long id) {
        return majorService.listBySecondaryId(id);
    }

    @GetMapping("/list")
    @ApiOperation(value = "获取专业列表")
    public AjaxResult<List<MajorVO>> list() {
        return majorService.getList();
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "根据id删除专业")
    public AjaxResult<Object> deleteById(@PathVariable Long id) {
        return majorService.deleteById(id);
    }

    @PostMapping("/add")
    @ApiOperation(value = "添加专业")
    public AjaxResult<Object> add(@Validated @RequestBody MajorDTO majorDTO) {
        return majorService.add(majorDTO);
    }

    @PutMapping("/update/{id}")
    @ApiOperation(value = "根据id更新专业")
    public AjaxResult<Object> updateById(@RequestBody MajorDTO majorDTO, @PathVariable Long id) {
        return majorService.updateById(majorDTO,id);
    }
}
