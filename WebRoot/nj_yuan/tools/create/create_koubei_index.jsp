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

 
    freemarkerUtils.generate("koubei/koubei_index_wjj.htm",realPath+"/include/koubei/koubei_index_wjj.htm") ;  
    freemarkerUtils.generate("koubei/koubei_index_zzj.htm",realPath+"/include/koubei/koubei_index_zzj.htm") ;  
   freemarkerUtils.generate("koubei/koubei_index_ttj.htm",realPath+"/include/koubei/koubei_index_ttj.htm") ;  
    freemarkerUtils.generate("koubei/koubei_index_pdj.htm",realPath+"/include/koubei/koubei_index_pdj.htm") ; 
	
	    freemarkerUtils.generate("koubei/koubei_index_wjj_right.htm",realPath+"/include/koubei/koubei_index_wjj_right.htm") ;  
    freemarkerUtils.generate("koubei/koubei_index_zzj_right.htm",realPath+"/include/koubei/koubei_index_zzj_right.htm") ;  
   freemarkerUtils.generate("koubei/koubei_index_ttj_right.htm",realPath+"/include/koubei/koubei_index_ttj_right.htm") ;  
    freemarkerUtils.generate("koubei/koubei_index_pdj_right.htm",realPath+"/include/koubei/koubei_index_pdj_right.htm") ; 
   
    freemarkerUtils.generate("koubei/list_wjj.htm",realPath+"/include/koubei/list_wjj.htm") ;  
    freemarkerUtils.generate("koubei/list_zzj.htm",realPath+"/include/koubei/list_zzj.htm") ;  
    freemarkerUtils.generate("koubei/list_qzj.htm",realPath+"/include/koubei/list_qzj.htm") ;  
    freemarkerUtils.generate("koubei/list_ttj.htm",realPath+"/include/koubei/list_ttj.htm") ;
    freemarkerUtils.generate("koubei/list_pdj.htm",realPath+"/include/koubei/list_pdj.htm") ; 
    freemarkerUtils.generate("koubei/list_ylj.htm",realPath+"/include/koubei/list_ylj.htm") ; 
	
   
	out.println("ok") ;
%>