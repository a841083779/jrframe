<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
String html ="";
DBHelper dbHelper = DBHelper.getInstance() ;
List<Map> list=dbHelper.getMapList(" select num,name from pro_catalog where parentid = 430 order by order_no ");
for(Map m:list){
	html += "{'text':'"+CommonString.getFormatPara(m.get("name"))+"','id':'"+CommonString.getFormatPara(m.get("num"))+"'},";
}
out.println(html);
%>