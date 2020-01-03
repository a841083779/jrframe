<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<link href="/style/brandshop_top.css" rel="stylesheet" type="text/css" />
<div class="brand_topBar">
  <div class="contain980 clearfix">
    <div class="visit_21sun"><a title="返回工程机械产品中心" href="http://product.21-sun.com/" target="_blank"><img src="/images/brandshop_toppoint.gif"> 返回工程机械产品中心</a></div>
    <script type="text/javascript">
	jQuery(function(){
		jQuery(".loginLinks_new li").hover(function(){
			jQuery(this).toggleClass("hover");
		},function(){
			jQuery(this).removeClass("hover");
		});
	});
	</script>
    <ul class="loginLinks_new">
      <li onclick="window.open('/agent/login.jsp');">厂家登录</li>
      <li onclick="window.open('/agent/login.jsp');">代理商登录</li>
    </ul>
    <ul class="tlRight">
      <li onclick="window.open('http://product.21-sun.com/products/');" class="tl">产品大全</li>
      <li onclick="window.open('http://product.21-sun.com/brand/');" class="tl">品牌大全</li>
      <li onclick="window.open('http://product.21-sun.com/news/');" class="tl">行情导购</li>
      <li onclick="window.open('http://product.21-sun.com/inquiry/');" class="tl">采购询价</li>
      <li onclick="window.open('http://product.21-sun.com/photo/');" class="tl">产品图库</li>
      <li onclick="window.open('http://product.21-sun.com/top_list/');" class="tl">排行榜</li>
      <li onclick="window.open('http://product.21-sun.com/agent/');" class="tl">代理商专区</li>
      <li class="guide"><span class="gt">网站导航</span>
        <ul>
          <li onclick="window.open('http://market.21-sun.com/');">供求市场</li>
          <li onclick="window.open('http://news.21-sun.com/');">行业动态</li> 
          <li onclick="window.open('http://product.21-sun.com/');">整机市场</li>
          <li onclick="window.open('http://www.21-sun.com/part/');">配件市场</li>
          <li onclick="window.open('http://www.21-rent.com/');">租赁调剂</li>
          <li onclick="window.open('http://www.21part.com/');">杰 配 网</li>
          <li onclick="window.open('http://www.21peitao.com/');">配 套 网</li>
          <li onclick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
          <li onclick="window.open('http://www.21-cmjob.com/');">招聘求职</li>
          <li onclick="window.open('http://data.21-sun.com/');">数据分析</li>
          <li onclick="window.open('http://www.21-sun.com/bidding/');">招 投 标</li>
          <li onclick="window.open('http://stock.21-sun.com/');">行业股市</li>
        </ul>
      </li>
    </ul>
  </div>
</div>
<div class="brand_topbg">
<div class="top contain980 brand_top">
  <h1><a href="/"><img width="136" height="72" alt="中国工程机械商贸网" src="/images/new_n_21sun.gif"><img width="53" height="72" alt="产品中心" src="/images/new_n_pro_name.gif"></a></h1>
  <div class="new_topMid">
    <ul class="news_topSearch">  
      <form target="_blank" onsubmit="if(jQuery('#keyword').val()==''){alert('请输入您要搜索的关键词');jQuery('#keyword').focus();return false;}" action="http://sowa.21-sun.com/" method="get" name="top_search" id="top_search">
        <li class="ntsi">  
          <input type="text" value="" maxlength="30" id="q" name="q">
        </li>
        <li class="ntsb">     
          <input type="submit" value="&nbsp;" id="button">  
        </li>
          <input type="hidden" value="product" name="f">  
      </form>
    </ul>
    <div class="hotWords">热门搜索：<a href="/products/prolist.jsp?catalog=101001"><b>挖掘机</b></a> <a href="/products/prolist.jsp?catalog=101002">装载机</a> <a href="/products/prolist.jsp?catalog=102">起重机</a> <a href="/products/prolist.jsp?factory=134&amp;catalog=101001">中联挖掘机</a><a onclick="window.open('http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101001');" style="cursor:pointer" target="_blank" class="link09"> 卡特彼勒挖机</a></div>
  </div>
  <div id="topHot" class="topHot">
    <ul class="thl">
      <li style="display: block;"><img width="260" height="80" style="cursor:pointer" onclick="window.open('/tuan/');" alt="产品中心优买团" src="/images/tu1.png"></li>
      <li style="display: none;"><img width="260" height="80" style="cursor:pointer" onclick="window.open('http://data.21-sun.com/');" alt="产品中心数据分析" src="/images/tu3.png"></li>
      <li style="display: none;"><img width="260" height="80" style="cursor:pointer" onclick="window.open('http://market.21-sun.com/');" alt="工程机械供求市场" src="/images/tu2.png"></li>
    </ul>
    <ul class="thn">
      <li class="on">1</li>
      <li>2</li>
      <li>3</li>
    </ul>
    <p><span><em id="showNumId">1</em>/3</span><a title="上一张" class="imgPrev" href="javascript:showPre3();">上一张</a><a title="下一张" class="imgNext" href="javascript:showAuto3();">下一张</a></p>
  </div>
  
  <script type="text/javascript">
  var count3 = 0;
    count3=jQuery(".thl li").length;
	jQuery(".thl li").hide();
	jQuery(".thl li:first").show();
	jQuery("#topHot").show();
	jQuery(".thn li").click(function() {
		var i = jQuery(this).text() - 1;
		n3 = i;
		if (i >= count3) return;
		jQuery(".thl li").filter(":visible").fadeOut(800).parent().children().eq(i).fadeIn(800);
		jQuery(this).toggleClass("on");
		jQuery(this).siblings().removeAttr("class");
	});
	t3 = setInterval("showAuto3()", 11000);
	jQuery("#topHot").hover(function(){clearInterval(t3)}, function(){t3 = setInterval("showAuto3()", 11000);});
  </script>
</div>
</div>