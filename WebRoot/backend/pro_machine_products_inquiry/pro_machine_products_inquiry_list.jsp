<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%

	String tablePrefix = Env.getInstance().getProperty("table_prefix");
    String tableName = "pro_machine_products_inquiry";
	String fileds = "id,name,add_date,mobile_phone,province,city,product_name,factoryname,cataname,message,uuid";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = " and is_del=0 ";
	String orderByStr = " id desc ";
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	List <Map> catalog=null;
	List <Map> brandList = null;
	try{
		connection=dbHelper.getConnection();
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
		  		<div class="searchLeft">姓名</div>
		  		<div class="searchRight">
		  			<input type="text" id="name" name="name" style="width: 160px;" class="jr_text" />
		  		</div>
		  		<div class="searchLeft">手机号</div>
		  		<div class="searchRight">
		  			<input type="text" id="mobile_phone" name="mobile_phone" style="width: 160px;" class="jr_text" />
		  		</div>
		  		<div class="searchLeft">省</div>
		  		<div class="searchRight">
		  			<input type="text" id="province" name="province" style="width: 100px;" class="jr_text" />
		  		</div>
		  		<div class="searchLeft">市</div>
		  		<div class="searchRight">
		  			<input type="text" id="city" name="city" style="width: 100px;" class="jr_text" />
		  		</div>
		  		
              
  		</div>
  		<div class="searchCondition">
		  		
		  		<div class="searchLeft">品牌</div>
		  		<div class="searchRight">
		  			<select class="jr_select" id="factoryid" name="factoryid">
                    	<option value="">--请选择品牌--</option>
		  				<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=m.get("first_letter")%>-<%=m.get("name")%></option>
                        <%}}%>
		  			</select>
		  		</div>
		  		<div class="searchLeft">产品类别</div>
		  		<div class="searchRight">
		  			<select class="jr_select" id="catanum" name="catanum">
                    	<option value="">--请选择产品类别--</option>
		  				<%if(catalogList != null){for(Map m : catalogList){%>
                        	<option value="<%=m.get("num")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
                        <%}}%>
		  			</select>
		  		</div>
		  		<div class="searchLeft">产品名称</div>
		  		<div class="searchRight">
		  			<input type="text" id="product_name" name="product_name" style="width: 100px;" class="jr_text" />
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
						items : [ {
									text : '删除',
									click : function(){
										toolbarOrderDel();
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
	{ display : '姓名', name : 'name', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '手机号', name : 'mobile_phone', align : 'left' , type : 'string' , width : 110 } ,
	{ display : '省市', name : 'province', align : 'left' , type : 'string' , width : 110 ,render:function(row){
	   return row.province+" "+row.city;
	}} ,
	{ display : '产品', name : 'product_name', align : 'left' , type : 'string' , width : 180,render:function(row){
	   return row.factoryname+row.product_name+row.cataname;
	}} ,
	{ display : '询价时间', name : 'add_date', align : 'center' , type : 'string' , width : 100 }  
	];
	

	
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
			conditionStr += " and (factoryid = '"+factoryid+"')";
		}
		var catanum = jQuery("#catanum").val();
		if(''!=jQuery.trim(catanum)){
			conditionStr += " and catanum like '"+catanum+"%' ";
		}
		
		var mobile_phone = jQuery("#mobile_phone").val();
		if(''!=jQuery.trim(mobile_phone)){
			conditionStr += " and mobile_phone like '"+mobile_phone+"%' ";
		}
		var province = jQuery("#province").val();
		if(''!=jQuery.trim(province)){
			conditionStr += " and province like '"+province+"%' ";
		}
		var city = jQuery("#city").val();
		if(''!=jQuery.trim(city)){
			conditionStr += " and city like '"+city+"%' ";
		}
		var product_name = jQuery("#product_name").val();
		if(''!=jQuery.trim(product_name)){
			conditionStr += " and product_name like '"+product_name+"%' ";
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
		jQuery("#catanum").val('');
		jQuery("#mobile_phone").val('');
		jQuery("#province").val('');
		jQuery("#city").val('');
		jQuery("#product_name").val('');
	}
	
	
	// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
    }
    
   function toolbarOrderDel(arg) {
		if (arg == undefined || arg == null) {
			arg = {};
		}
		var checkedRows = grid.getCheckedRows();
		if (checkedRows.length <= 0) {
			return;
		}
		// 遍历所有的选中行，如果是没有UUID，则移除
		jQuery.each(checkedRows, function(index, data) {
			if (this.uuid == undefined) {
				jrDeleteRow(this.__index);
			}
		});
		jrConfirm("确定删除选中项吗？", function(v) {
			if (v) {
				var checkedRows = grid.getCheckedRows();
				var idStr = "";
				for (var i = 0; i < checkedRows.length; i++) {
					idStr += "'" + checkedRows[i].uuid + "',";
				}
				if (idStr.indexOf(",") != -1) {
					idStr = idStr.substring(0, idStr.length - 1);
				}
				arg.del_id = idStr;
				if(undefined==arg.tableName){
					arg.tableName = tableName;
				}
				executeLogicalDel(arg);
			}
		});
	}
	
	function executeLogicalDel(arg){
		arg.flag = "updateMachineProductLogicalDel";
		jQuery.ajax({
			url : '/backend/action/ajax_r.jsp',
			data : arg,
			type : 'post',
			async : false,
			cache : false,
			success : function(data) {
				grid.loadData();
			}
		});
	}
    
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>