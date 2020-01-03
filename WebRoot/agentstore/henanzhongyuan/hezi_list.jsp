<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> waProductsList = new ArrayList() ;
	String wa_sql = " select * from pro_agent_product_vi where factoryid=183 and catalognum LIKE '101001%' AND agentid=1202 and is_show=1" ; 

	waProductsList = dbHelper.getMapList(wa_sql+"order by order_no");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>中远机械 - 中国工程机械商贸网</title>
<meta name="keywords" content="中远机械,中远机械产品报价,中远机械产品,中远机械产品图片,中远机械产品介绍,中远机械介绍" />
<meta name="description" content="中国工程机械商贸网为您提供中远机械介绍,中远机械产品介绍,中远机械产品报价,中远机械产品图片,中远机械产品展示等中远机械产品信息，帮助您全面了解中远机械。" />

<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<link href="http://product.21-sun.com/style/brandshop_top.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />


<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<div class="brand_topBar">
  <div class="contain980 clearfix">
    <div class="visit_21sun"><a target="_blank" href="http://product.21-sun.com/" title="返回铁臂商城"><img src="http://product.21-sun.com/images/brandshop_toppoint.gif" /> 返回铁臂商城</a></div>
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
      <li class=""><a target="_blank" href="http://product.21-sun.com/agent/login.jsp">厂家登录</a></li>
      <li class=""><a target="_blank" href="http://product.21-sun.com/agent/login.jsp">代理商登录</a></li>
    </ul>
    <ul class="tlRight">
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/products/">产品大全</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/brand/">品牌大全</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/news/">行情导购</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/inquiry/">采购询价</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/photo/">产品图库</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/top_list/">排行榜</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/agent/">代理商专区</a></li>
      <li onmouseout="hideOther()" onmouseover="showOther()" class="guide"><span class="gt">网站导航</span>
        <ul id="other">
          <li onclick="window.open('http://market.21-sun.com/');" style="color:#434343">供求市场</li>
          <li onclick="window.open('http://news.21-sun.com/');" style="color:#434343">行业动态</li> 
          <li onclick="window.open('http://product.21-sun.com/');" style="color:#434343">整机市场</li>
          <li onclick="window.open('http://www.21-sun.com/part/');" style="color:#434343">配件市场</li>
          <li onclick="window.open('http://www.21-rent.com/');" style="color:#434343">租赁调剂</li>
          <li onclick="window.open('http://www.21part.com/');" style="color:#434343">杰 配 网</li>
          <li onclick="window.open('http://www.21peitao.com/');" style="color:#434343">配 套 网</li>
          <li onclick="window.open('http://www.21-sun.com/supply/');" style="color:#434343">供 应 商</li>
          <li onclick="window.open('http://www.21-cmjob.com/');" style="color:#434343">招聘求职</li>
          <li onclick="window.open('http://data.21-sun.com/');" style="color:#434343">数据分析</li>
          <li onclick="window.open('http://www.21-sun.com/bidding/');" style="color:#434343">招 投 标</li>
          <li onclick="window.open('http://stock.21-sun.com/');" style="color:#434343">行业股市</li>
        </ul>
      </li>
    </ul>
  </div>
</div>

<div class="brand_topbg brand_top">
<div class="top contain980 ">
  <h1><a href="http://product.21-sun.com/" title="铁臂商城"><img width="220" height="72" alt="铁臂商城" src="images/new_logo.png" title="铁臂商城"></a></h1>
  <div class="new_topMid">
    <ul class="news_topSearch">  
        <li class="ntsi">  
          <input type="text" onkeydown="tj2();" name="keyword" id="keyword" maxlength="30" value=""/>
        </li>
        <li class="ntsb">     
          <input type="submit" onclick="tj3();" id="button" value="&nbsp;"/>  
        </li>
          <input type="hidden" name="f" value="product"/> 
    </ul>
      <div class="hotWords">热门搜索： <a target="_blank" href="/search/挖掘机_0_0_0.htm"><b>挖掘机</b></a> <a target="_blank" href="/search/装载机_0_0_0.htm">装载机</a> <a target="_blank" href="/search/起重机_0_0_0.htm">起重机</a> <a target="_blank" href="/search/卡特彼勒挖机_0_0_0.htm" class="link09"> 卡特彼勒挖机</a> </div>
  </div>
          <script>
		  function showOther(){
		  document.getElementById('other').style.display="block";
		  }
		  function hideOther(){
		  document.getElementById('other').style.display="none";
		  }
		  function tj2(){
		  if((event.ctrlKey&&window.event.keyCode==13)||window.event.keyCode==13) {
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/search/"+keyword+"_0_0_0.htm","target");
		  }
		  }
		  function tj3(){
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/search/"+keyword+"_0_0_0.htm","target");
		  }
		</script>
  <div class="topHot" id="topHot">
  <img width="260" height="80" src="images/tu5.gif" />
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
		$(function(){
		$("body,html").animate({
		scrollTop:$("#list").offset().top //让body的scrollTop等于pos的top，就实现了滚动
		},100);
		
	})
  </script>
</div>
</div>


<div class="g_top">
    	<div class="wrap clearfix">
    	<h1 class="logo"><a href="" title=""><img src="images/logo.png" alt=""/></a></h1>
        <a class="collect" href="javascript:void();" onclick="addShop()" title=""><img src="images/collect.png" alt=""/></a>
        <p>原装神钢挖掘机、宣工推土机、<br />厦工机械产品河南地区总代理</p>
        </div>
    </div>
