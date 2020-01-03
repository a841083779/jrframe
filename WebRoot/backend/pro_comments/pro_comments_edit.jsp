<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_comments";
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
					<div class="group">
					<span>
				    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
				     </span>
					<span class="groupTitle">评论信息</span>
					</div>
				<div class="formLeft">评论时间</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_add_date" id="zd_add_date" value="<%=CommonDate.getFormatDate("yyyy-MM-dd HH:mm:ss", model.get("add_date")) %>" dataType="Require" msg="请输入评论时间" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">评论者</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">电<span class="span3">&nbsp;</span>话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_phone" id="zd_phone" value="<%=CommonString.getFormatPara(model.get("phone")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">邮<span class="span3">&nbsp;</span>箱</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">评论内容</div>
				<div class="formRight">
					<textarea class="jr_textarea" name="zd_content" id="zd_content" style="heigth:50px;"><%=CommonString.getFormatPara(model.get("content")) %></textarea>
				</div>
				<div style="clear:left;height:30px;"></div>
				<div class="formLeft">价格分</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_score1" id="zd_score1" value="<%=CommonString.getFormatPara(model.get("score1")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">性能分</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_score2" id="zd_score2" value="<%=CommonString.getFormatPara(model.get("score2")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">质量分</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_score3" id="zd_score3" value="<%=CommonString.getFormatPara(model.get("score3")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">售后分</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_score4" id="zd_score4" value="<%=CommonString.getFormatPara(model.get("score4")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">总<span class="span3">&nbsp;</span>分</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_score5" id="zd_score5" value="<%=CommonString.getFormatPara(model.get("score5")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">显<span class="span3">&nbsp;</span>示</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">购<span class="span3">&nbsp;</span>买</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_buy")),"zd_is_buy") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">购买日期</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_buy_date" id="zd_buy_date" value="<%=CommonString.getFormatPara(model.get("buy_date")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">购买价格</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_buy_price" id="zd_buy_price" value="<%=CommonString.getFormatPara(model.get("buy_price")) %>" />
				</div>
				<div style="clear:left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					if (rs > 0 ) {
						jrSuccess("保存成功！");
						<%
						if("".equals(id)){
							%>
						window.location.reload();
							<%
						}
						%>
					} 
				}
			});
		}
	}
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>