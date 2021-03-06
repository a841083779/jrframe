﻿<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	String tableName = "pro_products";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "web_title,id,uuid,name,factoryname,catalogname,view_count,catalognum,last_modify_date,tonandmeter,is_show,file_name,is_check,old_last_modify_date,new_last_modify_date";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	try{
		connection = dbHelper.getConnection();
		brandList =  dbHelper.getMapList(" select id,name,upper_index from pro_agent_factory where is_show=1 and flag=1 order by upper_index",connection) ;
		}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
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
  	<div class="searchForm">
  		<div class="searchCondition">
		  		<div class="searchLeft">产品型号</div>
		  		<div class="searchRight">
		  			<input type="text" id="name" name="name" style="width: 150px;" class="jr_text" />
		  		</div>
		  		<div class="searchLeft">品牌</div>
		  		<div class="searchRight">
		  			<select class="jr_select" id="factoryid" name="factoryid">
                    	<option value="">--请选择品牌--</option>
		  				<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=m.get("upper_index")%>-<%=m.get("name")%></option>
                        <%}}%>
		  			</select>
		  		</div>
		  		<div class="searchLeft">产品类别</div>
		  		<div class="searchRight">
		  			<select class="jr_select" id="catalognum" name="catalognum">
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
                <div class="searchLeft">是否排序</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  	    	<input type="radio" id="order_no_0" name="order_no" value="" checked='checked'/>全部
		  			<input type="radio" id="order_no_1" name="order_no" value="1" />是
                    <input type="radio" id="order_no_2" name="order_no" value="0" />否
		  		</div>
			
                <div class="searchLeft">手册有无</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  	    	<input type="radio" id="manual_0" name="manual" value="" checked='checked'/>全部
		  			<input type="radio" id="manual_1" name="manual" value="1" />是
                    <input type="radio" id="manual_2" name="manual" value="0" />否
		  		</div>
				
				
				<div class="searchLeft">参数录入</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  	    	<input type="radio" id="is_param_0" name="is_param" value="" checked='checked'/>全部
		  			<input type="radio" id="is_param_1" name="is_param" value="1" />是
                    <input type="radio" id="is_param_2" name="is_param" value="0" />否
		  		</div>
				
				<div class="searchLeft">是否审核</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  	    	<input type="radio" id="is_check_0" name="is_check" value="" checked='checked'/>全部
		  			<input type="radio" id="is_check_1" name="is_check" value="1" />是
                    <input type="radio" id="is_check_2" name="is_check" value="0" />否
		  		</div>
				<div style="clear:left;"></div>
				<div class="searchLeft" style="width:100px;">最后修改时间</div>
		  		<div class="searchRight" >
		  			<input type="text" style="width: 50px;"  name="start_date" id="start_date" />
		  		</div>
		  			<div class="searchLeft" style="width:10px;">&nbsp;~</div>
		  		<div class="searchRight" >
		  			<input type="text" style="width: 50px;"  name="end_date" id="end_date" />
		  		</div>
				<div class="searchLeft">类别编号</div>
		  		<div class="searchRight">
		  			<input type="text" id="catalognum_new" name="catalognum_new" style="width: 150px;" class="jr_text" />
		  		</div>
				<div class="searchLeft">新类别编号</div>
		  		<div class="searchRight">
		  			<input type="text" id="catalogname" name="catalogname" style="width: 150px;" class="jr_text" />
		  		</div>
				<div style="clear:left;"></div>
				<div class="searchLeft">有无图片</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  	    	<input type="radio" id="is_pic_0" name="is_pic" value="" checked='checked'/>全部
		  			<input type="radio" id="is_pic_1" name="is_pic" value="1" />是
                    <input type="radio" id="is_pic_2" name="is_pic" value="0" />否
		  		</div>
				
				<div class="searchLeft">有无介绍</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  	    	<input type="radio" id="is_intro_0" name="is_intro" value="" checked='checked'/>全部
		  			<input type="radio" id="is_intro_1" name="is_intro" value="1" />是
                    <input type="radio" id="is_intro_2" name="is_intro" value="0" />否
		  		</div>
				
				
				<div class="searchLeft">有无汉字</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  	    	<input type="radio" id="is_update_0" name="is_update" value="" checked='checked'/>全部
		  			<input type="radio" id="is_update_1" name="is_update" value="1" />是
                    <input type="radio" id="is_update_2" name="is_update" value="0" />否
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
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript">
	jQuery("#start_date").ligerDateEditor({width:150}); 
	jQuery("#end_date").ligerDateEditor({width:150});
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
					enabledEdit: true,
					rownumbers : true,
					onAfterEdit:function(e){
		               if(e.column.columnname=='web_title'){ 
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'updateKeywords',
					  				id:e.record.id,
					  				value:e.value
					  			},
					  			type:'post'
					  		}) ;
					   }
					    if(e.column.columnname=='tonandmeter'){ 
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'updateTonandmeter',
					  				id:e.record.id,
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
								}, {
									text : '取消排序',
									click : function(){
										toolbarDel({
											channel_uuid:'<%=channelUUID %>',
											flag:'cancelProductsOrder'
										});
									},
									icon : 'back'
								}, {
									text : '设为显示',
									click : function(){
										setProductShow({
											channel_uuid:'<%=channelUUID %>',
											flag:'setProductShow'
										});
									},
									icon : 'settings'
								}, {
									text : '设为隐藏',
									click : function(){
										setProductShow({
											channel_uuid:'<%=channelUUID %>',
											flag:'setProductHide'
										});
									},
									icon : 'config'
								},{
									text : '挖掘机推荐',
									click : function(){
										wjjtj();
									},
									icon : 'add'
								},{
									text : '装载机推荐',
									click : function(){
										zzjtj();
									},
									icon : 'add'
								}
								
								]
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
	{ display : '品牌', name : 'factoryname', align : 'left' , type : 'string' , width : 110 } ,
	{ display : '类别', name : 'catalogname', align : 'left' , type : 'string' , width : 110 } ,
	{ display : '浏览量', name : 'view_count', align : 'center' , type : 'string' , width : 70 } ,

	{ display : '最后修改日期', name : 'last_modify_date', align : 'center' , type : 'string' , width : 100 } ,
	{ display : '文件名称', name : 'file_name', align : 'left' , type : 'string' , width : 110,render:function(row){
		return "<a target='_blank' href='/proDetail/"+row.file_name+"'>"+row.file_name+"</a>";	
	}} ,
	{ display : '吨位', name : 'tonandmeter', align : 'center' , type : 'editor' , width : 50 ,editor:{type:"string"}} ,

	{ display : '是否显示', name : 'is_show', align : 'center' , type : 'is' , width : 60 } , 
	{ display : '操作', align : 'center' , type : 'is' , width : 200 ,render : function(row){
			var operateStr="";
			$.ajax({
				async:false,
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:{flag:"koubei_count",productid:row.id},
				success:function(result){
					operateStr=$.trim(result);
				}
			});
	if(row.is_check==1){
		return "<a class='link' href='javascript:void(0);' onclick='showParamList(\""+row.id+"\",\""+row.catalognum+"\")' style='color:green;'>参数</a>"+
		"&nbsp;&nbsp;<a href='javascript:;' class='link' onclick='showPicList(\""+row.id+"\")'>图片</a>"+
		"&nbsp;&nbsp;<a href='javascript:;' class='link' onclick='showComments(\""+row.id+"\");'>评论("+operateStr+")</a>" +
		"&nbsp;&nbsp;<a href='javascript:;' class='link' onclick='createProNew(\""+row.id+"\")'>页面更新</a>";
		}else{
		return "<a class='link' href='javascript:void(0);' onclick='showParamList(\""+row.id+"\",\""+row.catalognum+"\")' style='color:red;'>参数</a>"+
		"&nbsp;&nbsp;<a href='javascript:;' class='link' onclick='showPicList(\""+row.id+"\")'>图片</a>"+
		"&nbsp;&nbsp;<a href='javascript:;' class='link' onclick='showComments(\""+row.id+"\");'>评论("+operateStr+")</a>" +
	
		"&nbsp;&nbsp;<a href='javascript:;' class='link' onclick='createProNew(\""+row.id+"\")'>页面更新</a>";
		}
				 
	}
	},
	{ display : '页面更新日期', name : 'new_last_modify_date', align : 'center' , type : 'string' , width : 100 } ,

	{ display : '产品复制', align : 'center' , type : 'is' , width : 50,render:function(row){
	  		return "<a class='link' style='color:red' href='javascript:void(0);' onclick='copyProduct("+row.__index+");'>复制</a>";
    	   } 
	} ,
	
	
	{ display : '关键词',name:'web_title', align : 'center' , type : 'editor' , width : 50,editor:{type:"string"} } 
	
	
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
		var catalogname = jQuery("#catalogname").val();
		if(''!=jQuery.trim(catalogname)){
			conditionStr += " and new_catalog = '"+catalogname+"' ";
		}
		var catalognum_new = jQuery("#catalognum_new").val();
		if(''!=jQuery.trim(catalognum_new)){
			conditionStr += " and catalognum = '"+catalognum_new+"' ";
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
		var is_check = jQuery("input[name='is_check']:checked").val();
		if(''!=jQuery.trim(is_check)){
			if(is_check=='1'){
			conditionStr += " and is_check = "+is_check+"";
			}
			if(is_check=='0'){
			conditionStr += " and (is_check = 0 or is_check is null )";
			}
		}
		
		
		
	    var is_update = jQuery("input[name='is_update']:checked").val();
		if(''!=jQuery.trim(is_update)){
			if(is_update=='1'){
			conditionStr += " and is_update = "+is_update+"";
			}
			if(is_update=='0'){
			conditionStr += " and (is_update = 0 or is_update is null )";
			}
		}
		
		var start_date = jQuery("#start_date").val();
		if(''!=jQuery.trim(start_date)){
			conditionStr += " and last_modify_date >='"+start_date+" 00:00:00'";
		}
		var end_date = jQuery("#end_date").val() ;
		if(''!=jQuery.trim(end_date))
		{
		   conditionStr += " and last_modify_date <='"+end_date+" 23:59:59'";
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
		
		var is_param = jQuery.trim(jQuery("input[name='is_param']:checked").val()) ;
		if(''!=is_param){
		   if('1'==is_param){
		   	 conditionStr += " and  param is not null and   last_modify_date>='2015-07-02'  ";
		   }else if('0'==is_param){
		   	   conditionStr += "  and  param is  null  ";
			}
		}
		
		
		var is_pic = jQuery.trim(jQuery("input[name='is_pic']:checked").val()) ;
		if(''!=is_pic){
		   if('1'==is_pic){
		   	 conditionStr += " and (img2 is not null and  img2!='')  ";
		   }else if('0'==is_pic){
		   	   conditionStr += "  and (img2 is  null or  img2='')  ";
			}
		}
		
		
		var is_intro = jQuery.trim(jQuery("input[name='is_intro']:checked").val()) ;
		if(''!=is_intro){
		   if('1'==is_intro){
		   	 conditionStr += " and DATALENGTH (introduce)>50  ";
		   }else if('0'==is_intro){
		   	   conditionStr += "  and DATALENGTH (introduce)<=50  ";
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
	function showParamList(id,cata){
		jrWindow("/backend/pro_products/pro_products_param_edit.jsp?id="+id,"产品参数",800,400);
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
	
	function copyProduct(index){
			var row = grid.getRow(index);
			$.ajax({
				async:false,
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:{flag:"copyProduct",productid:row.id},
				success:function(result){
					jrSuccess("产品复制成功!");
					grid.loadData();
				}
			});
	
	}
	
	//更新详细页
	function createPro(id){
		
			$.ajax({
				async:false,
				type:"post",
				url:"/backend/action/after.jsp",
				data:{eventAfter:"productsCreate",keyId:id,tableName:"pro_products"},
				success:function(result){
					jrSuccess("产品详细页更新成功!");
					grid.loadData();
				}
			});
	
	}
	
	
		
	//更新新版详细页
	function createProNew(id){
		
			$.ajax({
				async:false,
				type:"post",
				url:"/backend/action/after.jsp",
				data:{eventAfter:"productsCreateNew",keyId:id,tableName:"pro_products"},
				success:function(result){
					jrSuccess("产品详细页更新成功!");
				}
			});
	
	}
	
	function wjjtj(){
 		var url = "/backend/pro_products/wjj.jsp?uuid=7DDFCCF1-2D24-4984-81D5-FABAA2979324"
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "挖掘机推荐", 400, 540);
	}
	
	function zzjtj(){
 		var url = "/backend/pro_products/zzj.jsp?uuid=7DDFCCF1-2D24-4984-81D5-FABAA2979324"
		//var url = "/backend/pro_400/send.jsp?productid="+row.id+"&city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "装载机推荐", 400, 540);
	}
	
</script>