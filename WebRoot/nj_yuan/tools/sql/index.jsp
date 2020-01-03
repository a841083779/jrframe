<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String sql = CommonString.getFormatPara(request.getParameter("sql"));
	
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	List<Map> list =null;
	int num=0;
	try{
	    connection = dbHelper.getConnection();
		if(!sql.equals("")){
			try{
			 list = dbHelper.getMapList(sql,connection) ;
			}catch(Exception e){
		     e.printStackTrace();
	        }
		}
		
		
%><!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>数据查询</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<script src="http://product.21-sun.com/scripts/jquery-1.7.min.js"></script>
<script src="http://product.21-sun.com/scripts/scripts.js"></script>
</head>
<style>
.top_1{  margin-bottom: 22px;}
.top_2{padding: 20px;}
form{text-align: center;}
table{  border: 1px solid #cccccc; font-family: Microsoft Yahei;border-collapse: collapse;background-color: #ffffff;font-size: 12px;}
td{border: 1px solid #cccccc;text-align: left;padding-top: 4px;padding-bottom: 4px;padding-left: 10px;}
</style>
<body>
<div class="top_1">
<form action="" method="post" name="formSubmit"  id="formSubmit">
<textarea class="l-textarea" id="sql" name="sql" style="width: 498px;min-height: 80px;"><%=sql%></textarea>
<input type="submit" value="查询" style="  width: 100px;height: 40px;" />
</form>
</div>
<div class="top_2">
<%if(list!=null&&list.size()>0){%>
  <table>
	<%
	int count=0;
	for(Map zhi:list){
	if(count==0){%>
	<tr style="  background-color: #F5F5F5;">
	<td>序号</td>
	   <% Set keySet = zhi.keySet();
	    Iterator iter = keySet.iterator();
         while (iter.hasNext()) {//遍历
		 String k=(String)iter.next();
		%>
	      <td><%=k%></td>
	    <%}%>
	</tr>
	<%count++;}%>
	<%}%>
	
	<%for(Map zhi:list){%>
	
	<tr>
	    <td><%=num%></td>
	   <% Set keySet = zhi.keySet();
	    Iterator iter = keySet.iterator();
         while (iter.hasNext()) {//遍历
		 String k=(String)iter.next();
		%>
	      <td><%=zhi.get(k)%></td>
	    <%}%>
	</tr>
	<%num++;}%>
  </table>
  <%}else{%>
  <span>错误，sql可能有问题！！</span>
  <%}%>
</div>

</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>