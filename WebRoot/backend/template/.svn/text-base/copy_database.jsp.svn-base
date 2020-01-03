<%@ page language="java"
	import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
	String dbSql = "select distinct substring(name,0,charindex('_',name)) as dbname from sysobjects where type='U'";
	DBHelper helper = DBHelper.getInstance();
	List dbList = helper.getMapList(dbSql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>复制数据库</title>
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css"
			rel="stylesheet" type="text/css" />
		<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="/backend/scripts/common.js"></script>
	</head>
	<body>
		<div class="l-loading" style="display: block" id="pageloading"></div>
		<div id="maingrid4" style="margin: 0; padding: 0"></div>
		<%
			if (dbList == null || dbList.size() <= 0) {
		%>
		<div>
			没有已创建的数据库，不能复制
		</div>
		<%
			} else {
				Map dbMap = CommonCollection.listToMap(dbList, "dbname", "dbname");
				dbMap.put("", "请选择数据库源");
		%>
		<div id="step1">
			选择要复制的源数据库：
			<select id="dbsource">
				<%=CommonForm.createSelect(dbMap, "")%>
			</select>
			<br />
			新数据库名称：
			<input type="text" id="newdbname" />
			<br />
			<input type="button" id="btnToStep2" value="下一步" onclick="toStep2();" />
		</div>
		<%
			}
		%>
		<div id="step2">
			<h2>选择要复制的表</h2>
			<div id="source_table"></div>
			<div>
				<input type="button" id="step2_prev" value="上一步" onclick="backStep1();" />
				<input type="button" id="step3_next" value="下一步" onclick="toStep3();" />
			</div>
		</div>
		<div id="step3">
		
		</div>
	</body>
</html>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/backend/scripts/dialog.js" type="text/javascript"></script>
<script type="text/javascript">
	var sourceTblGrid;
	jQuery(function (){
		$("#step2").hide();
		$("#step3").hide();
		jQuery("#pageloading").hide();
	});
	
	function toStep2(){
		var dbsource=$("#dbsource").val();
		var newdbname=$.trim($("#newdbname").val());
		
		if(dbsource==""){
			jrError("请选择要复制的源数据库");
			return;
		}
		if(newdbname==""){
			jrError("新数据库的名称不能为空");
			return;
		}
		var nameExist=false;
		$("#dbsource").children("option").each(function(i){
			if($(this).attr("value")==newdbname){
				nameExist=true;
				return false;
			}
		});
		if(nameExist){
			jrError("新数据库与原有数据库重名，请修改");
			return;
		}

		$("#pageloading").show();
		step2Init(dbsource,newdbname);
		$("#pageloading").hide();
	}
	
	function step2Init(dbsource,newdbname){
		var url="/backend/template/action.jsp?flag=copy_database&step=1&dbsource="+dbsource;
		sourceTblGrid = $("#source_table").ligerGrid({
			columns : [ 
						{ display : '表', name : 'name', align : 'left' , type : 'string' , width : 500 }
			] ,
			url : url, 
			pageSize : 10,
			width : '600',
			checkbox: true, 
			rownumbers : true,
			selectRowButtonOnly : true,
			usePager : false,
			onSuccess : function(){
				$("#step1").hide();
				$("#step2").show();
			}
		});
	}
	
	function backStep1(){
		$("#step2").hide();
		$("#step1").show();
	}
	
	function toStep3(){
		var checkedTables=sourceTblGrid.getCheckedRows();
		if(checkedTables.length<=0){
			jrError("未选择要复制的表");
			return;
		}
		var newdbname=$.trim($("#newdbname").val());
		if(newdbname==""){
			jrError("新数据库的名称不能为空");
			return;
		}
		var nameExist=false;
		$("#dbsource").children("option").each(function(i){
			if($(this).attr("value")==newdbname){
				nameExist=true;
				return false;
			}
		});
		if(nameExist){
			jrError("新数据库与原有数据库重名，请修改");
			return;
		}
		
		jrConfirm("确认选中的表，并开始复制吗？",function(v){
			if(v){
				$("#step2").hide();
				$("#pageloading").show();
				var tableNames="";
				for(var i=0;i<checkedTables.length;i++){
					tableNames+=checkedTables[i].name+"|";
				}
				var url="/backend/template/action.jsp?flag=copy_database&step=2";
				$.ajax({
					type: "post",
					url: url,
			        data: {tableNames:tableNames,newdbname:newdbname},
			        dataType: "text",
			        success: function(result) {
			        	$("#step3").text(result);
			        	$("#step3").show();
			        	$("#pageloading").hide();
			        }
				});
			}
		});
	}
</script>