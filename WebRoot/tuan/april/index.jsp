﻿<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
	String ip  = Common.getIp(request);
	String jsonStr = Tools.getMyProvinceAndCity(ip);
	String city = "";
	String province = "";
	if(!CommonString.getFormatPara(jsonStr).equals("")){
		JSONObject obj = new JSONObject(jsonStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>4月工程机械订单季-21-sun优买团</title>
<meta name="keywords" content="21-sun优买团,4月工程机械订单,山工平地机,临沂亚华三一挖机,湖南中旺,浙江永弘斗山挖机,超值优惠政策" />
<meta name="description" content="21-sun优买团,4月工程机械订单季,在优买团下订单皆可享受超值优惠政策,山工平地机免费试驾,临沂亚华三一挖机4月19日 订货会期间，订机客户，均可享受三重优惠大礼,湖南中旺赠送破碎锤,斗山浙江代理商" />
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<link href="style/tuan.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/scripts.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.SuperSlide.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<!--[if (IE 6)]>
<link href="http://product.21-sun.com/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<div class="topLinks">
  <div class="contain980">
    <div class="visit_21sun"><a title="中国工程机械商贸网产品中心首页" href="http://product.21-sun.com/	" target="_blank" rel="nofollow"><img align="absmiddle" src="http://product.21-sun.com/images/n_toppoint.gif" /> 中国工程机械商贸网产品中心首页</a></div>
    <ul class="loginLinks_new">
      <li onclick="window.open('/agent/login.jsp');">厂家登录</li>
      <li onclick="window.open('/agent/login.jsp');">代理商登录</li>
    </ul>
    <ul class="tlRight">
      <li onclick="addCookie();" class="tl">加入收藏</li>
      <li onclick="window.open('http://market.21-sun.com/');" class="tl">供求市场</li>
      <!--  <li class="tl" onclick="window.open('http://news.21-sun.com/');">资讯中心</li> -->
      <li onclick="window.open('http://news.21-sun.com/');" class="tl">行业动态</li>
      <li class="guide"><span class="gt">网站导航</span>
        <ul>
          <li onclick="window.open('http://market.21-sun.com/');">供求市场</li>
          <li onclick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
          <li onclick="window.open('http://data.21-sun.com/');">数据分析</li>
          <li onclick="window.open('http://www.21-sun.com/bidding/');">招 投 标</li>
          <li onclick="window.open('http://www.21-cmjob.com/');">招聘求职</li>
          <!--  <li onclick="window.open('http://news.21-sun.com/');">资讯中心</li>  -->
          <li onclick="window.open('http://news.21-sun.com/');">行业动态</li> 
          <li onclick="window.open('http://product.21-sun.com/');">整机市场</li>
          <li onclick="window.open('http://stock.21-sun.com/');">行业股市</li>
          <li onclick="window.open('http://www.21-sun.com/part/');">配件市场</li>
          <li onclick="window.open('http://www.21-rent.com/');">租赁调剂</li>
          <li onclick="window.open('http://www.21part.com/');">杰 配 网</li>
          <li onclick="window.open('http://www.21peitao.com/');">配 套 网</li>
        </ul>
      </li>
      <li style="width:63px; background:none; padding:4px 0px 0px 5px; height:24px" class="tl"><iframe width="63" scrolling="no" height="24" frameborder="0" src="http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&amp;width=63&amp;height=24&amp;uid=1904756027&amp;style=1&amp;btn=red&amp;dpc=1" border="0" marginheight="0" marginwidth="0"></iframe></li>
    </ul>
  </div>
</div>
<div class="banner">
  <div class="contain980"><img src="images/big_banner.jpg" alt="4月，工程机械订单季" width="980" height="428" border="0" usemap="#Map" />
    <map name="Map" id="Map">
      <area shape="rect" coords="767,431,843,492" href="#" />
    </map>
    <a href="javascript:void(0);" onclick="may();" class="yugao"></a>
    <p class="time">
      预热期：4月15日-18日<br />
    活动期：4月18日-30日
  </p>
  </div>
</div>
<div class="tuan-con">
  <div class="contain980 clearfix pb20">
    <div class="zc">
      <strong>在优买团下订单皆可享受超值优惠政策</strong>
      <ul id="guide">
        <li class="odd"><a href="#g1">山工(全国)</a></li>
        <li><a href="#g2">临沂亚华</a></li>
        <li class="odd"><a href="#g3">湖南中旺</a></li>
        <li><a href="#g4">浙江永弘</a></li>
        <li class="odd"><a href="#g5">杭州威格尔</a></li>
      </ul>
    </div>
    <div class="r" style="position:relative; width:427px; height:80px;"><img src="images/yg.gif" alt="4月，工程机械订单季；5月，工程机械“劳动”季" width="427" height="80" border="0" />
      <a href="javascript:void(0);" onclick="may();" class="yugao" style="width:213px; height:80px; left:auto; right:0px; top:0px;"></a>
    </div>
  </div>
  
  <div class="contain980 clearfix">
    <!--scroll begin-->
    <div id="scroll">
      <div class="hd"> 
        <a class="newsImgprev"></a>
        <a class="newsImgnext"></a>
      </div>
      <div class="bd">
        <ul class="scrollList">
          <li>
            <div class="pic"><span class="ico shijia"></span><a href="http://product.21-sun.com/proDetail/SEM919.shtm" target="_blank"><img src="images/tuan_img01.jpg" alt="SEM919或SEM921平地机" /></a></div>
			<div class="con">
              <h3>免费试驾</h3>
              <span><a href="http://product.21-sun.com/proDetail/SEM919.shtm" target="_blank">SEM919或SEM921平地机</a></span>
            </div>
            <a href="http://product.21-sun.com/tuan/semsj/index.jsp#form" target="_blank" class="btn">立即报名</a>
          </li>
          <li>
            <div class="pic"><span class="ico cuxiao"></span><a href="http://product.21-sun.com/proDetail/SY60C-9.shtm" target="_blank"><img src="images/tuan_img01-2.jpg" alt="三一SY60C-9挖掘机" /></a></div>
			<div class="con">
              <h3>&yen;39万</h3>
              <span><a href="http://product.21-sun.com/proDetail/SY60C-9.shtm" target="_blank">三一SY60C-9挖掘机</a></span>
            </div>
            <a href="javascript:void(0);" onclick="showinquery('9692','');" class="btn">立即订购</a>
          </li>
          <li>
            <div class="pic"><span class="ico cuxiao"></span><a href="http://product.21-sun.com/proDetail/SY55C-9.shtm" target="_blank"><img src="images/tuan_img01-3.jpg" alt="三一SY55C-9挖掘机" /></a></div>
			<div class="con">
              <h3>送破碎锤一个</h3>
              <span><a href="http://product.21-sun.com/proDetail/SY55C-9.shtm" target="_blank">三一SY55C-9挖掘机</a></span>
            </div>
            <a href="javascript:void(0);" onclick="showinquery('7210','');" class="btn">立即订购</a>
          </li>
          <li>
            <div class="pic"><span class="ico cuxiao"></span><a href="http://product.21-sun.com/proDetail/DH55GOLD.shtm" target="_blank"><img src="images/tuan_img01-4.jpg" alt="斗山DH55GOLD履带式挖掘机" /></a></div>
			<div class="con">
              <h3>&yen;36万</h3>
              <span><a href="http://product.21-sun.com/proDetail/DH55GOLD.shtm" target="_blank">斗山DH55GOLD履带式挖掘机</a></span>
            </div>
            <a href="javascript:void(0);" onclick="showinquery('389','');" class="btn">立即订购</a>
          </li>
          <li>
            <div class="pic"><span class="ico cuxiao"></span><a href="http://product.21-sun.com/proDetail/XE60.shtm" target="_blank"><img src="images/XE60CA.jpg" alt="徐工XE60CA挖掘机" /></a></div>
			<div class="con">
              <h3>&yen;35万</h3>
              <span><a href="http://product.21-sun.com/proDetail/XE60.shtm" target="_blank">徐工XE60CA挖掘机</a></span>
            </div>
            <a href="javascript:void(0);" onclick="showinquery('497','');" class="btn">立即订购</a>
          </li>
        </ul>
      </div>
    </div>
    <script type="text/javascript">
	jQuery("#scroll").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:4,scroll:1,autoPlay:true});
    </script>
    <!--scroll end-->
    <div class="brandShow" id="brandShow">
      <div class="bs sem">
        <a href="#g1"><h2>山工平地机<br />免费试驾</h2>
        <p>2周的免费试用时间试用后订购平地机，更能获得价值5000元的配件</p></a>
        <a href="#g1" class="detailBtn" title="查看详情">查看详情</a>
      </div>
      <div class="bs sany">
        <a href="#g2"><h2>临沂亚华<br />三一挖机</h2>
        <p>4月19日  订货会期间，订机客户，均可享受三重优惠大礼</p></a>
        <a href="#g2" class="detailBtn" title="查看详情">查看详情</a>
      </div>
      <div class="bs hnzw">
        <a href="#g3"><h2>湖南中旺</h2>
        <p>购SY55机型送破碎锤一个；20-30T（不含<br />
        SY195机型）送一万元配件；30T以</p>
