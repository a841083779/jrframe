<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" pageEncoding="UTF-8" %>
<%@page import="java.sql.Connection"%><%
	String tableName = "pro_ymt_activity";
	String parentId = CommonString.getFormatPara(request.getParameter("parentId"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	
	
	String whereStr = "";
	List<Map> list =null;
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		if(parentId!=null && !parentId.equals("")){
		if(parentId.length()>6){
		parentId=parentId.substring(0,6);
		}
			
			 String sql = " select * from "+tableName+" where pro_catanum like '"+parentId+"%'   order by catanum_no desc,id desc ";
			list = dbHelper.getMapList(sql,connection);
		}else{
		String sql = " select * from "+tableName+"   order by catanum_no desc,id desc ";
			list = dbHelper.getMapList(sql,connection);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection) ;
	}

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
	 			String title = CommonString.getFormatPara(m.get("title").toString());
	 			if(title!=null && title.length()>16){
	 				title = title.substring(0,16);
	 			}
	 			%>
<li class="ui-state-default" myid="<%=m.get("uuid") %>"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span><%=i+1 %>&nbsp;<%=title %></li>
	 			<%
	 		}
	 	%>
	</ul>
  </body>
</html>
<script type="text/javascript" src="/backend/scripts/common.js"></script>
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
			url:"/backend/action/ajax_cud.jsp",
			type:"post",
			data:{'flag':'fenleisaveSort',"tableName":"<%=tableName%>","sortId":sortHtml,'enumNo':'106001'},
			async:false,
			cache:false,
			success:function(data){
				if(jQuery.trim(data)=='ok'){
					jrAlert("排序成功！");
				}
			}
		});
	}
</script>