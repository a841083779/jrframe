<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_charge_members";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,factoryname,address,catalogname,membercategory";
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
  		<div class="searchCondition">
		  		<div class="searchLeft">会员名字</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="factoryname" id="factoryname" />
		  		</div>
		  		<div class="searchLeft">地区</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="address" id="address" />
		  		</div>
		  		<div class="searchLeft">类别号</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="catalogname" id="catalogname" />
		  		</div>
		  		<div class="searchLeft">会员类别</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="membercategory" id="membercategory" />
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
	
	{ display : '会员名字', name : 'factoryname', align : 'center' , type : 'string' , width : 200,render:function(row){
 		return "<a class='link' href='javascript:;' title='"+row.factoryname+"' onclick='addAndEdit("+row.__index+");'>"+row.factoryname+"</a>" ;
		} } ,
	{ display : '地区', name : 'address', align : 'center' , type : 'string' , width : 200 } ,
	{ display : '类别号', name : 'catalogname', align : 'center' , type : 'string' , width : 200 } ,
	{ display : '会员类别', name : 'membercategory', align : 'center' , type : 'string' , width : 200 } ,
	{ display : '添加日期', name : 'pub_date', align : 'center' , type : 'time' , width : 200,render:function(row){
	 return row.pub_date.substring(0,16) ;
		} } 
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
		var factoryname = jQuery("#factoryname").val();
		if(''!=jQuery.trim(factoryname)){
			conditionStr += " and factoryname like '%"+factoryname+"%' ";
		}
		var address = jQuery("#address").val();
		if(''!=jQuery.trim(address)){
			conditionStr += " and address like '%"+address+"%' ";
		}
		var catalogname = jQuery("#catalogname").val();
		if(''!=jQuery.trim(catalogname)){
			conditionStr += " and catalogname like '%"+catalogname+"%' ";
		}
		var membercategory = jQuery("#membercategory").val();
		if(''!=jQuery.trim(membercategory)){
			conditionStr += " and membercategory like '%"+membercategory+"%' ";
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