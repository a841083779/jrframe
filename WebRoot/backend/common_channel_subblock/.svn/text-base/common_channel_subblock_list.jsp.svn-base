<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix+"common_channel_subblock ccs , "+tablePrefix+"common_acl_channel_subblock cacs";
	String fileds = " ccs.uuid,ccs.name,ccs.data_key,ccs.is_data,ccs.is_show ";
	String whereStr = " and ccs.uuid = cacs.subblock_uuid ";
	whereStr += " and cacs.channel_uuid = '"+channelUUID+"' ";
	String orderByStr = " ccs.order_no desc , ccs.id desc ";
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
											eventAfter : "deleteChannelSubblock",
											tableName : "<%=tablePrefix %>common_channel_subblock"
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
		{ display : '元素名称', name : 'name', align : 'left' , type : 'string' , frozen : true , width : 200 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
			}
		} ,
		{ display : '模板访问名称', name : 'data_key', align : 'left' , type : 'string' , width : 200  } ,
		{ display : '是否录入数据', name : 'is_data', align : 'center' , type : 'is' , width : 100 } ,
		{ display : '是否显示', name : 'is_show', align : 'center' , type : 'is' , width : 100 } 
	];
    function addAndEdit(index){
    	if(undefined==index){//如果是增加
			toolbarAdd({
				width:710,
				height:420,
				title:"元素增加",
				folderName : "<%=tablePrefix %>common_channel_subblock",
				fileName : "<%=tablePrefix %>common_channel_subblock",
				params : {
					channel_uuid : "<%=channelUUID %>"
				}
			});
    	}else{//如果是修改
	    	var row = grid.getRow(index);
	    	toolbarAdd({
	    		width:710,
	    		height:420,
	    		folderName : "<%=tablePrefix %>common_channel_subblock",
				fileName : "<%=tablePrefix %>common_channel_subblock",
	    		title:"元素编辑"
	    	},row.uuid);
    	}
    }
</script>