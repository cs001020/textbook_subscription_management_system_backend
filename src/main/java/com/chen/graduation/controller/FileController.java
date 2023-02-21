package com.chen.graduation.controller;

import cn.hutool.core.util.IdUtil;
import com.chen.graduation.beans.VO.AjaxResult;
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
@ApiSupport(author = "1006596474@qq.com")
@RestController
@RequestMapping("/file")
@Slf4j
public class FileController {
    @Resource
    private FileUtils fileUtils;

    @ApiOperation("文件上传,最大5MB")
    @PostMapping("/upload")
    public AjaxResult<Object> adminUpload(MultipartFile file) {
        if (Objects.isNull(file)){
            log.warn("ProductController.adminUpload业务结束，结果:{}","上传失败,空文件");
            return AjaxResult.error("文件上传失败");
        }
        String fileName = IdUtil.simpleUUID()+"-"+file.getOriginalFilename();
        try {
            fileUtils.fileUpload(fileName, file.getInputStream());
        } catch (Exception e) {
            log.error("ProductController.adminUpload业务结束，结果:{}","上传失败",e);
            return AjaxResult.error("文件上传失败");
        }
        HashMap<String, Object> stringObjectHashMap = new HashMap<>(16);
        stringObjectHashMap.put("url","/upload/"+fileName);
        log.info("FileController.adminUpload业务结束，结果:{},{}","上传成功","/upload/"+fileName);
        return AjaxResult.success(stringObjectHashMap);
    }
}
