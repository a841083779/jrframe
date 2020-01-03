<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  DBHelper dbHelper = DBHelper.getInstance() ;
  List<Map> provinceList = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id=0") ;
  
  for(Map map:provinceList){
	  out.print(CommonString.getFormatPara(map.get("area_name"))+"<br/>");
	  List<Map> cityList = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id="+CommonString.getFormatPara(map.get("area_id"))) ;
	  for(Map m:cityList){
		  out.print(CommonString.getFormatPara(m.get("area_name"))+"<br/>");
	  }
  }
%>
