<%@ page language="java"  pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.util.List"%><%@page import="java.util.Map"%><%@page import="com.jerehnet.util.common.CommonHtml"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	String flag  = CommonString.getFormatPara(request.getParameter("flag")) ; // 标识 brand 按品牌排序 product 按产品排序
	String offset = "".equals(CommonString.getFormatPara(request.getParameter("offset")))?"0":CommonString.getFormatPara(request.getParameter("offset")) ;
%><%--<cache:cache cron="1 /1 * * *"> --%><%
	String cachekey = flag+offset ;
	PageBean pageBean = new PageBean() ;
	String tablename = "pro_agent_factory" ;
	pageBean.setPageSize(10) ;
	 Integer nowPage = 1 ;
	   if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	   }
	pageBean.setNowPage(nowPage) ;
	String url = CommonString.getFormatPara(request.getQueryString()) ;
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
    pageBean.setParams(url) ;
	pageBean.setTableName(tablename) ;
	pageBean.setOrderBy(" view_count desc ") ;
	pageBean.setCondition(" and flag=1 ") ;
	pageBean.setFields(" logo,full_name,usern,introduce,view_count ") ;
	List<Map> allBrands = pageBean.getDatas() ;
 %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【品牌排名|品牌排行榜】 - 铁臂商城</title>
<meta name="keywords" content="品牌排名,品牌排行榜" />
<meta name="description" content="品牌排名、品牌排行榜，品牌排名是经过销量、销售额、企业品牌知名度等综合数据进行权威统计。品牌排名涵盖中国、日本、韩国、欧美等世界多个地区品牌。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/top_list/">排行榜</a> &gt;&gt; 品牌排名</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">
<%
  if(null!=allBrands && allBrands.size()>0){
	  int i = Integer.parseInt(offset)+1 ;
	  for(Map oneMap:allBrands){
		  %>
<div class="<%=(i<=3&&("".equals(offset)||"0".equals(offset)))?"rl top3":"rl" %>"> <em><%=i %></em>
  <div class="img jlb"><a href="/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("logo")) %>" width="131" height="84" title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" /></a></div>
  <div class="rlRight">
    <div class="rlt">
      <h2><a href="/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name")) %></a></h2>
      <span>专注指数：<%=CommonString.getFormatPara(oneMap.get("view_count")) %></span> </div>
    <div class="rli"><%=CommonString.substringByte(CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("introduce"))),225)+"..." %><a href="/brand/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"><strong><font color="red">详细信息</font></strong></a></div>
  </div>
</div>
<%
		  i++ ;
	  }
  }
%>

<!--翻页-->
<div class="wfull l">
  <div id="pagination" class="page">
    <tags:page pageBean="<%=pageBean %>"/>
  </div>
</div>
<!--翻页-->
<div class="clear"></div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<script type="text/javascript" src="/scripts/sort.js"></script> 
<!--end of foot--> 
<script type="text/javascript">
<%
 if(referer.indexOf("brand.jsp")!=-1){
	 %>
	    //jQuery('html, body').animate({scrollTop: 215}, 0);
	 <%
 }
%>
</script>
</body>
<%-- </cache:cache> --%>
</html>