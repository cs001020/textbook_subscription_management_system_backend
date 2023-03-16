package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.DTO.TextbookSearchDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.service.TextbookService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 教科书控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "教材")
@ApiSupport(author = "1006596474@qq.com", order = 4)
@RestController
@RequestMapping("/textbook")
public class TextbookController {

    @Resource
    private TextbookService textbookService;

    @ApiOperation("搜索教材信息")
    @GetMapping("/search")
    public AjaxResult<List<TextbookVO>> pageQuery(@Validated TextbookSearchDTO textbookSearchDTO) {
        return textbookService.search(textbookSearchDTO);
    }

    @ApiOperation("更具id列表获取教材信息")
    @GetMapping("/byIds")
    public AjaxResult<List<TextbookVO>> getByIds(String ids) {
        return textbookService.getByIds(ids);
    }


    @ApiOperation("添加待审核教材")
    @PostMapping("/addTextBook")
    public AjaxResult<Object> addTextBook(@Validated @RequestBody TextbookDTO textbookDTO) {
        return textbookService.addTextBook(textbookDTO);
    }
    @ApiOperation("我的教材")
    @GetMapping("/me")
    public AjaxResult<List<TextbookVO>> me() {
        return textbookService.me();
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
