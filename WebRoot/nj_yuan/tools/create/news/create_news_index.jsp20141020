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
	freemarkerWebserviceUtils.generate("news/new_pro_rec.htm",realPath+"/include/news/new_pro_rec.htm") ;  // 生成新品推荐
	freemarkerUtils.generate("news/new_pro_pics.htm",realPath+"/include/news/new_pro_pics.htm") ;  // 生成新品推荐
	freemarkerUtils.generate("news/pro_news_agent.htm",realPath+"/include/news/pro_news_agent.htm") ;  // 生成新品推荐

	freemarkerWebserviceUtils.generate("news/pro_news.htm",realPath+"/include/news/pro_news.htm") ;  // 生成新品推荐
	freemarkerWebserviceUtils.generate("news/news_list.htm",realPath+"/include/news/news_list.htm") ;  // 资讯排行
	freemarkerWebserviceUtils.generate("news/pro_videos.htm",realPath+"/include/news/pro_videos.htm") ;  // 视频
%>
