package com.chen.graduation.controller;

import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.MajorVO;
import com.chen.graduation.beans.VO.TeachingGroupVO;
import com.chen.graduation.service.MajorService;
import com.chen.graduation.service.TeachingGroupService;
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
 * teaching组控制器
 *
 * @author CHEN
 * @date 2023/02/23
 */
@Slf4j
@Api(tags = "专业")
@ApiSupport(author = "1006596474@qq.com")
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
}
