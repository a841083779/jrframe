<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String province = "";
	String city = "";
	String ip  = Common.getIp(request);
	//ip="119.180.60.125";
	String objStr = Tools.getMyProvinceAndCity(ip);
		JSONObject obj = new JSONObject(objStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>配件-优买团</title>
<meta name="keywords" content="装载机,挖掘机优惠促销，工程机械优惠活动" />
<meta name="description" content="装载机,挖掘机，工程机械促销,买工程机械就来铁臂商城4006-521-526" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>

<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<div class="top">
  <div class="wrap">
	<div class="logo"><a href="#"><img src='images/logo.gif'/></a></div>
    <div class="img mr30"> <a href="#"><img src='images/ymt.gif'/></a></div>
    <div class="city">
    	<span><%=city%></span>
    </div>
    <div class="search">
    	<input name="keyword" id="keyword" type="text" class="txt" onKeyDown="tj2();"/>
        <input type="button" class="btn" onclick="tj3();"/>
    </div>
	<script>
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
    <div class="tel">
    	<img src='images/tel.gif'/>
    </div>
  </div>
</div>
<div class="nav">
	<ul class="wrap">
    	<li class="quick">快速导航</li>
		<li><a href="index.jsp">首页</a></li>
        <li><a href="index.jsp?catalog=101001">挖掘机</a></li>
        <li><a href="index.jsp?catalog=101002">装载机</a></li>
        <li><a href="part.jsp">配件</a></li>
        <li><a href="index.jsp?catalog=113001">破碎锤</a></li>
        <li><a href="index.jsp?catalog=other">其他设备</a></li>
        <li><a href="http://koubei.21-sun.com">铁臂口碑</a></li>
        <li><a href="activity.jsp">专题活动</a></li>
    </ul>
</div>
<div class="homeCon wrap">
	<div class="h_left">
    	<ul class="subNav">
        	<li class="l1"><a href="wjj.htm"><i class="ico ic0"></i>挖掘机<em>Excavator</em></a>
            	<dl class="menu">
                	<dt>品牌：</dt>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                    <dd><a href="#">湖南嘉龙</a></dd>
                    <dd><a href="#">贵州通程兄弟</a></dd>
                    <dd><a href="#">约翰迪尔</a></dd>
                    <dd><a href="#">福田雷沃</a></dd>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                </dl>
            </li>
            <li class="l2"><a href="zzj.htm"><i class="ico ic2"></i>装载机<em>Loaders</em></a>
            	<dl class="menu">
                	<dt>品牌：</dt>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                    <dd><a href="#">湖南嘉龙</a></dd>
                    <dd><a href="#">贵州通程兄弟</a></dd>
                    <dd><a href="#">约翰迪尔</a></dd>
                    <dd><a href="#">福田雷沃</a></dd>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                </dl>
            
            </li>
            <li class="l3"><a href="ylj.htm"><i class="ico ic3"></i>压路机<em>Roller</em></a>
            <dl class="menu">
                	<dt>品牌：</dt>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                    <dd><a href="#">湖南嘉龙</a></dd>
                    <dd><a href="#">贵州通程兄弟</a></dd>
                    <dd><a href="#">约翰迪尔</a></dd>
                    <dd><a href="#">福田雷沃</a></dd>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                </dl>
            </li>
            <li class="l4"><a href="#"><i class="ico ic4"></i>混凝土<em>Concrete</em></a>
            <dl class="menu">
                	<dt>品牌：</dt>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                    <dd><a href="#">湖南嘉龙</a></dd>
                    <dd><a href="#">贵州通程兄弟</a></dd>
                    <dd><a href="#">约翰迪尔</a></dd>
                    <dd><a href="#">福田雷沃</a></dd>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                </dl>
            
            </li>
            <li class="l5"><a href="part.htm"><i class="ico ic5"></i>配件<em>Parts</em></a>
            	<dl class="menu">
                	<dt>品牌：</dt>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                    <dd><a href="#">湖南嘉龙</a></dd>
                    <dd><a href="#">贵州通程兄弟</a></dd>
                    <dd><a href="#">约翰迪尔</a></dd>
                    <dd><a href="#">福田雷沃</a></dd>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                </dl>
            </li>
            <li class="l6"><a href="psc.htm"><i class="ico ic6"></i>破碎锤<em>Breaker</em></a>
            <dl class="menu">
                	<dt>品牌：</dt>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                    <dd><a href="#">湖南嘉龙</a></dd>
                    <dd><a href="#">贵州通程兄弟</a></dd>
                    <dd><a href="#">约翰迪尔</a></dd>
                    <dd><a href="#">福田雷沃</a></dd>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                </dl>
            </li>
            <li class="l7"><a href="other.htm"><i class="ico ic7"></i>其他设备<em>Other</em></a>
            <dl class="menu">
                	<dt>品牌：</dt>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                    <dd><a href="#">湖南嘉龙</a></dd>
                    <dd><a href="#">贵州通程兄弟</a></dd>
                    <dd><a href="#">约翰迪尔</a></dd>
                    <dd><a href="#">福田雷沃</a></dd>
                    <dd><a href="#">特彼勒(青州)</a></dd>
                </dl>
            </li>
            <li class="l8"><a href="http://m.product.21-sun.com/"><i class="ico ic8"></i>手机app</a></li>
        </ul>
        <dl class="h_left_mid">
        	<dt>我们的服务</dt>
            <dd><em>服务顾问：</em><br />解答用户购买设备的疑惑</dd>
             <dd><em>优惠专家：</em><br />为用户争取最优惠的购机价格</dd>
              <dd><em>6S认证：</em><br />为您提供正规代理商渠道，放心
购机。</dd>
        </dl>
        <div class="img"><img src='images/tel2.gif'/></div>
    </div>
 	<div class="h_right">
        <div class="opt mt10">
        	<a href="#" class="active">默认</a>
            <a href="#">销量</a>
            <a href="#">价格</a>
            <a href="#">最新</a>
         <span><i class="ico ic1"></i>我们能为客户提供什么？</span>   
        </div>
        <div class="order">
        	<div class="l"><span>按品牌：</span>
            <div class="label">
            <a href="#" class="cur">不限</a>
            <a href="#">三一</a>
            <a href="#">卡特彼勒</a>
            <a href="#">卡特彼勒青州</a>
            <a href="#">小松</a>
            <a href="#">斗山</a>
            <a href="#">山推股份</a>
            <a href="#">龙工</a>
            <a href="#">山东临工</a>
            <a href="#">福田雷沃</a>
            <a href="#">徐工</a>
            </div>
            </div>
            <div class="l"><span>按类型：</span>
             <div class="label">
            <a href="#" class="cur">不限</a>
            <a href="#">大挖</a>
            <a href="#">中挖</a>
            <a href="#">小挖</a>
            </div>
            </div>
        </div>
        <ul class="hlist">
        	<li >
            	<a href="http://www.catparts.com.cn/cel/part/1090_for_detail.htm"><img src='images/img/p1.jpg'/></a>
                <h3>卡特312D-GC-RXZ服务包-250小时</h3>
                <div class="price">
                 <span class="t">拨打热线电话询最低价</span>
                <a href="http://www.catparts.com.cn/cel/part/1090_for_detail.htm" class="btn"></a>
                </div>
            </li>
            <li>
            	<a href="http://www.21part.com/viphouse/YTTS_27162_products.shtm"><img src='images/img/p2.jpg'/></a>
                <h3>泰盛螺纹锁固剂系列产品</h3>
                <div class="price">
                 <span class="t">拨打热线电话询最低价</span>
                <a href="http://www.21part.com/viphouse/YTTS_27162_products.shtm" class="btn"></a>
                </div>
            </li>
             <li>
            	<a href="http://www.21part.com/viphouse/lzwy_29086_products.shtm"><img src='images/img/p3.jpg'/></a>
                <h3>威源机械油缸</h3>
                <div class="price">
                 <span class="t">拨打热线电话询最低价</span>
                <a href="http://www.21part.com/viphouse/lzwy_29086_products.shtm" class="btn"></a>
                </div>
            </li>
             <li>
            	<a href="http://www.21part.com/shop/27521_detail_detail.shtm"><img src='images/img/p4.jpg'/></a>
                <h3>济宁山推新动力康明斯QSB发动机</h3>
                <div class="price">
                 <span class="t">拨打热线电话询最低价</span>
                <a href="http://www.21part.com/shop/27521_detail_detail.shtm" class="btn"></a>
                </div>
            </li>
             <li>
            	<a href="http://www.3dgzpart.com/viphouse/gzsjzljxsbyxgs_19473_products.shtm"><img src='images/img/p5.jpg'/></a>
                <h3>广州骏之隆EX200-3液压电脑板</h3>
                <div class="price">
                 <span class="t">拨打热线电话询最低价</span>
                <a href="http://www.3dgzpart.com/viphouse/gzsjzljxsbyxgs_19473_products.shtm" class="btn"></a>
                </div>
            </li>
            
        
        </ul>
    </div>
</div>
<div class="brand">
	<div class="wrap">
    	<div class="img"><img src='images/br.gif'/></div>
        <a href="#"><img src='images/br1.jpg'/></a>
        <a href="#"><img src='images/br2.jpg'/></a>
        <a href="#"><img src='images/br3.jpg'/></a>
        <a href="#"><img src='images/br4.jpg'/></a>
        <a href="#"><img src='images/br5.jpg'/></a>
         <a href="#"><img src='images/br6.jpg'/></a>
        <a href="#"><img src='images/br7.jpg'/></a>
        <a href="#"><img src='images/br8.jpg'/></a>
        <a href="#"><img src='images/br9.jpg'/></a>
        <a href="#"><img src='images/br10.jpg'/></a>
        <a href="#"><img src='images/br11.jpg'/></a>
        <a href="#"><img src='images/br12.jpg'/></a>
        <a href="#"><img src='images/br13.jpg'/></a>
        <a href="#"><img src='images/br14.jpg'/></a>
        <a href="#"><img src='images/br15.jpg'/></a>
        <a href="#"><img src='images/br16.jpg'/></a>
        <a href="#"><img src='images/br17.jpg'/></a>
        <a href="#"><img src='images/br18.jpg'/></a>
    </div>
</div>
<div class="bottom">
	<div class="wrap">
	<span class="l">中国工程机械商贸网 Copyright © 2000-2014 </span>	
    <div class="r">客服：9:00-21:00<em>|</em>4006-521-526</div>
    </div>
 </div>
 <script type="text/javascript" src="scripts/comm.js"></script>
 
</body>
</html>