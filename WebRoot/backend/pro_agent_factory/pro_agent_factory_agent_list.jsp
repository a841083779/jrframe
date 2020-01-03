﻿<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_agent_factory";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*,(select count(*) from pro_agent_factory paf where paf.parent_id = pro_agent_factory.id ) as subCount ";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = "  and flag=2  ";
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
		  		<div class="searchLeft">代理商名称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="full_name" id="full_name" />
		  		</div>
		  		<div class="searchLeft">品牌</div>
		  		<div class="searchRight">
		  			<select class="jr_select" id="factoryid" name="factoryid">
                    	<option value="">--请选择品牌--</option>
		  				<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
                        <%}}%>
		  			</select>
		  		</div>
		  		<div class="searchLeft">级别</div>
		  		<div class="searchRight">
		  			<%
		  				Map typeMap = new HashMap();
		  				typeMap.put("","--请选择级别--");
		  				typeMap.put("0","总代理");
		  				typeMap.put("1","办事处");
		  			%>
		  			<select class="jr_select" id="levelflag" name="levelflag">
		  				<%=CommonForm.createSelect(typeMap,"") %>
		  			</select>
		  		</div>
		  		<div class="searchLeft">营销宝开通</div>
		  		<div class="searchRight">
		  			<%
		  				TreeMap yingXiaoBaoMap = new TreeMap();
			  			yingXiaoBaoMap.put("","--请选择--");
			  			yingXiaoBaoMap.put("0","未开通");
			  			yingXiaoBaoMap.put("1","免费版");
			  			yingXiaoBaoMap.put("2","基础版");
			  			yingXiaoBaoMap.put("3","高级版");
		  			%>
		  			<select class="jr_select" id="is_shop" name="is_shop">
		  				<%=CommonForm.createSelect(yingXiaoBaoMap,"") %>
		  			</select>
		  		</div>
		  		<div class="searchLeft">旗舰店开通</div>
		  		<div class="searchRight">
		  			<%
		  				TreeMap qiJianDianMap = new TreeMap();
			  			qiJianDianMap.put("","--请选择--");
			  			qiJianDianMap.put("0","未开通");
			  			qiJianDianMap.put("1","已开通");
		  			%>
		  			<select class="jr_select" id="is_qijiandian" name="is_qijiandian">
		  				<%=CommonForm.createSelect(qiJianDianMap,"") %>
		  			</select>
		  		</div>
		  		 <div class="searchLeft">地区</div>
		  		<div class="searchRight">
		  			<input type="text" class="jr_text" name="city" id="city" style="width: 100px;" />
		  		</div>
		  		<div class="searchLeft">是否显示</div>
		  		<div class="searchRight"><%= CommonForm.createRadio(inner,"","全部")%></div>
				
				<div class="searchLeft">用户名</div>
		  		<div class="searchRight">
		  			<input type="text" class="jr_text" name="username" id="username" style="width: 100px;" />
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
		params.push({'name':'fields','value':fields});
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
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'delete'
								}, {
									text : '选择总代理',
									click : function(){
										var checkedRows = grid.getCheckedRows();
										if(checkedRows.length>0){
											var idStr = "";
											for (var i = 0; i < checkedRows.length; i++) {
												idStr += "" + checkedRows[i].uuid + ",";
											}
											if (idStr.indexOf(",") != -1) {
												idStr = idStr.substring(0, idStr.length - 1);
											}
											jrWindow("/backend/pro_agent_factory/choose_zong_dai_li.jsp?ids="+idStr,"选择总代理",300,60);
										}else{
											alert("请选择办事处！");
										}
									},
									icon : 'plus'
								},
								
								
								{
									text : '批量设置为不显示',
									click : function(){
										hideAgent({
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'back'
								}
								
								
								]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	
	{ display : 'ID', name : 'id', align : 'center' , type : 'string' , width : 50 } ,
	{ display : '代理商名称', name : 'full_name', align : 'left' , type : 'string' , width : 200 ,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.full_name+"</a>";
	  }
	} ,
	{ display : '代理品牌', name : 'agent_fac_name', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '最后修改日期', name : 'last_modified_date', align : 'left' , type : 'string' , width : 150 } ,
	
	//{ display : '公司邮箱', name : 'email', align : 'left' , type : 'string' , width : 150 } ,
	{ display : '是否显示', name : 'is_show', align : 'center' , type : 'string' , width : 50 ,render:function(row){
	   return (row.is_show=="1")?"是":"否" ;
	  }
	  } ,
	{ display : '代理地区', name : 'city', align : 'center' , type : 'string' , width : 80
	 } ,
	{ display : '联系电话', name : 'telphone', align : 'left' , type : 'string' , width : 100 } ,
	
	{ display : '业务员', align : 'center' , type : 'is' , width : 50 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick='openYwy("+row.id+");'>操作</a>";
	}} ,
	{ display : '坐标管理', align : 'center' , type : 'is' , width : 50 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick='openLac("+row.id+");'>操作</a>";
	}} ,
	{ display : '代理品牌', align : 'center' , type : 'is' , width : 50 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick='openBrand("+row.id+",\""+row.full_name+"\");'>操作</a>";
	}} ,
	{ display : '代理产品', align : 'center' , type : 'is' , width : 50 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick='openWin("+row.id+");'>操作</a>";
	}} ,
	
	{ display : '代理区域', align : 'center' , type : 'is' , width : 50 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick='openArea("+row.id+");'>操作</a>";
	}},
	{ display : '是否有办事处', name : 'city', align : 'center' , type : 'string' , width : 80 , render : function(row){
			if(row.subCount>0){
				return '<span style="color:red;">是('+row.subCount+')</span>';
			}
			return '否';
		}
	} ,
	{ display : '合同时间', name : 'order_end_time', align : 'center' , type : 'string' , width : 100 ,render:function(row){
		      return (row.order_end_time)?row.order_end_time:'无' ;
		  }
	}	
	
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:520,
	    		title:'增加',
	    		fileName:"pro_agent_factory_agent" ,
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:520,
	    		title:'修改',
	    	    fileName:"pro_agent_factory_agent" 
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
			conditionStr += " and  ( full_name like '%"+full_name+"%'    or name like '%"+full_name+"%' )";
		}
		var inner = jQuery(".jr_radio:checked").val() ;
		if(''!=jQuery.trim(inner))
		{
		  conditionStr += " and is_show ='"+inner+"'";
		}
		var factoryid = jQuery("#factoryid").val() ;
		if(''!=jQuery.trim(factoryid)){
			conditionStr += " and agent_fac like '%"+factoryid+"%'" ;
		}
		var city = jQuery("#city").val();
		if(''!=jQuery.trim(city)){
			conditionStr += " and city like '%"+city+"%' ";
		}
		var username = jQuery("#username").val();
		if(''!=jQuery.trim(username)){
			conditionStr += " and usern = '"+username+"' ";
		}
		var levelflag = jQuery("#levelflag").val();
		if(''!=jQuery.trim(levelflag)){
			conditionStr += " and levelflag = '"+levelflag+"' ";
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
	
	function openWin(id){
		jrWindow("/backend/pro_agent_factory/pro_agent_products_edit.jsp?id="+id,"导入产品",900,600);	
	}
	function openBrand(id,name){
		jrWindow("/backend/pro_agent_factory/agent_brand.jsp?id="+id+"&name="+name,"代理品牌",900,600);	
	}
	//业务员管理
	function openYwy(id){
		jrWindow("/backend/pro_agent_personnel/pro_agent_personnel_list.jsp?id="+id,"业务员管理",750,600);	
	}
	/*打开代理区域修改页面*/
	function openArea(id){
	     jrWindow("/backend/pro_agent_factory/chooseArea.jsp?id="+id,"修改代理地区",900,600);
	}
   /*修改坐标*/
   	function openLac(id){
	     jrWindow("/backend/pro_agent_factory/pro_agent_location.jsp?id="+id,"修改代理地区",800,160);
	}
	function hideAgent(arg){
			if (arg == undefined || arg == null) {
			   arg = {};
		    }
		    var checkedRows = grid.getCheckedRows();
		    if (checkedRows.length <= 0) {
			   return;
		    }
		    var idList=""; var uidList="";
		 	for (var i = 0; i < checkedRows.length; i++) {
				idList += "" + checkedRows[i].id + ",";
				uidList += "" + checkedRows[i].uuid + ",";
		    }
			if (idList.indexOf(",") != -1) {
				idList = idList.substring(0, idList.length - 1);
			}
			if (uidList.indexOf(",") != -1) {
				uidList = uidList.substring(0, uidList.length - 1);
			}
			
			

			
		$.ajax({
				url : '/backend/action/ajax_cud.jsp',
				data :  {flag:"hideAgent",idList:idList},
				type : 'post',
				success : function(data) {
				    alert("隐藏成功!") ;
				 	// grid.loadData();
				}
			});

	}
</script>