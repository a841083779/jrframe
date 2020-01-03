<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_product_form";
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

<body style="margin: 0;padding: 0; overflow-x: hidden; ">
<form name="theform" id="theform" action="/admin/action/crud.jsp">
  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/> </span> <span class="groupTitle">订单人信息</span> </div>
    <div style="clear:left;"></div>
    <div class="formLeft">订单人</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" readonly="readonly"/>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">联系邮箱</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" readonly="readonly" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">所在公司</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_company" id="zd_company" value="<%=CommonString.getFormatPara(model.get("company")) %>"  readonly="readonly"/>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">所在地区</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_contact_address" id="zd_contact_address" value="<%=CommonString.getFormatPara(model.get("contact_address")) %>" readonly="readonly" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">固定电话</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_contact_tel" id="zd_contact_tel" value="<%=CommonString.getFormatPara(model.get("contact_tel")) %>" readonly="readonly" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">手机号码</div>
    <div class="formRight">
      <input  type="text" class="jr_text" name="zd_mobile_phone" id="zd_mobile_phone" value="<%=CommonString.getFormatPara(model.get("mobile_phone")) %>" readonly="readonly" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">留言内容</div>
    <div class="formRight" style="height: 50px; text-align: left;">
      <textarea id="zd_message" name="zd_message" cols="90" rows="2" readonly="readonly"><%=CommonString.getFormatPara(model.get("message")) %></textarea>
    </div>
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/> </span> <span class="groupTitle">处理信息</span> </div>
    <div class="formLeft">是否处理</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("state")),"zd_state") %> </div>
    <div style="clear:left;"></div>
    <div class="formLeft">处理内容</div>
    <div class="formRight" style="height: 50px; text-align: left;">
      <textarea id="zd_disposal_content" name="zd_disposal_content" cols="90" rows="2"><%=CommonString.getFormatPara(model.get("disposal_content")) %></textarea>
    </div>
    <div style="clear:left;"></div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <input type="hidden" name="zd_channel_uuid" id="zd_channel_uuid" value="<%=channelUUID %>" />
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
    
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>