<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	String tableName = "pro_agent_factory";
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String fileds = "id,full_name,email,logo,is_show,is_inner,view_count,mobile,english_name";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	Map channelMap = (Map)application.getAttribute("channelMap");
	String whereStr = "  and flag=1 ";
	String orderByStr = " upper_index desc ";
	CommonForm commonForm = new CommonForm() ;
	Map inner = new HashMap() ;
	inner.put("","全部") ;
	inner.put("1","国内") ;
    inner.put("0","国外") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
   <style type="text/css">
	.l-grid-body-table tr td{
	 height:35px;
	}
	</style>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  </head>
  <body>
  	<div class="searchForm">
  		<div class="searchCondition">
		  		<div class="searchLeft">厂商名称</div>
		  		<div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="full_name" id="full_name" />
		  		</div>
		  		<div class="searchLeft">首字母</div>
		  		 <div class="searchRight">
		  			<input type="text" style="width: 100px;" class="jr_text" name="upper_index" id="upper_index" />
		  		</div>
		  		<div class="searchLeft">营销宝开通</div>
		  		<div class="searchRight">
		  			<%
		  				TreeMap yingXiaoBaoMap = new TreeMap();
			  			yingXiaoBaoMap.put("","--请选择--");
			  			yingXiaoBaoMap.put("0","未开通");
			  			yingXiaoBaoMap.put("1","免费版");
			  			yingXiaoBaoMap.put("2","基础版");
			  			yingXiaoBaoMap.put("3","高级版");
						yingXiaoBaoMap.put("4","订单版");
		  			%>
		  			<select class="jr_select" id="is_shop" name="is_shop">
		  				<%=CommonForm.createSelect(yingXiaoBaoMap,"") %>
		  			</select>
		  		</div>
		  		<div class="searchLeft">旗舰店开通</div>
		  		<div class="searchRight">
		  			<%
		  				TreeMap qiJianDianMap = new TreeMap();
			  			qiJianDianMap.put("","--请选择--");
			  			qiJianDianMap.put("0","未开通");
			  			qiJianDianMap.put("1","已开通");
		  			%>
		  			<select class="jr_select" id="is_qijiandian" name="is_qijiandian">
		  				<%=CommonForm.createSelect(qiJianDianMap,"") %>
		  			</select>
		  		</div>
		  		 <div class="searchLeft" style="width:100px;">地区</div>
		  		<div class="searchRight">
		  			<%= commonForm.createRadio(inner,"","全部")%>
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
					enabledEdit: true,
					onAfterEdit:function(e){
					  if(e.column.columnname=='english_name'){ 
					  		jQuery.ajax({
					  			url:'/backend/action/ajax_cud.jsp',
					  			data:{
					  				flag:'english_name',
					  				uid:e.record.uuid,
					  				value:e.value
					  			},
					  			type:'post'
					  		}) ;
					  } 
					},
					toolbar : {
						items : [{
									text : '增加',
									click : function(){
										addAndEdit();
									},
									icon : 'add'
								}, {
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
	{ display : '', name : 'img1', align : 'left' , type : 'string' , width : 50,render:function(row){
	   return "<img src='/uploadfiles/"+row.img1+"' width='100%' height='100%' title='"+row.full_name+"' onerror='this.src=\"/uploadfiles/no_small.gif\"'>" ;
	  }
	} ,
	{ display : '厂商名称', name : 'name', align : 'left' , type : 'string' , width : 160 ,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.name+"</a>";
	  }
	} ,
	{ display: '英文名字', width: 80,name: 'english_name',type:'string',
            editor: { 
            type: 'text',
            valueField: 'english_name'
             },
            render: function (item)
            {
                return item.english_name==null?"-":item.english_name;
            }
        },
	{ display : '厂商名称', name : 'full_name', align : 'left' , type : 'string' , width : 160 ,render:function(row){
	      return "<a class='link' href='javascript:void(0);' onclick='addAndEdit("+row.__index+");'>"+row.full_name+"</a>";
	  }
	} ,
	{ display : '公司邮箱', name : 'email', align : 'left' , type : 'string' , width : 200 } ,
	{ display : '公司标识', name : 'logo', align : 'left' , type : 'string' , width : 70,render:function(row){
	    return "<img src='/uploadfiles/"+row.logo+"' title='"+row.full_name+"'/>" ;
	  }
	 } ,
	{ display : '是否显示', name : 'is_show', align : 'center' , type : 'string' , width : 50 ,render:function(row){
	   return (row.is_show=="1")?"是":"否" ;
	  }
	  } ,
	{ display : '地区', name : 'is_inner', align : 'center' , type : 'string' , width : 50,render:function(row){
	  return (row.is_inner=="1")?"国内":"国外" ;
	 }
	 } ,
	{ display : '访问量', name : 'view_count', align : 'left' , type : 'string' , width : 50 } ,
	{ display : '联系电话', name : 'telphone', align : 'left' , type : 'string' , width : 90 } ,
	{ display : '品牌排序', align : 'center' , type : 'string' , width : 100,render:function(row){
		return	" <a class='link' href='javascript:;' onclick=commonSort({tableName:\"pro_agent_factory\",value:\""+row.upper_index+"\"});>品牌排序</a>";
	} } ,
	{ display : '操作代理商', name : 'telphone', align : 'center' , type : 'string' , width : 130 ,render:function(row){
		return "<a href='javascript:;' class='link' onclick='changeAgent(1,"+row.id+");'>全部显示</a>&nbsp;&nbsp;<a href='javascript:;' class='link' onclick='changeAgent(0,"+row.id+");'>全部隐藏</a>" ;
	 }} ,
	{ display : '产品列表品牌推荐', name : 'view_count', align : 'center' , type : 'string' , width :110,render:function(row){
		return "<a class='link' href='javascript:;' onclick='catalogrecommend(\""+row.id+"\");'>操作</a>" ;
	} } ,
	{ display : '合同时间', name : 'order_end_time', align : 'center' , type : 'string' , width : 130 ,render:function(row){
		      return (row.order_end_time)?row.order_end_time:'无' ;
		  }
	}	
	];
	
	//增加和编辑的方法
	function addAndEdit(index){
    	if(undefined==index){//如果是增加
    	    toolbarAdd({
	    		width:800,
	    		height:620,
	    		title:'增加',
	    		fileName:"pro_agent_factory_fac" ,
	    		params : {
	    			channel_uuid : "<%=channelUUID %>"
	    		}
	    	});
    	}else{//如果是修改
    		var row = grid.getRow(index);
    	    toolbarAdd({
	    		width:800,
	    		height:720,
	    		title:'修改',
	    	    fileName:"pro_agent_factory_fac" 
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
		var full_name = jQuery("#full_name").val();
		if(''!=jQuery.trim(full_name)){
			conditionStr += " and full_name like '%"+jQuery.trim(full_name)+"%' ";
		}
		var inner = jQuery(".jr_radio:checked").val() ;
		if(''!=jQuery.trim(inner)){
		  conditionStr += " and is_inner ='"+inner+"'";
		}
		var upper_index = jQuery("#upper_index").val() ;
		if(''!=jQuery.trim(upper_index)){
			conditionStr += " and upper_index ='"+jQuery.trim(upper_index)+"'" ;
		}
		var is_shop = jQuery("#is_shop").val();
		if(''!=jQuery.trim(is_shop)){
			conditionStr += " and is_shop = "+is_shop;
		}
		var is_qijiandian = jQuery("#is_qijiandian").val();
		if(''!=jQuery.trim(is_qijiandian)){
			conditionStr += " and is_qijiandian = "+is_qijiandian;
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
function changeAgent(obj,brandid){
		if(confirm("是否"+(obj==0?"隐藏":"显示")+"全部代理商")){
		jQuery.ajax({
			type:"post" ,
			url:"/backend/action/ajax_cud.jsp",
			data:"flag=changeagent&choose="+obj+"&brandid="+brandid,
			success:function(msg){
			alert("已更改成功") ;
			}
		}) ;
		}
	}
	    // 品牌推荐
  function catalogrecommend(facId){
     if(facId.length>0){
       jrWindow("/backend/pro_agent_factory/catalogrecommend.jsp?facId="+facId,"机型推荐",300,400);
     }
    }
</script>