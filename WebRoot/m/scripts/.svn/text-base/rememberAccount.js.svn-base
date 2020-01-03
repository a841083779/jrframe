	// 在此做 cookie 处理
	/*
	*	如果cookie中没有用户的信息，则为用户自动创建一个账户
	*  用户名：ip 地址  初始密码：666666
	*  否则自动登录
	*/


function GetCookie(name)
 {
	var arg = name + "=";
	var alen = arg.length;
	var clen = window.document.cookie.length;
	var i = 0;
	while (i < clen)
	 {
		var j = i + alen;
		if (window.document.cookie.substring(i, j) == arg) return getCookieVal(j);
		i = window.document.cookie.indexOf(" ", i) + 1;
		if (i == 0)
		 break;
	}
	return null;
}
function getCookieVal(offset)
 {
	var endstr = window.document.cookie.indexOf(";", offset);
	if (endstr == -1)
	 endstr = window.document.cookie.length;
	return unescape(window.document.cookie.substring(offset, endstr));
}
function SetCookie(name, value)
 {
	var exp = new Date();
	var Days = 365*10 ;
	exp.setTime(exp.getTime() + (Days * 24 * 60 * 60 * 1000));
	window.document.cookie = name + "=" + escape(value) + "; expires=" + exp.toGMTString() + ";path=/";
}
function DeleteCookie(name)
 {	
	var exp = new Date();
	exp.setTime(exp.getTime() - 100);
	var cval = GetCookie(name);
	window.document.cookie = name + "=" + null + "; expires*=" + exp.toGMTString() + ";path=/";
}
function DelCookie()
 {
	DeleteCookie(document.all.username.value);
}
function remember()
 {
	 SetCookie(jQuery("#login_username").val(),jQuery("#login_password").val()) ;
}
function showpassword()
 {
	var p = GetCookie(jQuery("#login_username").val());
	if (p != null){
	 jQuery("#login_password").val(p);
	 }
}