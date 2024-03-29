package com.chen.graduation;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.extra.spring.SpringUtil;
import cn.hutool.jwt.JWT;
import com.chen.graduation.beans.PO.*;
import com.chen.graduation.beans.VO.TextbookFeedbackVO;
import com.chen.graduation.constants.SystemConstants;
import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.mapper.OpeningPlanMapper;
import com.chen.graduation.mapper.TextbookFeedbackMapper;
import com.chen.graduation.service.SupplierService;
import com.chen.graduation.service.TextbookService;
import com.chen.graduation.service.UserService;
import com.github.javafaker.Faker;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ScheduledExecutorService;

@SpringBootTest
@Slf4j
class TextbookSubscriptionManagementSystemBackendApplicationTests {
    @Resource
    TextbookService textbookService;
    @Resource
    private UserService userService;
    @Resource
    private OpeningPlanMapper openingPlanMapper;
    @Resource
    private TextbookFeedbackMapper textbookFeedbackMapper;
    @Resource
    private SupplierService supplierService;

    @Test
    void tokenTest() {
        String token1 = JWT.create()
                .setPayload(SystemConstants.JWT_ID_PAYLOAD_KEY, 2L)
                .setPayload("hello", IdUtil.simpleUUID())
                .setKey("123456".getBytes())
                .sign();
        String token2 = JWT.create()
                .setPayload(SystemConstants.JWT_ID_PAYLOAD_KEY, 2L)
                .setPayload("hello", IdUtil.simpleUUID())
                .setKey("123456".getBytes())
                .sign();
        log.info("TextbookSubscriptionManagementSystemBackendApplicationTests.tokenTest业务结束，结果:{}",token1.equals(token2));
    }

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
        System.out.println(byId.getState().toString());
    }

    @Test
    void addStudent() {
        for (int i = 1; i < 11; i++) {
            User user = new User();
            user.setAccount("student"+i);
            user.setPassword("207acd61a3c1bd506d7e9a4535359f8a");
            user.setGradeId(1L);
            user.setName("学生"+i);
            user.setIcon("/icons/default-icon.png");
            user.setIntroduction("please set introduction");
            user.setState(UserStateEnums.NORMAL);
            userService.save(user);
        }
    }


    @Test
    void addSupplier() {
        Faker faker = new Faker(Locale.CHINA);
        for (int i = 1; i < 11; i++) {
            Supplier supplier = new Supplier();
            supplier.setName("供应商"+faker.name().fullName());
            supplier.setDescription("这是供应商"+i);
            supplier.setContactNumber(faker.phoneNumber().cellPhone());
            supplier.setEmail(supplier.getContactNumber()+"@gmail.com");
            supplier.setAddress(faker.address().fullAddress());
            supplierService.save(supplier);
        }
    }

    @Test
    void feedbackTest() {
        List<TextbookFeedback> feedbackByTextbookId = textbookFeedbackMapper.getFeedbackByTextbookId(1742L);
        feedbackByTextbookId.forEach(System.out::println);
    }

    @Test
    void name() {
        Object scheduledExecutorService1 = SpringUtil.getBean("scheduledExecutorService");
        System.out.println(scheduledExecutorService1);
    }
}
