<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_sale_policy";
	String facId = CommonString.getFormatPara(request.getParameter("facId"));

	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
 	    List <Map> brandList = (ArrayList)application.getAttribute("brandList");  // 品牌
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
   	<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
	<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
	<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y:scroll;">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
		
    <div style="clear:left;"></div>
    <div class="formLeft">类<span class="span2">&nbsp;</span>别</div>
    <div class="formRight">
      <select class="jr_select" id="zd_catalognum" name="zd_catalognum" onchange="jQuery('#zd_catalogname').val(jQuery.trim(jQuery('#zd_catalognum').find('option:selected').text()));">
        <option value="">--请选择产品类别--</option>
      <%if(catalogList != null){for(Map m : catalogList){
		  %>

	         <option value="<%=m.get("num")%>" <%if(CommonString.getFormatPara(model.get("catalognum")).equals(m.get("num").toString())){%> selected="selected"<%}%>><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>

	  <%}}%>
      </select>
    </div>
	 <input type="hidden" class="jr_text" name="zd_catalogname" id="zd_catalogname" value="<%=CommonString.getFormatPara(model.get("catalogname")) %>" style="width:270px" />
     
	 
	 <div style="clear:left;"></div>
     <div class="formLeft" style="width:180px;float:left"><strong style="font-weight:bold">为用户提供哪些金融服务</strong></div>
	 <div style="clear:left;"></div>
	 <div class="formRight" style="width:600px;text-align:left">
	 
	<label><input name="q1" id="q1" type="checkbox" value="全款优惠购车"  <%if(CommonString.getFormatPara(model.get("q1")).indexOf("全款优惠购车")>=0 ){%>checked="checked"<%}%>   />全款优惠购车</label> &nbsp;&nbsp;
	 <label><input name="q1" id="q1" type="checkbox" value="融资租赁"  <%if(CommonString.getFormatPara(model.get("q1")).indexOf("融资租赁")>=0 ){%>checked="checked"<%}%>/>融资租赁</label> &nbsp;&nbsp;
	 <label><input name="q1" id="q1" type="checkbox" value="分期付款" <%if(CommonString.getFormatPara(model.get("q1")).indexOf("分期付款")>=0 ){%>checked="checked"<%}%>/>分期付款</label> &nbsp;&nbsp;
	 <label><input name="q1" id="q1" type="checkbox" value="按揭付款"  <%if(CommonString.getFormatPara(model.get("q1")).indexOf("按揭付款")>=0 ){%>checked="checked"<%}%> />按揭付款</label> &nbsp;&nbsp;
	 <label><input   id="q1" type="checkbox" />其他：</label> 
     <input type="text" class="jr_text" name="q1_other" id="q1_other"  style="width:160px" value="<%=CommonString.getFormatPara(model.get("q1")).replace("全款优惠购车,","").replace("融资租赁,","").replace("分期付款,","").replace("按揭付款,","")%>"/> 
     </div>
	 <input type="hidden" class="jr_text" name="zd_q1" id="zd_q1" value="<%=CommonString.getFormatPara(model.get("q1")) %>" />

	<div style="clear:left;"></div>
     <div class="formLeft" style="width:180px;float:left;padding-top:10px"><strong style="font-weight:bold">是否提供【以旧换新】服务</strong></div>
	 <div style="clear:left;"></div>
	 <div class="formRight" style="width:600px">
            <div class="jr_radio_group" style="width:600px">
			<input class="jr_radio"  type="radio" name="zd_q2" id="zd_q2" value="不提供"   <%if(CommonString.getFormatPara(model.get("q2")).equals("不提供")){%>checked="checked"<%}%>  />
			<label for="zd_is_show0">不提供</label>
			<input class="jr_radio" type="radio" name="zd_q2" id="zd_q2" value="提供不受限的以旧换新服务" <%if(CommonString.getFormatPara(model.get("q2")).equals("提供不受限的以旧换新服务")){%>checked="checked"<%}%> />
			<label for="zd_is_show1">提供不受限的以旧换新服务</label>
			<input class="jr_radio"  type="radio" name="zd_q2" id="zd_q2" value="提供受限（旧机有要求）的以旧换新服务" <%if(CommonString.getFormatPara(model.get("q2")).equals("提供受限（旧机有要求）的以旧换新服务")){%>checked="checked"<%}%>   />
			<label for="zd_is_show2">提供受限（旧机有要求）的以旧换新服务</label>
			</div>
	 </div>
 
	<div style="clear:left;"></div>
     <div class="formLeft" style="width:180px;float:left;padding-top:5px"><strong style="font-weight:bold">提供什么样的免费保修服务</strong></div>
	 <div style="clear:left;"></div>
	 <div class="formRight" style="width:600px;text-align:left">
      	<label><input name="q3"  type="checkbox" value="一年不限工作时间"  <%if(CommonString.getFormatPara(model.get("q3")).indexOf("一年不限工作时间")>=0 ){%>checked="checked"<%}%> />一年不限工作时间</label> &nbsp;&nbsp;
	    <label><input name="q3" type="checkbox" value="2年/4000小时先到为准"   <%if(CommonString.getFormatPara(model.get("q3")).indexOf("2年/4000小时先到为准")>=0 ){%>checked="checked"<%}%> />2年/4000小时先到为准</label> &nbsp;&nbsp;
	    <label><input name="q3" type="checkbox" value="3年/6000小时先到为准"   <%if(CommonString.getFormatPara(model.get("q3")).indexOf("3年/6000小时先到为准")>=0 ){%>checked="checked"<%}%> />3年/6000小时先到为准</label> &nbsp;&nbsp;
		<br><br>
	    <label><input  type="checkbox" />其他：</label> 
        <input type="text" class="jr_text" name="q3_other" id="q3_other"  style="width:160px" value="<%=CommonString.getFormatPara(model.get("q3")).replace("一年不限工作时间,","").replace("2年/4000小时先到为准,","").replace("3年/6000小时先到为准,","") %>" /> 
    </div> 
	<input type="hidden" class="jr_text" name="zd_q3" id="zd_q3" value="<%=CommonString.getFormatPara(model.get("q3")) %>" />

		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_factoryid" id="zd_factoryid" value="<%=CommonString.getFormatPara(model.get("factoryid")).equals("")?facId:CommonString.getFormatPara(model.get("factoryid")) %>" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript">
	function addProbation(){
		jQuery.post("/backend/action/ajax_cud.jsp",{
			flag : 'addProbation',
			id : '<%=id %>'
		},function(data){
			jQuery("#zd_probation_date").val(data);
		});
	}

	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		var result = 0 ;
		var q1="";
		var q2="";
		var q3="";
        var str=document.getElementsByName("q1");
        var objarray=str.length;
        for (i=0;i<objarray;i++){
            if(str[i].checked == true){
                q1+=str[i].value+",";
            }
        }
	    if(jQuery("#q1_other").val()!=''){
			q1+=jQuery("#q1_other").val();
		}
		jQuery("#zd_q1").val(q1);
		
		str=document.getElementsByName("q3");
        var objarray=str.length;
        for (i=0;i<objarray;i++){
            if(str[i].checked == true){
                q3+=str[i].value+",";
            }
        }
	    if(jQuery("#q3_other").val()!=''){
			q3+=jQuery("#q3_other").val();
		}
		jQuery("#zd_q3").val(q3);
		
		
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					result = rs ;
				
			       if (rs > 0) {
						jrSuccess("保存成功！");
						<%
						if("".equals(id)){
							%>
					     	window.location.reload();
							<%
						}
						%>
					} 
		           
					
					
				}
			});
		};
		if(result>0)
		{
		  return true ;
		}
	}
	//

	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	function smallToBig(o,id){
	jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
	return hs.expand(o);
}
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>