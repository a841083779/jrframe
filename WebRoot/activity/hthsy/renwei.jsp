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
    			<td>城市</td>
    			<td>
    				<select name="city">
    					<option value="烟台">烟台</option>
		              <option value="威海">威海</option>
		              <option value="青岛">青岛</option>
		              <option value="潍坊">潍坊</option>
		              <option value="济南">济南</option>
		              <option value="东营">东营</option>
		              <option value="滨州">滨州</option>
    				</select>
    			</td>
    		</tr>
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