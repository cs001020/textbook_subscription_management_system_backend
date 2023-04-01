package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.PO.TextbookOrder;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.service.RoleService;
import com.chen.graduation.service.TextbookOrderService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


/**
 * 教科书订单控制器
 *
 * @author CHEN
 * @date 2023/03/16
 */
@Slf4j
@Api(tags = "教材订单")
@ApiSupport(author = "1006596474@qq.com", order = 7)
@RestController
@RequestMapping("/textbookOrder")
public class TextbookOrderController {

    @Resource
    private TextbookOrderService textbookOrderService;

    @ApiOperation("教材订单列表")
    @GetMapping("list")
    public AjaxResult<List<TextbookOrder>> getList(@Validated PageParamDTO pageParamDTO) {
        return textbookOrderService.pageQuery(pageParamDTO);
    }

    @ApiOperation("发放教材")
    @PostMapping("/grant/{id}")
    public AjaxResult<Object> grant( @PathVariable Long id) {
        return textbookOrderService.grant(id);
    }

    @ApiOperation("根据教材订单id获得教材信息")
    @GetMapping("/textbook/{id}")
    public AjaxResult<List<TextbookVO>> getTextBookListById(@PathVariable Long id){
        return textbookOrderService.getTextBookListById(id);
    }

}
