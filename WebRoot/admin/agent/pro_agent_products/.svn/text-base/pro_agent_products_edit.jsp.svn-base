<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_agent_product_vi";
	String agentid = CommonString.getFormatPara(request.getParameter("id")) ;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = " ";
	if(!"".equals(agentid)){
		whereStr += " and agentid="+agentid ;
	}
	String orderByStr = " id desc ";
	CommonForm commonForm = new CommonForm() ;
	
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
										deleteData({
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
	{ display : '', name : 'img1', align : 'left' , type : 'string' , width : 50,render:function(row){
	   return "<img src='/uploadfiles/x_"+row.img1+"' width='100%' height='100%' title='"+row.name+"' onerror='this.src=\"/uploadfiles/no_small.gif\"'>" ;
	  }
	} ,
	{ display : '型号', name : 'name', align : 'center' , type : 'string' , width : 150 } ,
	{ display : '品牌', name : 'factoryname', align : 'center' , type : 'string' , width : 150 } ,
	{ display : '类别', name : 'catalogname', align : 'center' , type : 'string' , width : 150  } ,
	{ display : '厂家价格', name : 'agentprice', align : 'center' , type : 'string' , width : 170,render:function(row){
	     return row.agentprice=="null"?"-":row.agentprice;
	  } }
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:620,
	    		title:'增加',
	    		fileName:"pro_agent_products_add" ,
	    		folderName:"pro_agent_factory",
	    		params : {
	    			channel_uuid : "<%=channelUUID %>",agentid:"<%=agentid%>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:720,
	    		title:'修改',
	    	    fileName:"pro_agent_factory_agent"
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
			conditionStr += " and full_name like '%"+full_name+"%' ";
		}
		var inner = jQuery(".jr_radio:checked").val() ;
		if(''!=jQuery.trim(inner))
		{
		  conditionStr += " and is_show ='"+inner+"'";
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
		function openWin(id){
		jrWindow("/backend/pro_agent_factory/pro_agent_products_eidt.jsp?id="+id,"导入产品",900,600);	
	}
	
	function deleteData(arg) {
	if (arg == undefined || arg == null) {
		arg = {};
	}
	var checkedRows = grid.getCheckedRows();
	if (checkedRows.length <= 0) {
		return;
	}
	// 遍历所有的选中行，如果是没有UUID，则移除
	jQuery.each(checkedRows, function(index, data) {
				if (this.agentproductuuid == undefined) {
					jrDeleteRow(this.__index);
				}
			});
	jrConfirm("确定删除选中项吗？", function(v) {
				if (v) {
					var checkedRows = grid.getCheckedRows();
					var idStr = "";
					for (var i = 0; i < checkedRows.length; i++) {
						idStr += "'" + checkedRows[i].agentproductuuid + "',";
					}
					if (idStr.indexOf(",") != -1) {
						idStr = idStr.substring(0, idStr.length - 1);
					}
					arg.del_id = idStr;
					if(undefined==arg.tableName){
						arg.tableName = tableName;
					}
					arg.tableName = "pro_agent_products" ;  // 更改删除表
			 		executeDel(arg);
				}
			});
}
	function doSub(){
		return true ;
	}
</script>