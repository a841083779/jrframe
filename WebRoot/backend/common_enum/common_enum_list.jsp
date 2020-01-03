<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix+"common_enum";
	String fileds = "id,uuid,no,name,is_show,order_no";
	String whereStr = "";
	String orderByStr = " order_no desc , no asc ";
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
  	
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div id="maingrid" style="margin: 0; padding: 0"></div>
	<div style="display: none;"></div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
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
		var url = "/backend/action/ajax_r.jsp";
		params.push({'name':'flag','value':'eunm_tree'});
		params.push({'name':'whereStr','value':whereStr});
		params.push({'name':'orderByStr','value':orderBy});
		params.push({'name':'tableName','value':'<%=tableName%>'});
		grid = jQuery("#maingrid").ligerGrid({
					columns : columnsArr,
					url : url,
					pageSize : 20,
					width : '99%',
					height : '98%',
					checkbox : true,
					parms : params,
					selectRowButtonOnly : true,
					rownumbers : true,
					alternatingRow : false ,
					usePager : false ,
					tree : {
						columnId: 'no'
					} ,
					toolbar : {
						items : [{
									text : '增加',
									click : function(obj){
										addAndEdit();
									},
									icon : 'add'
								}, {
									text : '删除',
									click : function(){
										toolbarDel({
											'eventAfter':'updateApplicationEnum'
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
	
	{ display : '名称', name : 'name'  , id : 'no', align : 'left' , type : 'string' , width : 600 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
			}
		} ,
	{ display : '编号', name : 'no', align : 'left' , type : 'string' , width : 150 } ,
	{ display : '是否显示', name : 'is_show', align : 'center' , type : 'string' , width : 150 ,render : function(row){
			if(row.is_show==1){
				return "是";
			}
			return "否";
		}
	} ,
	{ display : '同级排序', name : 'order_no', align : 'center' , type : 'string' , width : 150 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick=commonSort({tableName:\"<%=tableName %>\",value:\""+row.parent_no+"\"});>同级排序</a>";
	} } 
	];
	function addAndEdit(index){
		if(undefined==index){//如果是增加
			toolbarAdd({
				width:700,
				height:320,
				title:"增加枚举"
			});
		}else{//如果是修改
	    	var row = grid.getRow(index);
	    	toolbarAdd({width:700,height:320,title:'枚举编辑'},row.uuid);
		}
    }
</script>