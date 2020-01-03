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
	DBHelper dbHelper = DBHelper.getInstance();
	String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
	Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid + "' ");
	if(one_proform !=null && one_proform.get("id") != null){
		
		String id = CommonString.getFormatPara(one_proform.get("id"));
		String name = CommonString.getFormatPara(one_proform.get("name")); 
		String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone")); 
  		String province = CommonString.getFormatPara(one_proform.get("province")).trim(); 
 		String city = CommonString.getFormatPara(one_proform.get("city")); 
 		String product_id = CommonString.getFormatPara(one_proform.get("product_id")); 

		String area = "-";
        String cat="";
		String small_cat="";
		String catanum = CommonString.getFormatPara(one_proform.get("catanum"));
		int push=0;

		//挖掘机
		if(catanum.equals("101001001")||catanum.equals("101001004")||catanum.equals("101001007")){
			Map productMap = dbHelper.getMap("  select  tonandmeter from pro_products  where id="+product_id );
			cat="8";
			if(catanum.equals("101001004")||catanum.equals("101001007")){
			    small_cat="124";
                push=1;				
			}else{
				float ton= Float.parseFloat(CommonString.getFormatPara(productMap.get("tonandmeter"))); 
				if(ton<=3.0){
					small_cat="62";
                    push=1;	
				}else if(ton<=8.0){
					small_cat="63";
                    push=1;	
				}else if(ton<=15.0){
					small_cat="64";
                    push=1;	
				}else{
					small_cat="65";
                    push=1;	
				}
				if(product_id.equals("21005")){
					small_cat="62";
				}
			}
			
		}
		//装载机
		if(catanum.equals("101002007")){
			cat="8";
		    small_cat="66";	
            push=1;			
		}
		//平地机
		if(catanum.equals("101005002")){
			cat="5";
		    small_cat="68";
            push=1;			
		}
		//自卸卡车/矿卡
		if(catanum.equals("101008001")||catanum.equals("101008002")){
		
		}
		//塔式起重机
		if(catanum.equals("102002")){
			cat="9";
		    small_cat="78";
            push=1;				
		}
		//随车起重机
		if(catanum.equals("102006")){
			cat="9";
		    small_cat="79";	
			push=1;	
		}
		//汽车起重机
		if(catanum.equals("102007")){
			cat="9";
		    small_cat="72";	
			push=1;	
		}
		//履带式起重机
		if(catanum.equals("102008")){
			cat="9";
		    small_cat="76";	
			push=1;	
		}
		//伸缩臂叉装机
		if(catanum.equals("102012")){

		}
		//龙门/桥梁起重机
		if(catanum.equals("102013")){
		
		}
		//混凝土泵车
		if(catanum.equals("103001")){
			cat="7";
		    small_cat="50";	
			push=1;	
		}
		//混凝土搅拌站/楼/机
		if(catanum.equals("103002")){
			cat="7";
		    small_cat="54";
            push=1;				
		}
		//混凝土布料杆/机
		if(catanum.equals("103005")){
			cat="7";
		    small_cat="53";
            push=1;				
		}
		//干粉/砂浆生产设备
		if(catanum.equals("103008")){
			cat="7";
		    small_cat="57";	
			push=1;	
		}
		//车载泵
		if(catanum.equals("103017")){
			cat="7";
		    small_cat="52";
            push=1;				
		}
		//拖泵
		if(catanum.equals("103018")){
			cat="7";
		    small_cat="51";	
			push=1;	
		}
		//混凝土搅拌运输车
		if(catanum.equals("103019")){
			cat="7";
		    small_cat="60";	
			push=1;	
		}
		//摊铺机
		if(catanum.equals("104001")){
			cat="5";
		    small_cat="69";	
			push=1;
		}
		//铣刨机
		if(catanum.equals("104005")){
			cat="5";
		    small_cat="70";	
            push=1;			
		}
		//沥青搅拌/转运
		if(catanum.equals("104009")){
		
		}
		//旋挖钻机
		if(catanum.equals("105003")){
			cat="13";
		    small_cat="98";	
            push=1;			
		}
		//连续墙设备
		if(catanum.equals("105007")){
			cat="13";
		    small_cat="101";
            push=1;			
		}
		//压桩机/打桩机
		if(catanum.equals("105009")){
			cat="13";
		    small_cat="100";
            push=1;			
		}
		//其它桩工机械
		if(catanum.equals("105027")){
			cat="13";
		    small_cat="103";
			push=1;
		}
		
		//单钢轮压路机
		if(catanum.equals("106001001")){
		    cat="5";
		    small_cat="67";
			push=1;
		}
		//双钢轮压路机
		if(catanum.equals("106001002")){
			cat="5";
		    small_cat="67";
			push=1;
		}
		//轮胎压路机
		if(catanum.equals("106001005")){
			cat="5";
		    small_cat="67"; 
            push=1;			
		}
		
		
		
		
	    //内燃平衡重叉车
		if(catanum.equals("107011")){
			cat="10";
		    small_cat="82";
            push=1;			
		}
		
		//专用叉车
		if(catanum.equals("107017")){
			cat="10";
		    small_cat="82";
            push=1;			
		}
		
		//盾构机
		if(catanum.equals("110001")){
		
		}
		
		//掘进机
		if(catanum.equals("110002")){
			cat="15";
		    small_cat="107"; 
            push=1;			
		}
		
		//凿岩台车/钻机
		if(catanum.equals("110008")){
		
		}
		
		
		//装载及搬运设备
		if(catanum.equals("110013")){
		
		}
		
		
		
		
		
		//采煤机
		if(catanum.equals("110019")){
			cat="15";
		    small_cat="110"; 
            push=1;			
		}
		
		//正面吊
		if(catanum.equals("111001")){
			cat="10";
		    small_cat="80"; 
            push=1;			
		}
		
		//码头堆高机
		if(catanum.equals("111002")){
			cat="10";
		    small_cat="81"; 
            push=1;			
		}
		
		//卸船机
		if(catanum.equals("111003")){
		
		}
		
		//门式起重机
		if(catanum.equals("111004")){
			cat="10";
		    small_cat="86"; 
			push=1;
		}
		
 
		
		
        String source_from="23";
		String product_name = CommonString.getFormatPara(one_proform.get("product_name"));  
		String add_date = CommonDate.getToday("yyyy-MM-dd HH:mm:ss"); 
		//add_date="2017-04-01 09:03:00";
		String url="area="+area+"&big_cat_id="+cat+"&city="+city+"&goods_name="+product_name+"&name="+name+"&province="+province+"&small_cat_id="+small_cat+"&source_from="+source_from+"&tel="+mobile_phone+"&time="+add_date+"&securet=sany888";
 		String sign=getMD5(url.getBytes("UTF-8"));
		sign=sign.toUpperCase();
		
        System.out.println(url);
		System.out.println(sign);
		
		HttpClient httpClient = new HttpClient(); 
		PostMethod postMethod = new UTF8PostMethod("http://crmgn.sanygroup.com:80/web/index.php?s=api/third/form"); 
		NameValuePair[] arr = new NameValuePair[11]; 
		List<NameValuePair> formParams = new ArrayList<NameValuePair>(); 
		formParams.add(new NameValuePair("area", area)); 
		formParams.add(new NameValuePair("big_cat_id", cat)); 
		formParams.add(new NameValuePair("small_cat_id", small_cat)); 
		formParams.add(new NameValuePair("city",(city))); 
		formParams.add(new NameValuePair("goods_name", (product_name))); 
		formParams.add(new NameValuePair("name", (name))); 
		formParams.add(new NameValuePair("province", (province))); 
		formParams.add(new NameValuePair("source_from", "23")); 
		formParams.add(new NameValuePair("tel", mobile_phone)); 
		formParams.add(new NameValuePair("time", add_date)); 
		//formParams.add(new NameValuePair("securet", "sany888")); 
		formParams.add(new NameValuePair("sign", sign )); 
		postMethod.addParameters(formParams.toArray(arr)); 
		if(push==1){
		    statusCode = httpClient.executeMethod(postMethod); 
		}
	    String str = postMethod.getResponseBodyAsString(); 
		out.println(str);
		
        JSONObject obj = null;
 
		if(str!=null&&str.indexOf("msg")>=0){
		try {
		    obj = new JSONObject(str);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String temp=((CommonString.getFormatPara(obj.getString("msg"))));

            String upSql="";
			if(temp.indexOf("成功") >= 0){
				 upSql = " update pro_product_form set is_success = 1 where uuid = '"+uuid+"' ";
			}else{
				 upSql = " update pro_product_form set is_success = 0 where uuid = '"+uuid+"' ";	

			}
			dbHelper.execute(upSql);
		}

		
	}
	out.println(statusCode);
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