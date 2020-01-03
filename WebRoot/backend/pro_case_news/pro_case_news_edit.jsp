<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_case_news";
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
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
    <link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
			<div class="group">
				 <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/></span> 
				 <span class="groupTitle">案例信息</span>
		     </div>
				<div class="formLeft">标<span class="span2">&nbsp;</span>题</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入标题' class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">浏<span class="span3">&nbsp;</span>览<span class="span3">&nbsp;</span>量</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_view_count" id="zd_view_count" value="<%=CommonString.getFormatPara(model.get("view_count")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">回<span class="span3">&nbsp;</span>复<span class="span3">&nbsp;</span>量</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_reply_count" id="zd_reply_count" value="<%=CommonString.getFormatPara(model.get("reply_count")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">地<span class="span2">&nbsp;</span>址</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入地址' class="jr_text" name="zd_address" id="zd_address" value="<%=CommonString.getFormatPara(model.get("address")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">发<span class="span3">&nbsp;</span>布<span class="span3">&nbsp;</span>者</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入发布者姓名' class="jr_text" name="zd_username" id="zd_username" value="<%=CommonString.getFormatPara(model.get("username")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">发布日期</div>
				<div class="formRight">
					<input type="text" name="zd_pub_date" id="zd_pub_date" value="<%=CommonString.getFormatPara(model.get("pub_date"))%>" />
				</div>
				<div style="clear:left;"></div>
			    <div class="formLeft">是否显示</div>
			    <div class="formRight"> <%=CommonForm.createIsRadio((CommonString.getFormatPara(model.get("is_approval")).equals("")?"0":CommonString.getFormatPara(model.get("is_approval"))),"zd_is_approval") %> </div>
			    <div style="clear:left;"></div>
			<div class="formLeft">内<span class="span2">&nbsp;</span>容</div>
			<div class="formRight" style="height: 300px; text-align: left;">
				<script type="text/plain" id="editor_content" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("content")) %></script>
				<input type="hidden" dataType='Require' msg='请输入内容' name="zd_content" id="zd_content" value="<%=CommonString.getFormatPara(model.get("content")) %>" />
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
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/javascript"></script>
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
    var ue_content = new baidu.editor.ui.Editor({
    	textarea : 'zd_content',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_content.render('editor_content');
    ue_content.addListener("selectionchange",function(){
	    var state_content = ue_content.queryCommandState("source");
	    document.getElementById("zd_content").value=ue_content.getContent();
	});
	jQuery("#zd_pub_date").ligerDateEditor({width:150});
	jQuery("#zd_address").val(remote_ip_info['province']+remote_ip_info['city']) ;
	jQuery("#zd_pub_date").val('<%=CommonString.getFormatPara(model.get("pub_date")).equals("")?CommonDate.getToday("yyyy-MM-dd"):CommonString.getFormatPara(model.get("pub_date"))%>') ;
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>