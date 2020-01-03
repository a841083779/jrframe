package com.dv.api.util;



import com.dv.api.DvConstants;
import com.dv.api.DvRequestEntity;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author lizhiyuan
 * @create 2018-03-09 10:09
 * @desc
 **/
public class ParamUtil {

    public static String getSignatureContent(DvRequestEntity requestEntity){
        return getSignContent(getSortedMap(requestEntity));
    }

    public static String getSignatureContent(Map<String, String> sortedMap){
        return getSignContent(sortedMap);
    }

    public static String getPostContent(DvRequestEntity requestEntity){
        return getPostContent(getSortedMap(requestEntity));
    }

    public static String getPostContent(Map<String, String> sortedMap) {
        StringBuffer content = new StringBuffer();
        int index = 0;
        for (String key : sortedMap.keySet()) {
            String value = sortedMap.get(key);
            if (StringUtils.areNotEmpty(key, value)) {
                content.append((index == 0 ? "" : "&") + key + "=" + value);
                index++;
            }
        }
        return content.toString();
    }

    public static String getSignContent(Map<String, String> sortedMap) {
        StringBuffer content = new StringBuffer();
        int index = 0;
        for (String key : sortedMap.keySet()) {
            String value = sortedMap.get(key);
            if (StringUtils.areNotEmpty(key, value) && !DvConstants.FIELD_SIGN.equals(key)) {
                content.append((index == 0 ? "" : "&") + key + "=" + value);
                index++;
            }
        }
        return content.toString();
    }

    public static Map<String, String> getSortedMap(DvRequestEntity requestEntity){
        Map<String, String> sortedMap = new TreeMap<String, String>();
        try{
            Field[] fields = requestEntity.getClass().getDeclaredFields();
            for(Field field : fields){
                field.setAccessible(true);
                String key = field.getName();
                if(DvConstants.FIELD_SIGN.equals(key)){
                    continue;
                }
                String value = convertString(field.get(requestEntity));
                sortedMap.put(key, value);
            }
        }catch (IllegalAccessException e){
            e.printStackTrace();
        }
        return sortedMap;
    }

    public static String convertString(Object value){
        String strValue;
        if (value == null) {
            strValue = null;
        } else if (value instanceof String) {
            strValue = (String) value;
        } else if (value instanceof Integer) {
            strValue = ((Integer) value).toString();
        } else if (value instanceof Long) {
            strValue = ((Long) value).toString();
        } else if (value instanceof Float) {
            strValue = ((Float) value).toString();
        } else if (value instanceof Double) {
            strValue = ((Double) value).toString();
        } else if (value instanceof Boolean) {
            strValue = ((Boolean) value).toString();
        } else if (value instanceof Date) {
            DateFormat format = new SimpleDateFormat(DvConstants.DATE_TIME_FORMAT);
            format.setTimeZone(TimeZone.getTimeZone(DvConstants.DATE_TIMEZONE));
            strValue = format.format((Date) value);
        } else {
            strValue = value.toString();
        }
        return strValue;
    }


}
