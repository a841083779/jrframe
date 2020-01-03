<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "ad_search";
	// String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tablePrefix = "" ;
	String fileds = "id,add_user,add_date,uuid,title,intro,url,keyword,flag";
	 String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	//  String whereStr = " and channel_uuid = '"+channelUUID+"' ";
	String whereStr = "" ;
	String orderByStr = " id desc ";
	Map flagMap = new HashMap() ;
	flagMap.put("10","产品中心") ;
	flagMap.put("1","其它") ;
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
		  		<div class="searchLeft">添加者</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="add_user" id="add_user" />
		  		</div>
		  		<div class="searchLeft">添加日期</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" name="start_date" id="start_date" />
		  		</div>
		  		<div class="searchLeft" style="width:50px;">~</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" name="end_date" id="end_date" />
		  		</div>
		  		<div class="searchLeft">标题</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="title" id="title" />
		  		</div>
		  		<div style="clear:left;"></div>
		  		<div class="searchLeft">关键词</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="keyword" id="keyword" />
		  		</div>
		  		<div class="searchLeft">所属网站</div>
		  		<div class="searchRight">
		  		<select class="jr_select"  name="flag" id="flag" style="width:152px;">
		  		<option value="">--请选择--</option>
		  		<%=CommonForm.createSelect(flagMap,"0") %>
		  		</select>
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
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '标题', name : 'title', align : 'center' , type : 'string' , width : 150 ,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.title+"</a>";
	 }} ,
	{ display : '添加者', name : 'add_user', align : 'center' , type : 'string' , width : 133 } ,
	{ display : '添加日期', name : 'add_date', align : 'center' , type : 'datetime' , width : 200 ,render:function(row){
	 	return (row.add_date.length>=19)?row.add_date.substr(0,19):row.add_date ;
	 }} ,
	{ display : '链接', name : 'url', align : 'left' , type : 'string' , width : 400 } ,
	{ display : '关键词', name : 'keyword', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '所属网站', name : 'flag', align : 'center' , type : 'string' , width : 100 ,render:function(row){
		return (row.flag==10)?"产品中心":"其它";
	}} 
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
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var add_user = jQuery("#add_user").val();
		if(''!=jQuery.trim(add_user)){
			conditionStr += " and add_user like '%"+add_user+"%' ";
		}
		var start_date = jQuery("#start_date").val();
		if(''!=jQuery.trim(start_date)){
			conditionStr += " and add_date >= '"+start_date+" 00:00:00' ";
		}
		var end_date = jQuery("#end_date").val();
		if(''!=jQuery.trim(end_date)){
			conditionStr += " and add_date <="+end_date +" 23:59:59" ;
		}
		var title = jQuery("#title").val();
		if(''!=jQuery.trim(title)){
			conditionStr += " and title like '%"+title+"%' ";
		}
		var keyword = jQuery("#keyword").val();
		if(''!=jQuery.trim(keyword)){
			conditionStr += " and keyword like '%"+keyword+"%' ";
		}
		var flag = jQuery("#flag").val();
		if(''!=jQuery.trim(flag)){
			conditionStr += " and flag = '"+flag+"' ";
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
		  jQuery("#flag option:eq(0)").attr("selected",true) ;
	}
  jQuery("#start_date").ligerDateEditor({width:150});
  jQuery("#end_date").ligerDateEditor({width:150});
</script>