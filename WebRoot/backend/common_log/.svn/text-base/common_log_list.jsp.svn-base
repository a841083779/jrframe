<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String tableName = table_prefix+"common_log";
	String fileds = "id,add_user,add_date,add_ip,uuid,channel_name,content,type";
	String whereStr = " and log_level = 0 ";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	if(adminInfo.get("usern").equals("admin")){
		whereStr = "";
	}
	String orderByStr = " id desc ";
	DBHelper dbHelper = DBHelper.getInstance();
	List types = dbHelper.getMapList(" select no,name from "+table_prefix+"common_enum where parent_no = '101' and is_show = 1 order by no ");
	Map typeMap = new TreeMap();
	typeMap.putAll(CommonCollection.listToMap(types,"no","name"));
	typeMap.put("","--请选择--");
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
  		<div class="searchCondition">
	  		<div class="searchLeft">操作类型</div>
	  		<div class="searchRight">
	  			<select name="type" id="type" class="jr_select">
	  				<%=CommonForm.createSelect(typeMap,"") %>
	  			</select>
	  		</div>
			<div class="searchLeft">操<span class="span3"></span>作<span class="span3"></span>者</div>
	  		<div class="searchRight">
	  			<input type="text" style="width:150px;" name="add_user" class="jr_text" id="add_user" />
	  		</div>
			<div class="searchLeft">操作日期</div>
	  		<div class="searchRight">
	  			<input type="text" name="add_date" id="add_date" />
	  		</div>
  		</div>
  		<div class="searchBtn">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
  		</div>
  	</div>
  	<div style="clear: left;"></div>
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div id="maingrid" style="margin: 0; padding: 0"></div>
	<div style="display: none;"></div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script type="text/javascript">
	var grid;
	var tableName = '<%=tableName %>';
	var fields = '<%=fileds %>';
	var whereStr = '<%=whereStr %>';
	var orderBy = '<%=orderByStr %>';
	var columnsArr = [];
	var url = '';
	var conditionStr = '';
	var main = '';
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
					checkbox : false,
					selectRowButtonOnly : true,
					parms : params,
					rownumbers : true
				});
		jQuery("#pageloading").hide();
	});
	
	//列数组
	columnsArr =  [
	{ display : '操作者', name : 'add_user', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '添加日期', name : 'add_date', align : 'center' , type : 'string' , width : 200 } ,
	{ display : '操作者IP', name : 'add_ip', align : 'center' , type : 'string' , width : 100 } ,
	{ display : '频道名称', name : 'channel_name', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '操作内容', name : 'content', align : 'left' , type : 'string' , width : 500 , render : function(row){
			return "<span title='"+row.content+"'>"+row.content+"</span>";
		}
	} ,
	{ display : '操作类型', name : 'type', align : 'center' , type : 'string' , width : 100 , render : function(row){
			return getEnum(row.type);
		}
	} 
	];
	
	jQuery("#add_date").ligerDateEditor({width:150});
	
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var type = jQuery("#type").val();
		if(''!=jQuery.trim(type)){
			conditionStr += " and type = '"+type+"' ";
		}
		var add_user = jQuery("#add_user").val();
		if(''!=jQuery.trim(add_user)){
			conditionStr += " and add_user like '%"+add_user+"%' ";
		}
		var add_date = jQuery("#add_date").val();
		if(''!=jQuery.trim(add_date)){
			conditionStr += " and Datename(year,add_date)+'-'+Datename(month,add_date)+'-'+Datename(day,add_date) = '"+add_date+"' ";
		}
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':conditionStr});
		params.push({'name':'orderBy','value':orderBy});
		grid.options.parms=params;
		grid.loadData();
	}
	
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
	}
</script>