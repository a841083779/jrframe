<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_tuan_image";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String group_id = CommonString.getFormatPara(request.getParameter("id")) ;
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = " and pro_id = "+group_id;
	
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
	<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
  </head>
  <body>
  	<div class="searchForm">
  		<div class="searchCondition" style="width:75%">
		  		
				 <div style="clear: left;"></div>
        <div class="formLeft">添加图片</div>
       <div class="formRight" style=" position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFiled('zd_img2',700,480,'<%=group_id%>');" value="选择图片" />
			
		</div>
    <div style="clear:left;"></div>
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
						items : [ {/*
									text : '增加',
									click : function(){
										openWin(<%=group_id%>);
									},
									icon : 'add'
									}, {
									text : '删除',
									click : function(){
										toolbarDel({
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'delete'*/
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	
		function doSub(){
		//设置分类
		
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					if (rs > 0 ) {
						jrSuccess("保存成功！");
						
					} 
				}
			});
		}
	}
	
	//列数组
	columnsArr =  [ 
	{ display : '产品名称', name : 'new_name', align : 'left' , type : 'string' , width : 300 
	} ,
	{ display : '添加日期', name : 'add_date', align : 'center' , type : 'date' , width : 100 } 
	];
	

	
		function openWin(no) {
	var url = "/backend/pro_tuan_pros/pro_ymt_edit.jsp?id="+no;
	var title = "导入产品";
	var width = 800;
	var height = 500;
	
	jQuery.ligerDialog.open({
				height : height,
				url : url,
				width : width,
				showMax : true,
				showToggle : false,
				showMin : false,
				isResize : false,
				modal : true,
				title : title,
				buttons : [{
					text : '确定',
					onclick : function(item, dialog) {
						dialog.frame.doSub(dialog);
						var ifid = parent.tab.getSelectedTabItemID();
						parent.document.getElementById(ifid).contentWindow.grid
								.loadData();
					}
				}, {
					text : '取消',
					onclick : function(item, dialog) {
						dialog.close();
					}
				}]
			});
}
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	//增加和编辑的方法
	/*function addAndEdit(index,id){
	var fileName="";
	var folderName="";
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:600,
	    		title:'增加',
				fileName:"pro_tuan_pros",
				folderName:"pro_tuan_pros",
	    		params : {
	    			channel_uuid : "<%=channelUUID %>",
					id:id
					
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:600,
	    		title:'修改',
				fileName:"pro_tuan_pros",
				folderName:"pro_tuan_pros"
	    	},row.uuid);
    	}
    }*/
	
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var title = jQuery("#title").val();
		if(''!=jQuery.trim(title)){
			conditionStr += " and title like '%"+title+"%' ";
		}
		var pub_date = jQuery("#pub_date").val();
		if(''!=jQuery.trim(pub_date)){
			conditionStr += " and pub_date >'"+pub_date+" 00:00:00' and pub_date < '"+pub_date +" 23:59:59'";
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
   	// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
	 }

	 
	 //图集
	 function chooseFiled(id, w, h,group_id) {
	var url = "/backend/function/file/choose_tuan_list.jsp?id=" + id+"&group_id="+group_id;
	var title = "选择";
	var width = 650;
	if (w != undefined) {
		width = w;
	}
	var height = 400;
	if (h != undefined) {
		height = h;
	}
	jQuery.ligerDialog.open({
				height : height,
				url : url,
				width : width,
				showMax : true,
				showToggle : false,
				showMin : false,
				isResize : false,
				modal : true,
				title : title,
				buttons : [{
					text : '确定',
					onclick : function(item, dialog) {
						dialog.frame.doSub(dialog);
						var ifid = parent.tab.getSelectedTabItemID();
						parent.document.getElementById(ifid).contentWindow.grid
								.loadData();
					}
				}, {
					text : '取消',
					onclick : function(item, dialog) {
						dialog.close();
					}
				}]
			});
}

</script>