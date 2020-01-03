<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_member";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String pro_id = CommonString.getFormatPara(request.getParameter("id")) ;
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = " ";
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
  		<div class="searchCondition" style="width:800px;">
			  		<div class="searchLeft">用户名</div>
			  		<div class="searchRight">
			  			<input type="text" style="width: 100px;" class="jr_text" name="username" id="username" />
			  		</div>
		  		<div class="searchLeft">注册时间</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" name="start_add_date" id="start_add_date" />
		  		</div>
		  		<div class="searchLeft" style="width:10px;">~</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" name="end_add_date" id="end_add_date" />
		  		</div>
  		</div>
  		<div class="searchBtn" style="width:300px;">
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
						items : [  {
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
	{ display : '用户名', name : 'username', align : 'left' , type : 'string' , width : 200 ,render:function(row){
	  return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.username+"</a>";
	  }
	} ,
	{ display : '注册时间', name : 'add_date', align : 'center' , type : 'date' , width : 100 } ,
	{ display : '是否可用', name : 'state', align : 'center' , type : 'string' , width : 100 ,render:function(row){
	  return ((jQuery.trim(row.state)==1)?"<font color='green'>是</font>":"<font color='red'>否</font>") ;
	 }
	} 
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:550,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:700,
	    		height:550,
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
		var username = jQuery("#username").val();
		if(''!=jQuery.trim(username)){
			conditionStr += " and username like '%"+username+"%' ";
		}
		var start_add_date = jQuery("#start_add_date").val() ;
		if(''!=jQuery.trim(start_add_date))
		{
		   conditionStr += " and add_date >='"+start_add_date+" 00:00:00' ";
		}
		var end_add_date = jQuery("#end_add_date").val() ;
		if(''!=jQuery.trim(end_add_date))
		{
		    conditionStr += " and add_date<='"+end_add_date+" 23:59:59'" ;
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
   jQuery("#start_add_date").ligerDateEditor({width:150});
   jQuery("#end_add_date").ligerDateEditor({width:150});
   	// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
	 }
</script>