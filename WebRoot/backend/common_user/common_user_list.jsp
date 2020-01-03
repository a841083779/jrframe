<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,org.json.JSONArray" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix + "common_user";
	String fileds = "id,uuid,usern,role_uuid,name,sex,telephone,state,login_count,last_login_date,last_login_ip";
	String whereStr = " and usern <> 'admin' ";
	String orderByStr = " id desc ";
	List roles = dbHelper.getMapList(" select uuid,role_name from "+Env.getInstance().getProperty("table_prefix")+"common_role ");
	JSONArray roleArray = new JSONArray(roles);
	Map roleMap = CommonCollection.listToMap(roles,"uuid","role_name");
	roleMap.put("","--选择角色--");
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
  		<div class="searchCondition">
		  		<div class="searchLeft">用<span class="span3"></span>户<span class="span3"></span>名</div>
		  		<div class="searchRight">
		  			<input type="text" name="usern" style="width: 150px;" class="jr_text" id="usern" />
		  		</div>
		  		<div class="searchLeft">角<span class="span2"></span>色</div>
		  		<div class="searchRight">
		  			<select name="role_uuid" id="role_uuid" class="jr_select">
		  				<%=CommonForm.createSelect(roleMap,"") %>
		  			</select>
		  		</div>
		  		<div class="searchLeft">姓<span class="span2"></span>名</div>
		  		<div class="searchRight">
		  			<input type="text" class="jr_text" style="width: 150px;" name="name" id="name" />
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
	<div style="display: none;"></div>
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
	var roles = <%=roleArray.toString() %>;
	jQuery(function() {
		jQuery.ligerDefaults.Grid.formatters["date"] = function(content,
				column) {
			return content.substring(0, content.indexOf(" "));
		}
		jQuery.ligerDefaults.Grid.formatters["is"] = function(content,
				column) {
			if (content == 1) {
				return "是";
			}
			return "否";
		}
		jQuery.ligerDefaults.Grid.formatters["sex"] = function(content,
				column) {
			if (content == 1) {
				return "男";
			}
			return "女";
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
						items : [{
									text : '增加',
									click : function(obj){
										addAndEdit();
									},
									icon : 'add'
								}, {
									text : '删除',
									click : function(){
										toolbarDel();
									},
									icon : 'delete'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [
		{ display : '用户名', name : 'usern', align : 'left' , type : 'string' , width : 200 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.usern+"</a>";
			}
		} ,
		{ display : '角色', name : 'role_uuid', align : 'left' , type : 'string' , width : 100 , render : function(row){
				for(var i=0;i<roles.length;i++){
					if(roles[i].role_uuid==row.role_uuid){
						return roles[i].role_name;
					}
				}
				return "";
			}
		} ,
		{ display : '姓名', name : 'name', align : 'left' , type : 'string' , width : 100 } ,
		{ display : '性别', name : 'sex', align : 'center' , type : 'sex' , width : 100 } ,
		{ display : '电话', name : 'telephone', align : 'left' , type : 'string' , width : 100 } ,
		{ display : '是否禁用', name : 'state', align : 'center' , type : 'is' , width : 100 } ,
		{ display : '登录次数', name : 'login_count', align : 'right' , type : 'int' , width : 100 } ,
		{ display : '登录日期', name : 'last_login_date', align : 'center' , type : 'date' , width : 100 } ,
		{ display : '登录IP', name : 'last_login_ip', align : 'center' , type : 'string' , width : 140 } ,
		{ display : '权限',  align : 'center' , type : 'string' , width : 100 , render : function(row){
				var htm = "";
				if(jQuery.trim(row.role_uuid)=='4CCDF227-7F10-4E09-A47C-085CCB4A45FF'){
					htm += "<a class='link' href='javascript:void(0);' onclick='jrWindow(\"/backend/common_user/common_power.jsp?id="+row.uuid+"\",\"用户权限\",300,400);'>权限设置</a>";
				}
				return htm;
			}
		}
	];
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var usern = jQuery("#usern").val();
		if(''!=jQuery.trim(usern)){
			conditionStr += " and usern = '"+usern+"' ";
		}
		var role_uuid = jQuery("#role_uuid").val();
		if(''!=jQuery.trim(role_uuid)){
			conditionStr += " and role_uuid = '"+role_uuid+"' ";
		}
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
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
		var m = jQuery("#role_uuid").ligerGetComboBoxManager();
		jQuery("#role_uuid").val('');
		m.setValue('');
	}

    function addAndEdit(index){
    	if(undefined==index){//如果是增加
			toolbarAdd({
				width:700,
				height:530,
				title:"用户增加"
			});
    	}else{//如果是修改
	    	var row = grid.getRow(index);
	    	toolbarAdd({
		    	width:700,
		    	height:530,
		    	title:"用户编辑"
	    	},row.uuid);
    	}
    }
</script>