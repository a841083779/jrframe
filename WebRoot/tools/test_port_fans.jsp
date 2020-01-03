<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.*"%>
<%@page import="com.jerehnet.mobile.action.*" %>
<%@page import="com.jerehnet.util.dbutil.*" %>
<%@page import="java.sql.*" %>
<%@page import="net.sf.json.*" %>
<%
	ExportFansFromPublic ef=new ExportFansFromPublic();
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String resultStr="";
	String flag = CommonString.getFormatPara(request.getParameter("flag"));	
	//------------------------------代理商（开始）------------------------------
	//代理商 登录
    if("getFans".equals(flag)){
		ef.getUserList("","oBp9ht_9JmazzI4XpHuOQWCM6F_o");
	}
	if("send".equals(flag)){
		ef.sendWxMsg("ovfREFa2Xr3UX9pLhrReeRIlw0GsSzB93XZorgVK9tc");
	}
	
 
    
%>





 
