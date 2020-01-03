<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>短信发送</title>
		<link rel="stylesheet" type="text/css" href="/style/style.css">
		<script type="text/javascript" src="/plugin/jquery/jquery.min.js"></script>
	</head>

	<body>
		<table cellpadding="5" cellspacing="5">
			<tr>
				<td>
					内容
				</td>
				<td>
					<textarea
						style="width: 400px; height: 100px; border: 1px solid #ccc;"
						name="content" id="content"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					手机
				</td>
				<td>
					<input type="text" style="border: 1px solid #ccc; width: 400px;"
						name="phone" id="phone" />
				</td>
			</tr>
		</table>
	</body>
</html>
<script type="text/javascript">
function doSub(){
	var url = "http://service.21-sun.com/http/utils/sms.jsp";
	url += "?phone="+jQuery("#phone").val();
	url += "&content="+encodeURI(jQuery("#content").val());
	url += "&source=195002";
	url += "&callback=?";
	jQuery.getJSON(url,function(json){
		if(json.rs==1||json.rs=='1'){
			alert("发送成功！");
			parent.nowDialog.close();
		}
	});
}
</script>