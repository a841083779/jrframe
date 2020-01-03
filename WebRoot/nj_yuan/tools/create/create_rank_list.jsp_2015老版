<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  // 生成热点产品栏目下的静态页
  String realpath = Common.getAbsolutePath(request) ;
  FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realpath+"template/") ;
  freemarkerUtils.generate("rank/catalog_rank_index.htm",realpath+"include/rank/catalog_rank_index.htm") ; //   品牌关注度排行榜
  freemarkerUtils.generate("rank/brand_rank_index.htm",realpath+"include/rank/brand_rank_index.htm") ; //   品牌关注度排行榜
  out.println("ok") ;
%>
