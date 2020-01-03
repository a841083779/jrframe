<%@ page language="java" import="java.util.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.Header"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="com.jerehnet.util.common.*"%>

<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>


<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.net.URLDecoder" %>
<%@page import="java.io.DataOutputStream"%>
<% 

    int statusCode=0;
	request.setCharacterEncoding("UTF-8");
	String name=CommonString.getFormatPara(request.getParameter("name"));
	name=URLDecoder.decode(name, "UTF-8");
	String tel=CommonString.getFormatPara(request.getParameter("tel"));
	System.out.println(name +";"+tel);
%>
<%!
public  String string2Unicode(String string) {
    StringBuffer unicode = new StringBuffer();
    for (int i = 0; i < string.length(); i++) {
        // 取出每一个字符
        char c = string.charAt(i);
        // 转换为unicode
        unicode.append("\\u" + Integer.toHexString(c));
    }
 
    return unicode.toString();
}
%>

<%!
public   String getMD5( byte[] source) {
String s = null;
char [] hexDigits =new char[] {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
final int temp = 0xf;
final int arraySize = 32;
final int strLen = 16;
final int offset = 4;
try {
java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
md.update(source);
byte [] tmp = md.digest();
char [] str = new char[arraySize];
int k = 0;
for (int i = 0; i < strLen; i++) {
byte byte0 = tmp[i];
str[k++] = hexDigits[byte0 >>> offset & temp];
str[k++] = hexDigits[byte0 & temp];
}
s = new String(str);
} catch (Exception e) {
e.printStackTrace();
}
return s;
}


/**
 * unicode 转字符串
 */
public static String unicode2String(String unicode) {
 
    StringBuffer string = new StringBuffer();
 
    String[] hex = unicode.split("\\\\u");
 
    for (int i = 1; i < hex.length; i++) {
 
        // 转换出每一个代码点
        int data = Integer.parseInt(hex[i], 16);
 
        // 追加成string
        string.append((char) data);
    }
 
    return string.toString();
}
/**
     * <p>转为unicode 编码<p>
     *
     * @param str
     * @return unicodeString
     */
    public static String encode(String str) {
        String prefix = "\\u";
        StringBuffer sb = new StringBuffer();
        char[] chars = str.toCharArray();
        if (chars == null || chars.length == 0) {
            return null;
        }
        for (char c : chars) {
            sb.append(prefix);
            sb.append(Integer.toHexString(c));
        }
        return sb.toString();
    }

    

%>