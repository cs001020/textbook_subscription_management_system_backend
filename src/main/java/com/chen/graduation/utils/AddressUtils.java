package com.chen.graduation.utils;

import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 地址跑龙套
 *
 * @author CHEN
 * @date 2023/03/05
 */
public class AddressUtils {
    private static final Logger log = LoggerFactory.getLogger(AddressUtils.class);

    // IP地址查询
    public static final String IP_URL = "http://whois.pconline.com.cn/ipJson.jsp";

    /**
     * 未知地址
     */
    public static final String UNKNOWN = "未知地址";

    public static String getRealAddressByIp(String ip) {
        try {
            String rspStr = HttpUtil.get(IP_URL + "?ip=" + ip + "&json=true");
            if (StrUtil.isEmpty(rspStr)) {
                log.error("获取地理位置异常 {}", ip);
                return UNKNOWN;
            }
            JSONObject obj = JSON.parseObject(rspStr);
            String region = obj.getString("pro");
            String city = obj.getString("city");
            String address = String.format("%s %s", region, city);
            return StrUtil.isBlank(address)?UNKNOWN:address;
        } catch (Exception e) {
            log.error("获取地理位置异常 {}", ip);
        }

        return UNKNOWN;
    }
}
