<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String uuid = CommonString.getFormatPara(request.getParameter("uuid")) ;  // 获取uuid
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单通知--中国工程机械商贸网</title>
</head>
<body>
<%=uuid %>
</body>
</html>
