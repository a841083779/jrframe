<!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>注册 - 铁臂口碑 </title>
<link href="Static/css/style.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="top.jsp" flush="true"/>
<div class="lr_form_val fix">
 <form class="logForm" name="registerForm" id="registerForm" method="post" action="/action/ajax_mobile.jsp?message=regist">
	<div class="lrftom">
    	<div class="lin_nr fix lin_nr1">
        	<span class="lr_ico"><img src="Static/img/u_ico.gif"/></span>
            <span class="lr_inp"><input type="text" name="zd_username"  id="zd_username" dataType="Require" msg="请填写4-16个字母、数字，不支持特殊符号" placeholder="账 号"/></span>
        </div>
        <div class="lin_nr fix lin_nr2">
        	<span class="lr_ico"><img src="Static/img/p_ico.gif"/></span>
            <span class="lr_inp"><input type="text" name="zd_password"name="zd_password" dataType="Require"  maxlength="20"  min="6" max="20" msg="密码长度为6-20个字符" placeholder="密 码"/></span>
        </div>
        <div class="lin_nr fix lin_nr3">
        	<span class="lr_ico"><img src="Static/img/t_ico.gif"/></span>
            <span class="lr_inp"><input type="text" name="zd_telephone" name="zd_telephone" datatype="Mobile" maxlength="11" msg="请输入正确格式的手机号" placeholder="手机号"/></span>
        </div>
    </div>
    <div class="lr_yzm">
    </div>
    <div class="lr_subbtn"><a href="javascript:;" onclick="checkValidator(this);">注册</a></div>
	</fomr>
</div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script language="javascript" type="text/javascript">


	
		
//验证用户名是否存在
function checkUserName(){
	var rs = "ok";
	if($("#zd_username").val().length<4||$("#zd_username").val().length>16){
		rs = "请填写4-16个字母、数字，不支持特殊符号\n";
	}else{//ajax验证用户是否存在		
		$.ajax({
			url:"/action/ajax_mobile.jsp",
			async:false,
			type:"post",
			data:"message=checkUserName&username="+$("#zd_username").val()
			}).done(function (back) {
				if($.trim(back)=="yes"){
					rs = "您输入的用户名已存在\n";
				}
			});
	}
	return rs;
}
//验证电话号码合法性
function checkPhoneNum(){
	var rs = "ok";
	/*if($("#zd_telephone").val().length!=11){
		rs = "请输入正确的手机号，便于及时收到获奖通知\n";
	}else{//ajax验证电话号码唯一*/
		$.ajax({
			url:"/action/ajax_mobile.jsp",
			async:false,
			type:"post",
			data:"message=checkPhoneNum&phone_num="+$("#zd_telephone").val()
			}).done(function (back) {
				if($.trim(back)=="yes"){
					rs = "同一手机号码只能注册一次\n";
				}
			});
	/*}*/
	return rs;
}


//注册表单验证
function checkValidator(a){
	var checkResult = Validator.Validate(document.getElementById('registerForm'));
	if(checkResult){
		var rs1 = checkUserName();
		if(rs1=="ok"){
			var rs2 = checkPhoneNum();
			if(rs2=="ok"){
		     var yzm = '';

	

			 registerForm.submit();
	
	
				
			}else{
				alert(rs2);
				$("#zd_telephone").focus();
			}	
		}else{
			alert(rs1);
			$("#zd_user_no").focus();
		}		
	}
	
}

function common(data) {
	var serialize = $(data).closest("form").serialize();
	$.post("/action/ajax_mobile.jsp?message=regist", serialize, function (back) {
		if($.trim(back)=="registSuccess"){
			alert("用户注册成功，为您跳转到首页");
			parent.window.location.href="http://m.koubei.21-sun.com/";
		}
		else if($.trim(back)=="uniqueName"){
			alert("用户名不能重复");
		}
		else if($.trim(back).indexOf("loginSuccess")!=-1){
			window.location.reload();
		}else{
			alert($.trim(back));
		}
	});
}


</script>

<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
</script>
</html>