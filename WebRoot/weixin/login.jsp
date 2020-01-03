<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.mobile.action.*"%>
<%
String flag=CommonString.getFormatPara(request.getParameter("flag"));
String actionPath="",bindPath="",jumpPath="";
if("factory".equals(flag)){
	actionPath="/tools/mobileInterface.jsp?flag=factory_login";
	bindPath="/tools/mobileInterface.jsp?flag=factory_bind_wxid";
	jumpPath="/weixin/factory/order_unfinished.jsp?id=";
}else if("agent".equals(flag)){
	actionPath="/tools/mobileInterface.jsp?flag=agent_login";
	bindPath="/tools/mobileInterface.jsp?flag=agent_bind_wxid";
	jumpPath="/weixin/agent/order_unfinished.jsp?id=";
}else if("personnel".equals(flag)){
	actionPath="/tools/mobileInterface.jsp?flag=personnel_login";
	bindPath="/tools/mobileInterface.jsp?flag=personnel_bind_wxid";
	jumpPath="/weixin/personnel/order_unfinished.jsp?id=";
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>登录</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link rel="stylesheet" type="text/css" href="css/mui.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
	</head>
	<body class="register register_per">
		
		<div class="header pr">
			<a href="javascript:void(0);" class="back"><i class="ion pa">&#xe61c;</i></a>
			<p class="title">登录</p>
		</div>
		
		<div class="content pa">
			<div class="re_mask pa"></div>
			<div class="re_main pa">
				<img src="images/register_front.jpg" class="front_img"/>
				
				<div class="reg_box">
					
					<div class="row fix">
						<div class="head_box l">
							<i class="ion">&#xe619;</i>
						</div>
						<div class="input_box l">
							<input id="usern" name="usern" type="text" placeholder="这里是用户名"/>
						</div>
					</div>
					
					<div class="row fix">
						<div class="head_box l">
							<i class="ion">&#xe603;</i>
						</div>
						<div class="input_box l">
							<input id="pwd" name="pwd" type="password" placeholder="这里是密码"/>
						</div>
					</div>
					
					<a href="javascript:void(0);" class="reg_submit dib">提交</a>
				</div>
				

				
			</div>
		</div>
		
	</body>
	<script src="js/module/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/register.js" type="text/javascript" charset="utf-8"></script>
	<script>
	$('body').on('click','.reg_submit',function(){
	$.ajax({

		type: "GET",

		url: '<%=actionPath%>',

		data : {
			usern : $('#usern').val(),
			pwd : $('#pwd').val()
		},

		dataType: "json",

		success: function(json){
			
			if(json.result!=''&&json.result.uid>0){//登录成功
				var uid=json.result.uid;
				$.ajax({

					type: "GET",

					url: '<%=bindPath%>',

					data : {
						uid : uid
					},

					dataType: "json",

					success: function(json){
						if(json.result=='true'){
							location.replace('<%=jumpPath%>'+uid);
						}else{
							alert(json.msg);
						}
					}
				});
				
			}else{
				alert("登录失败!");
			}
		}
	});
})
	</script>
</html>
