package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.TextbookDTO;
import com.chen.graduation.beans.DTO.TextbookSearchDTO;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.enums.UniqueEnums;
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

    @Auth({"academic:textbook:list","textbookSubscription:openingPlan:submit","textbookSubscription:audit:resubmit"})
    @ApiOperation("搜索教材信息")
    @GetMapping("/search")
    public AjaxResult<List<TextbookVO>> pageQuery(@Validated TextbookSearchDTO textbookSearchDTO) {
        return textbookService.search(textbookSearchDTO);
    }

    @Auth({"academic:textbook:edit"})
    @ApiOperation("根据id获取教材信息")
    @GetMapping("/{id}")
    public AjaxResult<Textbook> getByIds(@PathVariable Long id) {
        return AjaxResult.success(textbookService.getById(id));
    }

    @Auth({"student:textbook:list"})
    @ApiOperation("我的教材")
    @GetMapping("/me")
    public AjaxResult<List<TextbookVO>> me() {
        return textbookService.me();
    }

    @Auth({SystemConstants.LOGIN_PERM})
    @ApiOperation("教材是否存在该名字图书")
    @GetMapping("/checkbookName")
    public AjaxResult<UniqueEnums> checkBookName(String name) {
        return textbookService.checkBookName(name);
    }

    @Auth({"academic:textbook:add"})
    @Log(title = "教材管理",businessTypeEnums = BusinessTypeEnums.INSERT)
    @ApiOperation("添加教材")
    @PostMapping("/addTextBook")
    public AjaxResult<Object> addTextBook(@Validated @RequestBody TextbookDTO textbookDTO) {
        return textbookService.addTextBook(textbookDTO);
    }

    @Auth({"academic:textbook:edit"})
    @Log(title = "教材管理",businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("添加教材库存")
    @PutMapping("/addStock/{id}")
    public AjaxResult<Object> addStock(@PathVariable Long id,Integer count) {
        return textbookService.addStock(id,count);
    }

    @Auth({"academic:textbook:edit"})
    @Log(title = "教材管理",businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("修改教材")
    @PutMapping("/update")
    public AjaxResult<Object> updateTextbook(@Validated @RequestBody Textbook textbook) {
        return textbookService.updateTextbook(textbook);
    }

    @Auth({"academic:textbook:disuse"})
    @Log(title = "教材管理",businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("弃用教材")
    @PutMapping("/discard/{id}")
    public AjaxResult<Object> discardTextbook(@PathVariable Long id) {
        return textbookService.discardTextbook(id);
    }
}
