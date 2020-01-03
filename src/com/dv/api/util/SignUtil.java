package com.dv.api.util;


import com.dv.api.DvConstants;
import com.dv.api.DvRequestEntity;

import java.security.MessageDigest;
import java.util.Map;


public class SignUtil {

    private static final char[] HEX_DIGITS = { '0', '1', '2', '3', '4', '5',
            '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

    public static String md5Sign(DvRequestEntity requestEntity, String key){
        return sign(ParamUtil.getSignatureContent(requestEntity), key, DvConstants.CHARSET_UTF8);
    }

    public static String md5Sign(Map<String, String> sortedMap, String key){
        return sign(ParamUtil.getSignatureContent(sortedMap), key, DvConstants.CHARSET_UTF8);
    }

    private static String sign(String text, String key, String charset){
        text = text + key;
        String mySign;
        try{
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(text.getBytes(charset));
            mySign =  getFormattedText(messageDigest.digest());
        }catch (Exception e){
            mySign = null;
        }
        return mySign;
    }

    private static String getFormattedText(byte[] bytes) {
        int len = bytes.length;
        StringBuilder buf = new StringBuilder(len * 2);
        // 把密文转换成十六进制的字符串形式
        for (int j = 0; j < len; j++) {
            buf.append(HEX_DIGITS[(bytes[j] >> 4) & 0x0f]);
            buf.append(HEX_DIGITS[bytes[j] & 0x0f]);
        }
        return buf.toString();
    }


}