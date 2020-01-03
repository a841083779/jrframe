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
<title>铁臂口碑活动——分享真实用机感受 - 铁臂口碑</title>
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
<jsp:include page="top.jsp" flush="true"></jsp:include>
<div class="kba_nav">
	<ul class="fix">
    	<li><a href="index_activity.jsp">首页</a></li>
        <li  class="cur"><a href="guize.jsp">活动规则</a></li>
        <li><a href="jiangpin.jsp">活动奖品</a></li>
        <li><a href="index_st.jsp">山推专区</a></li>
    </ul>
</div>
<div class="kba_fbwz">活动规则</div>
<div class="kba_content">
1. 用户需发布真实、客观的用机评价或使用报告，内容丰富；<br/>
2.发表评论或使用报告需为真实原创、发表者拥有版权的作品（图片不得带水印）；<br/>
3. 本活动所有作品版权归本站所有，即每位参与者视为同意本站拥有其永久免费使用权。其他媒体未经授权谢绝转载，本站保留追究法律责任的权利。 <br/>
4.用户可重复对某款机型发表不同评论，每人每期限获奖一次，品牌专区除外。<br/>
<span class="red">【特别注意】抄袭他人口碑，抄袭其他网站内容，造成侵权，一经发现，取消评奖资格。 </span>
</div>
<div class="kba_fbwz mt10">口碑热门机型</div>
<div class="kba_content">
最终成绩=产品评论总数+精品评论数*10（例如评论产品总条数100条，其中有20条精品评论，最终成绩=100+20*10=300 )<br/>
成功邀请5位好友注册并发表符合要求的评论，即可获得10分奖励+精美小礼品一份<br/>
【友情提示】邀请好友之后，需将好友姓名，联系方式私信发送至如下通道：<br/>
1)中国工程机械商贸网微博<br/>
2)微信（www21sun）<br/>
3)活动官方公告群群主<br/>
由中国工程机械商贸网工作人员电话核实后发放奖品。
</div>
<!--foot-->
<jsp:include page="foot.jsp" flush="true"></jsp:include>
<!--foot end-->
</body>
<script src="http://product.21-sun.com/mobile/koubei/huodong/modules/seajs/sea.js" id="seanode" ></script>
<script src="http://product.21-sun.com/mobile/koubei/huodong/web/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('/mobile/koubei/huodong/web/app/guize.js')
</script>
</html>