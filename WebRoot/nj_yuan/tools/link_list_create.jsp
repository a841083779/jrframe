<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerWebserviceUtils freemarkerUtils = new FreemarkerWebserviceUtils(realPath+"template/") ; 
	freemarkerUtils.generate("index/friendlink.htm",realPath+"/include/friendlink_index.htm") ;//生成友情链接
	out.println("<script type='text/javascript'>alert('友情链接更新成功！');window.close();</script>") ;
%>

