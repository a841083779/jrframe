<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<%
	int uid=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("id")));
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>我的订单-未完成</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="../css/mui.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/style.css" />
	</head>

	<body class="order_unfinished">
		<div class="header pr">
			<a href="javascript:void(0);" class="back"><i class="ion pa">&#xe61c;</i></a>
			<p class="title">我的订单</p>
		</div>
		<div class="nav fix">
			<div class="order_sep l act">
			    <a href="order_unfinished.jsp?id=<%=uid%>" class="dib">
					<p class="num" id="unfinished_num">0 </p>
					<p class="kind">未处理</p>
				</a></div>
			<div class="order_sep l">
				<a href="order_tracking.jsp?id=<%=uid%>" class="dib">
					<p class="num" id="track_num">0</p>
					<p class="kind">跟踪中</p>
				</a></div>
			<div class="order_sep l">
				<a href="order_deal.jsp?id=<%=uid%>" class="dib">
					<p class="num" id="deal_num">0</p>
					<p class="kind">成交</p>
				</a></div>
			<div class="order_sep l">
				<a href="order_loss.jsp?id=<%=uid%>" class="dib">
					<p class="num" id="loss_num">0</p>
					<p class="kind">流失</p>
				</a></div>
			<div class="order_sep l">
				<a href="order_mark.jsp?id=<%=uid%>" class="dib">
					<p class="num" id="mark_num">0</p>
					<p class="kind">星标客户</p>
				</a></div>
		</div>

		<div class="main" id="main">
			<ul id="list"></ul>
		</div>
		<div class="footer fix">
			<!--<div class="l">
				<a href="javascript:void(0);" class="dib">订单管理</a>
			</div>
			<div class="l">
				<a href="javascript:void(0);" class="dib">订单统计</a>
			</div>
			<div class="l">
				<a href="javascript:void(0);" class="dib">下属管理</a>
			</div>-->
		</div>

		<div class="recieve pa hide">
			<p class="msg"></p>
			<a href="javasript:void(0);" class="dib know_success">知道啦</a>
		</div>

		<div class="mask hide"></div>
		
		<input name="uid" id="uid" type="hidden" value="<%=uid%>"/>

	</body>
	<!--通用js-->
	<script src="../js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/module/mui/mui.min.js" type="text/javascript" charset="utf-8"></script>
	<!--页面单独js-->
	<script src="js/order_unfinished.js" type="text/javascript" charset="utf-8"></script>

</html>