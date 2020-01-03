<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix + "common_template";
	String fileds = "id,uuid,name,template_file_name,create_file_name";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String whereStr = " and channel_uuid = '"+channelUUID+"' ";
	String orderByStr = " id desc ";
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
  <body>
  	<div class="searchForm">
  		<div class="searchCondition" style="width: 73%">
		  		<div class="searchLeft">模板名称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="name" id="name" />
		  		</div>
		  		<div class="searchLeft">模板路径</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="template_file_name" id="template_file_name" />
		  		</div>
		  		<div class="searchLeft">生成路径</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="create_file_name" id="create_file_name" />
		  		</div>
  		</div>
  		<div class="searchBtn" style="width: 23%;">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
  		</div>
  	</div>
  	<div style="clear: left;"></div>
  	
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div id="maingrid" style="margin: 0; padding: 0"></div>
	<div style="display: none;">
		<input type="hidden" name="channel_uuid" id="channel_uuid" value="<%=channelUUID %>" />
	</div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript">
	var grid;
	var tableName = "<%=tableName %>";
	var fields = "<%=fileds %>";
	var whereStr = "<%=whereStr %>";
	var orderBy = "<%=orderByStr %>";
	var columnsArr = [];
	var url = "";
	var conditionStr = "";
	var params = [];
	jQuery(function() {
		jQuery.ligerDefaults.Grid.formatters['date'] = function(content,
				column) {
			return content.substring(0, content.indexOf(' '));
		}
		jQuery.ligerDefaults.Grid.formatters['is'] = function(content,
				column) {
			if (content == 1) {
				return '是';
			}
			return '否';
		}
		jQuery.ligerDefaults.Grid.formatters['sex'] = function(content,
				column) {
			if (content == 1) {
				return '男';
			}
			return '女';
		}
		url = "/backend/action/liger.jsp";
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':whereStr});
		params.push({'name':'orderBy','value':orderBy});
		grid = jQuery("#maingrid").ligerGrid({
					columns : columnsArr,
					url : url,
					pageSize : 20,
					width : '99%',
					height : '98%',
					checkbox : true,
					selectRowButtonOnly : true,
					parms : params,
					rownumbers : true,
					toolbar : {
						items : [{
									text : '增加',
									click : function(){
										toolbarAdd({
											width:700,
											height:270,
											params:{
												channel_uuid:'<%=channelUUID %>'
											},
											title:"扩展模板增加"
										});
									},
									icon : 'add'
								}, {
									text : '删除',
									click : function(){
										toolbarDel({
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'delete'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '模板名称', name : 'name', align : 'left' , type : 'string' , width : 200 , render : function(row){
			return "<a class='link' href='javascript:void(0);' onclick='toolbarAdd({title:\"扩展模板编辑\",width:700,height:270},\""+row.uuid+"\");'>"+row.name+"</a>"
		}
	} ,
	{ display : '模板路径', name : 'template_file_name', align : 'left' , type : 'string' , width : 200 } ,
	{ display : '生成路径', name : 'create_file_name', align : 'left' , type : 'string' , width : 200 } 
	];
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
		}
		var template_file_name = jQuery("#template_file_name").val();
		if(''!=jQuery.trim(template_file_name)){
			conditionStr += " and template_file_name like '%"+template_file_name+"%' ";
		}
		var create_file_name = jQuery("#create_file_name").val();
		if(''!=jQuery.trim(create_file_name)){
			conditionStr += " and create_file_name like '%"+create_file_name+"%' ";
		}
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':whereStr+conditionStr});
		params.push({'name':'orderBy','value':orderBy});
		grid.options.parms=params;
		grid.loadData();
	}
	
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
	}
</script>