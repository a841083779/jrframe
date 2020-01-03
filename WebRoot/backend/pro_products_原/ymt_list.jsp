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
	<link rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" type="text/css"></link>
	<style type="text/css">
	.l-grid-body-table tr td{
	 height:30px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script></head>
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
<script src="/backend/scripts/common_ymt.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
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
					
							items :[{
									text : '删除',
									click : function(){
										toolbarDel({
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'delete'
								}, {
									text : '设为显示',
									click : function(){
										setYmtShow({
											channel_uuid:'<%=channelUUID %>',
											flag:'setYmtShow'
										});
									},
									icon : 'settings'
								}, {
									text : '设为隐藏',
									click : function(){
										setYmtShow({
											channel_uuid:'<%=channelUUID %>',
											flag:'setYmtHide'
										});
									},
									icon : 'config'
								}]
					
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
   { display : 'ID', name : 'id', align : 'left' , type : 'string' , width : 50,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.id+"</a>";} } ,
	{ display : '标题', name : 'title', align : 'left' , type : 'string' , width : 110 ,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.title+"</a>";}} ,
	{ display : '活动方', name : 'factoryname', align : 'left' , type : 'string' , width : 100 } ,

	{ display : '是否显示', name : 'is_show', align : 'left' , type : 'is' , width : 110 } 

	];
	
	//增加和编辑的方法
	function addAndEdit(index){
 		var row = grid.getRow(index);
		var url = "/backend/pro_products/ymt_edit.jsp?id="+row.id;
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "优买团活动", 900, 600);
    }
	
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
		}
		var factoryid = jQuery("#factoryid").val();
		if(''!=jQuery.trim(factoryid)){
			conditionStr += " and (factoryid = '"+factoryid+"' or factoryid_sub='"+factoryid+"')";
		}
		var catalognum = jQuery("#catalognum").val();
		if(''!=jQuery.trim(catalognum)){
			conditionStr += " and catalognum like '"+catalognum+"%' ";
		}
		var is_show = jQuery("input[name='is_show']:checked").val();
		if(''!=jQuery.trim(is_show)){
			conditionStr += " and is_show = '"+is_show+"' ";
		}
		var order_no = jQuery.trim(jQuery("input[name='order_no']:checked").val()) ;
		if(''!=order_no){
		   if('1'==order_no){
		   	 conditionStr += " and order_no > 0 and order_no is not null ";
		   }else if('0'==order_no){
		   	   conditionStr += " and (order_no <= 0  or  order_no is null)";
			}
		}
		
		var manual = jQuery.trim(jQuery("input[name='manual']:checked").val()) ;
		if(''!=manual){
		   if('1'==manual){
		   	 conditionStr += " and manual!='' ";
		   }else if('0'==manual){
		   	   conditionStr += " and (order_no = ''  or  manual is null)";
			}
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
		jQuery("#factoryid").val('');
		jQuery("#catalognum").val('');
		jQuery("#is_show_1").attr("checked",false);
	}
	function openWin(id,name){
		jrWindow("/backend/pro_products/ipt_product_temp_products_list.jsp?pro_name="+name+"&pid="+id,"导入产品",900,600);	
	}
	function showPicList(pro_id){
		jrWindow("/backend/pro_product_pic/pro_product_pic_list.jsp?id="+pro_id+"&channel_no=","产品图片",800,600);
	}
	function showComments(pro_id){
	   jrWindow("/backend/pro_comments/pro_comments_list.jsp?id="+pro_id+"&channel_no=","产品图片",900,600);
	}
	
	// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
    }

	//优买团推送
	function pushOrder(index){
		var row = grid.getRow(index);
		var url = "/backend/pro_products/ymt_push.jsp?uuid="+row.uuid;
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "优买团活动", 900, 600);
	}	
</script>