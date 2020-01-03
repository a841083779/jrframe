<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
		String id = CommonString.getFormatPara(request.getParameter("id"));
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
<form name="theform" id="theform" action="/backend/action/after_own.jsp">

  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /> </span> <span class="groupTitle">删除订单</span> </div>

    <div class="formLeft"> 删除原因 </div>
    <div class="formRight" style="width: 420px">
      <input style="width:420px"  type="text" class="jr_text" name="jr_message" id="jr_message" value="" />
    </div>
  </div>
  </div>
         <input type="hidden" name="form_id" id="form_id" value="<%=id %>" />
  		<input type="hidden" name="del_id" id="del_id" value="<%=uuid %>" />
		<input type="hidden" name="eventAfter" id="eventAfter" value="deleteOrder" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		var rs=1;
		//var rs = Validator.Validate(document.getElementById("theform"),1);
		var a=$("#jr_message").val();
		//$("#test").val()
		if(a==''){
		rs=0;
		alert("请输入删除原因!");
		return ;
		}

		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
						jrSuccess("删除成功！");	
					   	//window.location.close();
						parent.nowDialog.close();
                        //parent.grid.loadData();
				}
			});
		}
	}
</script>

<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>