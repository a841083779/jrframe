<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	freemarkerUtils.generate("brand/all.htm",realPath+"/include/brand/all.htm") ;  // 生成全部品牌
	 freemarkerUtils.generate("brand/inner.htm",realPath+"/include/brand/inner.htm") ;  // 生成国内品牌
	 freemarkerUtils.generate("brand/outer.htm",realPath+"/include/brand/outer.htm") ;  // 生成国外品牌
	
     //freemarkerUtils.generate("brand/agent_all.htm",realPath+"/include/agent_new/all.htm") ;  // 生成全部品牌
	//freemarkerUtils.generate("brand/agent_inner.htm",realPath+"/include/agent_new/inner.htm") ;  // 生成国内品牌
	//freemarkerUtils.generate("brand/agent_outer.htm",realPath+"/include/agent_new/outer.htm") ;  // 生成国外品牌
	out.println("ok") ;
%>