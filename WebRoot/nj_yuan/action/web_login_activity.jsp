<!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>9要随手拍——就要出风头摄影大赛 - 铁臂图库</title>
<meta name="keywords" content="工程机械图片库" />
<meta name="description" content="铁臂图库为摄影爱好者带来9要随手拍——就要出风头摄影大赛活动，上传美图就有机会获得大奖。买工程机械产品，就上铁臂商城。" />
<link href="Static/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/history/json.js"></script>
<script type="text/javascript" src="/scripts/history/history_search.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/plugin/emotions/jquery.emoticons.js"></script>
</head>
<body>
<jsp:include page="top.jsp" flush="true"/>
<div class="lr_form_val fix">
 <form class="logForm" name="login_form" id="login_form"  method="post" action="/action/ajax_mobile_activity.jsp?message=login&flag=2">
	<div class="lrftom login_form">
    	<div class="lin_nr fix lin_nr1">
        	<span class="lr_ico"><img src="Static/img/u_ico.gif"/></span>
            <span class="lr_inp"><input type="text"  name="zd_username"  id="zd_username" dataType="Require" msg="请填写4-16个字母、数字，不支持特殊符号" placeholder="账 号"/></span>
        </div>
        <div class="lin_nr fix lin_nr2">
        	<span class="lr_ico"><img src="Static/img/p_ico.gif"/></span>
            <span class="lr_inp"><input type="password" id="zd_password" name="zd_password" dataType="Require"  maxlength="20"  min="6" max="20" msg="密码长度为6-20个字符" placeholder="密 码"/></span>
        </div>
    </div>
    <div class="lr_subbtn"><a  href="javascript:void(0);" onclick="loginWebSite(this);">登录</a></div>
	</form>
</div>
<jsp:include page="foot.jsp" flush="true"/>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script language="javascript" type="text/javascript">


function loginWebSite(a){
	var checkResult = Validator.Validate(document.getElementById('login_form'));
	
	if(checkResult){
	
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&flag=2&r='+new Date()+'&u='+encodeURI(jQuery("#zd_username").val())+'&p='+encodeURI(jQuery("#zd_password").val()),
		async:false,
		cache:false,
		success:function(data){
	
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");				
				setTimeout(function(){
	 	 	       window.location.href = "/mobile/photo/index.jsp" ;
	 	       },1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
		//login_form.submit();
	}
}

</script>
<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
</script>
</html>