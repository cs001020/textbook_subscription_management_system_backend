package com.chen.graduation.utils;

import cn.hutool.core.date.DateUtil;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.style.column.LongestMatchColumnWidthStyleStrategy;
import com.chen.graduation.beans.VO.OperateLogVO;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * excel工具
 *
 * @author CHEN
 * @date 2023/03/06
 */
public class ExcelUtils {
    public static void exportOperateLog(HttpServletResponse response, List<OperateLogVO> operateLogVOList) throws IOException {
        //设置响应参数
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        // 这里URLEncoder.encode可以防止中文乱码 当然和easyexcel没有关系
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("_yyyy-MM-dd_HH-mm-ss"));
        String fileName = URLEncoder.encode("operateLog" + now, "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        //写出文件
        EasyExcel.write(response.getOutputStream(), OperateLogVO.class).sheet("操作日志").doWrite(operateLogVOList);
    }
}
