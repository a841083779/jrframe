<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_index_data";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String whereStr = " and channel_uuid='"+channelUUID+"'";
	String orderByStr = " order_no  asc ";
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" type="text/css"></link>
	<style type="text/css">
	.l-grid-body-table tr td{
	 height:30px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script></head>
  <body>
  
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
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
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
								},{
									text : '生成静态页',
									click : function(){
										create();
									},
									icon : 'settings'
								},{
									text : '生成页面预览',
									click : function(){
									
									window.open("/create/index_new/index_hunningtu.htm","_blank");
									
									},
									icon : 'config'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	    { display : '排序号', isSort : false , name : 'order_no', align : 'center' , type : 'string' , width : 100 },   
		{ display : '名称', name : 'title', isSort : false ,  id : 'no' , align : 'left' , type : 'string' , width : 250 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.title+"</a>";
			}
		},
		{ display : '是否显示', isSort : false , name : 'is_pub', align : 'center' , type : 'is' , width : 60 }
	];
	
	  //增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:500,
	    		title:'增加',
				fileName:"pro_hunningtu_F4/pro_hunningtu_F4",
				folderName:"pro_index",
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:700,
	    		height:500,
				fileName:"pro_hunningtu_F4/pro_hunningtu_F4",
				folderName:"pro_index",
	    		title:'修改'
	    	},row.uuid);
    	}
    }
//静态页生成
	function create(){
		jQuery.ajax({
			type:'post' ,
			url:'/tools/create_index_new/create_index_sub.jsp?cuuid=<%=channelUUID%>' ,
			success:function(data){
			if($.trim(data)=='true'){
			alert("静态更新成功！")	;
			}else{
			alert(data)	;
			}}
		}) ;
		
	}

	
</script>