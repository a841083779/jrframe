<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_ymt_activity";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,add_date,factoryname,catalogname,name,img2,file_name,view_count,is_show,title";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
	List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
	String whereStr = "";
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
  		<div class="searchCondition">
		  		<div class="searchList">  
			  		<div class="searchLeft">标题</div>
			  		<div class="searchRight">
			  			<input type="text" style="width: 100px;" class="jr_text" name="title" id="title" />
			  		</div>
		  		</div>
  				 <div class="searchList">  
			  		<div class="searchLeft">发布日期</div>
			  		<div class="searchRight">
			  			<input type="text" style="width: 100px;" onfocus="WdatePicker()" class="Wdate" name="pub_date" id="pub_date" />
			  		</div>
		  		</div>
  		</div>
  		<div class="searchBtn">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" style="margin-right: 5px;" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
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
						items : [ {
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
	{ display : 'ID', name : 'title', align : 'left' , type : 'string' , width : 100 ,render:function(row){
	return "<a class='link' href='javascript:void(0);' onclick='addAndEdits("+row.__index+");'>"+row.id+"</a>";}} ,
	{ display : '活动标题', name : 'title', align : 'left' , type : 'string' , width : 400 ,render:function(row){
	return "<a class='link' href='javascript:void(0);' onclick='addAndEdits("+row.__index+");'>"+row.title+"</a>";}} ,
	{ display : '活动类型', name : 'pro_type', align : 'left' , type : 'pro_type' , width : 100 } ,
	{ display : '活动方', name : 'factoryname', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '发布时间', name : 'add_date', align : 'left' , type : 'date' , width : 100 } ,
    { display : '操作', name : 'id', align : 'center' , type : 'string' , width : 120,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='subject_edit("+row.id+");'>操作</a>";
	} },
	{ display : '是否显示', name : 'is_show', align : 'left' , type : 'is' , width : 110 } 

	];
	
	//增加和编辑的方法
	function addAndEdits(index){
 		var row = grid.getRow(index);
		var url = "/backend/pro_tuan/pro_tuanShow_edit.jsp?id="+row.id;
		jrWindow(url, "优买团活动", 900, 600);
    }
	//增加和编辑的方法
	/*function addAndEdit(index){
    	var row = grid.getRow(index);
		var url = "/backend/pro_tuan/ymt_addEdit.jsp";
		jrWindow(url, "优买团活动", 900, 600);
    }*/
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:620,
	    		title:'增加',
	    		fileName:"pro_tuan" ,
				folderName:"pro_tuan",
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:720,
	    		title:'修改',
	    	    fileName:"pro_tuan",
				folderName:"pro_tuan"
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
		var title = jQuery("#title").val();
		if(''!=jQuery.trim(title)){
			conditionStr += " and title like '%"+title+"%' ";
		}
		
		var pub_date = jQuery("#pub_date").val();
		if(''!=jQuery.trim(pub_date)){
			conditionStr += " and add_date >'"+pub_date+" 00:00:00' and _date < '"+pub_date +" 23:59:59'";
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
   	
	//操作
	function subject_edit(no) {
		var _url = "/backend/pro_tuan_pros/pro_tuan_pros_list.jsp?id="+no;
		var _title = "图片";
		var iWidth = 800;
		var iHeight = 600;
		var iTop = (window.screen.height - 30 - iHeight) / 2;
		var iLeft = (window.screen.width - 10 - iWidth) / 2;
		var _par = "height="
				+ iHeight
				+ ",width="
				+ iWidth
				+ ",top="
				+ iTop
				+ ",left="
				+ iLeft
				+ ",toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no";
		// window.open(_url, _title, _par);
		jrWindow(_url, _title, iWidth, iHeight);
	}
</script>
</script>