<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" pageEncoding="UTF-8" %><%
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String value = CommonString.getFormatPara(request.getParameter("value"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
	String field = "id";
	String whereStr = "";
	if(tableName.equals(table_prefix+"common_channel")){
		field = "name";
		whereStr = " and parent_uuid = '"+value+"' ";
	}
	if(tableName.equals(table_prefix+"common_enum")){
		field = "name";
		whereStr = " and parent_no = '"+value+"' ";
	}
	if(tableName.equals(table_prefix+"common_channel_subblock_data")){
		field = "title";
		whereStr = " and subblock_uuid = '"+value+"' ";
	}
	if(tableName.equals(table_prefix+"catalog")){
		field = "name";
		whereStr = " and parentid = '"+value+"' ";
	}
	String sql = " select uuid,"+field+" from "+tableName+" where 1=1 "+whereStr+" ";
	String orderBy = "order by order_no desc , id asc ";
	if(tableName.equals(table_prefix+"catalog")){
		orderBy = "order by order_no asc , id asc ";
	}
	sql += orderBy;
	DBHelper dbHelper = DBHelper.getInstance();
	List<Map> list = dbHelper.getMapList(sql);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>排序</title>
    <link rel="stylesheet" href="/plugin/ui/jqueryUI/themes/base/jquery.ui.all.css" />
    <script src="/plugin/jquery/jquery.min.js"></script>
    <script src="/plugin/ui/jqueryUI/jquery-ui-1.8.20.custom.min.js"></script>
    <style type="text/css">
    body{font-size: 12px;}
    #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
	#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 12px; height: 14px; }
	#sortable li span { position: absolute; margin-left: -1.3em; }
	.tip{
		margin: 5px;
	}
    </style>
  </head>
  
  <body>
  	<div class="tip">提示：拖动后点击确定保存排序</div>
	 <ul id="sortable">
	 	<%
	 		Map m = null;
	 		for(int i=0;i<list.size();i++){
	 			m = (Map)list.get(i);
	 			%>
<li class="ui-state-default" myid="<%=m.get("uuid") %>"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span><%=i+1 %>&nbsp;<%=m.get(field) %></li>
	 			<%
	 		}
	 	%>
	</ul>
  </body>
</html>
<script type="text/javascript" src="/admin/scripts/common.js"></script>
<script type="text/javascript">
	jQuery("#sortable").sortable();
	jQuery("#sortable").disableSelection();
	function doSub(){
		var sortHtml = "";
		jQuery.each(jQuery("#sortable li"),function(index,data){
			sortHtml += ""+jQuery(this).attr("myid")+",";
		});
		sortHtml = sortHtml.substring(0,sortHtml.length-1);
		jQuery.ajax({
			url:"/admin/action/ajax_cud.jsp",
			type:"post",
			data:{'flag':'saveSort',"tableName":"<%=tableName %>","sortId":sortHtml},
			async:false,
			cache:false,
			success:function(data){
				if(jQuery.trim(data)=='ok'){
					jrAlert("排序成功！");
					jQuery.ajax({
							url:"/admin/action/ajax_r.jsp",
							type:"post",
							data:{"flag":"updateApp","tableName":"<%=tableName%>"}
						});
				}
			}
		});
	}
</script>