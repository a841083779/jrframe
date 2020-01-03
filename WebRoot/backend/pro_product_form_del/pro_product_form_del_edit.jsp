<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_product_form_del";
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
		// 清除新订单session
		 application.removeAttribute("applicationOrderId") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
    <link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden;overflow-y:scroll; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
		<div class="group">
			<span>
		    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
		     </span>
			<span class="groupTitle">产品信息</span>
			</div>
				<div class="formLeft">所属厂家</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>" readonly="readonly"/>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">所属代理商</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_agentname" id="zd_agentname" value="<%=CommonString.getFormatPara(model.get("agentname")) %>" readonly="readonly"/>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">产品类别</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_cataname" id="zd_cataname" value="<%=CommonString.getFormatPara(model.get("cataname")) %>" readonly="readonly"/>
				</div>
						<div style="clear:left;"></div>
				<div class="formLeft">产品名字</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_product_name" id="zd_product_name" value="<%=CommonString.getFormatPara(model.get("product_name")) %>" />
				</div>
				<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">订单人信息</span>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">订单人</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>"/>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">联系邮箱</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">所在公司</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_company" id="zd_company" value="<%=CommonString.getFormatPara(model.get("company")).equals("公司名字")?"个人":CommonString.getFormatPara(model.get("company"))%>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">所在地区</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_contact_address" id="zd_contact_address" value="<%=CommonString.getFormatPara(model.get("contact_address")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">固定电话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_contact_tel" id="zd_contact_tel" value="<%=CommonString.getFormatPara(model.get("contact_tel")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">手机号码</div>
				<div class="formRight">
					<input  type="text" class="jr_text" name="zd_mobile_phone" id="zd_mobile_phone" value="<%=CommonString.getFormatPara(model.get("mobile_phone")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">是否处理</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("state")),"zd_state") %>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">删除原因</div>
				<div class="formRight">
					<input  type="text" class="jr_text" name="zd_delete_reason" id="zd_delete_reason" value="<%=CommonString.getFormatPara(model.get("dele_reason")) %>" />
				</div>
				<div style="clear:left;"></div>
			<div class="formLeft">留言内容</div>
			<div class="formRight" style="height: 300px; text-align: left;">
				<script type="text/plain" id="editor_message" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("message")) %></script>
				<input type="hidden" name="zd_message" id="zd_message" value="<%=CommonString.getFormatPara(model.get("message")) %>" />
			</div>
			<div style="clear:left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_channel_uuid" id="zd_channel_uuid" value="<%=channelUUID %>" />
		<input type="hidden" name="eventAfter" value="updateAgentForm" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
 <script type="text/javascript" src="/scripts/rememberAccount.js"></script>
 <script type="text/javascript" src="/scripts/show_msg.js"></script>
<script type="text/javascript">
jQuery(function(){
	DeleteCookie("cookieOrderId") ;
}) ;
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
    var ue_message = new baidu.editor.ui.Editor({
    	textarea : 'zd_message',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_message.render('editor_message');
    ue_message.addListener("selectionchange",function(){
	    var state_message = ue_message.queryCommandState("source");
	    document.getElementById("zd_message").value=ue_message.getContent();
	});
	
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>