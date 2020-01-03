<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_agent_personnel";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,name,province";
	int id=CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("id")));
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = " and agent_id= "+id;
	String orderByStr = " id desc ";
	Map inner = new HashMap() ;
	inner.put("","全部") ;
	inner.put("1","显示") ;
    inner.put("0","不显示") ;
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
   <style type="text/css">
	.l-grid-body-table tr td{
	 height:30px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
  	<div class="searchForm">
  		<div class="searchCondition" style="width:400px;">
		  		<div class="searchLeft">业务员名称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="full_name" id="full_name" />
		  		</div>
		  		
  		</div>
  		<div class="searchBtn" style="width:200px;">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />&nbsp;&nbsp;
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
		params.push({'name':'fields','value':fields});
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
					rownumbers : true
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '业务员名称', name : 'name', align : 'left' , type : 'string' , width : 200 ,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
	  }
	},
	{ display : '分管省份', name : 'name', align : 'left' , type : 'string' , width : 200 ,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.province+"</a>";
	  }
	} 	
	
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:200,
	    		title:'增加',
	    		fileName:"pro_agent_personnel" ,
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:200,
	    		title:'修改',
	    	    fileName:"pro_agent_personnel" 
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
		var full_name = jQuery("#full_name").val();
		if(''!=jQuery.trim(full_name)){
			conditionStr += " and name like '%"+full_name+"%' ";
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