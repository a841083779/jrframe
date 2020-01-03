<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "${table}";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "<#list name as n><#if n_has_next>${n},<#else>${n}</#if></#list>";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
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
  <#if haveSearchForm??&&haveSearchForm>
  	<div class="searchForm">
  		<div class="searchCondition">
  		<#list search as s>
  			<#if s!=''>
		  		<div class="searchLeft">${display_name[s_index]}</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="${name[s_index]}" id="${name[s_index]}" />
		  		</div>
  			</#if>
  		</#list>
  		</div>
  		<div class="searchBtn">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
  		</div>
  	</div>
  	<div style="clear: left;"></div>
  </#if>
  	
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
										addAndEdit();
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
								}, {
									text : '栏目',
									click : function(){
										parent.f_addTab('<%=CommonString.getUUID() %>','<%=channelMap.get(channelUUID) %>栏目','/backend/common_channel/common_channel_edit.jsp?channel_uuid=<%=channelUUID %>');
									},
									icon : 'home'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
<#list name as n>
	<#if n_has_next>
	<#if n!='id'&&n!='uuid'>{ display : '${display_name[n_index]}', name : '${name[n_index]}', align : '${text_align[n_index]}' , type : '${type[n_index]}' , width : ${column_width[n_index]} } ,</#if>
	<#else>
	<#if n!='id'&&n!='uuid'>{ display : '${display_name[n_index]}', name : '${name[n_index]}', align : '${text_align[n_index]}' , type : '${type[n_index]}' , width : ${column_width[n_index]} } </#if>
	</#if>
</#list>
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:320,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:700,
	    		height:320,
	    		title:'修改'
	    	},row.uuid);
    	}
    }
<#if haveSearchForm??&&haveSearchForm>
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		<#list search as s>
  			<#if s!=''>
		var ${name[s_index]} = jQuery("#${name[s_index]}").val();
		if(''!=jQuery.trim(${name[s_index]})){
			<#if s=='eq'>
			conditionStr += " and ${name[s_index]} = '"+${name[s_index]}+"' ";
			<#elseif s=='like'>
			conditionStr += " and ${name[s_index]} like '%"+${name[s_index]}+"%' ";
			</#if>
		}
  			</#if>
 			</#list>
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
</#if>
</script>