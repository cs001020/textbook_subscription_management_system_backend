package com.chen.graduation.service;

import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.Approval;
import com.chen.graduation.beans.PO.TextbookOrder;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.VO.AjaxResult;

import java.util.List;

/**
* @author 10065
* @description 针对表【tb_textbook_order(教材订单)】的数据库操作Service
* @createDate 2023-01-27 17:06:37
*/
public interface TextbookOrderService extends IService<TextbookOrder> {

    /**
     * 生成教科书订单被批准
     *
     * @param approval 批准
     */
    void generateTextbooksOrderByApproval(Approval approval);

    /**
     * 页面查询
     *
     * @param pageParamDTO 页面参数dto
     * @return {@link AjaxResult}<{@link List}<{@link TextbookOrder}>>
     */
    AjaxResult<List<TextbookOrder>> pageQuery(PageParamDTO pageParamDTO);

    /**
     * 发放教材
     *
     * @param id id
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> grant(Long id);
}
