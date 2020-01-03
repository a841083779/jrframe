<%@page import="java.net.URLEncoder"%><%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ;   // 厂家
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类别
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map factoryMap = null; 
	List<Map> articleList = null ;
	String factoryName = "";
	String factoryId = "";
	String whereStr = "is_show=1 ";
	String catalogName = "";
%>
	<cache:cache cron="* */5 * * *" >
<%
	List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where len(num) = 6");
	if(allcatalogsList!=null && allcatalogsList.size()>0){
		for(Map m:allcatalogsList){
			if(m.get("num").equals(catalog)){
				catalogName = m.get("name").toString();
			}
		}
	}
	if(usern!=null && !usern.equals("")){
		String factory_sql = "select is_made, is_qijiandian,usern,is_shop,id,name,is_shop,logo,full_name,introduce,mobile,zturl,img1,telphone from pro_agent_factory where usern = '"+usern+"' and is_show=1 and flag=1" ;
		factoryMap = dbHelper.getMap(factory_sql);
		factoryId = CommonString.getFormatPara(factoryMap.get("id"));
		factoryName = CommonString.getFormatPara(factoryMap.get("name"));
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=factoryName %><%=catalogName %>动态_<%=factoryName %><%=catalogName %>动态大全_<%=factoryName %> - 铁臂商城</title>
<meta name="keywords" content="<%=factoryName %><%=catalogName %>动态,<%=factoryName %><%=catalogName %>动态大全,<%=factoryName %>,<%=factoryName %><%=catalogName %>" />
<meta name="description" content="铁臂商城<%=factoryName %><%=catalogName %>品牌专区，为您提供<%=factoryName %><%=catalogName %>最新动态资讯，帮助您全面了解<%=factoryName %><%=catalogName %>最新动态。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!-- jbox -->
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
</head>
<body>
<!--top--> 
<jsp:include page="/include/top_brand.jsp" flush="true">
<jsp:param value="<%=factoryId %>" name="factoryid"/>
</jsp:include>
<!--top end-->
<!--nav-->
<jsp:include page="brand_top.jsp" flush="true">
<jsp:param value="<%=usern %>" name="usern"/>
<jsp:param value="<%=factoryName %>" name="factoryName"/>
</jsp:include>
<!--nav end-->
<div></div>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt;  <a href="/brand/">品牌大全</a> &gt;&gt; <a href="/brand/<%=usern %>/"><%=factoryName %></a> &gt;&gt;  <a href="/brand/<%=usern %>/news.htm"><%=factoryName %>动态</a> &gt;&gt;  <%=factoryName %><%=catalogName %>动态</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 n_pp_promain">
	<div class="npp_protitle"><span><h1><%=factoryName %><%=catalogName %>动态</h1></span></div>
    <div class="npp_prolist">
    	<div class="npp_pl_top">
        	<ul class="np_fix">
        	<%
        		if(allcatalogsList!=null && allcatalogsList.size()>0){
        			for(Map m:allcatalogsList){
        				String num = CommonString.getFormatPara(m.get("num"));
        				String name = CommonString.getFormatPara(m.get("name"));
        				List<Map> subcatalogList = dbHelper.getMapList("select top 1 id from pro_products where is_show=1 and factoryid = '"+factoryId+"' and catalognum like '"+num+"%'");
        				if(subcatalogList!=null && subcatalogList.size()>0){
        	%>  
            		<li><a href="/brand/<%=usern %>/news_<%=num %>.htm" title="<%=factoryName %><%=name %>动态"><%=factoryName %><%=name %>动态</a></li>
        	<%}}}%>
            </ul>
        </div>
        <div class="np_fix npp_chan_t">
            	<div class="l npp_chan_t_left"><%=factoryName %>图片动态</div>
                <div class="r npp_chan_t_right"><a href="http://product.21-sun.com/news/list.jsp?flag=pronews" title="更多图片动态">更多 &gt;&gt;</a></div>
         </div>
        <div class="npp_video_list">
        	<ul class="np_fix">
            	<!--pic--> 
            	<jsp:include page="/include/brand/news_pic.jsp" flush="true">
				<jsp:param value="<%=factoryId %>" name="factoryid"/>
				<jsp:param value="<%=catalogName %>" name="catalogName"/>
				</jsp:include>
				<!--end of pic--> 
                
            </ul>
        </div>
        <div class="np_fix npp_chan_t">
            	<div class="l npp_chan_t_left"><%=factoryName %>动态</div>
                <div class="r npp_chan_t_right"><a href="http://sowa.21-sun.com/?q=<%=URLEncoder.encode(factoryName,"utf-8") %>&f=news" target="_blank" title="更多动态">更多 &gt;&gt;</a></div>
         </div>
         <div class=" npp_newslist">
         	<ul class="np_fix">
         		<!--news--> 
         		<jsp:include page="/include/brand/news_article.jsp" flush="true">
				<jsp:param value="<%=factoryId %>" name="factoryid"/>
				<jsp:param value="<%=catalogName %>" name="catalogName"/>
				</jsp:include>
				<!--end of news--> 
            </ul>
         </div>
        
       
    </div>
</div>
<!--main end--> 
<!--foot--> 
<jsp:include page="/include/foot.jsp" flush="true" />
<!--end of foot--> 
<script type="text/javascript" src="../scripts/sort.js"></script>
</body>
</html>
</cache:cache>