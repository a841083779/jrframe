<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.action.ToBrandListHtmlAction"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
 ToBrandListHtmlAction toHtml = new ToBrandListHtmlAction() ;
  PoolManager pool = new PoolManager() ;
  toHtml.toHtmlAllCatalogNames(pool,request) ;
  out.println("ok") ;
%>