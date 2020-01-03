<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_agent_factory";
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where id = ? ",new Object [] {id} , connection);
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
		List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		Map levelflagMap = new HashMap();
		levelflagMap.put("0","总代理");
		levelflagMap.put("1","办事处");
		List<Map> dailiList =dbHelper.getMapList(" select id,name from pro_agent_factory where flag = 2 and levelflag = 0 ",connection);
		Map dailiMap = CommonCollection.listToMap(dailiList,"id","name");
		String import_sql = "select count(*) total from pro_agent_products_form where is_import=1 and agent_id=?" ;
		String total_str = CommonString.getFormatPara(dbHelper.getMap(import_sql,new Object[]{model.get("id")}).get("total")) ;
		int total_import = Integer.parseInt(total_str.equals("")?"0":total_str) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
<link rel="stylesheet" href="/plugin/date/My97DatePicker/skin/WdatePicker.css" type="text/css"/>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
</head>
<body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y:scroll;">
<form name="theform" id="theform" action="/backend/action/after.jsp">
  <div class="formDiv">
  <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/> </span> <span class="groupTitle">代理商坐标信息</span> </div>
  <div class="formLeft">代理商地址</div>
  <div class="formRight">
    <input type="text"  class="jr_text" name="jr_name" id="jr_name" value="<%=CommonString.getFormatPara(model.get("address")) %>" />
  </div>
  <div style="clear:left;"></div>
  <div class="formLeft">代理商坐标</div>
  <div class="formRight">
    <%if(CommonString.getFormatPara(model.get("lng")).equals("")&&CommonString.getFormatPara(model.get("lat")).equals("")){%>
    <input type="text"  class="jr_text" name="jr_location" id="jr_location" value="" />
    <%}else{%>
    <input type="text"  class="jr_text" name="jr_location" id="jr_location" value="<%=CommonString.getFormatPara(model.get("lng")) %>,<%=CommonString.getFormatPara(model.get("lat")) %>" />
	<%}%>
  </div>
  <div style="clear:left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="jr_agent_id" id="jr_agent_id" value="<%=id %>" />
  <input type="hidden" name="eventAfter" id="eventAfter" value="updateAgentLocation"/>
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
   function checkRepeat(){
   	
   
   }
	function addProbation(){
		jQuery.post("/backend/action/ajax_cud.jsp",{
			flag : 'addProbation',
			id : '<%=id %>'
		},function(data){
			jQuery("#zd_probation_date").val(data);
		});
	}
	function changeValue(){
		var strs = jQuery("#factoryid option:selected").text() ; // 取得选择的品牌
		var ids = jQuery("#zd_agent_fac").val() ;
		var str = strs.substring(strs.indexOf('-')+1)
		var brand = jQuery("#zd_agent_fac_name").val() ;
		if(''!=jQuery.trim(brand)){
			jQuery("#zd_agent_fac_name").val(brand+","+str) ;
			jQuery("#zd_agent_fac").val(ids+","+jQuery("#factoryid").val()) ;
		}else{
		jQuery("#zd_agent_fac_name").val(str) ;
		jQuery("#zd_agent_fac").val(jQuery("#factoryid").val()) ;
		}
	}
	jQuery("input[name=zd_levelflag]").click(function(){
		if(this.value==1){
			jQuery("#zd_parent_id").show();
		}else{
			jQuery("#zd_parent_id").hide();
		}
	});
	function doSub(){
    //验证表单及提交
		var rs = Validator.Validate(document.getElementById("theform"),1);
		var result = 0 ;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
            jrSuccess("保存成功");

				}
			});
		}
		
		
		if(result>0)
		{
		  return true ;
		}
	}


	function smallToBig(o,id){
	jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
	return hs.expand(o);
	}
	function imprt_order(agent_usern,obj){
		jQuery(obj).attr("disabled","disabled") ;
		jQuery.ajax({
			type:"post",
			url:'/tools/import_agent_order.jsp',
			data:{"usern":agent_usern},
			success:function(msg){
			  if(jQuery.trim(msg)=='ok'){
			  	jrSuccess("导入成功！") ;
			  }
			}
		}) ;
	}
	// 日期控件
// 	jQuery("#zd_order_start_time").ligerDateEditor({width:150});
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>