<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	int productId=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("productId")));
	String productName=CommonString.getFormatPara(request.getParameter("productName"));
	String productImg=CommonString.getFormatPara(request.getParameter("productImg"));
	String headUrl=CommonString.getFormatPara(request.getParameter("headUrl"));
	//headUrl="http://product.21-sun.com/uploadfiles//image/2016/05/20160512092018_729.jpg";
	String nickName=CommonString.getFormatPara(request.getParameter("nickName"));
	//nickName="小白菜";
	String openId=CommonString.getFormatPara(request.getParameter("openId"));
	//openId="babababababababababa";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>三一活动-定金支付</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<style>
		*{margin:0;padding:0;font-size:16px;}
		body,html{height:100%;overflow:hidden;}
		.page {
			position:absolute;
			width: 100%;
			height: 100%;
			background-image:url(/m/images/downPage/background.jpg);
			background-color: #fff;
			background-position: top center;
			background-size: cover;
		}
		.btns{ position:relative; top: 360px; }
		.btns img{display:block;width:80%;margin:.5em auto;}

		</style>
	</head>
	<body class="pay">
		
		<div class="pay_header pr">
			<a href="javascript:window.history.back();" class="pa">
				<img src="images/back_01.jpg"/>
			</a>
			<p>订单支付</p>
		</div>
		
		<div class="pay_info fix">
			<div class="img l">
				<img src="<%=productImg%>"/>
			</div>
			<div class="info_main l">
				<p>三一<%=productName%>微型液压挖掘机</p>
				<p>定金 ¥1800</p>
			</div>
		</div>
		<div class="juchi">
			<img src="images/juchi_02.png"/>
		</div>
		

		
		<div class="pay_ways">
		<div class="way fix">
				<div class="way_box l">
					<img src="images/vx.png"/>
				</div>
				<div class="way_name l">微信支付</div>
				<div class="way_input r">
					<input type="radio" name="source" value="vx" id="vx" checked="checked" />
					<label for="vx" class="check"></label>
				</div>
			</div>
			<div class="way fix">
				<div class="way_box l">
					<img src="images/zfb.png"/>
				</div>
				<div class="way_name l">支付宝支付</div>
				<div class="way_input r">
					<input type="radio" name="source" value="zfb" id="zfb" />
					<label for="zfb"></label>
				</div>
			</div>
			
		</div>
		<input name="openId" id="openId" type="hidden" value="<%=openId%>"/>
		<input name="price" id="price" type="hidden" value="1800.0"/>
		<input name="productId" id="productId" type="hidden" value="<%=productId%>"/>
		<input name="productName" id="productName" type="hidden" value="<%=productName%>"/>
		<a href="javascript:void(0);" class="confirm">确认支付</a>
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/paySec.js" type="text/javascript" charset="utf-8"></script>
</html>
