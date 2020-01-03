<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_agent_factory";
	try{
		connection = dbHelper.getConnection();
		Map factoryInfo = (Map)session.getAttribute("agentInfo");
		if(factoryInfo != null){
			model = dbHelper.getMap(" select * from "+tableName+" where usern = ? ",new Object [] {factoryInfo.get("usern")} , connection);
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/admin/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
</head>

<body style="margin: 0;padding: 0; overflow-x: no; overflow-y:no ">
<form name="theform" id="theform" action="/admin/action/crud.jsp">
  <div class="formDiv">
       <div style="clear:left;"></div>
    <div class="formLeft">旧密码</div>
    <div class="formRight">
      <input type="password" dataType='Require' msg='请输入密码' class="jr_text" name="passw" id="passw" value="<%=CommonString.getFormatPara(model.get("passw")) %>" />
    </div>
    <div style="clear:left;"></div>
        <div class="formLeft">新密码</div>
    <div class="formRight">
      <input type="password" dataType='Require' msg='请输入新密码' class="jr_text" name="zd_passw" id="zd_passw" value="" />
    </div>
     <div style="clear:left;"></div>
             <div class="formLeft">确认密码</div>
    <div class="formRight">
      <input type="password" dataType='Require' msg='请输入确认密码' class="jr_text" name="zd_passw_bak" id="zd_passw_bak" value="" />
    </div>
     <div style="clear:left;"></div>
    <div style="text-align:center; padding:2px 0px 20px 0px;"><input type="button" class="btn" onclick="doSub();" value="保存" style="float:none"/></div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/admin/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
		 if(jQuery("#zd_passw").val()!=jQuery("#zd_passw_bak").val()){
		 	alert("两次输入的密码不同!") ;
		 	return false ;
		 }
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					if (rs > 0 ) {
						jrSuccess("保存成功！");
						<%
						if("".equals(factoryInfo.get("usern"))){
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
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>