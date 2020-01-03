<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.mobile.action.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>注册</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="css/mui.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
	</head>
	<body class="register register_cp">
		
		<div class="header pr">
			<a href="javascript:void(0);" class="back"><i class="ion pa">&#xe61c;</i></a>
			<p class="title">注册</p>
		</div>
		
		<div class="content pa">
			<div class="re_mask pa"></div>
			<div class="re_main pa">
				<img src="images/register_front.jpg" class="front_img"/>
				
				<div class="reg_box">
					
					<a href="login.jsp?flag=factory" class="dib cj_binding">厂家账号绑定</a>
					<a href="login.jsp?flag=agent" class="dib dls_binding">代理商账号绑定</a>
					<a href="login.jsp?flag=personnel" class="dib ywy_binding">业务员账号绑定</a>
					
				</div>
				
			</div>
		</div>
		
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/register_cp.js" type="text/javascript" charset="utf-8"></script>
</html>
