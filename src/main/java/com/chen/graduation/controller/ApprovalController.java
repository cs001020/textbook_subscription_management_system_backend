package com.chen.graduation.controller;

import com.chen.graduation.beans.DTO.ApprovalDTO;
import com.chen.graduation.beans.DTO.ApprovalInsertDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.ApprovalVO;
import com.chen.graduation.service.ApprovalService;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 审批控制器
 *
 * @author CHEN
 * @date 2023/02/01
 */
@Api(tags = "审批")
@ApiSupport(author = "1006596474@qq.com",order = 3)
@RestController
@RequestMapping("/approval")
public class ApprovalController {

    @Resource
    private ApprovalService approvalService;

    @ApiOperation("教学组审批")
    @PostMapping("/teachingGroup/{id}")
    public AjaxResult<Object> teachingGroupApproval(@PathVariable Long id, @Validated @RequestBody ApprovalDTO approvalDTO) {
        return approvalService.teachingGroupApproval(id, approvalDTO);
    }

    @ApiOperation("二级学院审批")
    @PostMapping("/secondaryCollege/{id}")
    public AjaxResult<Object> secondaryCollegeApproval(@PathVariable Long id, @Validated @RequestBody ApprovalDTO approvalDTO) {
        return approvalService.secondaryCollegeApproval(id, approvalDTO);
    }

    @ApiOperation("教务处审批")
    @PostMapping("/academicAffairsOffice/{id}")
    public AjaxResult<Object> academicAffairsOfficeApproval(@PathVariable Long id, @Validated @RequestBody ApprovalDTO approvalDTO) {
        return approvalService.academicAffairsOfficeApproval(id, approvalDTO);
    }

    @ApiOperation("查看待审批申请")
    @GetMapping("/unApproval")
    public AjaxResult<List<ApprovalVO>> getUnApproval() {
        return approvalService.getUnApproval();
    }

    @ApiOperation("提交申请")
    @PostMapping("/submit")
    public AjaxResult<Object> submit(@Validated @RequestBody ApprovalInsertDTO approvalInsertDTO) {
        return approvalService.submit(approvalInsertDTO);
    }
}
