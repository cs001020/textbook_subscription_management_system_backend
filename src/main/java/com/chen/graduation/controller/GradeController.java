package com.chen.graduation.controller;

import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.GradeVO;
import com.chen.graduation.beans.VO.MajorVO;
import com.chen.graduation.service.GradeService;
import com.chen.graduation.service.MajorService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
@ApiSupport(author = "1006596474@qq.com")
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
}
