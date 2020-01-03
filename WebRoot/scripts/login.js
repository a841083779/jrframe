// 弹出登陆对话框
function login() {
	jQuery.jBox.setDefaults({
		defaults : {
			border : 5
		}
	}); // 只修改全局 border
	jQuery.jBox("iframe:/activity/koubei/login.jsp?back=" + encodeURIComponent(document.URL), {
		border:5,
		title : null,
		opacity : 0.3,
		width : 620,
		top : '30%',
		height : 280,
		showClose:false,
		showIcon : false,
		iframeScrolling : 'no',
		id:'loginFrame',
		buttons : {}
	});
}
//退出
function logout(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout&r='+new Date(),
		async:false,
		cache:false,
		success:function(data){
			jQuery.jBox.tip("您已退出登录！");
			setTimeout("window.location.reload()",1000);
		}
	});
}
function LoginToRegister(){//注册成功会自动登录并返回注册前页面
	window.parent.location.href = 'register.jsp';
}
function toRegist_for_return(){	
	parent.LoginToRegister();
	parent.jQuery.jBox.close('loginFrame');
}
