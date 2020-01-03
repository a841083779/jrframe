<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_sale_policy";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	//id,full_name,email,logo,is_show,is_inner,view_count,mobile,english_name
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String facId = CommonString.getFormatPara(request.getParameter("facId"));
	String whereStr = "  and 1=1" ;
	whereStr+=" and factoryid = "+facId;
	String orderByStr = " id desc ";
	CommonForm commonForm = new CommonForm() ;
	Map inner = new HashMap() ;
	inner.put("","全部") ;
	inner.put("1","国内") ;
    inner.put("0","国外") ;
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
	 height:35px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>

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
					enabledEdit: true,
					onAfterEdit:function(e){
					  if(e.column.columnname=='english_name'){ 
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'english_name',
					  				uid:e.record.uuid,
					  				value:e.value
					  			},
					  			type:'post'
					  		}) ;
					  } 
					},
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
	{ display : 'ID号', name : 'id', align : 'center' , type : 'string' , width : 150,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.id+"</a>";
	  }
	} ,
	{ display : '类别名称', name : 'catalogname', align : 'center' , type : 'string' , width : 300 
	} 
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:600,
	    		height:320,
	    		title:'增加',
	    		fileName:"pro_agent_sale_policy" ,
				folderName:"pro_agent_factory",
	    		params : {
	    			channel_uuid : "<%=channelUUID %>",
					facId:"<%=facId%>"
					
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:600,
	    		height:320,
	    		title:'修改',
	    	    fileName:"pro_agent_sale_policy" ,
				folderName:"pro_agent_factory"
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
			conditionStr += " and full_name like '%"+jQuery.trim(full_name)+"%' ";
		}
		var inner = jQuery(".jr_radio:checked").val() ;
		if(''!=jQuery.trim(inner)){
		  conditionStr += " and is_inner ='"+inner+"'";
		}
		var upper_index = jQuery("#upper_index").val() ;
		if(''!=jQuery.trim(upper_index)){
			conditionStr += " and upper_index ='"+jQuery.trim(upper_index)+"'" ;
		}
		var is_shop = jQuery("#is_shop").val();
		if(''!=jQuery.trim(is_shop)){
			conditionStr += " and is_shop = "+is_shop;
		}
		var is_qijiandian = jQuery("#is_qijiandian").val();
		if(''!=jQuery.trim(is_qijiandian)){
			conditionStr += " and is_qijiandian = "+is_qijiandian;
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