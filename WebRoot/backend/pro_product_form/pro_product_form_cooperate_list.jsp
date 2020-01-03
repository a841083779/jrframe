﻿<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	String tableName = "pro_agent_products_form";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,add_date,factory_name,cata_name,name,user_name,product_name,contact_address,contact_tel,state,mobile_phone,product_id,city,is_success,uuid,agent_id";
	 // String fields = "id,uuid,no,contact_address,user_name,contact_tel,add_date,message,buy_time,ifgroup,factory_name,cata_name,product_name,state";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String agent_id=CommonString.getFormatPara(request.getParameter("agent_id"));
	//System.out.println("获取到的id为："+agent_id);
	Map channelMap = (Map)application.getAttribute("channelMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
	DBHelper dbHelper = DBHelper.getInstance() ; 
	String whereStr = "and is_push=1 and agent_id="+agent_id;
	String orderByStr = " id desc ";
	CommonForm commonForm = new CommonForm() ;
	Map stateMap = new HashMap() ;
	stateMap.put("0","否") ;
	stateMap.put("1","是") ;
	stateMap.put("-1","全部") ;
	List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
	List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.l-grid-body-table tr td { height:25px; }
</style>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
</head>
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
					
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : 'ID', name : 'id', align : 'center' , type : 'string' , width : 50 ,render:function(row){
	    return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.id+"</a>";
	  }
	} ,
	{ display : '订单人', name : 'user_name', align : 'left' , type : 'string' , width : 50 } ,
	{ display : '订购产品', name : 'product_name', align : 'left' , type : 'string' , width : 100 ,render:function(row){
	   return "<a href='/inquiry/detail_for_"+row.id+".htm' target='_blank'>"+(row.product_name==null?"":row.product_name)+"</a>" ;
	  }
	} ,
	{ display : '所属分类', name : 'cata_name', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '所属厂家', name : 'factory_name', align : 'left' , type : 'string' , width : 80 ,render:function(row){
	   	return "<a href='../goto.jsp?flag=2&id="+row.factoryid+"' target='_blank'>"+(row.factory_name==null?"":row.factory_name)+"</a>" ;
	 }
	} ,
	{ display : '所在地区', name : 'contact_address', align : 'left' , type : 'string' , width : 100 } ,
	{ display : '手机号码', name : 'contact_tel', align : 'left' , type : 'string' , width : 90 } ,
	
	{ display : '预计购买时间', name : 'buy_time', align : 'center' , type : 'string' , width : 80,render:function(row){
				return  getBuyTime(row.buy_time) ;
	} } ,
	{ display : '订购时间', name : 'add_date', align : 'center' , type : 'string' , width : 150 ,render:function(row){
	      return (row.add_date.length>=19)?row.add_date.substr(0,19):row.add_date ;
	  }
	} 

	];
	
	//短信发送
	function sendSms(index){
		var row = grid.getRow(index);
		var url = "/backend/function/send_sms/send.jsp?city="+row.city+"&province="+row.province+"&order_id="+row.id+"&factoryid="+row.factoryid+"&param="+encodeURIComponent(row.contact_address+row.name+row.mobile_phone+"询"+row.factoryname+row.product_name+row.cataname);
		jrWindow(url, "短信发送", 600, 300);
	}
	
	//订单推送
	function sendOrder(index,flag){
		var row = grid.getRow(index);
		var url ="";
		if(flag=="1"){
		   url = "/tools/order_interface/cat_admin.jsp?uuid="+row.uuid;
		}else if(flag=="2"){
		   url = "/tools/order_interface/shangong_admin.jsp?uuid="+row.uuid;
		}
		
		jrWindow(url, "订单推送", 600, 300);
	}
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:620,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:620,
	    		title:'修改' 
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
		var start_date = jQuery("#start_date").val();
		if(''!=jQuery.trim(start_date)){
			conditionStr += " and add_date >='"+start_date+" 00:00:00'";
		}
		var tel = jQuery("#tel").val();
		if(''!=jQuery.trim(tel)){
			conditionStr += " and mobile_phone like '%"+tel+"%' ";
		}
		var end_date = jQuery("#end_date").val() ;
		if(''!=jQuery.trim(end_date))
		{
		   conditionStr += " and add_date <='"+end_date+" 23:59:59'";
		}
		var factoryname = jQuery("#factoryname").val();
		if(''!=jQuery.trim(factoryname)){
			conditionStr += " and factoryname like '%"+factoryname+"%' ";
		}
		var cataname = jQuery("#cataname").val();
		if(''!=jQuery.trim(cataname)){
		alert(cataname) ;
		
			conditionStr += " and cataname like '%"+cataname+"%' ";
		}
		var user_name = jQuery("#user_name").val();
		if(''!=jQuery.trim(user_name)){
			conditionStr += " and user_name like '%"+user_name+"%' ";
		}
		var product_name = jQuery("#product_name").val();
		if(''!=jQuery.trim(product_name)){
			conditionStr += " and product_name like '%"+product_name+"%' ";
		}
		var contact_address = jQuery("#contact_address").val();
		if(''!=jQuery.trim(contact_address)){
			conditionStr += " and contact_address like '%"+contact_address+"%' ";
		}
		var state = jQuery("input[name='state']:checked").val();
		if(''!=jQuery.trim(state) && '-1'!= jQuery.trim(state)){
			conditionStr += " and state = '"+state+"' ";
		}
		var is_success  = jQuery("input[name='is_success']:checked").val();
		if('1'== jQuery.trim(is_success)){
			conditionStr += " and is_success  = '1' ";
		}else if('0'== jQuery.trim(is_success)){
			conditionStr += " and (is_success  is null  or  is_success=''  or  is_success='0' )  ";
		}
		var is_first  = jQuery("input[name='is_first']:checked").val();
		if('1'== jQuery.trim(is_first)){
			conditionStr += " and is_first  = '1' ";
		}else if('0'== jQuery.trim(is_first)){
			conditionStr += " and (is_first  is null  or  is_first=''  or  is_first='0' )  ";
		}
		
		var catalogname = jQuery("#catalogname").val() ;
		if(''!=jQuery.trim(catalogname))
		{
		  conditionStr += " and cataname like '%"+catalogname+"%' ";
		}
		var factoryid = jQuery("#factoryid").val() ;
		if(''!=jQuery.trim(factoryid))
		{
		  conditionStr += " and factoryid='"+factoryid+"'";
		}
		var start_form_id = jQuery("#start_form_id").val() ;
		var end_form_id = jQuery("#end_form_id").val() ;
		if(''!=start_form_id)
		{
		    conditionStr += " and id>='"+start_form_id+"'";
		}
		if(''!=end_form_id)
		{
		    conditionStr += " and id<='"+end_form_id+"'";
		}
		var catalognum = jQuery.trim(jQuery("#catalognum").val()) ;
		if(''!=catalognum){
			 conditionStr += " and catanum like '"+catalognum+"%'";
		}
		var orderbywhat = jQuery("#orderbywhat").val() ;
		if(''!=orderbywhat){
		   orderBy = orderbywhat + " desc" ; 
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
		jQuery(".searchForm input:text,select").val('');
		 // alert(jQuery(".searchForm select option:eq(0)").html()) ;
       jQuery("#catanum option:eq(0)").attr("selected",true) ;
       jQuery("#factoryid option:eq(0)").attr("selected",true) ;
	}
	function dosubmit(obj){
	  jrConfirm("是否已选好导出条件？否则数据量会很大",function(v){
	   if(v){
	  jQuery("#if_tag").val(obj) ;
	  jQuery("#theform").attr("action","order_list_excel.jsp") ;
	  jQuery("#theform").attr("method","post") ;
	  jQuery("#theform").submit() ;
	   }
	  });
	}
	// 1 省份 1 月份
	function showTOP10orders(obj){
	  jrWindow("/backend/pro_product_form/top10orders.jsp?if_tag="+obj,obj=="1"?"省份订单量前10位":"月份订单量前10位","600","360") ;
	}
		// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
        }
  //提交提单 预计购买时间
      var buy_time = '' ;
        jQuery(function(){
        	jQuery.ajax({
        	type:"post" ,
        	dateType:'json',
        	url:"/action/ajax.jsp" ,
        	data:{"flag":"order_buy_time"} ,
        	success:function(data){
        	data = jQuery.trim(data) ;
        	data = jQuery.parseJSON(data);
        	buy_time = data ;
        }
        	}) ;
        }) ;
     function getBuyTime(buytime_flag){
        var showtime = "" ;
     	jQuery(buy_time).each(function(i,n){
     	if(jQuery.trim(buytime_flag)==jQuery.trim(n.no)){
     	    showtime = n.name 
          	return false ;
          }else if(jQuery.trim(buytime_flag)=='jinqi'){
           showtime='近期' ;
         	}else{
           showtime='-' ;
         	}
     	}) ;
     	return showtime ;
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
				executeOrderDel(arg);
			}
		});
	}
	
	function executeOrderDel(arg){
		arg.flag = "updateProductOrderDelete";
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