<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>支付成功</title>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
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
				<img src="images/success.png"/>
			</div>
			<div class="info_main l">
				<p>支付成功！</p>
				<p>请返回微信刷新页面查看！</p>
			</div>
		</div>
		<div class="juchi">
			<img src="images/juchi_02.png"/>
		</div>
		

	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/pay.js" type="text/javascript" charset="utf-8"></script>
</html>
