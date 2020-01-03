<%@ page language="java" import="java.util.*,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>山东宝格旗舰店</title>
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
		<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
		<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />

	</head>

	<body class="index">
		<div class="brand_topbg">
			<div class="top contain980 brand_top">
				<h1><a title="铁臂商城" href="http://product.21-sun.com/"><img title="铁臂商城" src="images/new_logo.png" alt="铁臂商城" width="220" height="72"></a></h1>
				<div class="new_topMid">
					<ul class="news_topSearch">
						<li class="ntsi">
							<input type="text" value="" maxlength="30" id="keyword" name="keyword" onkeydown="tj2();">
						</li>
						<li class="ntsb">
							<input type="submit" value="&nbsp;" id="button" onclick="tj3();">
						</li>
						<input type="hidden" value="product" name="f">
					</ul>
					<div class="hotWords">热门搜索：
						<a href="/search/挖掘机_0_0_0.htm" target="_blank"><b>挖掘机</b></a>
						<a href="/search/装载机_0_0_0.htm" target="_blank">装载机</a>
						<a href="/search/起重机_0_0_0.htm" target="_blank">起重机</a>
						<a class="link09" href="/search/卡特彼勒挖机_0_0_0.htm" target="_blank"> 卡特彼勒挖机</a>
					</div>
				</div>
				<script>
					function tj2() {
						if((event.ctrlKey && window.event.keyCode == 13) || window.event.keyCode == 13) {
							if(jQuery('#keyword').val() == '') {
								alert("请输入您要搜索的关键词");
								jQuery('#keyword').focus();
								return false;
							}
							var keyword = jQuery('#keyword').val();
							window.open("/search/" + keyword + "_0_0_0.htm", "target");
						}
					}

					function tj3() {
						if(jQuery('#keyword').val() == '') {
							alert("请输入您要搜索的关键词");
							jQuery('#keyword').focus();
							return false;
						}
						var keyword = jQuery('#keyword').val();
						window.open("/search/" + keyword + "_0_0_0.htm", "target");
					}
				</script>
				<div id="topHot" class="topHot">
					<img src="images/tu5.gif" width="260" height="80">
				</div>

			</div>
		</div>

		<div class="main">
			<div class="header">
				<img src="images/top_line_02.png" class="pa top_line" />
				<div class="header_in pr">
					<p class="pa">服务电话:0539-8785989</p>
					<img src="images/logo_03.png" />
				</div>
			</div>
			<div class="banner pr">
				<img src="images/banner_02.jpg" class="pa" />
			</div>
			<div class="main_in">
				<div class="section">
					<div class="sec_header pr">
						<img src="images/sec_line_03.png" alt="" class="pa" />
						<p>公司简介</p>
					</div>
					<div class="sec_abc fix">
						<img src="images/abc_img_03.jpg" class="l" />
						<div class="text r">
							<p>山东宝格机械科技有限公司隶属临工金利集团，临沂金利集团成立于1999年，是世界知名品牌工程机械配件提供商，公司下辖：临沂临工金利机械有限公司、临沂金利液压科技有限公司、临沂富盛机械配件有限公司、临沂临工金利电动车有限公司、山东宝格机械科技有限公司。自成立以来，公司以年均30%的速度增长，目前已经发展为国内重要工程机械零部件制造商。</p>
							<p>公司产品包括轮式挖掘机、工程机械钣金件（驾驶室、配重等）、液压件（液压油缸、高压软硬管），其中液压油缸已成为国内一线品牌，高压软、硬管市场占有率居国内首位。</p>
						</div>
					</div>
				</div>
				<div class="section">
					<div class="sec_header pr">
						<img src="images/sec_line_03.png" alt="" class="pa" />
						<a href="http://product.21-sun.com/proDetail/EW670BM.shtm" target="_blank"><p>EW670BM</p></a>
					</div>
					<div class="sec_pro pr">
						<img src="images/pro_1_07.jpg" class="pa" />
						<div class="pro_all pa">
							<div class="detail">
								<p class="title">EW670BM轮式挖掘机</p>
								<p class="de">最大挖掘高度：6149MM</p>
								<p class="de">最大卸载高度：4496MM</p>
								<p class="de">工作重量：6500KG</p>
								<p class="de">铲斗容量：0.28</p>
							</div>
							<div class="btns fix">
								<a onclick="javascript:down('/brandshop/sdbg/images/670BM.rar','670BM')" class="download l">下载产品手册>></a>
								<a onClick="showinquery('30467','');" class="pay r">立即订购>></a>
							</div>
						</div>
					</div>
				</div>
				<div class="section">
					<div class="sec_header pr">
						<img src="images/sec_line_03.png" alt="" class="pa" />
						<a href="http://product.21-sun.com/proDetail/EW680BM.shtm" target="_blank"><p>EW680BM</p></a>
					</div>
					<div class="sec_pro pr">
						<img src="images/pro_2_10.jpg" class="pa" />
						<div class="pro_all pa">
							<div class="detail">
								<p class="title">EW680BM轮式挖掘机</p>
								<p class="de">最大挖掘高度：6524MM</p>
								<p class="de">最大卸载高度：4716MM</p>
								<p class="de">工作重量：7600KG</p>
								<p class="de">铲斗容量：0.33</p>
							</div>
							<div class="btns fix">
								<a onclick="javascript:down('/brandshop/sdbg/images/680BM.rar','680BM')" class="download l">下载产品手册>></a>
								<a onClick="showinquery('30468','');" class="pay r">立即订购>></a>
							</div>
						</div>
					</div>
				</div>
				<div class="section">
					<div class="sec_header pr">
						<img src="images/sec_line_03.png" alt="" class="pa" />
						<a href="http://product.21-sun.com/proDetail/EW685BMZ.shtm" target="_blank"><p>EW685BMZ</p></a>
					</div>
					<div class="sec_pro pr">
						<img src="images/pro_3_12.jpg" class="pa" />
						<div class="pro_all pa">
							<div class="detail">
								<p class="title">EW685BMZ轮式挖掘机</p>
								<p class="de">最大挖掘高度：7554MM</p>
								<p class="de">最大卸载高度：5517MM</p>
								<p class="de">工作重量：7600KG</p>
								<p class="de">铲斗容量：0.33</p>
							</div>
							<div class="btns fix">
								<a onclick="javascript:down('/brandshop/sdbg/images/685BMZ.rar','685BMZ')" class="download l">下载产品手册>></a>
								<a onClick="showinquery('30469','');" class="pay r">立即订购>></a>
							</div>
						</div>
					</div>
				</div>
				<div class="section">
					<div class="sec_header pr">
						<img src="images/sec_line_03.png" alt="" class="pa" />
						<a href="http://product.21-sun.com/proDetail/EW690BMZ.shtm" target="_blank"><p>EW690BMZ</p></a>
					</div>
					<div class="sec_pro pr">
						<img src="images/pro_4_14.jpg" class="pa" />
						<div class="pro_all pa">
							<div class="detail">
								<p class="title">EW690BMZ夹木机</p>
								<p class="de">最大挖掘高度：7554MM</p>
								<p class="de">最大卸载高度：5517MM</p>
								<p class="de">工作重量：8300KG</p>
								<p class="de">铲斗容量：0.33</p>
							</div>
							<div class="btns fix">
								<a onclick="javascript:down('/brandshop/sdbg/images/690BMZ.rar','690BMZ')" class="download l">下载产品手册>></a>
								<a onClick="showinquery('30470','');" class="pay r">立即订购>></a>
							</div>
						</div>
					</div>
				</div>
				<div class="section">
					<div class="sec_header pr">
						<img src="images/sec_line_03.png" alt="" class="pa" />
						<a href="http://product.21-sun.com/proDetail/EW690BM.shtm" target="_blank"><p>EW690BM</p></a>
					</div>
					<div class="sec_pro pr">
						<img src="images/pro_5_16.png" class="pa" />
						<div class="pro_all pa">
							<div class="detail">
								<p class="title">EW690BM轮式挖掘机</p>
								<p class="de">最大挖掘高度：6524MM</p>
								<p class="de">最大卸载高度：4716MM</p>
								<p class="de">工作重量：8300KG</p>
								<p class="de">铲斗容量：0.33</p>
							</div>
							<div class="btns fix">
								<a onclick="javascript:down('/brandshop/sdbg/images/690BM.rar','690BM')" class="download l">下载产品手册>></a>
								<a onClick="showinquery('30471','');" class="pay r">立即订购>></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="page_footer tc">
			<p class="footer_item">
				<a style="color:#fff" target="_blank" href="http://www.21-sun.com/service/guanggao/index.htm">广告服务</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a style="color:#fff" target="_blank" href="http://aboutus.21-sun.com/contact/">联系方式</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a style="color:#fff" target="_blank" href="http://product.21-sun.com/about/">关于我们</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a style="color:#fff" target="_blank" href="http://www.jerei.com/news/index-list-0.htm">本网动态</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a style="color:#fff" href="http://www.jerei.com/site/mian-ze-sheng-ming.htm">法律声明</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a style="color:#fff" href="http://aboutus.21-sun.com/map.htm">网站导航</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a style="color:#fff" href="http://aboutus.21-sun.com/contact/">联系客服</a>
			</p>
			<p class="footer_item">中国工程机械商贸网 Copyright © 2000-2017</p>
		</div>

	</body>
	
	<script>
	 function showinquery(pid,factoryid){
		jQuery.jBox("iframe:/include/products/product_order_s.jsp?productid="+pid+"&factoryid="+factoryid, {
		title: "在线询价",
		width: 769,
		height: 480,
		top: '10%',	
		iframeScrolling : 'no',
		buttons: { '关闭': false }
		});
		jQuery(".jbox-button-panel").attr("style","display:none;") ;
		jQuery(".jbox-title-panel").attr("style","display:none;") ;
		jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
	}
	function down(obj,obj1){
		window.open("/brandshop/sdbg/down.jsp?filename="+encodeURI(obj)+"&title="+encodeURI(obj1));
	}

	</script>
</html>