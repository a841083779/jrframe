<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix+"machine_brand";
	String fileds = "id,name,is_show,first_letter,uuid,img1,full_name,logo";
	Map channelMap = (Map)application.getAttribute("channelMap");
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String whereStr = "  ";
	String orderByStr = " id desc ";
	Map inner = new HashMap() ;
	inner.put("","全部") ;
	inner.put("1","显示") ;
    inner.put("0","不显示") ;
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
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
  	<div class="searchForm">
  		<div class="searchCondition" style="width:700px;">
		  		<div class="searchLeft">厂家简称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="name" id="name" />
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
										toolbarDel();
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
	   return "<img src='/uploadfiles/"+row.img1+"' width='100%' height='100%' title='"+row.full_name+"' onerror='this.src=\"/uploadfiles/no_small.gif\"'>" ;
	  }
	} ,
	{ display : '厂家简称', name : 'name', align : 'left' , type : 'string' , width : 200 ,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
	  }
	} ,
	{ display : '厂家名称', name : 'full_name', align : 'left' , type : 'string' , width : 160 ,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.full_name+"</a>";
	  }
	} ,
	{ display : '公司标识', name : 'logo', align : 'left' , type : 'string' , width : 70,render:function(row){
	    return "<img src='/uploadfiles/"+row.logo+"' title='"+row.full_name+"'/>" ;
	  }
	 } ,
	{ display : '首字母', name : 'first_letter', align : 'center' , type : 'string' , width : 80 } ,
	{ display : '是否显示', name : 'is_show', align : 'center' , type : 'string' , width : 50 ,render:function(row){
	   return (row.is_show=="1")?"是":"否" ;
	  }
	  }	
	
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:900,
	    		height:500,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:900,
	    		height:500,
	    		title:'修改'
	    	},row.id);
    	}
    }
	// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
    }
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
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