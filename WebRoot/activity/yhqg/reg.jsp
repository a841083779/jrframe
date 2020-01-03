<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);
	DBHelper dbHelper = DBHelper.getInstance();
	Integer msgCounts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where CONVERT(varchar(100), reg_date, 1) = '"+CommonDate.getToday("MM/dd/yy")+"' ");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>注册</title>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  
  <body style="font-size: 12px;">
  <form action="action.jsp?flag=reg" name="theform" id="theform" method="post">
    <div>
    	<div style="margin-left: 10px;">
    		 &nbsp;
    	</div>
   </div>
    <div>
    	<table width="100%;">
    		<tr>
    			<td width="30%" style="text-align: center;">手机号码：</td>
    			<td width="70%">
    				<input style="width: 180px; border: 1px solid #ccc;" type="text" id="phone" name="phone" />
    			</td>
    		</tr>
    		<tr>
    			<td width="30%" style="text-align: center;">姓<span style="margin-left: 25px;"></span>名：</td>
    			<td width="70%">
    				<input style="width: 180px; border: 1px solid #ccc;" type="text" id="name" name="name" />
    			</td>
    		</tr>
    		<tr>
    			<td width="30%" style="text-align: center;">密<span style="margin-left: 25px;"></span>码：</td>
    			<td width="70%">
    				<input style="width: 180px; border: 1px solid #ccc;" type="password" id="password" name="password" />
    			</td>
    		</tr>
    		<%
    			if(msgCounts<200){
    				%>
    		<tr>
    			<td style="text-align: center;">验<span style="margin-left: 6px;"></span>证<span style="margin-left: 6px;"></span>码：</td>
    			<td><input style="width: 136px; border: 1px solid #ccc;" type="text" name="code" id="code" /><input type="button" id="getBtn" value="获取" onclick="getCode(this);" /></td>
    		</tr>
    				<%
    			}
    		%>

    	</table>
    </div>
   </form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script type="text/javascript" src="reg.js"></script>