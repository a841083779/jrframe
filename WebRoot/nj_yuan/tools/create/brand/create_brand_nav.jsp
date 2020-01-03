<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
   // 生成 品牌导航页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	freemarkerUtils.generate("brand/catalog_nav.htm",realPath+"/include/brand/catalog_nav.htm") ;  // 生成左侧类别导航 
	freemarkerUtils.generate("brand/catalog_brand.htm",realPath+"/include/brand/catalog_brand.htm") ;  // 生成品牌列表
	out.println("生成成功") ;
%>
