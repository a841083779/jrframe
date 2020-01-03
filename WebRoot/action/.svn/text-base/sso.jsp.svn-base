<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.util.*,com.jerehnet.util.common.*"
	%><% 
response.setHeader("P3P","CP=CAO PSA OUR");
String memNo = "";
String passw = "";
String crDate = "";
	
String key = CommonString.getFormatPara(request.getParameter("key"));


String keys[] = key.split("--");
if(keys!=null && keys.length==3){
	crDate=keys[2];
	memNo=keys[0];
	passw=keys[1];
}

Common.createCookie(response,"cookieMemNo",memNo,(6*60*60));
Common.createCookie(response,"cookiePassw",passw,(6*60*60));
Common.createCookie(response,"cookieCreatTime",crDate,(6*60*60));

//Common.createCookie(response,"test2","dddddddddddddddddd",(24*60*60));

%>