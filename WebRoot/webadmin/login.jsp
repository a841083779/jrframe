<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>登录-中国工程机械商贸网</title>
<link href="/webadmin/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/webadmin/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/webadmin/scripts/jquery.form.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<img src="images/loginbg.png" width="442" height="340" class="login_layerbg" />
<div class="login_layer">
  <h1 class="logo"><img src="images/logo_21sun.gif" alt="中国工程机械商贸网" width="118" height="47" /></h1>
   <form action="/webadmin/ajax_cud.jsp" method="post" id="theform" name="theform">
  <ul class="login_form">
    <li class="input user" id="user">
      <input type="text" name="usern" id="usern" onfocus="document.getElementById('user').className='input user u_focus'" onblur="document.getElementById('user').className='input user'" />
    </li>
    <li class="input password" id="password">
      <input type="password" name="password" id="password" onkeydown="if(event.keyCode==13){jQuery('#login').click()}" onfocus="document.getElementById('password').className='input password p_focus'" onblur="document.getElementById('password').className='input password'" />
    </li>
    <li class="btn">
      <input type="button" name="button" id="login" value="&nbsp;" />
      <input type="hidden" name="flag" value="login" />
    </li>
    <li class="copyRight"><a href="http://www.21-sun.com/" target="_blank">中国工程机械商贸网</a>　版权所有</li>
  </ul>
      </form>
</div>
</body>
</html>
<script type="text/javascript">
jQuery(function(){
	jQuery("#usern").focus();
	jQuery("#login").click(function(){
		jQuery("#theform").ajaxSubmit({
			type:"POST",
			success:function(data){
				if(jQuery.trim(data)=='ok'){
					window.location.href='/backend/';
				}else if(jQuery.trim(data)=='state0'){
					alert('您的帐户已被禁用，请您与管理员联系！');
				}else{
					alert('用户名或者密码不正确！');
				}
			}
		});
	});
});
</script>