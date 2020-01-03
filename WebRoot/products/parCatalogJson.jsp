<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
String html ="";
DBHelper dbHelper = DBHelper.getInstance() ;
List<Map> list=dbHelper.getMapList(" select num,name from pro_catalog where parentid = 0 order by order_no ");

for(Map m:list){
	html += "{'text':'"+CommonString.getFormatPara(m.get("name"))+"','id':'"+CommonString.getFormatPara(m.get("num"))+"','children':[{'text':'','id':'0'}]},";
}
out.println(html);
%>