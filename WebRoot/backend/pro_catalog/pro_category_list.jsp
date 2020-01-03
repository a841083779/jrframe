<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = "pro_category";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String category = CommonString.getFormatPara(request.getParameter("category"));//类别编号
	String fileds = "*";
	String whereStr = " and parent_no = '"+category+"' ";
	String orderByStr = " order_no desc,id desc "; 
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
		grid = new Dev21sunGrid({usePager : false,
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
								}]
					}});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '项目名称', name : 'name'  , id : 'no', align : 'left' , type : 'string' , width : 200 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
			}
		} ,


	{ display : '同级排序', name : 'order_no', align : 'center' , type : 'string' , width : 80 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick=commonSort({tableName:\"<%=tableName %>\",enumNo:\"106013\",value:\""+row.parent_no+"\"});>同级排序</a>";
	} }
	];
	function addAndEdit(index){
		if(undefined==index){//如果是增加
			toolbarAdd({
				width:550,
				height:120,
				title:"增加",
				fileName:"pro_category",
				folderName:'pro_catalog',
				params : {
	    			channel_uuid : "<%=channelUUID %>",
					category : "<%=category%>"
	    		}
			});
		}else{//如果是修改
	    	var row = grid.getRow(index);
	    	toolbarAdd({
	    		width:550,
	    		height:120,
	    		title:'编辑',
	    		fileName:"pro_category",
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