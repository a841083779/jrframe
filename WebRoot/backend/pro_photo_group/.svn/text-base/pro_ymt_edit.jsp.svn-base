<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	String tableName = "pro_products";
	String group_id = CommonString.getFormatPara(request.getParameter("id")) ;
	String agentid = CommonString.getFormatPara(request.getParameter("ids")) ;
     
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ; // 栏目 
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = " and  is_show=1";
	if(!"".equals(agentid)){
		whereStr += " and factoryid="+agentid ;
	}
	String orderByStr = " id desc ";
	CommonForm commonForm = new CommonForm() ;
	
	DBHelper dbHelper = DBHelper.getInstance() ;
	StringBuffer sel_sql2 = new StringBuffer(" select * from pro_products where 1=1  ") ; // 查出已经导入的产品
	List<Map> importProductsList = null ;
	if(!"".equals(agentid)){
		sel_sql2.append(" and factoryid=?") ;
		importProductsList = dbHelper.getMapList(sel_sql2.toString(),new Object[]{agentid}) ;
	}
	StringBuffer idStr = new StringBuffer("") ;
	if(null!=importProductsList && importProductsList.size()>0){
		for(Map oneMap:importProductsList){
			idStr.append(CommonString.getFormatPara(oneMap.get("uuid"))).append(",") ;
		}
	}
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
	List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=Env.getInstance().getProperty("project_name") %></title>
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css"
			rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css"
			rel="stylesheet" type="text/css" />
		<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
.l-grid-body-table tr td {
	height: 30px;
}
</style>
		<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	</head>
	<body>
	  <form name="theform" id="theform" action="" method="post">
  	<div class="searchForm">
  		<div class="searchCondition" style="width:250px;">
		  		<div class="searchLeft">产品名称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" name="productname" id="productname" />
		  		</div>
	
		  		</div>
		  			<div class="searchLeft">类别</div>
		  		<div class="searchRight">
	  				<select class="jr_select" id="catalognum" name="catalognum">
                   	<option value="">--请选择产品类别--</option>
	  				<%if(catalogList != null){for(Map m : catalogList){%>
                       	<option value="<%=m.get("num")%>" <%=m.get("num").equals(catalognum)?"selected=\"selected\"":""%>><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
                       <%}}%>
	  			</select>
	 
		  		</div>
  		</div>
		<input type="hidden" value="<%=agentid%>" id="fatoryId" name="fatoryId">
  		<div class="searchBtn" style="width:200px;">
  			<input type="button" class="btn" onclick="doSearch();" value="查询" />
  			<input type="button" class="btn" onclick="doClearForm();" value="重置" />
  			&nbsp;
  		</div>
  	</div>
  	<div style="clear: left;"></div>
	<div class="l-loading" style="display: block" id="pageloading"></div> 
	<div id="maingrid" style="margin: 0; padding: 0"></div>
	<div style="display: none;">
		<input type="hidden" name="channel_uuid" id="channel_uuid" value="<%=channelUUID %>" />
	</div>
	<input type="hidden" name="product_id" id="product_id"/>
	<input type="hidden" name="factory_id" id="factory_id"/>
	  </form>
	  <form name="theformed" id="theformed" action="/backend/pro_tuan_pros/tools/other_pros.jsp" method="post">
	  <input type="hidden" name="group_id" id="group_id" value="<%=group_id%>" />
	  <input type="hidden" name="products_ids" id="products_ids" value=""/>
	  </form>
	</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix%>"
	type="text/javascript"></script>
<script type="text/javascript">
	var grid;
	var tableName = "<%=tableName%>";
	var fields = "<%=fileds%>";
	var whereStr = "<%=whereStr%>";
	var orderBy = "<%=orderByStr%>";
	var columnsArr = [];
	var url = "";
	var select="";
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
							//items : [ {
									//text : '增加',
									//click : function(){
									     //doSub1();
									//},
									//icon : 'add'
								//}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组

	columnsArr =  [ 

	{ display : '型号', name : 'name', align : 'center' , type : 'string' , width : 200,render:function(row){
		return getShowName(row) ;
	} } ,
	{ display : '品牌', name : 'factoryname', align : 'center' , type : 'string' , width : 200 } ,
	{ display : '类别', name : 'catalogname', align : 'center' , type : 'string' , width : 150  } ,
	{ display : '厂家价格', name : 'agentprice', align : 'center' , type : 'string' , width : 150,render:function(row){
	     return row.agentprice=="null"?"-":row.agentprice;
	  } }

	];
	
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/

	
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
	}

	function deleteData(arg) {
	if (arg == undefined || arg == null) {
		arg = {};
	}
	

	
	// 遍历所有的选中行，如果是没有UUID，则移除
	jQuery.each(checkedRows, function(index, data) {
				if (this.uuid == undefined) {
					jrDeleteRow(this.__index);
				}
			});

   }

var idStr = '<%=idStr%>' ;
function getShowName(row){
	if(idStr.indexOf(row.uuid)!=-1){
		return "<font color='red'>"+row.name+"</font>" ;
	}else{
		return row.name ;
	}
}

   //表单提交
   var ids="";
	function doSub(){
	var checkedRows = grid.getCheckedRows();
	if (checkedRows.length <= 0) {
	    alert("请选择产品");
		return;
	}else{  
	   $(checkedRows).each(
	      function(){  
		   ids=ids+this.id+",";
		  } 
	   );
	var num=ids.lastIndexOf(",");   
	    ids=ids.substring(0,num);
		jQuery("#products_ids").val(ids);
		theformed.submit();
	}
}


	function doSearch(){
		params = [];
		conditionStr = "";
		var productname = jQuery("#productname").val() ;
		if(''!=jQuery.trim(productname))
		{
		   conditionStr += " and name like '%"+productname+"%'";
		}

		var catalognum = jQuery("#catalognum").val() ;
		
		if(''!=jQuery.trim(catalognum)){
		conditionStr += " and catalognum  like '"+catalognum+"%'" ;
		}
		
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':whereStr+conditionStr});
		params.push({'name':'orderBy','value':orderBy});
		grid.options.parms=params;
		grid.loadData();
	} 
</script>