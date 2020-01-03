<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_mobile_koubei_list";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String pro_id = CommonString.getFormatPara(request.getParameter("id")) ;
	String fileds = "id,add_date,username,product_id,content";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	//String whereStr = " and is_show=1 ";
	String whereStr = " ";
	if(!"".equals(pro_id))
	{
		whereStr += " and product_id="+pro_id ;
	}
	String orderByStr = " id desc ";
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
  	<div class="searchForm">
  		<div class="searchCondition" style="width:850px;">
		  		<div class="searchLeft">评论时间</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 90px;" name="start_add_date" id="start_add_date" />
		  		</div>
		  		<div class="searchLeft" style="width:10px;">~</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 90px;" name="end_add_date" id="end_add_date" />
		  		</div>
				<div class="searchLeft">用户名</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 90px;" name="username" id="username" />
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
				 <div class="searchLeft">是否有图</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  			<input type="radio" id="is_pic_1" name="is_pic" value="1" />是
                    <input type="radio" id="is_pic_0" name="is_pic" value="0" />否
		  		</div>
				<div class="searchLeft">是否山工</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  			<input type="radio" id="is_sg_1" name="is_sg" value="1" />是
                    <input type="radio" id="is_sg_0" name="is_sg" value="0" />否
		  		</div>
				<div class="searchLeft">是否柳工</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  			<input type="radio" id="is_lg_1" name="is_lg" value="1" />是
                    <input type="radio" id="is_lg_0" name="is_lg" value="0" />否
		  		</div>
				<div class="searchLeft">是否山推</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  			<input type="radio" id="is_st_1" name="is_st" value="1" />是
                    <input type="radio" id="is_st_0" name="is_st" value="0" />否
		  		</div>
				<div class="searchLeft">评论编号</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 90px;" name="comment_id" id="comment_id" />
		  		</div>
  		</div>
  		<div class="searchBtn" style="width:300px;">
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
									text : '放入评论回收站',
									click : function() {
										deleteCheck() ;  
									},
									icon : 'delete'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	/*
	{ display : '评论者', name : 'name', align : 'left' , type : 'string' , width : 100 ,render:function(row){
	  return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
	  }
	} ,
	*/
		{ display : '编号', name : 'id', align : 'center' , type : 'string' , width : 100 } ,
	{ display : '账号', name : 'username', align : 'center' , type : 'string' , width : 100 } ,
	{ display : '评论时间', name : 'add_date', align : 'center' , type : 'date' , width : 100 } ,
	{ display : '产品', name : 'product_id', align : 'center' , type : 'string' , width : 100,render:function(row){
	  return "<a href='/backend/goto.jsp?flag=3&id="+row.product_id+"' class='link' target='_blank'>来源</a>" ;
	  } } ,
	{ display : '详细', name : '', align : 'center' , type : 'string' , width : 100,render:function(row){
	  return "<a href='http://koubei.21-sun.com/detail/"+row.id+".htm' class='link' target='_blank'>详细</a>" ;
	  } } ,
	{ display : '评价内容', name : 'content', align : 'left' , type : 'string' , width : 650 } 
	/*
	{ display : '显示', name : 'is_show', align : 'center' , type : 'string' , width : 100 ,render:function(row){
	  return ((jQuery.trim(row.is_show)==1)?"<font color='green'>是</font>":"<font color='red'>否</font>") ;
	 }
	} 
	*/
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:550,
	    		title:'增加',
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:700,
	    		height:550,
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
		var start_add_date = jQuery("#start_add_date").val() ;
		if(''!=jQuery.trim(start_add_date))
		{
		   conditionStr += " and add_date >='"+start_add_date+" 00:00:00' ";
		}
		var end_add_date = jQuery("#end_add_date").val() ;
		if(''!=jQuery.trim(end_add_date))
		{
		    conditionStr += " and add_date<='"+end_add_date+" 23:59:59'" ;
		}
		var username = jQuery("#username").val() ;
		if(''!=jQuery.trim(username))
		{
		    conditionStr += " and username='"+username+"'" ;
		}
		var factoryid = jQuery("#factoryid").val();
		if(''!=jQuery.trim(factoryid)){
			conditionStr += " and  (factoryid="+factoryid+")";
		}
		var is_pic = jQuery("input[name='is_pic']:checked").val();
		if(''!=jQuery.trim(is_pic)){
		    if(is_pic==1){
			conditionStr += " and id in (SELECT comment_id FROM pro_comments_image)";
			}else if(is_pic==0){
			conditionStr += " and  id  not in (SELECT comment_id FROM pro_comments_image)";
			}
		}
		
		var is_sg = jQuery("input[name='is_sg']:checked").val();
		if(''!=jQuery.trim(is_sg)){
		    if(is_sg==1){
			conditionStr += " and  (factoryid=138)";
			}else if(is_sg==0){
			conditionStr += " and  ( factoryid!=138)";
			}
		}
		
		
		var is_lg = jQuery("input[name='is_lg']:checked").val();
		if(''!=jQuery.trim(is_lg)){
		    if(is_lg==1){
			conditionStr += " and  (factoryid=136)";
			}else if(is_lg==0){
			conditionStr += " and  ( factoryid!=136)";
			}
		}
		
		var is_st = jQuery("input[name='is_st']:checked").val();
		if(''!=jQuery.trim(is_st)){
		    if(is_st==1){
			conditionStr += " and  (factoryid=144)";
			}else if(is_st==0){
			conditionStr += " and  ( factoryid!=144)";
			}
		}
		
		var comment_id = jQuery("#comment_id").val() ;
		if(''!=jQuery.trim(comment_id))
		{
		    conditionStr += " and id="+comment_id+"" ;
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
   jQuery("#start_add_date").ligerDateEditor({width:150});
   jQuery("#end_add_date").ligerDateEditor({width:150});
   	// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            //执行的方法  
            doSearch();
        } 
	 }
	 /**
		 * 批量放入回收站方法
		 * 
		 * @param {}
		 *            arg 审核通过时要传的参数
		 */
		function deleteCheck(arg) {
			if (typeof(arg) == 'undefined' || arg == null) {
				arg = {};
			}
			var checkedRows = grid.getCheckedRows();
			if (checkedRows.length <= 0) {
				return;
			}
			// 遍历所有的选中行，如果是没有UUID，则移除
			jQuery.each(checkedRows, function(index, data) {
						if (typeof(this.uuid) == 'undefined') {
							jrDeleteRow(this.__index);
						}
					});
			jrConfirm("确定放入回收站吗？", function(v) {
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
							if ('undefined' == typeof(arg.tableName)) {
								arg.tableName = tableName;
							}
							executeDelete('pro_comments');
						}
					});
		}
		/**
		 * 执行批量审核的方法
		 * 
		 * @param {}
		 *            data 要传向后台的数据
		 */
		function executeDelete(selectData) {
			var enumNo = '';
			for (var i = 0; i < params.length; i++) {
				if (params[i].name == 'enumNo') {
					enumNo = params[i].value;
				}
			}
			jQuery.ajax({
						url:"/backend/action/ajax_r.jsp?flag=orderDeleteCheck&enumNo="+enumNo,
						data : selectData,
						type : 'post',
						async : false,
						cache : false,
						success : function(data) {
							grid.loadData();
						}
					});
		}
</script>