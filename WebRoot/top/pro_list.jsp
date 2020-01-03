<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%int year=2014;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【工程机械产品排行榜】工程机械品牌排名 - 铁臂排行榜</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="工程机械品牌排行榜,工程机械品牌排名" />
<meta name="description" content="铁臂商城为您提供最新的工程机械品牌排行榜，帮您实时了解工程机械品牌排名变化，买工程机械产品就上铁臂商城。" />
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
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="http://top.21-sun.com/">铁臂排行榜</a> &gt;&gt; <a href='/pro_list.jsp'>产品排行</a> </h3>
</div>
<!--面包屑结束-->
<!--main-->
<div class="contain980 mb10">
  <div class="brand_crumbss">
  <a href="http://top.21-sun.com/" >排行榜首页</a>
  <a href="/brand_list.jsp">品牌排行榜</a> 
  <a href="/pro_list.jsp" class="now">产品排行榜</a> 
  <a href="/pro_0_0_0_0_101001_0.htm">挖掘机排行榜</a>
  <a href="/pro_0_0_0_0_101002_0.htm">装载机排行榜</a>
  </div>
  <!--left-->
  <div class="w210 l np_left newLeft">
    <jsp:include page="/include/rank/left_brand.jsp" flush="true"/>
	<jsp:include page="tongji.jsp" flush="true" />
  </div>
  <!--left end-->
  <!--right-->
  <div class="w757 r np_right mb10 newRight">
    <div class="brand_right_js">
      <script type="text/javascript">
	  $(document).ready(function() {
        $('.pbtn').click(function(){
			if($(this).hasClass('pbon')){
				$(this).removeClass('pbon');
				$(this).parent().next('.plmore').hide();
			}else{
				$(this).addClass('pbon');
				$(this).parent().next('.plmore').show();
			}
		})
      });
	  </script>
      <h1><strong>工程机械产品排行榜</strong></h1>
      <p><strong>按类别：</strong>
      <a class="now">不限</a>
      <a href="/pro_<%=year%>_0_0_0_101001_0.htm">挖掘机</a>
      <a href="/pro_<%=year%>_0_0_0_101002_0.htm">装载机</a>
      <a href="/pro_<%=year%>_0_0_0_102_0.htm">起重机</a>
      <a href="/pro_<%=year%>_0_0_0_101003_0.htm">推土机</a>
      <a href="/pro_<%=year%>_0_0_0_103_0.htm">混凝土</a>
      <a href="/pro_<%=year%>_0_0_0_106001_0.htm">压路机</a>
      <a href="/pro_<%=year%>_0_0_0_101005_0.htm">平地机</a>
      <a href="/pro_<%=year%>_0_0_0_105003_0.htm">旋挖钻</a>
      <a href="/pro_<%=year%>_0_0_0_113003_0.htm">破碎锤</a>
      <a href="/pro_<%=year%>_0_0_0_104001_0.htm">摊铺机</a>
      <span class="pbtn"></span></p>
      <jsp:include page="/include/rank/more_catalog.jsp" flush="true">
	      <jsp:param value="<%=year%>" name="year"/>
	  </jsp:include>
	    
      <p><strong>按年份：</strong>
      <a class="now">总榜</a>
       <a href="/pro_2014_0_0_0_0_0.htm">2014</a> 
       <a href="/pro_2013_0_0_0_0_0.htm">2013</a>
       <a href="/pro_2012_0_0_0_0_0.htm">2012</a> 
       <a href="/pro_2011_0_0_0_0_0.htm">2011</a>
       <a href="/pro_2010_0_0_0_0_0.htm">2010</a> 
       <a href="/pro_2009_0_0_0_0_0.htm">2009</a> 
       <a href="/pro_2008_0_0_0_0_0.htm">2008</a> 
      </p>
    </div>
    <%@ include file="/include/rank/catalog_rank_index.htm" %>
  </div>
  <!--right end-->
  <div class="clear"></div>
</div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<div style="display:none"> <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5953945'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/stat.php%3Fid%3D5953945' type='text/javascript'%3E%3C/script%3E"));</script> </div>
<!--end of foot-->
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>