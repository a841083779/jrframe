<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
    FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ; 

    freemarkerUtils.generate("weixiu/wjj_index.htm",realPath+"/include/weixiu/wjj_index.htm") ;
    freemarkerUtils.generate("weixiu/zzj_index.htm",realPath+"/include/weixiu/zzj_index.htm") ; 
    freemarkerUtils.generate("weixiu/ttj_index.htm",realPath+"/include/weixiu/ttj_index.htm") ; 
	
    freemarkerWebserviceUtils.generate("weixiu/news_index.htm",realPath+"/include/weixiu/news_index.htm") ;  
	freemarkerWebserviceUtils.generate("weixiu/news_index_pic.htm",realPath+"/include/weixiu/news_index_pic.htm") ;  // สำฦต

%>
