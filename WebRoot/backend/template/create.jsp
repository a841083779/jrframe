<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>创建页</title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div id="maingrid4" style="margin: 0; padding: 0"></div>
	<div style="display: none;"></div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/dialog.js" type="text/javascript"></script>
<script type="text/javascript">
	var grid;
	jQuery(function (){
		var url = "/backend/template/action.jsp?flag=tables";
		grid = jQuery("#maingrid4").ligerGrid({
			columns : [ 
						{ display : '表名', name : 'name', align : 'left' , type : 'string' , width : 500 } ,
						{ display : '创建列表页', align : 'center' , type : 'string' , width : 100 , render :function(row){
							return "<a href='/backend/template/create_list.jsp?name="+row.name+"'>创建</a>";
						}} ,
						{ display : '创建编辑页', align : 'center' , type : 'string' , width : 100 , render :function(row){
							return "<a href='/backend/template/create_edit.jsp?name="+row.name+"'>创建</a>";
						}} 
			] ,
			url : url, 
			pageSize : 20,
			width : '99%',
			height : '98%',
			checkbox : false,
			rownumbers : true,
			selectRowButtonOnly : true,
			usePager : false
		});
		jQuery("#pageloading").hide();
	});
</script>