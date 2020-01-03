<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
        String id = CommonString.getFormatPara(request.getParameter("id"));
		String tableName = "pro_ymt_activity";
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
				model = dbHelper.getMap(" select * from pro_ymt_activity where id =? ",new Object [] {id},connection);
				
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
<form name="theform" id="theform" action="/backend/action/crud.jsp">

  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /> </span> <span class="groupTitle">优买团活动</span> </div>

    <div class="formLeft"> 产品分类 </div>
         
	<div style="clear:left;"></div>
	<div class="formLeft">产品类别</div>
		  		<div class="searchRight" style="margin-top:3px;">
		  			<input type="radio" id="is_show" name="zd_pro_type" value="<%=CommonString.getFormatPara(model.get("pro_type")) %>" <%if(CommonString.getFormatPara(model.get("pro_type")).equals("0")){%> checked="checked"<%}%>/>单产品
                    <input type="radio" id="is_show" name="zd_pro_type" value="<%=CommonString.getFormatPara(model.get("pro_type")) %>" <%if(CommonString.getFormatPara(model.get("pro_type")).equals("1")){%> checked="checked"<%}%>/>多产品
		  		</div>
	<div class="formRight">
	</div>
	
	<div style="clear: left;"></div>
    <div class="formLeft"> 活动标题 </div>
	<div class="formRight" >
			      <input style="width:328px;" type="text" class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>"/>
		
	</div>
	<div style="clear: left;"></div>
    <div class="formLeft"> 活动方 </div>
	<div class="formRight" >
			      <input style="width:328px;" type="text" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>"/>
		
	</div>
	   <div style="clear:left;"></div>
    <div class="formLeft">价格区间</div>
    <div class="formRight" style="width:155px; text-align:left">
      <input type="text" class="jr_text" name="zd_price_start" id="zd_price_start" value="<%=CommonString.getFormatPara(model.get("price_start")).equals("")?"0":CommonString.getFormatPara(model.get("price_start")) %>" style="width:130px" />
      &nbsp;万 </div>
    <div class="formLeft" style="width:10px; text-align:left">-</div>
    <div class="formRight" style="width:200px; text-align:left">
      <input type="text" class="jr_text" name="zd_price_end" id="zd_price_end" value="<%=CommonString.getFormatPara(model.get("price_end")).equals("")?"0":CommonString.getFormatPara(model.get("price_end")) %>" style="width:130px" />
      &nbsp;万 </div>
	<div style="clear:left;"></div>
	 <div class="formLeft"> 图片一 </div>
     <div class="formRight">
          <input type="text" readonly style="width: 400px;" class="jr_text" name="zd_img" id="zd_img" value="<%=CommonString.getFormatPara(model.get("img")) %>" />
        </div>
		<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img',700,480);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
		<div style="clear:left;"></div>
		 <div class="formLeft"> 图片二 </div>
	 <div class="formRight">
          <input type="text" readonly style="width: 400px;" class="jr_text" name="zd_img2" id="zd_img2" value="<%=CommonString.getFormatPara(model.get("img2")) %>" />
        </div>
		<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img2',700,480);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img2");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
	
    <div style="clear: left;"></div>
    <div class="formLeft"> 活动内容 </div>
			<div class="formRight" style="height: 100px; text-align: left;">
				<textarea  style="width:428px; height:80px;" class="jr_textarea" name="zd_description" id="zd_description" ><%=CommonString.getFormatPara(model.get("description")) %></textarea>
			</div>
	<div style="clear:left;"></div>
    <div class="formLeft">是否显示</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> </div>

  </div>
  

		<input type="hidden" name="tableName" id="tableName" value="pro_ymt_activity" />
         <input type="hidden" name="zd_id" id="zd_id" value="" />
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
    hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	function smallToBig(o,id){
		var sor = jQuery("#"+id).val();
		if(sor.indexOf('news')>-1){
			jQuery(o).attr("href",jQuery("#"+id).val());
		}else{
			jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
		}
		return hs.expand(o);
	}



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
   //选择类型后加载对应的厂家或者代理商
 
	
	
	
	function openWin(id, w, h) {
	var url = "/backend/pro_products/pro_ymt_edit.jsp?id="+ id;
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