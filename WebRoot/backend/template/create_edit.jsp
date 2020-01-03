<%@ page language="java" import="com.jerehnet.util.common.*,java.util.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>选择字段</title>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<style type="text/css">
		input,select,textarea{
			border:1px solid #ccc;
		}
	</style>
  </head>
  
  <body style="font-size: 12px;">
  <div>
	  文件夹名:<input type="text" name="folder" id="folder" />
	  文件名称:<input type="text" name="file" id="file" />
	  <input type="button" onclick="doSub();" value="生成" />
	  <input type="button" onclick="window.location.href='/backend/template/create.jsp'" value="返回" />
  </div>
  <table cellpadding="2" cellspacing="2" border="0">
  <tr>
  	<td>
  		<input type="checkbox" name="allcheck" onclick="checkAll(this);" />
  	</td>
  	<td>列名</td>
  	<td>表单类型</td>
  	<td>显示名称</td>
  	<td>是否验证(验证提示内容)</td>
  </tr>
    <%
    	DBHelper dbHelper = DBHelper.getInstance();
    	Map model = null;
    	String name = CommonString.getFormatPara(request.getParameter("name"));
    	String sql = sql = " select a.name,a.length,b.name as type from syscolumns a,systypes b,sysobjects c ";
    	sql += " where a.xtype=b.xtype and a.id=c.id and c.name= '"+name+"' ";
    	sql += " and b.name <> 'sysname' ";
    	
    	sql += " order by a.id ";
    	List columns =  dbHelper.getMapList(sql);
    	for(int j=0;j<columns.size();j++){
    		model = (Map)columns.get(j);
    		if(model.get("name").equals("id")||model.get("name").equals("uuid")||model.get("name").equals("add_user")||model.get("name").equals("add_date")||model.get("name").equals("add_ip")||model.get("name").equals("channel_uuid")){
    			continue;
    		}
    		%>
  <tr>
  	<td>
  		<input type="checkbox" class="name" name="name" value="<%=model.get("name") %>" />
  	</td>
  	<td><%=model.get("name") %></td>
  	<td>
  		<select name="type" class="type">
  			<option value="text">文本框</option>
  			<option value="hidden">隐藏框</option>
  			<option value="is">是否</option>
  			<option value="sex">男女</option>
  			<option value="date">时间</option>
  			<option value="number">数字</option>
  			<option value="select">下拉框</option>
  			<option value="radio">单选框</option>
  			<option value="checkbox">复选框</option>
  			<option value="textarea">文本域</option>
  			<option value="editor">编辑器</option>
  		</select>
  	</td>
  	<td>
  		<input type="text" name="display_name" class="display_name" value="<%=model.get("name") %>" />
  	</td>
  	<td>
  		<select name="validator" class="validator">
  			<option value="">--无验证--</option>
  			<option value="Require">非空</option>
  			<option value="Number">数字</option>
  			<option value="Email">邮箱</option>
  			<option value="Phone">电话号码</option>
  			<option value="Mobile">手机号码</option>
  			<option value="IdCard">身份证号</option>
  			<option value="Date">日期</option>
  		</select>
  		<input type="text" name="validator_txt" class="validator_txt" />
  	</td>
  </tr>
    		<%
    	}
    %>
   </table>
   <input type="hidden" name="table" id="table" value="<%=request.getParameter("name") %>" />
  </body>
</html>
<script type="text/javascript">
function doSub(){
	var queryString = "table="+jQuery("#table").val();
	queryString += "&folder="+jQuery("#folder").val();
	queryString += "&file="+jQuery("#file").val();
	jQuery.each(jQuery(".name:checked"),function(){
		var par = jQuery(this).parent().parent();
		queryString += "&name="+this.value;
		queryString += "&type="+par.find(".type").val();
		queryString += "&display_name="+par.find(".display_name").val();
		queryString += "&validator="+par.find(".validator").val();
		queryString += "&validator_txt="+par.find(".validator_txt").val();
	});
	jQuery.ajax({
		url:'/backend/template/generate_edit.jsp',
		data:queryString,
		type:'post',
		success:function(data){
			if(jQuery.trim(data)=='ok'){
				alert("创建成功！");
			}
		}
	});
}
function checkAll(o){
	if(o.checked){
		jQuery(".name").attr("checked","checked");
	}else{
		jQuery(".name").removeAttr("checked");
	}
}
</script>