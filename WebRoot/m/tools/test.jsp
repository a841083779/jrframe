<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  DBHelper dbHelper = DBHelper.getInstance() ;
  List<Map> catalogList = dbHelper.getMapList(" select name,num from pro_catalog where len(num)=6") ;
  out.println("型号    数量</br>") ;
  for(Map oneMap:catalogList){
	  Map ordersnum = dbHelper.getMap(" select count(*) total from pro_product_form where catanum like '"+CommonString.getFormatPara(oneMap.get("num"))+"%' and  add_date >= '2012-01-01'") ;
	  out.println(oneMap.get("name")+"   "+String.valueOf(ordersnum.get("total"))+"</br>") ;
  }
%>
