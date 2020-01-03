<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %><%

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户注册 - 铁臂商城</title>
<meta name="keywords" content="工程机械口碑" />
<meta name="description" content="铁臂口碑第一季活动——分享您的真实用机感受，就有机会获得大奖。买工程机械产品，就上铁臂商城。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/plugin/dialog/jBox/Skins/GreyBlue/jbox.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script>
</head>
<body>
<!--top-->
<div class="topLinks">
  <div class="contain980">
    <div class="visit_21sun"><a rel="nofollow" target="_blank" href="http://www.21-sun.com/" title="访问中国工程机械商贸网首页"><img src="/images/n_toppoint.gif" align="absmiddle"> 访问中国工程机械商贸网首页</a> 
    </div>
	<ul class="loginLinks_new" style="color:red;">
	
	
      <!--  <li onclick="window.open('http://product.21-sun.com/agent/login.jsp');">厂家登录</li>
      <li onclick="window.open('http://product.21-sun.com/agent/login.jsp');">代理商登录</li>-->
    </ul>
    <ul class="tlRight">
      <li class="tl" onclick="addCookie();">加入收藏</li>
	      <!--  
      <li class="tl" onclick="window.open('http://market.21-sun.com/');">供求市场</li>
      <li class="tl" onclick="window.open('http://news.21-sun.com/');">资讯中心</li> 
       <li class="tl" onclick="window.open('http://news.21-sun.com/');">行业动态</li>
	   -->
	  <li class="tl" style="width:45px;" onclick="window.open('http://weixiu.21-sun.com/');">维修</li>
	  <li class="tl" style="width:45px;" onclick="window.open('http://koubei.21-sun.com/');">口碑</li>
      <li class="tl" onclick="window.open('http://aboutus.21-sun.com/contact/');">客服中心</li>
      <li class="guide"><span class="gt">网站导航</span>
        <ul>
          <li onclick="window.open('http://product.21-sun.com/');">铁臂商城</li>
          <li onclick="window.open('http://photo.21-sun.com/');">产品图库</li> 
          <li onclick="window.open('http://weixiu.21-sun.com/');">维　　修</li>
          <li onclick="window.open('http://koubei.21-sun.com/');">口　　碑</li>
          <li onclick="window.open('http://market.21-sun.com/');">供求市场</li>
		  <li onclick="window.open('http://news.21-sun.com/');">行业动态</li>  
          <li onclick="window.open('http://used.21-sun.com/');">二手设备</li>
          <li onclick="window.open('http://www.21-sun.com/part/');">配件市场</li>
		  <li onclick="window.open('http://www.21part.com/');">杰 配 网</li>
		  <li onclick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
          <li onclick="window.open('http://www.21taiyang.com/');">太阳商城</li>
          <li onclick="window.open('http://www.wajueji.com/');">铁臂兄弟连</li>
        </ul>
      </li>
      <li class="tl" style="width:63px; background:none; padding:4px 0px 0px 5px; height:24px"><iframe width="63" height="24" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" border="0" src="http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&amp;width=63&amp;height=24&amp;uid=1904756027&amp;style=1&amp;btn=red&amp;dpc=1"></iframe></li>
      <li class="tl" style="width:80px; background:none;"><a target="_blank" href="http://www.21-sun.com/weixin/"><img width="74" height="20" src="http://www.21-sun.com/weixin/images/weixin.jpg" style="margin-top:4px;"></a></li>
    </ul>
  </div>
</div>

<div class="wrapper loginContainer mb25">
    
      <!--left-->
      <div class="loginLeft">
      	<form action="/action/ajax.jsp?flag=regist" method="post" name="theform" id="theform" onSubmit="return submitYN(this);">
        <ul class="registContent">
          <li class="rcl">
            <dl class="rcd">
            	<dt>用户名：</dt>
              <dd>
                <input type="text" name="zd_username" id="zd_username" class="email required bri" maxlength="20" onkeyup="isSpecialChar('zd_username')" />
              </dd>
            </dl>
            <div class="rfRight"><span>4-20个字符，由英文、数字及“_”组成</span></div>
          </li>
          <li class="rcl">
            <dl class="rcd">
            	<dt>密码：</dt>
              <dd>
                <input type="password" name="zd_password" id="zd_password" class="Pass required bri" maxlength="20" />
              </dd>
            </dl>
            <div class="rfRight"><span>4-20个字符，由英文、数字及“_”组成</span></div>
          </li>  
          <li class="rcl">
            <dl class="rcd">
            	<dt>再次输入密码：</dt>
              <dd>
                <input type="password" name="dbpassword" id="dbpassword" class="Pass required bri" maxlength="30" />
              </dd>
            </dl>
            <div class="rfRight"><span>请再次输入密码</span></div>
          </li>
          <li class="rcl">
            <dl class="rcd">
            	<dt>手机号码：</dt>
              <dd>
                <input type="text" name="zd_telephone" id="zd_telephone" class="email required bri" maxlength="11"  />
              </dd>
            </dl>
            <div class="rfRight"><span>请填写真实手机号码以便中奖信息核实</span></div>
          </li>
          <li class="rcl">
            <dl class="rcd">
            	<dt>地址：</dt>
              <dd>
                <input type="text" name="zd_address" id="zd_address" class="email required bri" />
              </dd>
            </dl>
            <div class="rfRight"><span>请填写详细地址以便奖品邮寄</span></div>
          </li>
          
          <li class="rcl">
            <dl class="rcd yanzhengma">
            	<dt>验证码：</dt>
              <dd class="select" style="width: 130px;">
                <input type="text" name="auth" id="auth" class="bri yanzheng" maxlength="4" />
              </dd>
            </dl>
            <dl class="yanzhengmaImg">
              <img src="/webadmin/authImgServlet" id="authImg" width="85" height="36" align="absmiddle" /> <a href="javascript:void(0);" onclick="refresh();" style="color:red;">换一张</a>
            </dl>
            <div class="rfRight" style="width: 125px;float: left;"><img src="/photo_domain/images/reg_error.png" class="imgError" /><span></span></div>
          </li> 
          <li class="b_btn" style="padding:70px 0px 30px 92px;width: 50%;"><input type="submit" class="b_lb" value="立即注册"  style="cursor: pointer;border:0px;"></li>
        </ul>
        </form>
      </div>
      <!--left end-->
      <!--right-->
      <div class="loginRight">
        <div class="mb20" style="margin-top: 100px;font-weight:bold;">
          已有帐号？<br>
          <a href="javascript:void(0);" onclick="login();" class="b_lb2  mt15">立即登录</a>
        </div>
      </div>
      <!--right end-->
    <div class="clear"></div>  
    </div>

