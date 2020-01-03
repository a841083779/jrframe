package com.dv.api;



import com.dv.api.util.SignUtil;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * @author lizhiyuan
 * @create 2018-03-05 10:49
 * @desc
 **/
public class DvRequestEntity {

    private String appId = DvRequestConfig.API_APP_ID;

    private String content;

    private Integer count;

    private String format;

    private String method;

    private String sign;

    private String signType = DvRequestConfig.API_SIGN_TYPE;

    private String timestamp = getNow();

    private String version = DvRequestConfig.API_VERSION;

    public DvRequestEntity(String method, String format, Integer count, String content) {
        this.method = method;
        this.format = format;
        this.count = count;
        this.content = content;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getSignType() {
        return signType;
    }

    public void setSignType(String signType) {
        this.signType = signType;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    /**
     * 获取当前时间字符串
     **/
    private String getNow() {
        SimpleDateFormat spf = new SimpleDateFormat(DvConstants.DATE_TIME_FORMAT);
        return spf.format(new Date());
    }

}
