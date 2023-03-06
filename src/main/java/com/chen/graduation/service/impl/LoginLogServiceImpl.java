package com.chen.graduation.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chen.graduation.beans.DTO.LoginLogSearchDTO;
import com.chen.graduation.beans.DTO.PageParamDTO;
import com.chen.graduation.beans.PO.LoginLog;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.beans.VO.LoginLogVO;
import com.chen.graduation.converter.LoginLogConverter;
import com.chen.graduation.service.LoginLogService;
import com.chen.graduation.mapper.LoginLogMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author CHEN
 * @description 针对表【tb_login_log(登录日志)】的数据库操作Service实现
 * @createDate 2023-02-20 17:04:52
 */
@Service
public class LoginLogServiceImpl extends ServiceImpl<LoginLogMapper, LoginLog>
        implements LoginLogService {

    @Resource
    private LoginLogConverter loginLogConverter;

    @Override
    public AjaxResult<List<LoginLogVO>> selectLoginLogList(LoginLogSearchDTO loginLogSearchDTO) {
        //获取分页参数
        PageParamDTO pageParamDTO = loginLogSearchDTO.getPageParamDTO();
        //查询
        Page<LoginLog> page = baseMapper.selectLoginLogList(new Page<>(pageParamDTO.getPage(), pageParamDTO.getSize()), loginLogSearchDTO);
        //转换对象
        List<LoginLogVO> loginLogVOList = loginLogConverter.po2vos(page.getRecords());
        //封装响应结果
        AjaxResult<List<LoginLogVO>> success = AjaxResult.success(loginLogVOList);
        success.setTotal(page.getTotal());
        //响应
        return success;
    }
}




