package com.chen.graduation.beans.VO;

import com.chen.graduation.beans.PO.Role;
import com.chen.graduation.beans.PO.SecondaryCollege;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * 教学组和二级学院与班级（树形）
 *
 * @author CHEN
 * @date 2023/04/03
 */
@Data
@ApiModel("教学组和二级学院与班级（树形）")
public class TeachingGroupAndSecondaryCollegeAndGradeTree {
    @ApiModelProperty("角色")
    private List<Role> roles;
    @ApiModelProperty("教学组")
    private List<TeachingGroupVO> teachingGroup;
    @ApiModelProperty("二级学院")
    private List<SecondaryCollegeVO> secondaryCollege;
    @ApiModelProperty("班级(树形结构)")
    private List<SecondaryCollege> gradeTree;
}
