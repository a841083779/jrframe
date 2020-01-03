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
	request.setCharacterEncoding("utf-8");
	String name=CommonString.getFormatPara(request.getParameter("name"));
	name=URLDecoder.decode(name, "UTF-8");
	String tel=CommonString.getFormatPara(request.getParameter("tel"));
	String regDate=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
		String jsonPara="{"+
	    "\"AppToken\": \"bc32633834483ad0e17da6ed4f4f7714\","+
	    "\"Users\": ["+
	        "{"+
	            "\"ClientUserId\": 1,"+
	            "\"IOL_ID\": 0,"+
	            "\"UniqueId\": null,"+
	            "\"UTM_Channel\": \"21sun_API\","+
	            "\"UTM_MEDIUM\": \"\","+
	            "\"UTM_CONTENT\": \"\","+
	            "\"UTM_CAMPAIGN\": \"\","+
	            "\"UTM_TERM\": \"\","+
	            "\"IsSem\":\"false\","+
	            "\"UserName\": \""+name+"\","+
	            "\"Mobile\": \""+tel+"\","+
	            "\"Industry\": \"\","+
	            "\"MediaSource\": \"3rd Party(21sun)\","+
	            "\"DataSource\": \"Corp-Campaign\","+
	            "\"DataSourceCode\": \"CP1007\","+
	            "\"REPORT_GROUP\": \"wap\","+
	            "\"SixType\": \"\","+
	            "\"ThirdDetail\": \"21sun-m\","+
	            "\"RegTime\": \""+regDate+"\""+
	       " }"+
	    "]}";
	//System.out.println("==================================================================https://api.cat-cn.com/api/clue/UserinfoClue?param="+jsonPara);

		HttpClient httpClient = new HttpClient(); 
		//PostMethod postMethod = new UTF8PostMethod("https://api.cat-cn.com/api/clue/UserinfoClue");
		PostMethod postMethod = new UTF8PostMethod("https://ms-api.cat-cn.com/api/clue/UserinfoClue");
		NameValuePair[] arr = new NameValuePair[0]; 
		List<NameValuePair> formParams = new ArrayList<NameValuePair>(); 
		formParams.add(new NameValuePair("param", jsonPara)); 
		postMethod.addParameters(formParams.toArray(arr)); 
		statusCode = httpClient.executeMethod(postMethod); 
	    String str = postMethod.getResponseBodyAsString(); 
		
        JSONObject obj = null;
 
		if(str!=null&&str.indexOf("msg")>=0){
		try {
		    obj = new JSONObject(str);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String temp=((CommonString.getFormatPara(obj.getString("msg"))));

          System.out.println("=================temp");
		}

		
	
%>
<%!
        public  String getMd5(String plainText) {  
           try {  
           MessageDigest md = MessageDigest.getInstance("MD5");  
            md.update(plainText.getBytes());  
            byte b[] = md.digest();  
            int i;  

             StringBuffer buf = new StringBuffer("");  
             for (int offset = 0; offset < b.length; offset++) {  
                i = b[offset];  
                 if (i < 0)  
                     i += 256;  
                 if (i < 16)  
                     buf.append("0");  
                buf.append(Integer.toHexString(i));  
            }  
            //32位加密  
           return buf.toString();  
            // 16位的加密  
            //return buf.toString().substring(8, 24);  
         } catch (Exception e) {  
             e.printStackTrace();  
             return null;  
         }  
   
    }  
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
%>