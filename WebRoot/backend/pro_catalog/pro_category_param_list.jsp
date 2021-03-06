﻿<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = "pro_catalog_param";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String category = CommonString.getFormatPara(request.getParameter("category"));//类别编号
	String fileds = "id,uuid,parent_no,no,name,type,enum_no,is_search,is_key,is_show,order_no,category_id";
	String whereStr = " and parent_no = '"+category+"' ";
	String orderByStr = " order_no desc,no asc "; 
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
	var tableName = "<%=tableName %>";
	var fields = "<%=fileds %>";
	var whereStr = "<%=whereStr %>";
	var orderBy = "<%=orderByStr %>";
	var channelUUID = '<%=channelUUID%>';
	var columnsArr = [];
	var url = "";
	var conditionStr = "";
	var params = [];
	jQuery(function() {
		params.push({'name':'enumNo','value':'106013','fileName':'test'});
		grid = new Dev21sunGrid({usePager : true,
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
										toolbarDel();
									},
									icon : 'delete'
								}, {
									text : '插入父类别参数',
									click : function(){
										insertParent('<%=category%>');
									},
									icon : 'add'
								}]
					}});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '参数名称', name : 'name'  , id : 'no', align : 'left' , type : 'string' , width : 200 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
			}
		} ,
		
	{ display : '项目类别', name : 'is_key', align : 'center' , type : 'string' , width : 70 ,render : function(row){

	
			var operateStr="";
			$.ajax({
				async:false,
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:{flag:"category_name",category_id:row.category_id},
				success:function(result){
					operateStr=$.trim(result);
				}
			});
			return operateStr;

	
		}
	} ,
	
	{ display : '核心参数', name : 'is_key', align : 'center' , type : 'string' , width : 70 ,render : function(row){
			if(row.is_key==1){
				return "是";
			}
			return "否";
		}
	} ,
	{ display : '同级排序', name : 'order_no', align : 'center' , type : 'string' , width : 80 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick=commonSort({tableName:\"<%=tableName %>\",enumNo:\"106013\",value:\""+row.parent_no+"\"});>同级排序</a>";
	} }
	];
	function addAndEdit(index){
		if(undefined==index){//如果是增加
			toolbarAdd({
				width:800,
				height:600,
				title:"增加",
				fileName:"pro_category_param1",
				folderName:'pro_catalog',
				params : {
	    			channel_uuid : "<%=channelUUID %>",
					category : "<%=category%>"
	    		}
			});
		}else{//如果是修改
	    	var row = grid.getRow(index);
	    	toolbarAdd({
	    		width:600,
	    		height:200,
	    		title:'编辑',
	    		fileName:"pro_category_param",
	    		folderName:'pro_catalog',
	    		},
	    		row.uuid);
		}
    }
	
	function insertParent(category){
		if(category == null || category.length <= 3){
			alert("已没有父类别");	
			return false;
		}		
		if(confirm("确认插入？")){
			jQuery.ajax({
					url:"/backend/action/ajax_cud.jsp",
					data:{'flag':'insertParent','category':category,'enumNo':'106001'},
					method:"post",
					success:function(data){
						if(jQuery.trim(data)=="ok"){
						alert("插入成功") ;
							//window.location.reload();
						}
					}
				})
		}
	}
</script>