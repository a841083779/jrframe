<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix + "factory_category";
	String fileds = "id,parentid,catalogname,num,is_show,factoryid";
	String orderByStr = " order_no desc , id desc ";
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")); // 该公司id 
	String parent_factoryid = CommonString.getFormatPara(request.getParameter("parent_factoryid")); // 所属集团 id 
	String whereStr = " and 1=1 ";
	if (!"".equals(factoryid)) {
		whereStr = " and factoryid=" + parent_factoryid;
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=Env.getInstance().getProperty("project_name")%></title>
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css"
			rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css"
			rel="stylesheet" type="text/css" />
		<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
		<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	</head>
	<body>
		<div class="l-loading" style="display: block" id="pageloading"></div>
		<div id="maingrid_tree" style="margin: 0; padding: 0"></div>
		<div style="display: none;"></div>
	</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix%>"
	type="text/javascript"></script>
<script type="text/javascript">
var had_import_catalog = '' ;  // 已经导入的栏目号
jQuery(function(){
		jQuery.ajax({
		 url:"/backend/action/ajax_cud.jsp" ,
		 type:"post" ,
		 data:{"flag":"had_import_catalog","factoryid":'<%=factoryid%>'} ,
		 success:function(msg){
		 	had_import_catalog = jQuery.trim(msg) ;
		 }
		}) ;
	}) ;
	jQuery.ligerDefaults.Grid.formatters['is'] = function(content,
			column) {
		if (content == 1) {
			return '是';
		}
		return '否';
	}
	var grid;
	var tableName = "<%=tableName%>";
	var fields = "<%=fileds%>";
	var whereStr = "<%=whereStr%>";
	var orderBy = "<%=orderByStr%>";
	var columnsArr = [];
	var url = "";
	var conditionStr = "";
	var params = [];
	//列数组
	columnsArr =  [ 
		{ display: '', width: 30, isAllowHide: false, name: 'checkbox', isSort: false, 
		render: function (row) 
		{ 
		var html = '<input style="margin-top:5px;" type="checkbox" '+(had_import_catalog.indexOf(row.num)!=-1?"checked":"")+' rowid="' + row.uuid + '">'; 
		return html; 
		}, 
		headerRender: function (column) 
		{ 
		var html = '<input id="checkall" onclick=selectAll(this) type="checkbox" style="margin:0 4px 5px 3px;">'; 
		return html; 
		} 
		},
		{ display : '名称', name : 'catalogname', isSort : false ,  id : 'no' , align : 'left' , type : 'string' , width : 250 , render : function(row){
				return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.catalogname+"</a>";
			}
		}
	];
	jQuery(function(){
		var url = "/backend/action/ajax_r.jsp";
		params.push({'name':'flag','value':'factory_catalog'});
		params.push({'name':'whereStr','value':whereStr});
		params.push({'name':'orderByStr','value':orderBy});
		params.push({'name':'tableName','value':'<%=tableName%>'});
		grid = jQuery("#maingrid_tree").ligerGrid({
				columns : columnsArr ,
				url : url, 
				pageSize : 20,
				width : '99%',
				height : '98%',
				checkbox : false,
				parms : params,
				selectRowButtonOnly : true,
				alternatingRow : false ,
				usePager : false ,
				tree : {columnId: 'no'} ,
				rownumbers : true ,
							toolbar : {
					items : [ {
									text : '确定',
									click : function(){
									  importFactoryCatagory('<%=factoryid%>','<%=parent_factoryid%>') ; // 导入栏目
									},
									icon : 'ok' 
								}]
								}
			});
		jQuery("#pageloading").hide();
	});
    //增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){ // 如果是增加
    	    toolbarAdd({
	    		width:700,
	    		height:310,
	    		title:'增加',
	    		folderName:'pro_factory_category' ,
	    		fileName:'pro_catalog' ,
	    		params : {
	    		 factoryid:'<%=factoryid%>' ,
	    		 channel_uuid : ""
	    		}
	    	});
    	}else{ // 如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:700,
	    		folderName:'pro_factory_category' ,
	    		fileName:'pro_catalog' ,
	    		height:310,
	    		title:'修改',
	    		params : {
	    		 factoryid:'<%=factoryid%>' ,
	    		 channel_uuid : ""
	    		}
	    	},row.id);
    	}
    }
    // 品牌推荐
    function brandrecommend(catalognum){
     if(catalognum.length>0){
       jrWindow("/backend/pro_catalog/brandrecommend.jsp?catalognum="+catalognum,"品牌推荐",300,400);
     }
    }
    
   // 导入集团栏目
   // factoryid 需要更改公司的 栏目 num
   // parent_factoryid 选择集团的栏目 num
   function importFactoryCatagory(factoryid,parent_factoryid){
   	var checkedRows = jQuery(":checkbox:checked[rowid]");
	var idStr = "";
	jQuery(checkedRows).each(function(){
	idStr += "'" + jQuery(this).attr("rowid") + "',";
	});
	if (idStr.indexOf(",") != -1) {
		idStr = idStr.substring(0, idStr.length - 1);
	}
  if(jQuery.trim(idStr)==''){
  	jrError("请选择要导入的栏目") ;
  	return false ;
  }else{
  	jQuery.ajax({
  		url:"/backend/action/ajax_cud.jsp" ,
  		type:"post" ,
  		data:{"idStr":idStr,"flag":"importFactoryCatagory","factoryid":factoryid,"parent_factoryid":parent_factoryid} ,
  		success:function(msg){
  		msg = jQuery.trim(msg) ;
	  		if(msg=='had'){
	  			jrConfirm("已经导入是否更改",function(yes){
	  				if(yes==true){
	  					jQuery.ajax({
	  					url:"/backend/action/ajax_cud.jsp" ,
	  					type:"post" ,
	  					data:{"idStr":idStr,"flag":"importFactoryCatagoryAgain","factoryid":factoryid,"parent_factoryid":parent_factoryid} ,
	  					success:function(msg){
	  					  if(jQuery.trim(msg)=='ok'){
	  					  	jrSuccess("更改成功") ;
	  					  }
	  					}
	  					}) ;
	  				}else{
	  				}
	  			}) ;
	  		}
	  		if(msg=='ok'){
	  		 jrSuccess("导入成功！") ;
	  		}
  		}
  	}) ;
 }
   }
  function selectAll (){
   var ifchecked = jQuery.trim(jQuery("#checkall").attr("checked")) ;  
   jQuery(":checkbox:not(#checkall)").attr("checked",("checked"==ifchecked)?"checked":false) ;  
   }
</script>