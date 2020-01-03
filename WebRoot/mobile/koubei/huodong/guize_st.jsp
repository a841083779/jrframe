<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%><!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>铁臂口碑活动——分享真实用机感受山推专区 - 铁臂口碑</title>
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
<jsp:include page="top_st.jsp" flush="true"></jsp:include>
<div class="kba_nav">
	<ul class="fix">
    	<li><a href="index_st.jsp">活动首页</a></li>
        <li  class="cur"><a href="guize_lg.jsp">活动规则</a></li>
        <li><a href="jiangpin_st.jsp">活动奖品</a></li>
		<li><a href="index_st.jsp#optbg_1">发布口碑</a></li>
    </ul>
</div>
<div class="kba_fbwz">活动规则</div>
<div class="kba_content">
山推专区中奖规则：发表山推产品评论数量=山推产品<br/>
评论总数+精品评论数*10（例如评论山推产品总条数10条，
其中有2条精品评论，最终成绩=10+2*10=30 )<br/>
<span class="red">注：参与品牌专区获奖的用户，将不再参与整体活动评奖。</span>
</div>
<!--foot-->
<jsp:include page="foot_st.jsp" flush="true"></jsp:include>
<!--foot end-->
</body>
<script src="http://product.21-sun.com/mobile/koubei/huodong/modules/seajs/sea.js" id="seanode" ></script>
<script src="http://product.21-sun.com/mobile/koubei/huodong/web/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('/mobile/koubei/huodong/web/app/guize.js')
</script>
</html>