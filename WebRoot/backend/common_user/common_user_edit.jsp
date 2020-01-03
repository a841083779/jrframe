<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = tablePrefix + "common_user";
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		List roles = dbHelper.getMapList(" select uuid,role_name from "+tablePrefix+"common_role ",connection);
		Map roleMap = new LinkedHashMap();
		roleMap.put("4CCDF227-7F10-4E09-A47C-085CCB4A45FF","--请选择角色--");
		roleMap.putAll(CommonCollection.listToMap(roles,"uuid","role_name"));
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
						<img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" />
					</span>
					<span class="groupTitle">基础信息</span>
				</div>
				<div class="formLeft">用<span class="span3"></span>户<span class="span3"></span>名</div>
				<div class="formRight">
					<%
						if(!"".equals(id)){
							%>
					<input type="text" readonly="readonly" class="jr_text" name="zd_usern" id="zd_usern" value="<%=CommonString.getFormatPara(model.get("usern")) %>" dataType="Require" msg="请您输入用户名！" />
							<%
						}else{
							%>
					<input type="text" class="jr_text" name="zd_usern" id="zd_usern" value="<%=CommonString.getFormatPara(model.get("usern")) %>" dataType="Require" msg="请您输入用户名！" />
							<%
						}
					%>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">密<span class="span2"></span>码</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_password_bak" id="zd_password_bak" value="<%=CommonString.getFormatPara(model.get("password_bak")) %>" dataType="Require" msg="请您输入密码！" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">角<span class="span2"></span>色</div>
				<div class="formRight">
					<select class="jr_select" name="zd_role_uuid" id="zd_role_uuid"><%=CommonForm.createSelect(roleMap,CommonString.getFormatPara(model.get("role_uuid"))) %></select>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">姓<span class="span2"></span>名</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" dataType="Require" msg="请您输入姓名！" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">性<span class="span2"></span>别</div>
				<div class="formRight">
					<%=CommonForm.createSexRadio(CommonString.getFormatPara(model.get("sex")),"zd_sex") %>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">电<span class="span2"></span>话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_telephone" id="zd_telephone" value="<%=CommonString.getFormatPara(model.get("telephone")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">邮<span class="span2"></span>箱</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">部<span class="span2"></span>门</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_dept" id="zd_dept" value="<%=CommonString.getFormatPara(model.get("dept")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="group">
					<span>
						<img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" />
					</span>
					<span class="groupTitle">扩展信息</span>
				</div>
				<div class="formLeft">是否激活</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("state")),"zd_state") %>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">登录次数</div>
				<div class="formRight">
					<input type="text" class="jr_text" readonly="readonly" name="zd_login_count" id="zd_login_count" value="<%=CommonString.getFormatPara(model.get("login_count")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">登录日期</div>
				<div class="formRight">
					<input type="text" class="jr_text" readonly="readonly" name="zd_last_login_date" id="zd_last_login_date" value="<%=CommonString.getFormatPara(model.get("last_login_date")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">登<span class="span3"></span>录<span class="span3"></span>IP</div>
				<div class="formRight">
					<input type="text" class="jr_text" readonly="readonly" name="zd_last_login_ip" id="zd_last_login_ip" value="<%=CommonString.getFormatPara(model.get("last_login_ip")) %>" />
				</div>
				<div style="clear: left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
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
					if (rs > 0) {
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