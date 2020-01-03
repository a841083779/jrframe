<%@ page contentType="text/html;charset=utf-8" language="java" errorPage="" %>
<%@ include file="../sysconfig/config.jsp"%>
<%
String sysWebNo="http://madmin.jereh-network.com";
String strpath=sysWebNo+"/webadmin/user/login-2.jsp?web_no="+web_no;
response.sendRedirect(strpath);
%>