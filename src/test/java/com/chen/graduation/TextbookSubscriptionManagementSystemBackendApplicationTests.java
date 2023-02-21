package com.chen.graduation;

import cn.hutool.core.util.RandomUtil;
import com.chen.graduation.beans.PO.OpeningPlan;
import com.chen.graduation.beans.PO.Textbook;
import com.chen.graduation.beans.PO.User;
import com.chen.graduation.enums.UserStateEnums;
import com.chen.graduation.mapper.OpeningPlanMapper;
import com.chen.graduation.service.TextbookService;
import com.chen.graduation.service.UserService;
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

    @Resource
    private UserService userService;

    @Resource
    private OpeningPlanMapper openingPlanMapper;

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
    void openingPlanTest() {
        User byId = userService.getById(2);
        List<OpeningPlan> planByUser = openingPlanMapper.getPlanByUser(byId);
        planByUser.forEach(openingPlan -> {
            System.out.println(openingPlan);
            System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++");
            openingPlan.getOpeningPlanDetails().forEach(System.out::println);
        });
        log.info("TextbookSubscriptionManagementSystemBackendApplicationTests.openingPlanTest业务结束，结果:{}",planByUser.size());
    }
}
