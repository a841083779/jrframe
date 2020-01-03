a<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	

	
	freemarkerUtils.generate("koubei/koubei_wwj_top.htm",realPath+"/include/koubei/koubei_wwj_top.htm") ;  // 口碑首页挖掘机排行
	freemarkerUtils.generate("koubei/koubei_zzj_top.htm",realPath+"/include/koubei/koubei_zzj_top.htm") ;  // 口碑首页装载机排行
	freemarkerUtils.generate("koubei/koubei_ttj_top.htm",realPath+"/include/koubei/koubei_ttj_top.htm") ;  // 口碑首页推土机排行
	freemarkerUtils.generate("koubei/koubei_pdj_top.htm",realPath+"/include/koubei/koubei_pdj_top.htm") ;  // 口碑首页平地机排行
 
 
   
	out.println("ok") ;
%>