<p>  上机型送38000元面包车一台</p>
        </a>
        <a href="#g3" class="detailBtn" title="查看详情">查看详情</a>
      </div>
      <div class="bs doosan">
        <a href="#g4"><h2>浙江永弘斗山挖机</h2>
        <p>斗山浙江代理商</p></a>
        <a href="#g4" class="detailBtn" title="查看详情">查看详情</a>
      </div>
      <div class="bs wge">
        <a href="#g5"><h2>杭州威格尔</h2>
        <p>不用抽奖，不靠运气，买就送！<br />
        相同配置比价格，相同价格比配置，徐工最优！</p></a>
        <a href="#g5" class="detailBtn" title="查看详情">查看详情</a>
      </div>
    </div>
    
    <div class="tuanParts sem" id="g1">
      <div class="title">
        <h2><img src="images/brand_logo_sem.png" alt="山工机械" width="191" height="69" /></h2>
        <span class="more">更多优惠，请致电：0535-6727793</span>
      </div>
      <div class="content">
        <div class="adimg pb15"><a href="http://product.21-sun.com/tuan/semsj/" target="_blank"><img src="images/adimg_sem01.jpg" alt="好机械用过才知道！山工机械支持您对品质的苛刻，给您长达2周时间免费试用山工平地机，在试用后订购更可获得价值5000元的配件！试用机会全国仅限10名，2013年4月15日—5月15日报名参加，还能赢取精美平地机模型。" width="930" height="114" /></a></div>
        <ul class="list">
          <li><span class="ico shijia"></span><a href="http://product.21-sun.com/proDetail/SEM919.shtm" target="_blank"><img src="images/tuan_img02.jpg" width="220" height="220" /></a>
            <h3><a href="http://product.21-sun.com/proDetail/SEM919.shtm" target="_blank">山工SEM919平地机</a></h3>
            <p>2周时间免费试用，试用后订购可获5000元的配件</p>
            <a href="http://product.21-sun.com/tuan/semsj/index.jsp#form" target="_blank" class="btn">我要报名</a>
          </li>
          <li><span class="ico shijia"></span><a href="http://product.21-sun.com/proDetail/SEM921.shtm" target="_blank"><img src="images/tuan_img03.jpg" width="220" height="220" /></a>
            <h3><a href="http://product.21-sun.com/proDetail/SEM921.shtm" target="_blank">山工SEM921平地机</a></h3>
            <p>2周时间免费试用，试用后订购可获5000元的配件</p>
            <a href="http://product.21-sun.com/tuan/semsj/index.jsp#form" target="_blank" class="btn">我要报名</a>
          </li>
        </ul>
        <div class="r"><a href="http://product.21-sun.com/tuan/semsj/" target="_blank"><img src="images/adimg_sem02.jpg" alt="免费用2周 订购减5000 山工平地机免费试用火热招募中" width="458" height="285" /></a></div>
      </div>
    </div>	
	
	<%
		if("山东".equals(province)){
			%>
			<jsp:include page="/tuan/april/area/lyyh.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/hnzw.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/zjyl.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/hzwge.jsp" flush="true" />
			<%
		}else if("湖南".equals(province)){
			%>
			<jsp:include page="/tuan/april/area/hnzw.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/lyyh.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/zjyl.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/hzwge.jsp" flush="true" />
			<%
		}else if("浙江".equals(province)){
			%>
			<jsp:include page="/tuan/april/area/hzwge.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/zjyl.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/hnzw.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/lyyh.jsp" flush="true" />
			<%
		}else{
			%>
			<jsp:include page="/tuan/april/area/lyyh.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/hnzw.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/zjyl.jsp" flush="true" />
			<jsp:include page="/tuan/april/area/hzwge.jsp" flush="true" />
			<%
		}
	%>
    
	<div class="bottomAds w100 l">
      <div class="l"><a href="javascript:void(0);" onclick="may();"><img src="images/b_ad01.jpg" width="472" height="178" /></a></div>
      <div class="r"><a href="javascript:void(0);" onclick="may();"><img src="images/b_ad02.jpg" width="472" height="178" /></a></div>
    </div>

  </div>
  
