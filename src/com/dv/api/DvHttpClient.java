package com.dv.api;



import com.dv.api.util.ParamUtil;
import com.dv.api.util.SignUtil;
import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import javax.xml.ws.http.HTTPException;
import java.util.Map;

/**
 * @author DataValuable
 */
public class DvHttpClient {

    private final static String USER_AGENT = "HttpClient/4.5.2 DataValuable/1.0.0";

    private final static RequestConfig defaultRequestConfig = RequestConfig.custom()
            .setSocketTimeout(30000)
            .setConnectTimeout(30000)
            .setConnectionRequestTimeout(30000)
            .build();

    public String execute(DvRequestEntity requestEntity){
        CloseableHttpClient httpClient;
        HttpPost httpPost;
        String reStr = "";
        try {
            Map<String, String> sortedMap = ParamUtil.getSortedMap(requestEntity);
            String mySign = SignUtil.md5Sign(sortedMap,DvRequestConfig.API_KEY_MD5);
            sortedMap.put(DvConstants.FIELD_SIGN, mySign);
            String requestStr = ParamUtil.getPostContent(sortedMap);
            httpClient = HttpClients.createDefault();
            httpPost = new HttpPost(DvRequestConfig.API_URL);
            httpPost.setConfig(defaultRequestConfig);
            StringEntity entity = new StringEntity(requestStr,"utf-8");
            httpPost.setEntity(entity);
            httpPost.setHeader("User-Agent",USER_AGENT);
            httpPost.setHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
            CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
            HttpEntity reEntity = httpResponse.getEntity();
            reStr =  EntityUtils.toString(reEntity,"utf-8");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            return reStr;
        }
    }

}
