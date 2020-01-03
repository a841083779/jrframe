<%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page language="java"  pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.util.List"%><%@page import="java.util.Map"%><%@page import="com.jerehnet.util.common.CommonHtml"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	String flag  = CommonString.getFormatPara(request.getParameter("flag")) ; // product 按类别排序
	String catalognum  = CommonString.getFormatPara(request.getParameter("catalognum")) ; // product 按类别排序
	String offset = "".equals(CommonString.getFormatPara(request.getParameter("offset")))?"0":CommonString.getFormatPara(request.getParameter("offset")) ;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String cachekey = flag+offset ;
	String catalogName = "" ;
%> <cache:cache cron="* * */5 * *"><%
	DBHelper dbHelper = DBHelper.getInstance();
	//类型名称
	List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where len(num) = 6");
	if(allcatalogsList!=null && allcatalogsList.size()>0){
		for(Map m:allcatalogsList){
			if(m.get("num").equals(catalognum)){
				catalogName = m.get("name").toString();
			}
		}
	}
	PageBean pageBean = new PageBean() ;
	String tablename = "pro_products" ;
	
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
  //	pageBean.setIsShowSql(true) ;
  	pageBean.setCondition(" and is_show=1 ") ;
  	if(catalognum!=null && !catalognum.equals("")){
  		pageBean.setCondition(" and is_show=1 and catalognum like '"+catalognum+"%'") ;
  	}else{
  		catalogName = "热门产品" ;
  		pageBean.setOrderBy(" view_count desc ") ;
  	}
	
	String whereStr = "" ;
	if(!"".equals(factoryid)){
		whereStr = "and factoryid='"+factoryid+"'"  ;
		pageBean.setCondition(whereStr) ;
	}
	if(!"".equals(catalog)){
		whereStr+=" and catalognum like '%"+catalog+"%'" ;
		pageBean.setCondition(whereStr) ;
	}
	pageBean.setFields(" img2,factoryname,name,catalogname,introduce,file_name,view_count") ;
	List<Map> allProducts = pageBean.getDatas() ;
 %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=catalogName %>排名|<%=catalogName %>排行榜】 - 中国工程机械商贸网</title>
<meta name="keywords" content=" <%=catalogName %>排名,<%=catalogName %>排行榜" />
<meta name="description" content="<%=catalogName %>排名、<%=catalogName %>排行榜，<%=catalogName %>排名是经过销量、销售额、企业品牌知名度等综合数据进行权威统计。<%=catalogName %>排名涵盖中国、日本、韩国、欧美等世界多个地区品牌。" />
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
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/top_list/">排行榜</a> &gt;&gt; <%=catalogName %>排名</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10">
<%
  if(null!=allProducts && allProducts.size()>0){
	  int i=Integer.parseInt(offset)+1 ;
	  for(Map oneMap:allProducts){
		  %>
<div class="<%=(i<=3&&("".equals(offset)||"0".equals(offset)))?"rl top3":"rl" %>"> <em><%=i %></em>
  <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="131" height="84" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" /></a></div>
  <div class="rlRight">
    <div class="rlt">
      <h2><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h2>
      <span>关注指数：<%=CommonString.getFormatPara(oneMap.get("view_count")) %></span> </div>
    <div class="rli"><%=CommonString.substringByte(CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("introduce"))),220)+"..." %><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><font color="red"><strong>详细信息</strong></font></a></div>
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
<% if(referer.indexOf("products.jsp")!=-1){%>
	    //jQuery('html, body').animate({scrollTop: 215}, 0);
	 <% }%>
</script>
</body>
</html>
</cache:cache>