<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>申请加入</title>
    <link href="/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="/plugin/validator/wofoshan/validator.alert.js" type="text/javascript"></script>
  </head>
  <body>
  <form action="" name="theform" id="theform" method="post">
    <table width="100%" style="padding: 10px;">
    	<tr>
    		<td colspan="2">填写您的信息（或者致电0535-6727793进行咨询）：</td>
    	</tr>
    	<tr>
    		<td width="20%">姓名：</td>
    		<td>
    			<input type="text" maxlength="10" id="name" style="border: 1px solid #ccc;width: 250px; height: 20px;" dataType="Require" msg="请输入姓名！" />
    		&nbsp;&nbsp;<font color="red">*</font>
    		</td>
    	</tr>
    	<tr>
    		<td>邮箱：</td>
    		<td>
    			<input type="text" id="email" maxlength="30" style="border: 1px solid #ccc;width: 250px; height: 20px;" dataType="Email" msg="请输入正确的邮箱！"  />
    		&nbsp;&nbsp;<font color="red">*</font>
    		</td>
    	</tr>
    	<tr>
    		<td>电话：</td>
    		<td>
    			<input type="text" id="phone" style="border: 1px solid #ccc;width: 250px; height: 20px;" msg="请输入电话！" />
    			&nbsp;&nbsp;<font color="red">*</font>
    		</td>
    	</tr>
    	<tr>
    		<td>留言：</td>
    		<td>
    			<textarea id="message" style="border: 1px solid #ccc; width: 250px; height: 60px;"></textarea>
    		</td>
    	</tr>
    </table>
    </form>
  </body>
</html>
<script type="text/javascript">
function doSub(){
	if(!vaPhone()){
		return false;
	}
	var rs = Validator.Validate(document.getElementById("theform"),1);
	if(rs){
		jQuery.ajax({
			url : "/action/ajax.jsp",
			data : {
				flag : "jia_ru_ding_dan_tong",
				name : jQuery("#name").val(),
				email : jQuery("#email").val(),
				phone : jQuery("#phone").val(),
				message : jQuery("#message").val()
			},
			type : 'post',
			async : true
		});
		alert("您的申请已经成功发送，我们会尽快处理您的申请！");
		return true;
	}
	return false;
}
function vaPhone(){
	var mobile_phone_reg = /^1([\d]{10})$/;
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	if ((null == jQuery("#phone").val() || jQuery("#phone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#phone").focus();
		},10);
		return false;
	}
	if (jQuery("#phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#phone').attr("value"))&&!connect_reg.test(jQuery('#phone').attr("value")))) {
		alert("请输入正确的电话号码！如:0535-6792733");
		setTimeout(function() {
			jQuery("#phone").focus();
			jQuery("#phone").select(); 
		},10);
		return false;
	}
	return true;
}
document.onkeydown = function(e){
        if(!e) e = window.event;//火狐中是 window.event
        if((e.keyCode || e.which) == 13){
          doSub() ;
        }
    }
    jQuery(function(){
    setTimeout(function(){
        	jQuery("#name").focus() ;
    },10) ;
    }) ;
</script>