package com.chen.graduation.controller;

import cn.hutool.core.util.IdUtil;
import com.chen.graduation.annotation.Log;
import com.chen.graduation.beans.VO.AjaxResult;
import com.chen.graduation.enums.BusinessTypeEnums;
import com.chen.graduation.service.FileService;
import com.chen.graduation.utils.FileUtils;
import com.github.xiaoymin.knife4j.annotations.ApiSupport;
import com.qiniu.http.Response;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Objects;

/**
 * 文件控制器
 *
 * @author CHEN
 * @date 2023/02/21
 */
@Api(tags = "文件")
@ApiSupport(author = "1006596474@qq.com",order = 8)
@RestController
@RequestMapping("/file")
public class FileController {
    @Resource
    private FileService fileService;

    @Log(title = "文件模块",businessTypeEnums = BusinessTypeEnums.UPLOAD)
    @ApiOperation("图片文件上传,最大5MB")
    @PostMapping("/upload/img")
    public AjaxResult<Object> adminUpload(MultipartFile file) {
        return fileService.uploadImg(file);
    }
}
