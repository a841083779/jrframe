<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String url = "/agent/login.jsp";
	if(flag.equals("2")){
		url = "/agent/login.jsp";	
		session.removeAttribute("agentInfo");
	}else{
		session.removeAttribute("factoryInfo");	
	}
	Common.do302(response,url);
%>