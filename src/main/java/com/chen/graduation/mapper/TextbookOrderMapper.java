package com.chen.graduation.mapper;

import com.chen.graduation.beans.PO.TextbookOrder;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.chen.graduation.beans.TextbookIdsAndGradePeople;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
* @author 10065
* @description 针对表【tb_textbook_order(教材订单)】的数据库操作Mapper
* @createDate 2023-01-27 17:06:37
* @Entity com.chen.graduation.domain.TextbookOrder
*/
public interface TextbookOrderMapper extends BaseMapper<TextbookOrder> {

    /**
     * 查询id和年级教科书通过批准id数
     *
     * @param approvalId 批准id
     * @return {@link Map}<{@link String}, {@link Integer}>
     */
    TextbookIdsAndGradePeople queryTextbookIdAndGradeNumberByApprovalId(@Param("approvalId") Long approvalId);
}




