<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%

	String tablePrefix = Env.getInstance().getProperty("table_prefix");
    String tableName = tablePrefix+"machine_products";
	String fileds = "id,add_date,name,catalog_name,brand_name,file_name,uuid";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = "";
	String orderByStr = " id desc ";
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	List <Map> catalog=null;
	List <Map> brandList = null;
	try{
		connection=dbHelper.getConnection();
		//List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		//List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		catalog=dbHelper.getMapList(" select * from pro_machine_catalog where is_show=1  order by order_no,id  ",connection);
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalog , "parentid","id");
		brandList = dbHelper.getMapList(" select * from  pro_machine_brand where is_show=1   order by first_letter,id  ",connection);

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" type="text/css"></link>
	<style type="text/css">
	.l-grid-body-table tr td{
	 height:30px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script></head>
  <body>
  	<div class="searchForm">
  		<div class="searchCondition">
		  		<div class="searchLeft">产品名称</div>
		  		<div class="searchRight">
		  			<input type="text" id="name" name="name" style="width: 150px;" class="jr_text" />
		  		</div>
		  		<div class="searchLeft">品牌</div>
		  		<div class="searchRight">
		  			<select class="jr_select" id="brand_id" name="brand_id">
                    	<option value="">--请选择品牌--</option>
		  				<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=m.get("first_letter")%>-<%=m.get("name")%></option>
                        <%}}%>
		  			</select>
		  		</div>
		  		<div class="searchLeft">产品类别</div>
		  		<div class="searchRight">
		  			<select class="jr_select" id="catalog_num" name="catalog_num">
                    	<option value="">--请选择产品类别--</option>
		  				<%if(catalogList != null){for(Map m : catalogList){%>
                        	<option value="<%=m.get("num")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
                        <%}}%>
		  			</select>
		  		</div>
                <div class="searchLeft">是否显示</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  			<input type="radio" id="is_show_1" name="is_show" value="1" />是
                    <input type="radio" id="is_show_0" name="is_show" value="0" />否
		  		</div>
		  		<div style="clear:left;"></div>
              
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
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
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
   { display : 'ID', name : 'id', align : 'left' , type : 'string' , width : 50 } ,
	{ display : '名称', name : 'name', align : 'left' , type : 'string' , width : 100 ,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
	}} ,
	{ display : '品牌', name : 'brand_name', align : 'left' , type : 'string' , width : 110 } ,
	{ display : '类别', name : 'catalog_name', align : 'left' , type : 'string' , width : 110 } ,
	{ display : '文件名称', name : 'file_name', align : 'left' , type : 'string' , width : 130,render:function(row){
		return "<a target='_blank' href='/nj/proDetail/"+row.file_name+"'>"+row.file_name+"</a>";	
	}} ,
	{ display : '是否显示', name : 'is_show', align : 'center' , type : 'is' , width : 60 }  
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:900,
	    		height:610,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:900,
	    		height:610,
	    		title:'修改'
	    	},row.id);
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
		var brand_id = jQuery("#brand_id").val();
		if(''!=jQuery.trim(brand_id)){
			conditionStr += " and (brand_id = '"+brand_id+"')";
		}
		var catalog_num = jQuery("#catalog_num").val();
		if(''!=jQuery.trim(catalog_num)){
			conditionStr += " and catalog_num like '"+catalog_num+"%' ";
		}
		var is_show = jQuery("input[name='is_show']:checked").val();
		if(''!=jQuery.trim(is_show)){
			conditionStr += " and is_show = '"+is_show+"' ";
		}
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':whereStr+conditionStr});
		params.push({'name':'orderBy','value':orderBy});
		params.push({'name':'main','value':main});
		grid.options.parms=params;
		grid.loadData();
	}
	
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
		jQuery("#brand_id").val('');
		jQuery("#catalog_num").val('');
		jQuery("#is_show_1").attr("checked",false);
	}
	
	
	// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
    }
	
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>