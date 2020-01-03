<%@ page language="java"  pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.*"%>
<%@page import="com.jerehnet.mobile.action.*" %>
<%
int orderId=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("id")));
String source=CommonString.getFormatPara(request.getParameter("source"));
int ywId=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("ywId")));
String orderState=CommonString.getFormatPara(CommonString.getFormatPara(request.getParameter("orderState")));
String province=CommonString.getFormatPara(CommonString.getFormatPara(request.getParameter("province")));

if(source==null||"".equals(source)){
	source="javascript:void(0);";
}
//else{
//	source += "?id="+ywId;
//	if(orderState!=null&&!"".equals(orderState)){
//		source += "&orderState="+orderState;
//	}
//	if(province!=null&&!"".equals(province)){
//		source += "&province="+province;
//	}
	
//}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>订单详情-销售</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="../css/mui.min.css"/>
		<link rel="stylesheet" type="text/css" href="../css/style.css"/>
	</head>
	<body class="order_detail order_detail_xs">
		<div class="header pr">
			<a href="<%=source%>"><i class="ion pa">&#xe61c;</i></a>
			<p class="title">订单详情</p>
			<input name="submit" type="submit" class="subBtn" value="保存" />
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
					<div class="info_content r"><a class="choose_btn"><span>选择状态</span><i class="ion">&#xe729;</i></a></div>
				</div>
				<div class="status fix hide" id="lossReason">
					<div class="info_title l">流失原因</div>
					<div class="info_content r"><a class="loss_btn"><span>选择原因</span><i class="ion">&#xe729;</i></a></div>
				</div>
				<div class="remark fix hide" id="lossBrand">
					<div class="info_title l">成交品牌</div>
					<div class="info_content r"><input type="text" id="brand" name="brand" placeholder="输入成交品牌"/></div>
				</div>
				<div class="remark fix">
					<div class="info_title l">备注信息</div>
					<div class="info_content r">
						<input type="text" id="appRemark" name="appRemark" placeholder="可编辑"/>
					</div>
				</div>
				<div class="track_status">
					<div class="tracking">跟踪状态</div>
					<div class="tr_status" id="orderStatename"></div>
				</div>
				<div class="status_img pr">
					<div class="line pa"></div>
					
				</div>
			</div>
		</div>
		
		<div class="mask hide"></div>
		<!--订单状态选择-->
		<div class="status_choose hide">
			<div class="cho_header pr">
				<p class="cho_title">选择状态</p>
				<i class="ion pa close_btn">&#xe68f;</i>
			</div>
			<div class="cho_items">
				<div class="item">
					<input type="radio" name="status" data-value='102002' checked="checked" /><label>已接收</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102003'/><label>初次见面</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102010'/><label>沟通中</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102004'/><label>确认意向</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102005'/><label>明确购机需求</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102006'/><label>形成共识，交付押金</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102007'/><label>签订购机合同</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102008'/><label>成交</label>
				</div>
				<div class="item">
					<input type="radio" name="status" data-value='102009'/><label>流失</label>
				</div>
				
			</div>
			<a href="javascript:void(0);" class="dib cho_confirm">确&nbsp;&nbsp;定</a>
		</div>
		
		<div class="mask loss_mask hide"></div>
		<!--流失原因选择-->
		<div class="loss_choose hide">
			<div class="cho_header pr">
				<p class="cho_title">选择原因</p>
				<i class="ion pa close_btn loss_close_btn">&#xe68f;</i>
			</div>
			<div class="loss_items">
				<div class="item">
					<input type="radio" name="reason" data-value='103001' checked="checked"/><label>成交竞品</label>
				</div>
				<div class="item">
					<input type="radio" name="reason" data-value='103002'/><label>意向识别不准确</label>
				</div>
				<div class="item">
					<input type="radio" name="reason" data-value='103003'/><label>无效电话</label>
				</div>
				<div class="item">
					<input type="radio" name="reason" data-value='103004'/><label>不需要</label>
				</div>
			</div>
			<a href="javascript:void(0);" class="dib loss_confirm">确&nbsp;&nbsp;定</a>
		</div>
		<input id="orderId" name="orderId" type="hidden" value="<%=orderId%>" />
		<input id="orderState" name="orderState" type="hidden" value=""/>
		<input id="lostReason" name="lostReason" type="hidden" value=""/>
	</body>
	<!--通用js-->
	<script src="../js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/module/mui/mui.min.js" type="text/javascript" charset="utf-8"></script>
	<!--页面单独js-->
	<script src="js/order_detail_edit.js" type="text/javascript" charset="utf-8"></script>
</html>
