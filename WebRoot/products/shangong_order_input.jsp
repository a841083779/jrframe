<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>

<html>
<head>
<title>山工询价推送</title>
<script src="/plugin/date/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
 <style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 1px;font-size:16px;text-align:center}
	td{height:20px;width:105px}
	input{height:30px;width:200px}
	</style>
</head>
<body>
<form name="theform" id="theform" action="" method="">
姓名：<input name="name" id="name" type="text" value=""/><br/>
电话：<input name="tel" id="tel" type="text" value=""/><br/>
省份：<input name="province" id="province" type="text" value=""/><br/>
城市：<input name="city" id="city" type="text" value=""/><br/>
<input name="sub" id="sub" type="button" value="提交"/>
</form>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script>
$(function(){
		
	//提交
	$('#sub').on('click',function(){
		$.ajax({
			url: '/tools/order_interface/shangong_admin_activity.jsp',
			data: {
				name:$('#name').val(),
				tel:$('#tel').val(),
				province:$('#province').val(),
				city:$('#city').val(),
			},
			success: function(data) {
				if($.trim(data)=='ok'){
					alert('提交成功！');
					$('#name').val('');
					$('#tel').val('');
					$('#province').val('');
					$('#city').val('');
				}
			}
		});
	})

	
})
</script>
</html>