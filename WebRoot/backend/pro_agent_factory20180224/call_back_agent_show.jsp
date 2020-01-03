<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
		//System.out.println("测试"+uuid);
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
				Map formMap = dbHelper.getMap(" select call_result1,call_result2,follow_content,id from pro_agent_products_form where uuid = ? ",new Object [] {uuid},connection);
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
<form name="theform" id="theform" action="/backend/action/crud.jsp">

  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /> </span> <span class="groupTitle">订单结果</span> </div>
    <div class="formLeft"> 第一次结果 </div>
    <div class="formRight" style="width:300px; ">
      <input style="width: 300px" type="text" class="jr_text" name="company_name" id="company_name" value="<%=CommonString.getFormatPara(formMap.get("call_result1")) %>" />
    </div>
    <div style="clear: left;"></div>
    <div style="clear: left;"></div>
    <div class="formLeft"> 第二次结果 </div>
    <div class="formRight" style="width: 300px">
      <input style="width: 300px" type="text" class="jr_text" name="zd_call_result2" id="zd_call_result2" value="<%=CommonString.getFormatPara(formMap.get("call_result2")) %>" />
    </div>
    <div style="clear: left;"></div>
    <div class="formLeft"> 客户跟踪结果 </div>
    <div class="formRight" style="width: 300px">
      <input style="width: 300px" type="text" class="jr_text" name="cata_name" id="cata_name" value="<%=CommonString.getFormatPara(formMap.get("follow_content")) %>" />
    </div>
    <div style="clear: left;"></div>

  </div>
  </div>
  	   <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(formMap.get("id")) %>" />

		<input type="hidden" name="eventAfter" id="eventAfter" value="updateAgentOrderssss" />
  	    <input type="hidden" name="tableName" id="tableName" value="pro_agent_products_form" />
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
		//var rs = Validator.Validate(document.getElementById("theform"),1);
		var rs=1;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
						jrSuccess("保存成功！");			
				}
			});
		}
	}
</script>
<script type="text/javascript" language="javascript">
   //选择合作客户加载合作客户品牌   
   jQuery(function(){
		jQuery("#factory_id").change(function(){
		    var factoryId=this.value;
			jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':factoryId,'flag':'getBrand'},function(data){
			   document.getElementById("brand_id").innerHTML = (jQuery.trim(data));
			});
		});
	});
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getPro'},function(data){
				document.getElementById("pro_id").innerHTML = (jQuery.trim(data));
			 });
		});
	});
    </script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>