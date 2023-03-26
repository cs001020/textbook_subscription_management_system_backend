package com.chen.graduation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.chen.graduation.beans.PO.File;
import com.chen.graduation.beans.VO.AjaxResult;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件服务
 *
 * @author CHEN
 * @date 2023/03/26
 */
public interface FileService extends IService<File> {
    /**
     * 上传图片
     *
     * @param file 文件
     * @return {@link AjaxResult}<{@link Object}>
     */
    AjaxResult<Object> uploadImg(MultipartFile file);
}
