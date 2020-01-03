<!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>登录 - 铁臂口碑</title>
<link href="Static/css/style.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="top.jsp" flush="true"/>
<div class="lr_form_val fix">
 <form class="logForm" name="login_form" id="login_form"  method="post" action="/action/ajax_mobile.jsp?message=login&flag=1">
	<div class="lrftom login_form">
    	<div class="lin_nr fix lin_nr1">
        	<span class="lr_ico"><img src="Static/img/u_ico.gif"/></span>
            <span class="lr_inp"><input type="text"  name="zd_username"  id="zd_username" dataType="Require" msg="请填写4-16个字母、数字，不支持特殊符号" placeholder="账 号"/></span>
        </div>
        <div class="lin_nr fix lin_nr2">
        	<span class="lr_ico"><img src="Static/img/p_ico.gif"/></span>
            <span class="lr_inp"><input type="text" name="zd_password"name="zd_password" dataType="Require"  maxlength="20"  min="6" max="20" msg="密码长度为6-20个字符" placeholder="密 码"/></span>
        </div>
    </div>
    <div class="lr_subbtn"><a href="javascript:;" onclick="loginWebSite(this);">登录</a></div>
	</form>
</div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script language="javascript" type="text/javascript">
//登录提交表单
function loginWebSite(a){
	var checkResult = Validator.Validate(document.getElementById('login_form'));
	if(checkResult){
		login_form.submit();
	}
}

</script>
<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
</script>
</html>