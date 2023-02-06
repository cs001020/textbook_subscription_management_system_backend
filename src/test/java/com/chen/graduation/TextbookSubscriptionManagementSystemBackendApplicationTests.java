package com.chen.graduation;

import cn.hutool.core.util.RandomUtil;
import com.alibaba.fastjson2.JSON;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.service.TextbookService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;

@SpringBootTest
@Slf4j
class TextbookSubscriptionManagementSystemBackendApplicationTests {
    @Resource
    TextbookService textbookService;

    @Test
    void contextLoads() {
        List<Textbook> list = textbookService.list();
        for (Textbook textbook : list) {
            textbook.setStock(RandomUtil.randomInt(100,1000));
        }
        boolean b = textbookService.updateBatchById(list);
        log.info("TextbookSubscriptionManagementSystemBackendApplicationTests.contextLoads业务结束，结果:{}",b);
    }

    @Test
    void enumTest() {
        Textbook byId = textbookService.getById(100);
        System.out.println(byId.getState().getStateName());
    }
}
