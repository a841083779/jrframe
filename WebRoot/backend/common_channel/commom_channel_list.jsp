<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix+"common_channel";
	String fileds = "parent_uuid,uuid,name,template_file_name,create_file_name,is_show";
	String whereStr = "";
	String orderByStr = " order_no desc , id asc ";
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
	<div id="maingrid_tree" style="margin: 0; padding: 0"></div>
	<div style="display: none;"></div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript">
	jQuery.ligerDefaults.Grid.formatters['is'] = function(content,
			column) {
		if (content == 1) {
			return '是';
		}
		return '否';
	}
	var grid;
	var tableName = "<%=tableName %>";
	var fields = "<%=fileds %>";
	var whereStr = "<%=whereStr %>";
	var orderBy = "<%=orderByStr %>";
	var columnsArr = [];
	var url = "";
	var conditionStr = "";
	var params = [];
	//列数组
	columnsArr =  [ 
		{ display : '名称', name : 'name', isSort : false ,  id : 'no' , align : 'left' , type : 'string' , width : 250 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
			}
		} ,
		{ display : '模板名称', isSort : false , name : 'template_file_name', align : 'left' , type : 'string' , width : 200 } ,
		{ display : '文件名称', isSort : false , name : 'create_file_name', align : 'left' , type : 'string' , width : 200 } ,
		{ display : '是否显示', isSort : false , name : 'is_show', align : 'center' , type : 'is' , width : 60 },
		{ display : '元素管理', align : 'center' , type : 'is' , width : 100 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='toolbarSubblock(\""+row.uuid+"\");'>元素</a>";
			}
		},{ display : '同级排序', align : 'center' , width : 100 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick=commonSort({tableName:\"<%=tableName %>\",value:\""+row.parent_uuid+"\"});>同级排序</a>";
			}
		}
	];
	
	jQuery(function(){
		var url = "/backend/action/ajax_r.jsp";
		params.push({'name':'flag','value':'channel_tree'});
		params.push({'name':'whereStr','value':whereStr});
		params.push({'name':'orderByStr','value':orderBy});
		params.push({'name':'tableName','value':'<%=tableName%>'});
		grid = jQuery("#maingrid_tree").ligerGrid({
				columns : columnsArr ,
				url : url, 
				pageSize : 20,
				width : '99%',
				height : '98%',
				checkbox : true,
				parms : params,
				selectRowButtonOnly : true,
				alternatingRow : false ,
				usePager : false ,
				tree : {columnId: 'no'} ,
				rownumbers : true ,
							toolbar : {
					items : [{
						text: '增加', 
						click: function(){
							addAndEdit();
						}, 
						icon: 'add' } , {
							text: '删除', 
							click: function(){
								toolbarDel();
							}, 
							icon: 'delete' 
						}
					]
				}
			});
		jQuery("#pageloading").hide();
	});
	function toolbarSubblock(uuid){
		jrWindow("/backend/common_channel_subblock/common_channel_subblock_list.jsp?channel_uuid="+uuid, "元素管理",700, 500);
	}
    function addAndEdit(index){
    	if(undefined==index){//如果是增加
    		parent.f_addTab('<%=CommonString.getUUID() %>','新增栏目','/backend/common_channel/common_channel_edit.jsp');
    	}else{//如果是修改
	    	var row = grid.getRow(index);
	    	parent.f_addTab(row.id,row.name+'栏目','/backend/common_channel/common_channel_edit.jsp?channel_uuid='+row.uuid);
    	}
    }
</script>