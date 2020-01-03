<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<%
	int uid=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("id")));
	String orderState=CommonString.getFormatPara(CommonString.getFormatPara(request.getParameter("orderState")));
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>我的订单-跟踪中</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="../css/mui.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/style.css" />
	</head>

	<body class="order_tracking">
		<div class="header pr">
			<a href="javascript:void(0);" class="back"><i class="ion pa">&#xe61c;</i></a>
			<p class="title">我的订单</p>
		</div>
		<div class="nav fix">
			<div class="order_sep l">
			    <a href="order_unfinished.jsp?id=<%=uid%>" class="dib">
					<p class="num" id="unfinished_num">0 </p>
					<p class="kind">未处理</p>
				</a></div>
			<div class="order_sep l act">
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
		<div class="track_status fix">
			<p class="ts_title l">跟踪状态</p>
			<a class="dib r ts_pro" href="javascript:void(0);"><span>选择状态</span><i class="ion">&#xe729;</i></a>
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
		
		<div class="mask hide"></div>
		
		<div class="status_choose hide">
			<div class="cho_header pr">
				<p class="cho_title">选择状态</p>
				<i class="ion pa close_btn">&#xe68f;</i>
			</div>
			<div id="status_items" class="cho_items">
				<div class="item">
					<input type="radio" name="status" data-value='' <%if("".equals(orderState)){ out.print("checked"); }%>/><label>全部</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102002' <%if("102002".equals(orderState)){ out.print("checked"); }%>/><label>已接收</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102003' <%if("102003".equals(orderState)){ out.print("checked"); }%>/><label>初次见面</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102010' <%if("102010".equals(orderState)){ out.print("checked"); }%>/><label>沟通中</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102004' <%if("102004".equals(orderState)){ out.print("checked"); }%>/><label>确认意向</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102005' <%if("102005".equals(orderState)){ out.print("checked"); }%>/><label>明确购机需求</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102006' <%if("102006".equals(orderState)){ out.print("checked"); }%>/><label>形成共识，交付押金</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102007' <%if("102007".equals(orderState)){ out.print("checked"); }%>/><label>签订购机合同</label>
				</div>
				
			</div>
			<a href="javascript:void(0);" class="dib cho_confirm">确&nbsp;&nbsp;定</a>
		</div>
		
		<input name="uid" id="uid" type="hidden" value="<%=uid%>"/>
		<input name="orderState" id="orderState" type="hidden" value="<%=orderState%>"/>
	</body>
	<!--通用js-->
	<script src="../js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/module/mui/mui.min.js" type="text/javascript" charset="utf-8"></script>
	<!--页面单独js-->
	<script src="js/order_tracking.js" type="text/javascript" charset="utf-8"></script>

</html>