<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<script type="text/javascript" src="scripts/scroll-row.js"></script>
<script language="javascript" type="text/javascript">
function isSpecialChar(myInput){ 
	var iptData=document.getElementById(myInput); 
	if(iptData.value.match(/[^\x00-\xff]/ig)){ 
		iptData.value=iptData.value.replace(/[^\x00-\xff]/ig,""); 
	} 
}
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	var check = 0;
	if (null == jQuery.trim(jQuery("#zd_username").val()) || jQuery.trim(jQuery("#zd_username").val()).length == 0 || jQuery.trim(jQuery("#zd_username").val()).length < 4|| jQuery.trim(jQuery("#zd_username").val()).length >20 ) {
		jQuery.jBox.tip("请输入您的用户名,4-20个字符，由英文、数字及“_”组成！");
		setTimeout(function() {
			jQuery("#zd_username").val("");
			jQuery("#zd_username").focus();
		},
		0);
		return false;
	}else{
		jQuery.ajax({
			url:'/action/ajax.jsp?flag=checkUser&r='+new Date()+'&n='+encodeURI(jQuery("#zd_username").val()),
			async:false,
			cache:false,
			success:function(data){
				if($.trim(data)=="no"){
					jQuery.jBox.tip("该用户名已经被使用，请更换其它名称！");
					setTimeout(function() {
						jQuery("#zd_username").val("");
						jQuery("#zd_username").focus();
					},
					0);
					check = 1;
				}
			}
		});
	}
	if(check==1){
		return false;
	}
	if (null == jQuery.trim(jQuery("#zd_password").val()) || jQuery.trim(jQuery("#zd_password").val()).length == 0|| jQuery.trim(jQuery("#zd_password").val()).length < 4|| jQuery.trim(jQuery("#zd_password").val()).length >20 ) {
		jQuery.jBox.tip("请输入您的密码！");
		setTimeout(function() {
			jQuery("#zd_password").val("");
			jQuery("#zd_password").focus();
		},
		0);
		return false;
	}
	if (jQuery.trim(jQuery("#zd_password").val()) != jQuery.trim(jQuery("#dbpassword").val())) {
		jQuery.jBox.tip("您两次输入的密码不一致！");
		setTimeout(function() {
			jQuery("#dbpassword").val("");
			jQuery("#dbpassword").focus();
		},
		0);
		return false;
	}
	if (jQuery.trim(jQuery("#zd_telephone").val()).length == 0 || (!mobile_phone_reg.test(jQuery('#zd_telephone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的手机号码!");
		setTimeout(function() {
			jQuery("#zd_telephone").val("");
			jQuery("#zd_telephone").focus();
		},
		10);
		return false;
	}
	if ((null == jQuery.trim(jQuery("#zd_address").val()) || jQuery.trim(jQuery("#zd_address").val()).length == 0)) {
		jQuery.jBox.tip("请输入您的联系地址！");
		setTimeout(function() {
			jQuery("#zd_address").val("");
		 	jQuery("#zd_address").focus();
		},
		10);
		return false;
	}
	if ((null == jQuery.trim(jQuery("#auth").val()) || jQuery.trim(jQuery("#auth").val()).length == 0)) {
		jQuery.jBox.tip("请输入验证码！");
		setTimeout(function() {
			jQuery("#auth").val("");
		 	jQuery("#auth").focus();
		},
		10);
		return false;
	}else{
		jQuery.ajax({
			url:'/action/ajax.jsp?flag=checkRand&r='+new Date()+'&a='+encodeURI(jQuery("#auth").val()),
			async:false,
			cache:false,
			success:function(data){
				if($.trim(data)=="no"){
					jQuery.jBox.tip("请输入正确的验证码！");
					setTimeout(function() {
						jQuery("#auth").val("");
					 	jQuery("#auth").focus();
					},
					10);
					check = 1;
				}
			}
		});
	}
	if(check==1){
		return false;
	}
	jQuery("#theform").ajaxSubmit({
	 	type:'post',
	    url:'/action/ajax.jsp?flag=regist' ,
	    success:function(msg){
	        if(jQuery.trim(msg)=='ok'){
		    	$.jBox.success('恭喜您注册成功！', '提示',{ closed: function () { window.parent.location.href = 'http://photo.21-sun.com/'; } });
		    	return ;
		    }else if(jQuery.trim(msg)=='no'){
		    	$.jBox.error("网络问题，请稍后重新尝试！", "出错");
		    	return ;
		    }else if(jQuery.trim(msg)=='rand'){
		    	$.jBox.error("请输入正确的验证码！", "出错");
		    	return ;
		    }
	    }
	 }) ;
	return false ;
}

refresh();
function refresh(){
	document.getElementById("authImg").src='/webadmin/authImgServlet?now=' + new Date();
}


</script>

</body>
</html>