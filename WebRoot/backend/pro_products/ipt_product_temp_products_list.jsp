<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
	String tableName = "ipt_product_temp_products";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "*";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	List <Map> catalogList = (ArrayList)application.getAttribute("catalogList");
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> outbrandList = dbHelper.getMapList("  select id,factoryname from dbo.ipt_product_factory order by factoryname asc") ;
	String pro_name = CommonString.getFormatPara(request.getParameter("pro_name")) ; // 查找的产品名字
	String pro_id = CommonString.getFormatPara(request.getParameter("pid")) ;  // 需要导入的产品id
	String whereStr = " and name like '%"+pro_name+"%'";
	String orderByStr = " id desc ";
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
	.l-grid-body-table tr td{
	 height:30px;
	}
	</style>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<div class="searchForm">
  <div class="searchCondition">
    <div class="searchLeft">产品名称:</div>
    <div class="searchRight">
      <input type="text" id="name" name="name" style="width: 80px;" class="jr_text" value="<%=pro_name %>"/>
    </div>
    <div class="searchLeft">品牌</div>
    <div class="searchRight">
      <select class="jr_select" id="factoryid" name="factoryid">
        <option value="">--请选择品牌--</option>
        <%if(outbrandList != null){for(Map m : outbrandList){%>
        <option value="<%=m.get("id")%>"><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("factoryname")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("factoryname")%></option>
        <%}}%>
      </select>
    </div>
    <div class="searchLeft">产品状态</div>
    <div class="searchRight" style="margin-top:3px;">
      <select class="jr_select" name="flag" id="flag" >
        <option value="">--选择状态--</option>
        <option value="1">已导入</option>
        <option value="2">未处理</option>
        <option value="3">扔弃</option>
        <option value="4">刚更新未处理</option>
        <option value="6">已修改</option>
      </select>
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
						items : [{
									text : '删除',
									click : function(){
										toolbarDel({
											channel_uuid:'<%=channelUUID %>'
										});
									},
									icon : 'delete'
								}, {
									text : '栏目',
									click : function(){
										parent.f_addTab('<%=CommonString.getUUID() %>','<%=channelMap.get(channelUUID) %>栏目','/backend/common_channel/common_channel_edit.jsp?channel_uuid=<%=channelUUID %>');
									},
									icon : 'home'
								}]
					}
				});
		jQuery("#pageloading").hide();
	});
	//列数组
	columnsArr =  [ 
	
	{ display : '', name : 'img2', align : 'left' , type : 'string' , width : 40,render:function(row){
		var img = row.img2;
		if(img == '' || img == 'null' || img == null){
			img = 'no_small.gif';	
		}
		return "<a target='_blank' href='/proDetail/"+row.file_name+"'><img src='/uploadfiles/"+img+"' width='35' height='24' onerror='this.src=\"/images/sys/no_small.gif\"'/></a>";
		} } ,
	{ display : '名称', name : 'name', align : 'left' , type : 'string' , width : 150 ,render:function(row){
		return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
	}} ,
	{ display : '品牌', name : 'factoryname', align : 'left' , type : 'string' , width : 170 } ,
	{ display : '类别', name : 'catalogname', align : 'left' , type : 'string' , width : 150 } ,
	{ display : '产品抓取日期', name : 'crawl_date', align : 'center' , type : 'string' , width : 100 },
	{ display : '本条状态', name : 'flag', align : 'center' , type : 'string' , width : 100 ,render:function(row){
	     return (row.flag=="1")?"<font color='green'><b>已导入</b></font>":((row.flag=="2")?"<font color='red'><b>未处理</b></font>":(row.flag=="3")?"<font color='cyan'><b>扔弃</b></font>":(row.flag=="4")?"刚更新未处理":(row.flag=="6")?"<font color='Mauve'>已修改</font>":"-") ;
     	}   
	 } ,
	{ display : '操作', align : 'center' , type : 'is' , width : 150 ,render : function(row){
		return "<a class='link' href='javascript:void(0);' onclick='openWin(\""+row.id+"\",\""+row.name+"\"<%=pro_id.equals("")?"":","+pro_id%>)'>修改并导入</a>";
	}}
	];
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:900,
	    		height:610,
	    	
	    		title:'增加',
	    		
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:900,
	    		height:610,
	    		folderName:"pro_products",
	    		fileName:"ipt_product_temp_products" ,
	    		title:'修改'
	    	},row.id);
    	}
    }
	
	/*列表页条件查询*/
	function doSearch(){
		params = [];
		conditionStr = "";
		var name = jQuery("#name").val();
		if(''!=jQuery.trim(name)){
			conditionStr += " and name like '%"+name+"%' ";
		}
		var factoryid = jQuery("#factoryid").val();
		if(''!=jQuery.trim(factoryid)){
			conditionStr += " and factoryid = '"+factoryid+"' ";
		}
		var catalognum = jQuery("#catalognum").val();
		if(''!=jQuery.trim(catalognum)){
			conditionStr += " and catalognum = '"+catalognum+"%' ";
		}
		var is_show = jQuery("input[name='is_show']:checked").val();
		if(''!=jQuery.trim(is_show)){
			conditionStr += " and is_show = '"+is_show+"' ";
		}
		var flag = jQuery("#flag").val() ;
		if(''!=jQuery.trim(flag))
		{
		   conditionStr += "and flag='"+flag+"'" ;
		}
		params.push({'name':'tableName','value':tableName});
		params.push({'name':'fileds','value':fields});
		params.push({'name':'whereStr','value':conditionStr});
		params.push({'name':'orderBy','value':orderBy});
		params.push({'name':'main','value':main});
		grid.options.parms=params;
		grid.loadData();
	}
	
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text").val('');
		jQuery("#factoryid").val('');
		jQuery("#catalognum").val('');
		jQuery("#is_show_1").attr("checked",false);
	}
	
	function openWin(id,name,pro_id){
		jrWindow("/backend/pro_products/ipt_product_temp_products_edit.jsp?id="+id+"&name="+name+"&pro_id="+pro_id,"导入产品",900,600);	
	}
</script>