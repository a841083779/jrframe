<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%><%
	String tableName = "pro_product_form";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,add_date,factoryname,cataname,name,product_name,contact_address,contact_tel,state,mobile_phone,product_id";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	
	Map agentInfo = (Map)session.getAttribute("agentInfo");
	String whereStr = " ";
	String agent_area = CommonString.getFormatPara(agentInfo.get("city")) ;  // 代理商代理地区
	String agent_factory = CommonString.getFormatPara(agentInfo.get("agent_fac")) ;  // 代理品牌
	String[] agent_factorys = null ;
	String agent_factory_str = "" ;
	 if(agent_factory.length()>0 && agent_factory.indexOf(",")>0){
		 agent_factorys = agent_factory.split(",") ;
	 }else{
		 whereStr+=" and factoryid="+agent_factory ;
	 }
	 if(null!=agent_factorys){
		 for(int i=0;i<agent_factorys.length;i++){
			 if(agent_factorys[i].length()>0 ){
				 agent_factory_str+=agent_factorys[i]+"," ;
			 }
		 }
	 }
	 if(agent_factory_str.length()>0 && agent_factory_str.lastIndexOf(",")!=0){
		 agent_factory_str = agent_factory_str.substring(0,agent_factory_str.length()-1) ;
	 }
	 if(agent_factory_str.length()>0){
		 whereStr += " and factoryid in("+agent_factory_str+")" ;
	 }
	 if(agent_area.length()>0 && agent_area.indexOf(",")==-1){ 
		  whereStr+= " and contact_address like'%"+agent_area+"%'" ;
	 }
	 String where = "" ;
	 if(agent_area.length()>0 && agent_area.indexOf(",")>0){  // 代理多个区域
		 String[] agent_areas = agent_area.split(",") ;
		 for(int i=0;i<agent_areas.length;i++){
			 where+=" or contact_address like '%"+agent_areas[i]+"%'" ;
		 }
	 }
	 if(where.length()>0 && where.indexOf("or")>0){
		 where = where.replaceFirst("or","") ;
	 }
	 if(where.length()>0){
		 whereStr+= " and ( "+where+" )" ;
	 }
	 System.out.println(whereStr+"--") ;
	String orderByStr = " id desc ";
	CommonForm commonForm = new CommonForm() ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/admin/style/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.l-grid-body-table tr td{
	 height:22px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
  <form name="theform" id="theform" method="get">
  	<div class="searchForm">
  		<div class="searchCondition" style="width:547px">
  		  	<div class="searchLeft">订单人</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 60px;" class="jr_text" name="name" id="name" />
		  		</div>
		  		<div class="searchLeft">订购时间</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 80px;"  name="start_date" id="start_date" />
		  		</div>
		  			<div class="searchLeft" style="width:10px;">&nbsp;~</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 80px;"  name="end_date" id="end_date" />
		  		</div>   	
  		</div>
  		<div class="searchBtn" style="width:170px">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
  		</div>
  	</div>
  	<input type="hidden" name="if_tag" id="if_tag" value="test"/>
	</form>
  	<div style="clear: left;"></div>
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div id="maingrid" style="margin: 0; padding: 0"></div>
	<div style="display: none;">
		<input type="hidden" name="channel_uuid" id="channel_uuid" value="<%=channelUUID %>" />
	</div>
  </body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/admin/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
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
		url = "/admin/action/liger.jsp";
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':whereStr});
		params.push({'name':'orderBy','value':orderBy});
		grid = jQuery("#maingrid").ligerGrid({
					columns : columnsArr,
					url : url,
					pageSize : 16,
					width : '99%',
					height : '98%',
					onAfterShowData : function(){
					 if(jQuery.trim(jQuery(".l-grid-body-table tbody").html())==''){
					 jQuery("#maingridgrid").html("<font size='4px'>您负责的地区暂无订单！</font>") ;
					 }
					},
					checkbox : false,
					selectRowButtonOnly : true,
					parms : params,
					rownumbers : true
				});
			
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '订单人', name : 'name', align : 'left' , type : 'string' , width : 100 ,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>" ;
		}
	} ,
	{ display : '订购产品', name : 'product_name', align : 'left' , type : 'string' , width : 100 ,render:function(row){
	   return "<a href='/tools/goto.jsp?flag=1&id="+row.product_id+"' target='_blank'>"+(row.product_name==null?"":row.product_name)+"</a>" ;
	  }
	} ,
	{ display : '所在地区', name : 'contact_address', align : 'center' , type : 'string' , width : 90 } ,
	{ display : '手机号码', name : 'mobile_phone', align : 'center' , type : 'string' , width : 150 ,render:function(row){
		return  (row.state==0?"<a class='link' href='javascript:;' onclick='showTel(this,"+row.mobile_phone+")' showid="+row.uuid+">查看</a>":row.mobile_phone) ;
	  }} ,
	{ display : '订购时间', name : 'add_date', align : 'center' , type : 'string' , width : 150 ,render:function(row){
	      return (row.add_date.length>=19)?row.add_date.substr(0,19):row.add_date ;
	  }
	}
	];
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:520,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:520,
	    		title:'查看',
				folderName:"agent/pro_product_form"
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
		var end_date = jQuery("#end_date").val() ;
		if(''!=jQuery.trim(end_date))
		{
		   conditionStr += " and add_date <='"+end_date+" 23:59:59'";
		}
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
		 // alert(jQuery(".searchForm select option:eq(0)").html()) ;
       jQuery("#catanum option:eq(0)").attr("selected",true) ;
       jQuery("#agentid option:eq(0)").attr("selected",true) ;
	}
	function dosubmit(obj){
	  jQuery("#if_tag").val(obj) ;
	  jQuery("#theform").attr("action","order_list_excel.jsp") ;
	  jQuery("#theform").attr("method","post") ;
	  jQuery("#theform").submit() ;
	}
	
	jQuery("#start_date").ligerDateEditor({width:150});
	jQuery("#end_date").ligerDateEditor({width:150});
	function  showTel(obj,phone){
	var uuid = jQuery(obj).attr("showid") ;  // 更改操作，更改该条订单的状态 
	if(jQuery.trim(uuid)!=''){
		jQuery.ajax({
			type:"post" ,
			url:"/admin/action/ajax_cud.jsp" ,
			data:{"flag":"changeOrderState","idStr":uuid} ,
			success:function(msg){
				
			}
		}) ;
	}
	jQuery(obj).parent().text(phone) ;
		
	}
</script>