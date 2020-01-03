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
  freemarkerUtils.generate("top_list_new/brand_attention_order.htm",realpath+"include/top_list_new/brand_attention_order.htm") ; //   品牌关注度排行榜
  freemarkerUtils.generate("top_list_new/hot_products_order.htm",realpath+"include/top_list_new/hot_products_order.htm") ; //   热门产品排行
  freemarkerUtils.generate("top_list_new/catalog_order.htm",realpath+"include/top_list_new/catalog_order.htm") ; //   热门产品排行
  freemarkerUtils.generate("top_list_new/brand_rank.htm",realpath+"include/top_list_new/brand_rank.htm") ; //   品牌百分比排行
  
  out.println("ok") ;
%>
