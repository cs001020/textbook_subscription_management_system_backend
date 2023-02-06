package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.PO.TextbookOrder;
import com.chen.graduation.service.TextbookOrderService;
import com.chen.graduation.mapper.TextbookOrderMapper;
import org.springframework.stereotype.Service;

/**
* @author 10065
* @description 针对表【tb_textbook_order(教材订单)】的数据库操作Service实现
* @createDate 2023-01-27 17:06:37
*/
@Service
public class TextbookOrderServiceImpl extends ServiceImpl<TextbookOrderMapper, TextbookOrder>
    implements TextbookOrderService{

}