<div class="g_nav">
    	<ul class="wrap">
          <li><a href="/agentstore/henanzhongyuan/index.jsp">首页</a></li>
            <li><a href="/agentstore/henanzhongyuan/yuanwa_list.jsp" >原装神钢挖掘机</a></li>
          <li><a href="/agentstore/henanzhongyuan/hezi_list.jsp" >合资神钢挖掘机</a></li>
          <li><a href="/agentstore/henanzhongyuan/tui_list.jsp" >宣工推土机</a></li>
          <li><a href="/agentstore/henanzhongyuan/zhuang_list.jsp" >厦工机械产品</a></li>
          <li><a href="/agentstore/henanzhongyuan/index.jsp#jieshao">公司介绍</a></li>
          <li><a href="/agentstore/henanzhongyuan/index.jsp#lianxi">联系方式</a></li>
        </ul>
    </div>
       <div class="g_banner">
    	<div class="bd">
          <ul>
            <li><a href="" title=""><img src="images/banner.jpg" alt="" /></a></li>
          
          </ul>
        </div>
        <div class="hd"></div>
    </div>
<!--          <script>jQuery(".g_banner").slide({mainCell:".bd ul",effect:"left",autoPlay:true,vis:1}); </script>
-->
	<div class="g_link">
    	<div class="wrap clearfix">
    	<ul class=" ">
          <li><a href="/agentstore/henanzhongyuan/yhwa_list.jsp"><img src="images/a1.jpg" alt=""/></a></li>
          <li><a href="/agentstore/henanzhongyuan/tui_list.jsp" ><img src="images/a2.jpg" alt=""/></a></li>
          <li><a href="/agentstore/henanzhongyuan/zhuang_list.jsp" ><img src="images/a3.jpg" alt=""/></a></li>
        </ul>
        </div>
    </div>
    <div class="con1" id="list">
    <div class="g_tit">
      <div class="wrap clearfix">
    	<h2>合资神钢挖掘机</h2>
      </div>
    </div>
    <ul class="pro1 wrap proList">
    <% 
    	if(waProductsList.size()>0 && waProductsList!=null){
    		for(Map oneMap:waProductsList){
    			%>
    			<li><a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="<%="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="284" height="221"/></a>
                <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
                <a href="javascript:;" class="order_btn"  onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');"></a>
               </li>
    			<%
    		}
    	}
    %>
    </ul>
    </div>

<div class="bottombg">
<div class="proFoot" style="width:980px; height:170px; margin:0 auto; clear:both; position:relative;">
<div class="fewm" style="position:absolute; right:-18px; top:36px; width:160px; text-align:center;"><img width="90" height="90" src="images/ewm_new.gif"><br/>关注铁臂商城<br/>抢先查询新品信息</div>
  <link type="text/css" href="http://www.21-sun.com/00css/new_21sun_include.css" rel="stylesheet"/>
  <div class="New_website">
    <div class="New_linksContain">
      <strong><span onclick="window.open('http://www.21-sun.com');" class="New_links">中国工程机械商贸网</span>旗下网站：</strong>
      <span onclick="window.open('http://part.21-sun.com/');" class="New_links">中国工程机械配件网</span>
      <span onclick="window.open('http://www.21-cmjob.com/');" class="New_links">中国工程机械人才网</span>
      <span onclick="window.open('http://www.21-rent.com/');" class="New_links">中国工程机械租赁网</span>
      <span onclick="window.open('http://www.21-used.com/');" class="New_links">中国工程机械二手网</span>
      <span onclick="window.open('http://www.21part.com/');" class="New_links">配件商城</span>
      <span onclick="window.open('http://www.21peitao.com/');" class="New_links">配套网</span>
      <span onclick="window.open('http://www.cmbol.com/');" class="New_links">工程机械外贸网</span>
      <span onclick="window.open('http://product.21-sun.com/');" class="New_links">铁臂商城</span>
    </div>
  </div>
  <div class="New_foot">
    <span onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');" class="New_links">广告服务</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/contact/');" class="New_links">联系方式</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/');" class="New_links">关于我们</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/news/');" class="New_links">本网动态</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/contact/legal.jsp');" class="New_links">法律声明</span><em>|</em>
    <span onclick="window.open('http://aboutus.21-sun.com/map.htm');" class="New_links">网站导航</span><em>|</em>
    <span onclick="window.open('http://www.21-sun.com/contact/');" class="New_links">联系客服</span><br/>
    产品询价专线：4006-521-526<br/>
    <span onclick="window.open('http://www.21-sun.com');" class="New_links">中国工程机械商贸网</span>
    Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>2014
  </div>
  <!-- Baidu Button BEGIN -->
    <div style="width:300px; margin:0px auto;">
    <div style="padding-left:50px;" class="bdsharebuttonbox bdshare-button-style0-16" data-bd-bind="1409046586027">
    <a data-cmd="more" class="bds_more" href="#"></a><a title="分享到QQ空间" data-cmd="qzone" class="bds_qzone" href="#"></a><a title="分享到新浪微博" data-cmd="tsina" class="bds_tsina" href="#"></a><a title="分享到腾讯微博" data-cmd="tqq" class="bds_tqq" href="#"></a><a title="分享到人人网" data-cmd="renren" class="bds_renren" href="#"></a><a title="分享到微信" data-cmd="weixin" class="bds_weixin" href="#"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
    </div>
    <!-- Baidu Button END -->
</div>

 <script type="text/javascript">

function addShop(){　
    try{
       window.external.addFavorite('http://product.21-sun.com/agentstore/henanzhongyuan/', '中远机械投资集团');
   }catch (e){
       try{
           window.sidebar.addPanel('中远机械官方旗舰店','http://product.21-sun.com/agentstore/henanzhongyuan/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript">
/*function addUrl(){
	var url = window.location.href;
    try{
       window.external.addFavorite(url, '铁臂商城');
   }catch (e){
       try{
           window.sidebar.addPanel('铁臂商城',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}

$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});*/
</script>
</div>
</body>
</html>