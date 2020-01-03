<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%><%
	String tableName = "pro_products";
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ; // 获取产品id
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String pro_id = CommonString.getFormatPara(request.getParameter("id")) ; // 代理商id 
	String fileds = "name,factoryname,catalogname,is_show";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String agentid = CommonString.getFormatPara(request.getParameter("agentid")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ; // 栏目 
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = " and id not in (select product_id FROM pro_agent_products where agent_id='"+agentid+"') "; // 除去已经代理的产品id
	if(!"".equals(factoryid)){
		whereStr +=" and factoryid='"+factoryid+"'" ; 
	}
	if(!"".equals(catalognum)){
		whereStr +=" and catalognum like '%"+catalognum+"%'" ;
	}
	List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
	List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	DBHelper dbHelper = DBHelper.getInstance() ;
	if(!"".equals(pro_id))
	{
		whereStr += " and product_id="+pro_id ;
	}
	String orderByStr = " factoryid desc ";
	String productids = CommonString.getFormatPara(request.getParameter("product_id")) ;
	String factoryids = CommonString.getFormatPara(request.getParameter("factory_id")) ;
	productids = productids.replace("'","") ;
	factoryids = factoryids.replace("'","") ;
	String[] products_id = productids.split(",") ;
	String[] factorys_id = factoryids.split(",") ;
	int result = 0 ;
	if(products_id.length>0&&factorys_id.length>0 && products_id.length==factorys_id.length){
		String insert_sql = "" ;
		for(int i=0;i<products_id.length;i++){
			insert_sql = "insert into pro_agent_products(agent_id,product_id,price,factory_id,uuid) values('"+agentid+"','"+products_id[i]+"',null,'"+factorys_id[i]+"','"+UUID.randomUUID().toString()+"'"+")";
			if(!"".equals(products_id[i]) && !"".equals(factorys_id[i])){
				result += dbHelper.execute(insert_sql) ;
			}
		}
	}
	if(result>0){
		products_id = null ;
		factorys_id = null ;
		result = 0 ;
		%>
		<script>
		  alert("产品追加成功！");
		  try{
			// opener.document.location.reload();
			// window.location.reload() ;
			}catch(e){
			}	
		</script>
		<%
	}
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
  <form name="theform" id="theform" action="" method="post">
  	<div class="searchForm">
  		<div class="searchCondition" style="width:750px;">
		  		<div class="searchLeft">产品名称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" name="productname" id="productname" />
		  		</div>
		  		<div class="searchLeft">品牌</div>
		  		<div class="searchRight">
	  			<select class="jr_select" id="factoryid" name="factoryid">
                   	<option value="">--请选择品牌--</option>
	  				<%if(brandList != null){for(Map m : brandList){%>
                       	<option value="<%=m.get("id")%>"><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
                       <%}}%>
	  			</select>
	  			<script type="text/javascript">
	  			 var length=jQuery("#factoryid option").length;
	  			 for(var i=0;i<length;i++){
	  			  if(''!=jQuery("#factoryid option:eq("+i+")").val() && (jQuery("#factoryid option:eq("+i+")").val()=="<%=factoryid%>")){
	  			    	jQuery("#factoryid option:eq("+i+")").attr("selected","selected") ;
	  			  }
	  			 }
	  			</script>
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
  		<div class="searchBtn" style="width:300px;">
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
									text : '增加',
									click : function(){
										var checkedRows = grid.getCheckedRows();
										var idStr = "";
										var facidStr = "" ;
										for (var i = 0; i < checkedRows.length; i++) {
											idStr += "'" + checkedRows[i].id + "',";
											facidStr += "'" + checkedRows[i].factoryid + "',";
										}
										if (idStr.indexOf(",") != -1 &&facidStr.indexOf(",")!=-1 ) {
											idStr = idStr.substring(0, idStr.length - 1);
											facidStr = facidStr.substring(0, idStr.length - 1);
											jQuery("#product_id").val(idStr) ;
											jQuery("#factory_id").val(facidStr) ;
											 jrConfirm("确定导入吗?",function(yes){
											 	if(true==yes){
											 		 jQuery("#theform").submit() ;  //提交表单
											 	}
											 }) ;
										}
									},
									icon : 'add'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	{ display : '名称', name : 'name', align : 'center' , type : 'string' , width : 250	} ,
	{ display : '品牌', name : 'factoryname', align : 'center' , type : 'string' , width : 150 } ,
	{ display : '类别', name : 'catalogname', align : 'center' , type : 'string' , width : 150 } ,
	{ display : '显示', name : 'is_show', align : 'center' , type : 'string' , width : 100 ,render:function(row){
	  return ((jQuery.trim(row.is_show)==1)?"是":"否") ;
	 }
	} 
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
		var productname = jQuery("#productname").val() ;
		if(''!=jQuery.trim(productname))
		{
		   conditionStr += " and name like '%"+productname+"%'";
		}
		var factoryid = jQuery("#factoryid").val() ;
		if(''!=jQuery.trim(factoryid))  // 品牌
		{
		    conditionStr += " and factoryid='"+factoryid+"'" ;
		}else if(""!="<%=factoryid%>"){
			factoryid = "<%=factoryid%>" ;
			conditionStr += " and factoryid='"+factoryid+"'" ;
		}
		var catalognum = jQuery("#catalognum").val() ;
		if(''!=jQuery.trim(catalognum)){
		conditionStr += " and catalognum  like '"+catalognum+"%'" ;
		}
		whereStr = "and id not in (select product_id FROM pro_agent_products where agent_id='"+factoryid+"')"; 
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
		jQuery("#factoryid").val('');
		jQuery("#catalognum").val('');
	}
	function inputAll(){
	if(""==jQuery("#factoryid").val()){
	  alert("请先选择品牌") ;
	  return false ;
	}else if(""==jQuery("#catalognum").val()){
	   if(confirm("确定导入该品牌下的所有产品吗？"))
	   {
	      jQuery.ajax({
	        url:"/backend/action/ajax_cud.jsp",
	        type:"post",
	        data:{flag:"inputall",agentid:"<%=agentid%>",factoryid:jQuery('#factoryid').val(),catalognum:jQuery('#catalognum').val()},
	        success:function(msg){
	        if("fail"!=jQuery.trim(msg) && "ok"==jQuery.trim(msg)){
	          alert("产品导入成功！") ;pro_agent_products_edit
	        }
	        }
	      });
	   }
	}else
	{
	  if(confirm("确定导入吗？")){
	     jQuery.ajax({
	        url:"/backend/action/ajax_cud.jsp",
	        data:{flag:"inputall",agentid:"<%=agentid%>",factoryid:jQuery('#factoryid').val(),catalognum:jQuery('#catalognum').val()},
	        success:function(msg){
	        }
	      });
	  }
	}
	}
	function doSub(){
		return true ;
	}
   jQuery("#start_add_date").ligerDateEditor({width:150});
   jQuery("#end_add_date").ligerDateEditor({width:150});
</script>