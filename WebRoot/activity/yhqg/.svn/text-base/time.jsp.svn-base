<%@ page language="java" import="com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	response.setContentType("text/xml;");
	StringBuffer str = new StringBuffer();
	str.append("<?xml version='1.0' encoding='utf-8' ?>");
	str.append("<date>");
	str.append("<year>"+CommonDate.getToday("yyyy")+"</year>");
	str.append("<month>"+CommonDate.getToday("MM")+"</month>");
	str.append("<day>"+CommonDate.getToday("dd")+"</day>");
	str.append("<hour>"+CommonDate.getToday("HH")+"</hour>");
	str.append("<minute>"+CommonDate.getToday("mm")+"</minute>");
	str.append("<second>"+CommonDate.getToday("ss")+"</second>");
	str.append("<full>"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"</full>");
	str.append("</date>");
	out.print(str.toString());
%>