package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.service.TextbookService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 教科书控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "教材")
@ApiSupport(author = "1006596474@qq.com")
@RestController
@RequestMapping("/textbook")
public class TextbookController {

    @Resource
    private TextbookService textbookService;

    @ApiOperation("分页查询教材信息")
    @GetMapping("/page")
    public AjaxResult<List<TextbookVO>> pageQuery(@Validated PageParamDTO pageParamDTO) {
        return textbookService.pageQuery(pageParamDTO);
    }

    @ApiOperation("搜索教材信息")
    @PostMapping("/search")
    public AjaxResult<Object> search() {
        // TODO: 2023/2/1 搜索教材信息 for cs
        return AjaxResult.success();
    }

    @ApiOperation("添加待审核教材")
    @PostMapping("/add")
    public AjaxResult<Object> add() {
        // TODO: 2023/2/1 添加待审核教材 for cs
        return AjaxResult.success();
    }

    @ApiOperation("教材入库")
    @PostMapping("/storage")
    public AjaxResult<Object> storage() {
        // TODO: 2023/2/1 教材入库 for cs
        return AjaxResult.success();
    }

    @ApiOperation("教材发放")
    @PostMapping("/distribution")
    public AjaxResult<Object> distribution() {
        // TODO: 2023/2/1 教材发放 for cs
        return AjaxResult.success();
    }
}
