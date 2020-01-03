<%@ page language="java" import="java.util.Map,com.jerehnet.util.common.CommonDate" pageEncoding="UTF-8" %>
<%
	Map adminInfo = (Map)session.getAttribute("adminInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>
    <title>欢迎登录</title>
  </head>
  
  <body style="margin: 0;padding: 0;background: url('/backend/images/zoomlion/welcome-bigbg.jpg'); background-repeat: no-repeat;">
	<div style="background: url('/backend/images/zoomlion/welcome-bg.jpg'); height:46px;">
		<div style="position: relative;top:20px;left:10px;">
			<div style="float:left;"><img src="/backend/images/zoomlion/ren.gif" /></div>
			<div style="float:left;font-size:12px; font-weight:bold;position: absolute; top:2px;left:20px;">
				欢迎您，<%=adminInfo.get("usern") %>，今天是<%=CommonDate.getToday("yyyy年MM月dd日") %>
			</div>
			<div style="clear: left;"></div>
		</div>
	</div>
  </body>
</html>
