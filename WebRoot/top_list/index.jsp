﻿<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【工程机械排名|挖掘机排名|企业品牌排行榜】 - 铁臂商城</title>
<meta name="keywords" content="工程机械排名,挖掘机排名,装载机排名,排行榜" />
<meta name="description" content="工程机械排名、挖掘机排名，铁臂商城为您提供最新的世界工程机械销售排行榜、中国工程机械排行榜、2012工程机械企业排名等。" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; 排行榜</h3>
</div>
<!--面包屑结束-->

<!--main-->
<div class="contain980 mb10">
<%@ include file="/include/top_list/brand_attention_order.htm" %>  <!-- 品牌关注度排行榜 -->
<%@ include file="/include/top_list/hot_products_order.htm" %>       <!--  热门产品排行-->
<%@ include file="/include/top_list/catalog_order.htm" %>					 <!-- 类别产品排行 -->
<div class="clear"></div>
</div>
<!--main end-->
<!--foot-->
	<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot-->
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">
	    function showinquery(pid){
    	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+pid, {
	    title: "在线询价单",
	    width: 720,
	    height: 450,
	    buttons: { '关闭': false }
	    });
	    jQuery(".jbox-button-panel").attr("style","display:none;") ;
    }
</script>
</body>
</html>