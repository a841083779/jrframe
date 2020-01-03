<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>铁臂口碑活动——分享真实用机感受柳工专区 - 铁臂口碑</title>
<meta name="keywords" content="工程机械口碑" />
<meta name="description" content="铁臂口碑第二季活动——分享您的真实用机感受，就有机会获得大奖。买工程机械产品，就上铁臂商城。" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="apple-mobile-web-app-title" content="Web Starter Kit">
<link rel="apple-touch-icon" href="/web/img/apple-touch-icon.png" />
<link rel="apple-touch-startup-image" href="/web/img/screen.png" />
<meta name="format-detection" content="telephone=no">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com/mobile/koubei/huodong/web/css/style.css" rel="stylesheet" />
<!--[if lt IE 9]><script src="../web/lib/H5shiv.js"></script><![endif]-->
</head>
<body class="body_bottom">
<jsp:include page="top_lg.jsp" flush="true"></jsp:include>
<div class="kba_nav">
	<ul class="fix">
    	<li><a href="index_lg.jsp">活动首页</a></li>
        <li  ><a href="guize_lg.jsp">活动规则</a></li>
        <li class="cur"><a href="jiangpin_lg.jsp">活动奖品</a></li>
			<li><a href="index_lg.jsp#optbg_1">发布口碑</a></li>
    </ul>
</div>
<div class="kba_fbwz">活动奖品</div>
<div class="kba_content">
	<p>柳工挖掘机、装载机模型共3台（中奖会员可自选）</p>
	<ul class="fix kba_price_list">
    	<li>
            <img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/temp/pl_01.jpg" alt=""/>
            <div class="price_title">柳工挖掘机模型</div>
        </li>
        <li>
            <img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/temp/pl_02.jpg" alt=""/>
            <div class="price_title">柳工装载机模型</div>
        </li>
    </ul>
</div>

<div class="kba_fbwz mt10"  >获奖名单</div>
<div class="kba_content"  >
	<ul class="fix kba_hjmd">
    	<li class="fix first">
        	<span class="t1">用户名</span>
            <span class="t2">得分</span>
            <span class="t3">名次</span>
            <span class="t4">奖项</span>
        </li>
        <li class="fix">
        	<span class="t1">ruli125</span>
            <span class="t2">211分</span>
            <span class="t3">第1名 </span>
            <span class="t4">一等奖</span>
        </li>
        <li class="fix">
        	<span class="t1">18812365777</span>
            <span class="t2">70分</span>
            <span class="t3">第2名 </span>
            <span class="t4">一等奖</span>
        </li>
        <li class="fix">
        	<span class="t1">IKARUSSIA</span>
            <span class="t2">70分</span>
            <span class="t3">第3名 </span>
            <span class="t4">一等奖</span>
        </li>
      <!--  <li class="fix">
        	<span class="t1">xuan7516</span>
            <span class="t2">55分</span>
            <span class="t3">第4名 </span>
            <span class="t4">二等奖 </span>
        </li>
		<li class="fix">
        	<span class="t1">chenjindong</span>
            <span class="t2">50分</span>
            <span class="t3">第5名 </span>
            <span class="t4">三等奖</span>
        </li>
		<li class="fix">
        	<span class="t1">liu1411</span>
            <span class="t2">43分</span>
            <span class="t3">第6名 </span>
            <span class="t4">三等奖 </span>
        </li>
		<li class="fix">
        	<span class="t1">123456</span>
            <span class="t2">40分</span>
            <span class="t3">第7名 </span>
            <span class="t4">三等奖 </span>
        </li>
		<li class="fix">
        	<span class="t1">luo0816</span>
            <span class="t2">33分</span>
            <span class="t3">第8名 </span>
            <span class="t4">三等奖 </span>
        </li>
		<li class="fix">
        	<span class="t1">xin622</span>
            <span class="t2">33分</span>
            <span class="t3">第9名 </span>
            <span class="t4">三等奖 </span>
        </li>-->
    </ul>
</div>
<!--foot-->
<jsp:include page="foot_lg.jsp" flush="true"></jsp:include>
<!--foot end-->
</body>
<script src="http://product.21-sun.com/mobile/koubei/huodong/modules/seajs/sea.js" id="seanode" ></script>
<script src="http://product.21-sun.com/mobile/koubei/huodong/web/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('/mobile/koubei/huodong/web/app/jiangpin.js')
</script>
</html>