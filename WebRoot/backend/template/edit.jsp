<#function fun_va dataType msg>
	<#local lmsg=msg />
	<#local message="" />
	<#if lmsg!=''>	
		<#local message=" dataType='"+dataType+"' msg='"+lmsg+"'" />
	</#if>
	<#return message />
</#function>
<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "${table}";
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
<#list name as n>
	<#if type[n_index]=='editor'>
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
    <link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
		<#break />
	</#if>
</#list>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
		<#list name as n>
			<#if type[n_index]=='is'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("${n}")),"zd_${n}") %>
				</div>
				<div style="clear:left;"></div>
			<#elseif type[n_index]=='sex'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight">
					<%=CommonForm.createSexRadio(CommonString.getFormatPara(model.get("${n}")),"zd_${n}") %>
				</div>
				<div style="clear:left;"></div>
			<#elseif type[n_index]=='date'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight">
					<input type="text"${fun_va(validator[n_index],validator_txt[n_index])} class="jr_text" name="zd_${n}" id="zd_${n}" value="<%=CommonString.getFormatPara(model.get("${n}")) %>" />
				</div>
				<div style="clear:left;"></div>
			<#elseif type[n_index]=='number'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight">
					<input type="text"${fun_va(validator[n_index],validator_txt[n_index])} class="jr_text" name="zd_${n}" id="zd_${n}" value="<%=CommonString.getFormatPara(model.get("${n}")) %>" />
				</div>
				<div style="clear:left;"></div>
			<#elseif type[n_index]=='text'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight">
					<input type="text"${fun_va(validator[n_index],validator_txt[n_index])} class="jr_text" name="zd_${n}" id="zd_${n}" value="<%=CommonString.getFormatPara(model.get("${n}")) %>" />
				</div>
				<div style="clear:left;"></div>
			<#elseif type[n_index]=='select'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight">
					<select${fun_va(validator[n_index],validator_txt[n_index])} class="jr_select" name="zd_${n}" id="zd_${n}"><%=CommonForm.createSelect(null,CommonString.getFormatPara(model.get("${n}"))) %></select>
				</div>
				<div style="clear:left;"></div>
			<#elseif type[n_index]=='radio'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight"><%=CommonForm.createRadio(null,CommonString.getFormatPara(model.get("${n}")),"zd_${n}") %></div>
				<div style="clear:left;"></div>
			<#elseif type[n_index]=='checkbox'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight"><%=CommonForm.createCheckbox(null,CommonString.getFormatPara(model.get("${n}")),"zd_${n}") %></div>
			<#elseif type[n_index]=='textarea'>
				<div class="formLeft">${display_name[n_index]}</div>
				<div class="formRight">
					<textarea${fun_va(validator[n_index],validator_txt[n_index])} class="jr_textarea" name="zd_${n}" id="zd_${n}"><%=CommonString.getFormatPara(model.get("${n}")) %></textarea>
				</div>
				<div style="clear:left;"></div>
			</#if>
		</#list>
		<#list name as n>
			<#if type[n_index]=='editor'>
			<div class="formLeft">${display_name[n_index]}</div>
			<div class="formRight" style="height: 300px; text-align: left;">
				<script type="text/plain" id="editor_${n}" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("${n}")) %></script>
				<input type="hidden"${fun_va(validator[n_index],validator_txt[n_index])} name="zd_${n}" id="zd_${n}" value="<%=CommonString.getFormatPara(model.get("${n}")) %>" />
			</div>
			<div style="clear:left;"></div>
			</#if>
		</#list>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_channel_uuid" id="zd_channel_uuid" value="<%=channelUUID %>" />
		<#list name as n>
			<#if type[n_index]=='hidden'>
		<input type="${type[n_index]}" name="zd_${n}" id="zd_${n}" value="<%=CommonString.getFormatPara(model.get("${n}")) %>" />
			</#if>
		</#list>
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
<#list name as n>
	<#if type[n_index]=='editor'>
    var ue_${n} = new baidu.editor.ui.Editor({
    	textarea : 'zd_${n}',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_${n}.render('editor_${n}');
    ue_${n}.addListener("selectionchange",function(){
	    var state_${n} = ue_${n}.queryCommandState("source");
	    document.getElementById("zd_${n}").value=ue_${n}.getContent();
	});
	</#if>
</#list>
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>