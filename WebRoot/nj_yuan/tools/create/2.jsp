<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
// 生成所有的品牌详显页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
    FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ; 	
	String usern = "" ; // 品牌代号
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = new HashMap() ;
 

 
 
		usern = "hbxg";
		root.put("usern",usern) ;
		freemarkerUtils.generate("brandshow/new_detail_right.htm",root,realPath+"/brandshow/"+usern+"/right.htm") ;  // 生成所有的品牌详显页右侧公共部分
		freemarkerUtils.generate("brandshow/new_detail.htm",root,realPath+"/brandshow/"+usern+"/index.htm") ;  // 生成所有的品牌详显页
		freemarkerUtils.generate("brandshow/new_intro.htm",root,realPath+"/brandshow/"+usern+"/intro.htm") ;  // 生成一个品牌介绍页
	 
		
 
	out.println("ok") ;
%>
