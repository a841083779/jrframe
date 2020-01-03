<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>德工机械官方旗舰店</title>
<meta content="" name="Keywords">
<meta content="" name="Description">
<link rel="icon" href="/resources/favicon.ico" >
<meta name="format-detection" content="telephone=no">
<meta name="author" content="design by www.jerei.com">
<link href="css/style.css" rel="stylesheet">
<script src="js/jquery-1.7.min.js"></script>
<link href="/style/style.css" rel="stylesheet" type="text/css" />

</head>
<body>
<!--header-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>

<!--header end-->
<!--main-->
<section class="pageMain zhuangzaiji arrow_bg">
	<div class="wrap">
		<!-- 店铺介绍 start -->
		<div class="shop_header fix">
			<img class="dg_logo l" src="img/dg_logo.png" alt="logo">
			<div class="shop_search l">
				<div class="search_box fix">
					<input class="search_ipt l" type="text" id="keyword" />
					<input class="search_btn hidetext l" onclick="search()" type="submit">
				</div>
				<p class="hot_search el">热门搜索：<a href="zzj.jsp">德工装载机</a>、<a href="lzs.jsp">德工冷再生机</a>、<a href="psj.jsp">德工水泥路面破碎机</a></p>
			</div>
			<div class="shop_info r">
				<p>客服热线：<span class="shop_tel">0534-2552509</span></p>
				<p>客服时间：8:00-17:30</p>
				<p>销售部门QQ：<a  target="_blank"  href="http://wpa.qq.com/msgrd?v=3&uin=1789819546&site=qq&menu=yes" class="qq_server"></a></p>
			</div>
		</div>
		<!-- 店铺介绍 end -->
		<!-- 导航 start -->
		<div class="navs tc">
			<a style="color:#fff" href="index.htm" class="nav_item">首页</a>
			<a style="color:#fff" href="zzj.jsp" class="nav_item">装载机</a>
			<a style="color:#fff" href="lzs.jsp" class="nav_item">冷再生机</a>
			<a style="color:#fff" href="psj.jsp" class="nav_item">破碎机</a>
			<a style="color:#fff" href="wjj.jsp" class="nav_item">轮式挖掘机</a>
			<a style="color:#fff"  href="cycp.jsp" class="nav_item">差异化产品</a>
			<a style="color:#fff"  href="ttj.jsp" class="nav_item">推土机</a>
			<a style="color:#fff" href="intro.htm" class="nav_item">公司介绍</a>
		</div>
		<!-- 导航 end -->
		</div>
		<!-- banner start -->
		<div class="banner" style="background-image:url(img/banner1.jpg);height:510px;background-position: center;"  >
		</div>
		<!-- banner end -->
		<div class="wrap">
		<!-- 轮式挖掘机介绍 start -->
		<div class="product_info_list oh">
			<div class="title tit04 pr">
				<p class="title_info pa tr">销售热线： 0534-2552537  18605348511</p>
			</div>
			<div class="product_item pr">
				<a href="http://product.21-sun.com/proDetail/DG680.shtm" target="_blank"><img class="pa product_img" src="img/index_goods_06.jpg" alt="DG680轮式挖掘机"></a>
				<div class="product_info pa">
					<p class="item_tit">DG680轮式挖掘机</p>
					<p class="info_info oh">采用国Ⅲ发动机，动力强劲，高<br>效可靠；环保排放，低震动、低<br>噪音，低油耗。</p>
					<a href="javascript:;" onClick="showinquery('29727','');"   class="btn_consult">立即询价</a>
				</div>
			</div>
		</div>
		<!-- 轮式挖掘机介绍 end -->
	</div>
</section>
<!--main end-->
<!--footer-->
<footer class="page_footer tc">
	<p class="footer_item"><a  style="color:#fff" target="_blank" href="http://www.21-sun.com/service/guanggao/index.htm">广告服务</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a  style="color:#fff" target="_blank" href="http://aboutus.21-sun.com/contact/">联系方式</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a  style="color:#fff" target="_blank" href="http://product.21-sun.com/about/">关于我们</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a  style="color:#fff"  target="_blank" href="http://www.jerei.com/news/index-list-0.htm">本网动态</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a  style="color:#fff" href="http://www.jerei.com/site/mian-ze-sheng-ming.htm">法律声明</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a  style="color:#fff" href="http://aboutus.21-sun.com/map.htm">网站导航</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a  style="color:#fff" href="http://aboutus.21-sun.com/contact/">联系客服</a></p>
	<p class="footer_item">产品询价专线:4006-521-526</p>
	<p class="footer_item">中国工程机械商贸网 Copyright © 2000-2017</p>
</footer>
<!--footer end-->
<script src="js/jquery.SuperSlide.js"></script>
<script src="js/lunshi.js"></script>

<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />

<script>
function search(){

 var keyword=jQuery("#keyword").val();
 if(keyword==''){
    alert("请输入您要搜索的产品！");
 }else{
    window.location.href="/brandshop/dgjx/search.jsp?keyword="+keyword;
 }	

}
</script>
<div style="display:none"><script src="https://s22.cnzz.com/z_stat.php?id=1263117920&web_id=1263117920" language="JavaScript"></script></div>

</body>
</html>