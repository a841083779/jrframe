<%@ page language="java" import="com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %>1</title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.l-grid-body-table tr td{
	 height:25px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div style="float: left; width: 49%"><div id="maingrid" style="margin: 0; padding: 0"></div></div>
	<div style="float: right; width: 50%; padding-top: 150px; text-align: center;">
		<div id="chartdiv"></div>
	</div>
	<div style="clear: left;"></div>
  </body>
</html>
<script type="text/javascript" src="/plugin/report/FusionChartsV3/JSClass/FusionCharts.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script type="text/javascript">
	var columnsArr = [
		{ display : '外呼结果', name : 'name', align : 'center' , type : 'string' , width : 130 } ,
		{ display : '结果数量', name : 'counts', align : 'center' , type : 'string' , width : 130 } 
	];
	jQuery("#maingrid").ligerGrid({
		columns : columnsArr,
		url : "/backend/action/ajax_r.jsp?flag=task2_list_report",
		pageSize : 20,
		width : '99%',
		height : '98%',
		checkbox : false,
		selectRowButtonOnly : true,
		rownumbers : true,
		toolbar : null,
		usePager : false		
	});
	jQuery("#pageloading").hide();
	var chart = new FusionCharts("/plugin/report/FusionChartsV3/Charts/Column2D.swf", "chartdiv", "500", "300", "0", "0");
	chart.setDataURL(escape("/backend/action/chart_action.jsp?flag=task2_chart_report"));		   
	chart.render("chartdiv");
</script>