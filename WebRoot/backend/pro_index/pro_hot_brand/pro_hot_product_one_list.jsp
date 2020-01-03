<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_index_data";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String whereStr = " and channel_uuid='"+channelUUID+"'";
	String orderByStr = " order_no  asc ";
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
  
 <div style="height:30px;">
 <a href="javascript:;" onclick="create_pro();"><h2>全部生成</h2></a>
 </div>
<div class="l-grid2" style="width: 1148px; left: 57px;">  
	<table class="l-grid-body-table" cellpadding="0" cellspacing="0"><tbody><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">名称</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">推土机</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="/index_new/index_new/index_hot_tuituji.htm" target="_blank" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">叉车</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="/index_new/index_new/index_hot_chache.htm" target="_blank" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">压路机</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="/index_new/index_new/index_hot_yaluji.htm" target="_blank" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">筑路机械</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="/index_new/index_new/index_hot_zhulujixie.htm" target="_blank" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">平地机</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="/index_new/index_new/index_hot_pingdiji.htm" target="_blank" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">旋挖钻</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="/index_new/index_new/index_hot_xuanwazuan.htm" target="_blank" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">底下矿工机械</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
    <a class="link" href="/index_new/index_new/index_hot_kuangshanjixie.htm" target="_blank" >预览地址</a></div></td></tr><tr id="maingrid|2|r1001" class="l-grid-row l-grid-row-over">
	
	<td id="maingrid|2|r1001|no" class="l-grid-row-cell " style="width:250px;  ">
	<div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="javascript:void(0);" onclick="addAndEdit(0);">破碎设别</a></div>
	</td><td><div class="l-grid-row-cell-inner" style="width:242px;height:22px;min-height:22px; text-align:left;">
	<a class="link" href="/index_new/index_new/index_hot_posuishebei.htm" target="_blank" >预览地址</a></div>
	</td>
	</tr></table>
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
									text : '热门产品页面生成',
									click : function(){
										create_pro();
									},
									icon : 'settings'
								},{
									text : '热门产品页面浏览',
									click : function(){
										window.open("/index_new/index_new/index_hot_tuituji.htm","_blank");
									},
									icon : 'config'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	    { display : '排序号', isSort : false , name : 'order_no', align : 'center' , type : 'string' , width : 100 },   
		{ display : '名称', name : 'title', isSort : false ,  id : 'no' , align : 'left' , type : 'string' , width : 250 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.title+"</a>";
			}
		},
		{ display : '是否显示', isSort : false , name : 'is_pub', align : 'center' , type : 'is' , width : 60 }
	];
	
	  //增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:500,
	    		title:'增加',
				fileName:"pro_hot_product",
				folderName:"pro_index",
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:700,
	    		height:500,
				fileName:"pro_hot_product",
				folderName:"pro_index",
	    		title:'修改'
	    	},row.uuid);
    	}
    }

//静态页生成
	function create_pro(){
		jQuery.ajax({
			type:'post' ,
			url:'/tools/create_index/create_index_hot.jsp?flag=hot' ,
			success:function(data){
			if($.trim(data)=='true'){
			alert("静态更新成功！")	;
			}else{
			alert(data)	;
			}}
		}) ;
		
	}
	
</script>