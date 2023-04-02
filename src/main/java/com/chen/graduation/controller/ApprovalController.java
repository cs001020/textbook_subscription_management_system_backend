package com.chen.graduation.controller;

import com.chen.graduation.annotation.Auth;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.DTO.ApprovalDTO;
import com.chen.graduation.beans.DTO.ApprovalInsertDTO;
import com.chen.graduation.beans.DTO.ApprovalSearchDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.ApprovalDetailVO;
import com.chen.graduation.beans.VO.ApprovalVO;
import com.chen.graduation.beans.VO.TextbookVO;
import com.chen.graduation.enums.ApprovalTotalStateEnums;
import com.chen.graduation.enums.BusinessTypeEnums;
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
@ApiSupport(author = "1006596474@qq.com", order = 3)
@RestController
@RequestMapping("/approval")
public class ApprovalController {

    @Resource
    private ApprovalService approvalService;

    @Auth({"academic:audit:list"})
    @ApiOperation("查看所有教材申请")
    @GetMapping("/list")
    public AjaxResult<List<ApprovalVO>> getApprovalList(@Validated PageParamDTO pageParamDTO, ApprovalSearchDTO approvalSearchDTO) {
        return approvalService.getApprovalList(pageParamDTO,approvalSearchDTO);
    }

    @Auth({"textbookSubscription:openingPlan:resubmit","academic:audit:list","textbookSubscription:audit:list","textbookSubscription:teachingGroup:list","textbookSubscription:secondaryCollege:list","textbookSubscription:academic:list"})
    @ApiOperation("根据id查看教材申请详情")
    @GetMapping("/details/{id}")
    public AjaxResult<ApprovalDetailVO> getApprovalDetails(@PathVariable Long id) {
        return approvalService.getApprovalDetailsById(id);
    }

    @Auth({"textbookSubscription:audit:resubmit","academic:audit:list","textbookSubscription:audit:list","textbookSubscription:teachingGroup:list","textbookSubscription:secondaryCollege:list","textbookSubscription:academic:list"})
    @ApiOperation("根据审核id获取教材信息")
    @GetMapping("/textbook/{id}")
    public AjaxResult<List<TextbookVO>> getTextbookList( @PathVariable Long id) {
        return approvalService.getTextbookList(id);
    }

    @Auth({"textbookSubscription:audit:resubmit"})
    @ApiOperation("查看我的教材申请")
    @GetMapping("/me")
    public AjaxResult<List<ApprovalVO>> getApprovalForMe() {
        return approvalService.getApprovalByUser();
    }

    @Auth({"textbookSubscription:teachingGroup:list"})
    @ApiOperation("查看教学组待审核")
    @GetMapping("/unApproval/teachingGroup")
    public AjaxResult<List<ApprovalVO>> getUnApprovalForTeachingGroup() {
        return approvalService.getApprovalByStateAndUser(ApprovalTotalStateEnums.WAIT_GROUP);
    }

    @Auth({"textbookSubscription:secondaryCollege:list"})
    @ApiOperation("查看二级学院待审核")
    @GetMapping("/unApproval/secondaryCollege")
    public AjaxResult<List<ApprovalVO>> getUnApprovalForSecondaryCollege() {
        return approvalService.getApprovalByStateAndUser(ApprovalTotalStateEnums.WAIT_SECONDARY);
    }

    @Auth({"textbookSubscription:academic:list"})
    @ApiOperation("查看教务处待审核")
    @GetMapping("/unApproval/academicAffairsOffice")
    public AjaxResult<List<ApprovalVO>> getUnApprovalForAcademicAffairsOffice() {
        return approvalService.getApprovalByStateAndUser(ApprovalTotalStateEnums.WAIT_OFFICE);
    }

    @Auth({"textbookSubscription:openingPlan:submit"})
    @Log(title = "教材申请管理",businessTypeEnums = BusinessTypeEnums.INSERT)
    @ApiOperation("提交申请")
    @PostMapping("/submit")
    public AjaxResult<Object> submit(@Validated @RequestBody ApprovalInsertDTO approvalInsertDTO) {
        return approvalService.submit(approvalInsertDTO);
    }
    @Auth({"textbookSubscription:audit:resubmit"})
    @Log(title = "教材申请管理",businessTypeEnums = BusinessTypeEnums.UPDATE)
    @ApiOperation("重新提交申请")
    @PostMapping("/reSubmit/{id}")
    public AjaxResult<Object> reSubmit(@Validated @RequestBody ApprovalInsertDTO approvalInsertDTO,@PathVariable Long id) {
        return approvalService.reSubmit(approvalInsertDTO,id);
    }

    @Auth({"textbookSubscription:teachingGroup:audit"})
    @Log(title = "教材申请管理",businessTypeEnums = BusinessTypeEnums.AUDIT)
    @ApiOperation("教学组审批")
    @PostMapping("/teachingGroup/{id}")
    public AjaxResult<Object> teachingGroupApproval(@PathVariable Long id, @Validated @RequestBody ApprovalDTO approvalDTO) {
        return approvalService.teachingGroupApproval(id, approvalDTO);
    }

    @Auth({"textbookSubscription:secondaryCollege:audit"})
    @Log(title = "教材申请管理",businessTypeEnums = BusinessTypeEnums.AUDIT)
    @ApiOperation("二级学院审批")
    @PostMapping("/secondaryCollege/{id}")
    public AjaxResult<Object> secondaryCollegeApproval(@PathVariable Long id, @Validated @RequestBody ApprovalDTO approvalDTO) {
        return approvalService.secondaryCollegeApproval(id, approvalDTO);
    }

    @Auth({"textbookSubscription:academic:audit"})
    @Log(title = "教材申请管理",businessTypeEnums = BusinessTypeEnums.AUDIT)
    @ApiOperation("教务处审批")
    @PostMapping("/academicAffairsOffice/{id}")
    public AjaxResult<Object> academicAffairsOfficeApproval(@PathVariable Long id, @Validated @RequestBody ApprovalDTO approvalDTO) {
        return approvalService.academicAffairsOfficeApproval(id, approvalDTO);
    }

    @Auth({"academic:audit:remove"})
    @Log(title = "教材申请管理",businessTypeEnums = BusinessTypeEnums.DELETE)
    @ApiOperation("管理员删除审批")
    @DeleteMapping("/admin/{id}")
    public AjaxResult<Object> adminDelete(@PathVariable Long id) {
        return approvalService.adminDelete(id);
    }
}
