<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
        
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
				Map formMap = dbHelper.getMap(" select * from pro_products where uuid = ? ",new Object [] {uuid},connection);
				List<Map> proList= (ArrayList)(dbHelper.getMapList(" select * from pro_products where factoryid =  "+CommonString.getFormatPara(formMap.get("factoryid")),connection));
				List<Map> agentList=(ArrayList)(dbHelper.getMapList(" select * from pro_agent_factory where is_cooperate = 1 ",connection));
		     	List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
<form name="theform" id="theform" action="/backend/action/after.jsp">

  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /> </span> <span class="groupTitle">优买团活动</span> </div>
    <div class="formLeft"> 活动类型 </div>
    <div class="formRight" style="width:300px; ">
	  <select name="jf_flag" id="jf_flag" class="jr_select" style="width: 300px;">
		  		 <option value="">-请选择-</option>
		         <option value="1">厂家</option>	
                 <option value="2">代理商</option>	

	   </select>
    </div>
    <div style="clear: left;"></div>
    <div style="clear: left;"></div>
    <div class="formLeft"> 活动方 </div>
    <div class="formRight" style="width: 300px">
         <input style="width: 300px" type="hidden" class="jr_text" name="company_name" id="company_name" value="<%=CommonString.getFormatPara(formMap.get("factoryname")) %>" />
	  	  <select name="jr_activity_user" id="jr_activity_user" class="jr_select" style="width: 300px;" onchange="document.getElementById('company_name').value=options[selectedIndex].text">
		  		 <option value="">-请选择-</option>
	      </select>
    </div>
    <div style="clear: left;"></div>
    <div class="formLeft"> 活动图片 </div>
         


        <div class="formRight">
          <input type="text" readonly style="width: 400px;" class="jr_text" name="jr_activity_img" id="jr_activity_img" value="" />
        </div>
		<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('jr_activity_img',700,480);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"jr_activity_img");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
		
	<div style="clear: left;"></div>
    <div class="formLeft"> 活动其他产品id </div>
	<div class="formRight" style="height: 50px; text-align: left;">
			      <input style="width:328px;" type="text" class="jr_text" name="jr_ids" id="jr_ids" />
				  <input style="float:right;" type="button" class="btn" onclick="openWin('<%=CommonString.getFormatPara(formMap.get("factoryid"))%>');" value="选择产品" />
				  <span style="color:red;"> (id间英文逗号分割)</span>
	</div>
	
	<div style="clear: left;"></div>
    <div class="formLeft"> 活动标题 </div>
	<div class="formRight" style="height: 30px; text-align: left;">
			      <input style="width:328px;" type="text" class="jr_text" name="jr_title" id="jr_title" />
		
	</div>
	
    <div style="clear: left;"></div>
    <div class="formLeft"> 活动内容 </div>
			<div class="formRight" style="height: 100px; text-align: left;">
				<textarea  style="width:428px; height:80px;" class="jr_textarea" name="jr_textarea" id="jr_textarea" ></textarea>
			</div>

  </div>
  </div>
  		<input type="hidden" name="pro_uuid" id="pro_uuid" value="<%=uuid %>" />
		<input type="hidden" name="eventAfter" id="eventAfter" value="ymtActivity" />
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
						jrSuccess("发送成功！");			
				}
			});
		}
	}
</script>
<script type="text/javascript" language="javascript">
   //选择类型后加载对应的厂家或者代理商
   jQuery(function(){
		jQuery("#jf_flag").change(function(){
		    var jf_flag=this.value;
			if(jf_flag=='1'){
			    jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':<%=CommonString.getFormatPara(formMap.get("factoryid")) %>,'flag':'getAgentList'},function(data){
			         document.getElementById("jr_activity_user").innerHTML = ('<option value="<%=CommonString.getFormatPara(formMap.get("factoryid")) %>"><%=CommonString.getFormatPara(formMap.get("factoryname")) %></option>');
			    });
			}
			if(jf_flag=='2'){	
			    jQuery.post("/backend/action/ajax_r.jsp",{'factoryId':<%=CommonString.getFormatPara(formMap.get("factoryid")) %>,'flag':'getAgentList'},function(data){
			         document.getElementById("jr_activity_user").innerHTML = (jQuery.trim(data));
			    });
			}
		});
	});
		hs.graphicsDir = '/plugin/other/highslide/graphics/';
	    hs.wrapperClassName = 'wide-border';
		function smallToBig(o,id){
		jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
		return hs.expand(o);
	  }
	  

	
	
	
	function openWin(id, w, h) {
	var url = "/backend/pro_products/pro_ymt_edit.jsp?id=" + id;
	var title = "导入产品";
	var width = 800;
	if (w != undefined) {
		width = w;
	}
	var height = 500;
	if (h != undefined) {
		height = h;
	}
	jQuery.ligerDialog.open({
				height : height,
				url : url,
				width : width,
				showMax : true,
				showToggle : false,
				showMin : false,
				isResize : false,
				modal : true,
				title : title,
				buttons : [{
					text : '确定',
					onclick : function(item, dialog) {
						dialog.frame.doSub(dialog);
						var ifid = parent.tab.getSelectedTabItemID();
						parent.document.getElementById(ifid).contentWindow.grid
								.loadData();
					}
				}, {
					text : '取消',
					onclick : function(item, dialog) {
						dialog.close();
					}
				}]
			});
}
    </script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>