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
  	<td>字段类型</td>
  	<td>对齐标准</td>
  	<td>显示名称</td>
  	<td>列宽</td>
  	<td>定义查询</td>
  </tr>
    <%
    	DBHelper dbHelper = DBHelper.getInstance();
    	Map model = null;
    	String name = CommonString.getFormatPara(request.getParameter("name"));
    	String sql = " select a.name,a.length,b.name as type from syscolumns a,systypes b,sysobjects c ";
    	sql += " where a.xtype=b.xtype and a.id=c.id and c.name= '"+name+"' ";
    	sql += " and b.name <> 'sysname' ";
    	sql += " order by a.id ";
    	List columns =  dbHelper.getMapList(sql);
    	for(int j=0;j<columns.size();j++){
    		model = (Map)columns.get(j);
    		if(model.get("name").equals("id")||model.get("name").equals("uuid")){
    			%>
  <tr style="display: none;">
  	<td>
  		<input type="checkbox" checked="checked" class="name" name="name" value="<%=model.get("name") %>" />
  	</td>
    			<%
    		}else{
    			%>
  <tr>
  	<td>
  		<input type="checkbox" class="name" name="name" value="<%=model.get("name") %>" />
  	</td>
    			<%
    		}
    		%>
  	<td><%=model.get("name") %></td>
  	<td>
  		<select name="type" class="type">
  			<option value="string">字符串</option>
  			<option value="date">时间</option>
  			<option value="int">整数</option>
  			<option value="float">小数</option>
  			<option value="is">是否</option>
  			<option value="sex">男女</option>
  		</select>
  	</td>
  	<td>
  		<select name="text_align" class="text_align">
  			<option value="center">居中</option>
  			<option value="left" selected="selected">居左</option>
  			<option value="right">居右</option>
  		</select>
  	</td>
  	<td>
  		<input type="text" name="display_name" class="display_name" value="<%=model.get("name") %>" />
  	</td>
  	<td>
  		<input type="text" name="column_width" class="column_width" value="200" />
  	</td>
  	<td>
  		<select name="search" class="search">
  			<option value="">无查询</option>
  			<option value="eq">相等</option>
  			<option value="like">模糊</option>
  		</select>
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
<!--
function doSub(){
	var queryString = "table="+jQuery("#table").val();
	queryString += "&folder="+jQuery("#folder").val();
	queryString += "&file="+jQuery("#file").val();
	jQuery.each(jQuery(".name:checked"),function(){
		var par = jQuery(this).parent().parent();
		queryString += "&name="+this.value;
		queryString += "&type="+par.find(".type").val();
		queryString += "&text_align="+par.find(".text_align").val();
		queryString += "&display_name="+par.find(".display_name").val();
		queryString += "&column_width="+par.find(".column_width").val();
		queryString += "&search="+par.find(".search").val();
	});
	jQuery.ajax({
		url:'/backend/template/generate_list.jsp',
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

jQuery(".type").change(function(){
	var par = jQuery(this).parent().parent();
	if(this.value=='string'){
		par.find(".text_align").val('left');
	}
	if(this.value=='date'){
		par.find(".text_align").val('center');
	}
	if(this.value=='int'||this.value=='float'){
		par.find(".text_align").val('right');
	}
	if(this.value=='is'||this.value=='sex'){
		par.find(".text_align").val('center');
	}
});
//-->
</script>