<%@ page language="java" import="org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" pageEncoding="UTF-8"%><%
	HttpClient httpClient = new HttpClient();
	GetMethod getMethod = new GetMethod("http://www.21-sun.com/include/foot.htm");
	httpClient.executeMethod(getMethod);
	String outStr = new String(getMethod.getResponseBody(),"utf-8");
	out.print(outStr);
%>