</div>
<!--foot-->
<!--#include virtual="/include/foot.jsp"--> 
<!--end of foot--> 
<script type="text/javascript">
function may() {
    $.jBox('id:May',{
		title: "5月 工程机械劳动季",
		width:520,
		height:270
		});
}
</script>
<div id="May" style="display:none;">
    <div style='padding:10px;'><img src="images/may.gif" width="500" height="186" /></div>
</div>
<div style="display:none">
<script src="http://s20.cnzz.com/stat.php?id=5233070&web_id=5233070&show=pic" language="JavaScript"></script>
</div> 

</body>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://product.21-sun.com', "");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}

(function(jQuery){
 jQuery.extend(jQuery.fn,{
 scrollTo:function(time,to){
 time=time||800;
 to=to||1;
            jQuery('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
location.hostname == this.hostname) {
      var jQuerytarget = jQuery(this.hash);
     jQuerytarget = jQuerytarget.length && jQuerytarget || jQuery('[name=' + this.hash.slice(1) + ']');
                    if (jQuerytarget.length) {
                        if (to == 1) {
                            jQuery('html,body').animate({
                                scrollTop: jQuerytarget.offset().top
                            }, time);
                        }
                        else if(to==2){
                            jQuery('html,body').animate({
                                scrollLeft: jQuerytarget.offset().left
                            }, time);
                        }else{
alert('argument error');
  }
                        return false;
                    }
                }
            });
  }
 });
})(jQuery);
jQuery(function(){
  jQuery("#guide,#brandShow").scrollTo(700);
});
</script>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script>
</html>