<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="author" content="design by www.21-sun.com">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<title>铁臂兄弟连</title>
<link href="style_new/login.css" rel="stylesheet" type="text/css">
<link href="style_new/reset.css" rel="stylesheet" type="text/css">
<link href="style_new/style_new.css" rel="stylesheet" type="text/css">
<link href="style_new/member_new.css" rel="stylesheet" type="text/css">
<link href="style_new/member_grow.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="style_new/jbox.css" type="text/css">
<link href="/plugin/dialog/jBox/Skins/GreyBlue/jbox.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/plugin/emotions/jquery.emoticons.js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<style type="text/css">
html { height: 100%; }
.xz_title { height: 40px!important; line-height:40px!important; }
.xzLayer .xz_title h3 { padding-left: 20px; }
li.name input, li.code input { width: 227px; height: 21px; line-height: 21px; padding: 8px 0px 8px 43px; font-size: 14px; font-family: 微软雅黑; color: #9c9c9c; background: url(images/new_login_inputbg.gif) no-repeat; border: none; }
li.code input { background-position: 0px -37px; }
</style>
</head>
<body style="width: auto;height: auto;" class="xzLayer " marginwidth="0" marginheight="0">
<div class="xz_title">
  <h3>登录</h3>
  <a href="javascript:void(0);" onClick="window.parent.window.jBox.close();"> <span class="close" style="cursor: pointer;"><img src="images/bg_close.png"></span> </a> </div>
<div class="loginLayer">
  <div class="loginLayerLeft">
    <form action="/action/ajax.jsp" name="loginform" id="loginform" method="post">
      <ul class="b_whitebg">
        <li class="name">
          <input type="text" name="showLoginName" id="showLoginName" title="注册时的用户名" onFocus="onfocusTochangeTxt(this,2);" datatype="Require" msg="请输入用户名！">
          <input style="display: none;" name="login_username" type="text" id="login_username" onBlur="onblurTochangeTxt(this,2)">
        </li>
        <li class="code">
          <input type="text" class="b_wi02" name="showLoginPasswd" id="showLoginPasswd" value="" title="密码" onFocus="onfocusTochangeTxt(this,2);" datatype="Require" msg="请输入密码！">
          <input style="display: none;" name="login_password" type="password" class="b_wi02" id="login_password" value="密码" onKeyDown="if(event.keyCode==13){doLogin();}" onBlur="onblurTochangeTxt(this,2)">
        </li>
        <li class="remeber">
          <input type="checkbox" name="rememberPass" id="rememberPass" value="0">
          <span style="cursor: pointer;" id="rem_pass">两周内自动登录</span> </li>
        <li class="b_loginWays" style="line-height: 40px;">
          <div class="b_btn">
            <input style="font:0px a;color: #FFF;border: none;float: left; letter-spacing:-7px;" type="button" name="button" id="button" onClick="doLogin();" value="立即登录" class="b_lb1">
            &nbsp;&nbsp;&nbsp;<!-- <a href="javascript:void(0);" style="color:#ff8400; text-decoration:underline;">忘记密码？</a> -->
            <input type="hidden" name="flag" value="doLogin">
          </div>
        </li>
      </ul>
    </form>
  </div>
  <div class="loginLayerRight">
    <div class="mb5"> 还没有注册账号？<br>
      <a href="/activity/koubei/register.jsp" class="b_lb2 mt5" target="_blank">立即注册</a> </div>
     </div>
</div>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script> 
<script type="text/javascript" src="/scripts/common.js"></script> 
<script type="text/javascript" src="/scripts/common1.js"></script> 
<script type="text/javascript" src="/plugin/jbox/jquery.jBox-2.3.min.js"></script> 
<script>
var backUrl = '';
jQuery(function(){
	jQuery("#showLoginPasswd").val("密码") ;
	jQuery("#showLoginName").val("用户名") ;
	jQuery("#rem_pass").click(function(){//记住密码事件
		var remPass = jQuery("#rememberPass");
		if(remPass.attr("checked")=="checked"){
			remPass.removeAttr("checked");
			remPass.val("0");
		}else{
			remPass.attr("checked","checked");
			remPass.val("1");
		}
	});
	jQuery("#rememberPass").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
			remPass.attr("value","1");
		}else{
			remPass.attr("value","0");
		}
	});
})

function doLogin(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#login_username").val())+'&p='+encodeURI(jQuery("#login_password").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
}
</script>
</body>
</html>