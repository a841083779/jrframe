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
<section class="pageMain zhuangzaiji differentiation arrow_bg">
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
		<!-- 冷再生介绍 start -->
		<div class="product_info_list oh">
			<div class="title tit06 pr"></div>
		</div>
		<!-- 冷再生介绍 end -->
		<div class="list_tline style2">
			<ul class="fix">
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_02.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">侧卸斗</p>
							<p  class="info_info el">产品型号：956N</p>
							<p  class="info_info el">铲斗宽度：2970/3040</p>
							<p  class="info_info el">斗容：2.3/2.5</p>
						</div>
						<a  href="javascript:;" onClick="showinquery('','151');"  class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_06.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">货叉</p>
							<p  class="info_info el">货叉宽度:1270mm</p>
							<p  class="info_info el">提升高度:3800mm/4900mm</p>
							<p  class="info_info el">起重载荷:1500KG</p>
						</div>
						<a href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				
					<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_08.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">煤斗</p>
							<p  class="info_info el">产品型号:DG938N&nbsp;&nbsp;斗容:2.2</p>
							<p  class="info_info el">产品型号:DG956N&nbsp;&nbsp;斗容:4.0</p>
							<p  class="info_info el">产品型号:DG965N、DG966N&nbsp;&nbsp;斗容:5.0 </p>
						</div>
						<a href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_01.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">v型抱木器</p>
			                <p  class="info_info el">产品型号：956N</p>
							<p  class="info_info el">叉体宽度：2100</p>
							<p  class="info_info el">最大开口：2052</p>
						</div>
						<a  href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>

				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_03.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">错齿抱木器</p>
                            <p  class="info_info el">产品型号：956N</p>
							<p  class="info_info el">叉体宽度：2100</p>
							<p  class="info_info el">最大开口：1970</p>
						</div>
						<a href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_04.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">对齿抱木器</p>
                            <p  class="info_info el">产品型号：956N</p>
							<p  class="info_info el">叉体宽度：2332</p>
							<p  class="info_info el">最大开口：2110</p>
						</div>
						<a href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_05.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">滑齿抱木器</p>
                            <p  class="info_info el">产品型号：956N</p>
							<p  class="info_info el">叉体宽度：2440</p>
							<p  class="info_info el">最大开口：1900</p>
						</div>
						<a href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_15.jpg" alt="">
					<div class="item_info pa fix">
						<div class="info_box l">
							<p class="goods_tit el">抓草机</p>
                            <p  class="info_info el">产品型号：938N</p>
							<p  class="info_info el">叉体宽度：2380</p>
							<p  class="info_info el">最大开口：2784</p>
						</div>
						<a href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_07.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >螺旋钻</p>
			 
						</div>
						<a  style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
			
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_09.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >破碎锤</p>
				 
						</div>
						<a  style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_10.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >清扫机</p>
	 
						</div>
						<a  style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_11.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >清扫器</p>
	 
						</div>
						<a  style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_12.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >软包夹</p>
			 
						</div>
						<a  style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_13.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >三齿抱木器</p>
				 
						</div>
						<a   style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_14.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >推柴机</p>
 
						</div>
						<a  style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>

				<li class="l pr goods_item imgZoom">
					<img class="goods_img" src="img/product_16.jpg" alt="">
					<div class="item_info pa fix" style="height: 44px;">
						<div class="info_box l">
							<p class="goods_tit el" style="line-height: 40px;" >抓管机</p>
 
						</div>
						<a  style="margin-top: 4px;" href="javascript:;" onClick="showinquery('','151');" class="item_btn l">立即询价</a>
					</div>
				</li>
			</ul>
		</div>
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
<script src="js/differentiation.js"></script>

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