<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	String tableName = "phone_log";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "log_user,log_date,phone,order_id";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));

	DBHelper dbHelper = DBHelper.getInstance() ;
	String whereStr = " ";
	String orderByStr="id desc";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %>1</title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.l-grid-body-table tr td {
	height:25px;
}
</style>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<form name="theform" id="theform" method="post">
  <div class="searchForm">
    <div class="searchCondition">
	  <div class="searchLeft" style="width:70px;">回访人</div>
      <div class="searchRight" style="margin-left: 5px;margin-right: 45px; width: 80px;">
        <select name="log_user" id="log_user" class="jr_select" style="width: 100px;">
		  <option value="">-请选择-</option>
          <option value="mujie">-牟杰-</option>
          <option value="zhangjx">-张嘉迅-</option>
          <option value="zhangxuan">-仉璇-</option>
          <option value="jiangcc">-姜翠翠-</option>
        </select>
      </div>
	
      <div class="searchLeft" style="width:70px;">回访时间</div>
      <div class="searchRight" >
        <input type="text" style="width: 150px;"  name="start_date" id="start_date"  class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" />
      </div>
      <div class="searchLeft" style="width:10px;">&nbsp;~</div>
      <div class="searchRight" >
        <input type="text" style="width: 150px;"  name="end_date" id="end_date"  class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" />
      </div>
	
    </div>
    <div class="searchBtn">
      <input type="button" class="btn" onclick="doSearch();" value="查询" />
      <input style="margin-left: 5px;" type="button" class="btn" onclick="doClearForm();" value="重置" />
    </div>
  </div>
  <input type="hidden" name="if_tag" id="if_tag" value="test"/>
  <input type="hidden" name="flag_400" id="flag_400" value=""/>
</form>
<div style="clear: left;"></div>
<div class="l-loading" style="display: block" id="pageloading"></div>
<div id="maingrid" style="margin: 0; padding: 0"></div>
<div style="display: none;">
  <input type="hidden" name="channel_uuid" id="channel_uuid" value="<%=channelUUID %>" />
  <input type="hidden" name="if_tag" id="if_tag" value="test"/>
</div>
</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/date/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">

</script>
<script type="text/javascript">
	var isData = [{ is_deal: 1, text: '是' }, { is_deal: 0, text: '否'}];
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
					selectRowButtonOnly : false,
					parms : params,
					rownumbers : true,
					toolbar : {

					},
					enabledEdit: true,
					onAfterEdit:function(e){
					  if(e.column.columnname=='is_deal'){ 
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'isDeal',
					  				uid:e.record.uuid,
					  				value:e.value
					  			},
					  			type:'post'
					  		}) ;
					  } 
					  if(e.column.columnname=='deal_desc'){
					  var _value = jQuery.trim(e.value) ;
					  if(''!=_value){
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'isDeal_desc',
					  				uid:e.record.uuid,
					  				value:_value
					  			},
					  			type:'post'
					  		}) ;					  	
					  }
					}
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
		{ display : '回访人', name : 'log_user', align : 'center' , type : 'string' , width : 110 ,render:function(row){
				if(row.log_user=="mujie"){
				    return  "牟杰";
				}else 	if(row.log_user=="zhangjx"){
				    return  "张嘉迅";
				}else 	if(row.log_user=="zhangxuan"){
				    return  "仉璇";
				}else 	if(row.log_user=="jiangcc"){
				    return  "姜翠翠";
				}
		
			
    	   } } ,
        { display : '回访时间', name : 'log_date', align : 'center' , type : 'string' , width : 170 } ,
        { display : '回访电话', name : 'phone', align : 'center' , type : 'string' , width : 150 } ,
        { display : '回访订单ID', name : 'order_id', align : 'center' , type : 'string' , width : 150 } ,
	];

	
	
	function doSearch(){
		params = [];
		conditionStr = "";
		var log_user = jQuery("#log_user").val();
		if(''!=jQuery.trim(log_user)){
			conditionStr += " and log_user ='"+log_user+"'";
		}

		var start_date = jQuery("#start_date").val();
		if(''!=jQuery.trim(start_date)){
			conditionStr += " and log_date >='"+start_date+"'";
		}
		var end_date = jQuery("#end_date").val() ;
		if(''!=jQuery.trim(end_date))
		{
		   conditionStr += " and log_date <='"+end_date+"'";
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
       jQuery("#factoryid option:eq(0)").attr("selected",true) ;
	}


</script>