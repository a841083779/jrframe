<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String subblock_uuid = CommonString.getFormatPara(request.getParameter("subblock_uuid"));
	String uuid = CommonString.getFormatPara(request.getParameter("id"));
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = tablePrefix + "common_channel_subblock_data";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	try{
		connection = dbHelper.getConnection();
		if(null!=uuid&&!"".equals(uuid)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid  = ? ",new Object [] {uuid} , connection);
			subblock_uuid = CommonString.getFormatPara(model.get("subblock_uuid"));
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y: auto; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv" style="width: 650px;">
				<div class="group">
					<span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span>
					<span class="groupTitle">基础信息</span>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">标<span class="span2"></span>题</div>
				<div class="formRight">
					<input type="text" dataType="Require" msg="请您输入标题！" class="jr_text" style="width: 380px;" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">图<span class="span2"></span>片</div>
				<div class="formRight">
					<input type="text" readonly="readonly" class="jr_text" style="width: 380px;" name="zd_img" id="zd_img" value="<%=CommonString.getFormatPara(model.get("img")) %>" />
				</div>
				<div class="formRight" style="padding-left: 130px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img');" value="选择图片" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">外<span class="span2"></span>链</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width: 380px;" name="zd_url" id="zd_url" value="<%=CommonString.getFormatPara(model.get("url")) %>" />
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">是否显示</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio("1","zd_is_show") %>
				</div>
				<div style="clear: left; "></div>
				<div class="formLeft">介<span class="span2"></span>绍</div>
				<div class="formRight" style="text-align: left;">
					<script type="text/plain" id="editor_intro" style="width:520px; height:200px;"><%=CommonString.getFormatPara(model.get("intro")) %></script>
					<input type="hidden" name="zd_intro" id="zd_intro" value="<%=CommonString.getFormatPara(model.get("intro")) %>" />
				</div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
		<input type="hidden" name="zd_subblock_uuid" id="zd_subblock_uuid" value="<%=subblock_uuid %>" />
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
						if("".equals(uuid)){
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
    var ue_intro = new baidu.editor.ui.Editor({
   		textarea : 'zd_intro',
   		minFrameHeight:170
    });
    ue_intro.render('editor_intro');
    ue_intro.addListener("selectionchange",function(){
	    var state_intro = ue_intro.queryCommandState("source");
	    document.getElementById("zd_intro").value=ue_intro.getContent();
	});
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>