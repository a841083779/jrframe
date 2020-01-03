<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_agent_factory";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,full_name,email,logo,is_show,is_inner,view_count,mobile";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = "  and flag=1 ";
	String orderByStr = " order_no desc,id desc ";
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
  	<div class="searchForm">
  		<div class="searchCondition" style="width:650px;">
		  		<div class="searchLeft">厂商名称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="full_name" id="full_name" />
		  		</div>
		  		<div class="searchLeft">首字母</div>
		  		 <div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="upper_index" id="upper_index" />
		  		</div>
		  		 <div class="searchLeft" style="width:100px;">地区</div>
		  		<div class="searchRight">
		  			<%= commonForm.createRadio(inner,"","全部")%>
		  		</div>
  		</div>
  		<div class="searchBtn">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
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
					checkbox : false,
					selectRowButtonOnly : true,
					parms : params,
					rownumbers : true,
					toolbar : null
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
		{ display : '', name : 'img1', align : 'left' , type : 'string' , width : 50,render:function(row){
		   return "<img src='/uploadfiles/"+row.img1+"' width='100%' height='100%' title='"+row.full_name+"' onerror='this.src=\"/uploadfiles/no_small.gif\"'>" ;
		  }
		} ,
		{ display : '厂商名称', name : 'full_name', align : 'left' , type : 'string' , width : 160 ,render:function(row){
		      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.full_name+"</a>";
		  }
		} ,
		{ display : '公司邮箱', name : 'email', align : 'left' , type : 'string' , width : 200 } ,
		{ display : '公司标识', name : 'logo', align : 'left' , type : 'string' , width : 120,render:function(row){
		    return "<img src='/uploadfiles/"+row.logo+"' title='"+row.full_name+"'/>" ;
		  }
		 } ,
		{ display : '是否显示', name : 'is_show', align : 'center' , type : 'string' , width : 100 ,render:function(row){
		   return (row.is_show=="1")?"是":"否" ;
		  }
		  } ,
		{ display : '地区', name : 'is_inner', align : 'center' , type : 'string' , width : 100,render:function(row){
		  return (row.is_inner=="1")?"国内":"国外" ;
		 }
		 } ,
		{ display : '访问量', name : 'view_count', align : 'right' , type : 'string' , width : 80 } ,
		{ display : '联系电话', name : 'telphone', align : 'center' , type : 'string' , width : 120 } 
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:620,
	    		title:'增加',
	    		fileName:"pro_agent_factory_fac" ,
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
	    	    fileName:"pro_agent_factory_fac" ,
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
		if(''!=jQuery.trim(inner))
		{
		  conditionStr += " and is_inner ='"+inner+"'";
		}
		var upper_index = jQuery("#upper_index").val() ;
		if(''!=jQuery.trim(upper_index)){
		conditionStr += " and upper_index ='"+jQuery.trim(upper_index)+"'" ;
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
		function changeAgent(obj,brandid){
		if(confirm("是否"+(obj==0?"隐藏":"显示")+"全部代理商")){
		jQuery.ajax({
			type:"post" ,
			url:"/backend/action/ajax_cud.jsp",
			data:"flag=changeagent&choose="+obj+"&brandid="+brandid,
			success:function(msg){
			alert("已更改成功") ;
			}
		}) ;
		}
	}
</script>