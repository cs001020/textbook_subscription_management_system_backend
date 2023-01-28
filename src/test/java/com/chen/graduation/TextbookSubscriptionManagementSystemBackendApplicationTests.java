package com.chen.graduation;

import com.chen.graduation.model.DO.Textbook;
import com.chen.graduation.model.VO.AjaxResult;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class TextbookSubscriptionManagementSystemBackendApplicationTests {

    @Test
    void contextLoads() {
        AjaxResult<Textbook> success = new AjaxResult<>(AjaxResult.ResponseType.SUCCESS, "success", new Textbook());
        success.putExtra("total",1000);
    }

}
