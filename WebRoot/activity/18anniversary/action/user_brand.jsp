<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
String sql =" select * from anniversary18_user_brand order by id desc ";
Connection connection = null;
DBHelper dbHelper = DBHelper.getInstance();
List<Map> orderList = null;
try{
	connection = dbHelper.getConnection(); 	
	orderList = dbHelper.getMapList(sql,connection);
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBHelper.freeConnection(connection);
}	
%>
 <style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 1px;font-size:16px;text-align:center}
	td{height:20px;width:105px}
	</style>
<table>
<tr>
<td >tel</td>
<td style="width:400px">openId</td>
<td>brandId</td>
<td>otherBrand</td>
<td>addDate</td>
</tr>
<%
if(orderList!=null && orderList.size()>0){
	for(Map m:orderList){
%>
	<tr>
	<td ><%=CommonString.getFormatPara(m.get("tel"))%></td>
	<td style="width:400px"><%=CommonString.getFormatPara(m.get("open_id"))%></td>
	<td><%=CommonString.getFormatPara(m.get("brand_id"))%></td>
	<td><%=CommonString.getFormatPara(m.get("other_brand"))%></td>
	<td><%=CommonString.getFormatPara(m.get("add_date"))%></td>
	</tr>
<%
	}
}
%>
</table>

