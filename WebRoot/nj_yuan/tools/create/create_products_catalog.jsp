<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.action.ToBrandListHtmlAction"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	PoolManager pool = new PoolManager() ;
	ToBrandListHtmlAction totml = new ToBrandListHtmlAction() ;
	totml.toHtmlAllCatalogNames(pool,request) ;
	out.println("ok") ;
%>
