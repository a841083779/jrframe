a<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String realPath = Common.getAbsolutePath(request) ;
	System.out.println(realPath);
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	
    freemarkerUtils.generate("mobile/agent_list.htm",realPath+"/include/mobile/agent.htm") ; 
	
   
	out.println("ok") ;
%>