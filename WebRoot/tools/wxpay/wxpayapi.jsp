<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*,com.jerehnet.wxpay.*,java.net.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.wxpay.WXPayConstants.SignType" %>
<%@page import="com.jerehnet.util.common.*" %>
<%
WXPayUtil wxutil=new WXPayUtil();
String url = "https://api.mch.weixin.qq.com/pay/unifiedorder";

String out_trade_no=CommonString.getFormatPara(request.getParameter("out_trade_no"));
Map<String,String> querys= new HashMap<String,String>();
String xml="";String sign="";
String UTF8 = "UTF-8";
try{
	querys.put("mch_id", "1376182502");
	querys.put("appid", "wx5145c9b44ce3dbd1");
	querys.put("device_info", "WEB");
	querys.put("trade_type", "MWEB");
	querys.put("out_trade_no", out_trade_no);
	querys.put("nonce_str", WXPayUtil.generateUUID());
	querys.put("body", "铁臂商城-缴纳定金");
	querys.put("total_fee", "1");
	querys.put("spbill_create_ip", IPUtil.getIpAddress(request));
	querys.put("notify_url", "http://product.21-sun.com/tools/wxpay/notify_url.jsp");//支付回调地址 todo
	querys.put("scene_info", "{\"h5_info\": {\"type\":\"Wap\",\"wap_url\": \"http://product.21-sun.com\",\"wap_name\": \"铁臂商城\"}}");//todo
	sign=WXPayUtil.generateSignature(querys, "DgOSo8u6ix3fcId4jJtj9lISLZK8KllX",SignType.MD5);
	System.out.println("sign:"+sign);
	querys.put("sign", sign);//签名
	
	xml = WXPayUtil.mapToXml(querys);
	
	URL httpUrl = new URL(url);
    HttpURLConnection httpURLConnection = (HttpURLConnection) httpUrl.openConnection();
    httpURLConnection.setRequestProperty("Host", "api.mch.weixin.qq.com");
    httpURLConnection.setDoOutput(true);
    httpURLConnection.setRequestMethod("POST");
    httpURLConnection.setConnectTimeout(10*1000);
    httpURLConnection.setReadTimeout(10*1000);
    httpURLConnection.connect();
    OutputStream outputStream = httpURLConnection.getOutputStream();
    outputStream.write(xml.getBytes(UTF8));

    //获取内容
    InputStream inputStream = httpURLConnection.getInputStream();
    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, UTF8));
    final StringBuffer stringBuffer = new StringBuffer();
    String line = null;
    while ((line = bufferedReader.readLine()) != null) {
        stringBuffer.append(line);
    }
    String resp = stringBuffer.toString();
    if (stringBuffer!=null) {
        try {
            bufferedReader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    if (inputStream!=null) {
        try {
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    if (outputStream!=null) {
        try {
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    System.out.println("111:"+resp);
	System.out.println("222:"+xml);
}catch(Exception e){
	
}

%>
