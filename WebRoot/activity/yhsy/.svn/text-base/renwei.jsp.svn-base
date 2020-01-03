<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>TITLE</title>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  
  <body>
    <form action="action.jsp?flag=renwei" method="post" id="theform" name="theform">
    	<table>
    		<tr>
    			<td>电话</td>
    			<td>
    				<input type="text" name="phone" />
    			</td>
    		</tr>
    		<tr>
    			<td>姓名</td>
    			<td>
    				<input type="text" name="name" />
    			</td>
    		</tr>
    		<tr>
    			<td colspan="2">
    				<input type="button" value="提交" onclick="doSub();" />
    			</td>
    		</tr>
    	</table>
    </form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script type="text/javascript">
	function doSub(){
		jQuery("#theform").ajaxSubmit({
	        type: "POST",
	        async: false,
	        cache: false,
	        success : function(data){
	        	var tData = jQuery.trim(data);
	        	if(tData=='exist'){
	        		alert("该电话已注册抽奖");
	        	}else{
	        		alert("成功！");
	        	}
	        }
        })
	}
</script>