<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.*"%>
<%@page import="com.jerehnet.mobile.action.*" %>
<%
int orderId=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("id")));
String source=CommonString.getFormatPara(request.getParameter("source"));
int ywId=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("ywId")));
String orderState=CommonString.getFormatPara(CommonString.getFormatPara(request.getParameter("orderState")));

if(source==null||"".equals(source)){
	source="javascript:void(0);";
}else{
	source += "?id="+ywId;
	if(orderState!=null&&!"".equals(orderState)){
		source += "&orderState="+orderState;
	}
	
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>订单详情</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="../css/mui.min.css"/>
		<link rel="stylesheet" type="text/css" href="../css/style.css"/>
	</head>
	<body class="order_detail">
		<div class="header pr">
			<a href="<%=source%>" class="back"><i class="ion pa">&#xe61c;</i></a>
			<p class="title">订单详情</p>
		</div>
		<div class="main">
			<div class="order_info">
				<div class="time fix">
					<div class="info_title l">下单时间</div>
					<div class="info_content r" id="createDate"></div>
				</div>
				<div class="model fix">
					<div class="info_title l">产品型号</div>
					<div class="info_content r" id="orderTitle"></div>
				</div>
				<div class="name fix">
					<div class="info_title l">订单人</div>
					<div class="info_content r" id="orderUser"></div>
				</div>
				<div class="area fix">
					<div class="info_title l">地点</div>
					<div class="info_content r" id="contactAddress"></div>
				</div>
				<div class="tel fix">
					<div class="info_title l">联系方式</div>
					<a><div class="info_content r" id="contactTel"></div></a>
				</div>
			</div>
			
			<div class="order_status">
				<div class="status fix">
					<div class="info_title l">订单状态</div>
					<div class="info_content r" id="orderStatename"></div>
				</div>
				<div class="status fix hide" id="lossReason">
					<div class="info_title l">流失原因</div>
					<div class="info_content r" id="runOffFlagname"></div>
				</div>
				<div class="remark fix hide" id="lossBrand">
					<div class="info_title l">成交品牌</div>
					<div class="info_content r" id="brand"></div>
				</div>
				<div class="track fix">
					<div class="info_title l">跟踪分公司/代理商</div>
					<div class="info_content r" id="agentName"></div>
				</div>
				<div class="remark fix">
					<div class="info_title l">备注</div>
					<div class="info_content r" id="appRemark"></div>
				</div>
				<div class="status_img pr">
					<a href="javascript:void(0);" class="dib status_title">跟踪状态</a>
					
					<div class="line pa"></div>
					
					

				</div>
			</div>
			
		</div>
		<input id="orderId" name="orderId" type="hidden" value="<%=orderId%>" />
	</body>
	<!--通用js-->
	<script src="../js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/module/mui/mui.min.js" type="text/javascript" charset="utf-8"></script>
	<!--页面单独js-->
	<script src="js/order_detail.js" type="text/javascript" charset="utf-8"></script>
</html>
