<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
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
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object [] {id} , connection);
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
		
		Map factoryInfo = (Map)session.getAttribute("factoryInfo");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/admin/style/style.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
	<link rel="stylesheet" href="/plugin/date/My97DatePicker/skin/WdatePicker.css" type="text/css"/>
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
	<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
	<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
   </head>
  <body style="margin: 0;padding: 0; overflow-x: hidden; overflow-y:scroll;">
	<form name="theform" id="theform" action="/admin/action/crud.jsp">
		<div class="formDiv">
				<div class="group">
				<span>
			    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
			     </span>
				<span class="groupTitle">代理商基本信息</span>
				</div>		
				<div style="clear:left;"></div>
				<div class="formLeft">代理商简称</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入代理商简称' class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">代理商全称</div>
				<div class="formRight">
					<input type="text" dataType='Require' msg='请输入代理商全称' class="jr_text" name="zd_full_name" id="zd_full_name" value="<%=CommonString.getFormatPara(model.get("full_name")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">联系电话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_telphone" id="zd_telphone" value="<%=CommonString.getFormatPara(model.get("telphone")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">联<span class="span3">&nbsp;</span>系<span class="span3">&nbsp;</span>人</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_concatus" id="zd_concatus" value="<%=CommonString.getFormatPara(model.get("concatus")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">邮<span class="span2">&nbsp;</span>箱</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_email" id="zd_email" value="<%=CommonString.getFormatPara(model.get("email")) %>" />
				</div>
                <div style="clear:left;"></div>
				<div class="formLeft">传<span class="span2">&nbsp;</span>真</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_fax" id="zd_fax" value="<%=CommonString.getFormatPara(model.get("fax")) %>" />
				</div>
                <div style="clear:left;"></div>
				<div class="formLeft">地<span class="span2">&nbsp;</span>址</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_address" id="zd_address" value="<%=CommonString.getFormatPara(model.get("address")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">公司网址</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_url" id="zd_url" value="<%=CommonString.getFormatPara(model.get("url")) %>" />
				</div>
				<div style="clear:left;"></div>
			<div class="formLeft">公司简介</div>
	    <div class="formRight" style="height: 220px; text-align: left;"> 
	      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("introduce")) %></script>
	      <input type="hidden" name="zd_introduce" id="zd_introduce" value='' />
	    </div>
	   	<div style="clear:left;"></div>
				<div class="formLeft">代理品牌</div>
				<div class="formRight">
					<input type="text" readonly class="jr_text" style="width:150px;" name="zd_agent_fac_name" id="zd_agent_fac_name" value="<%=CommonString.getFormatPara(factoryInfo.get("name")) %>" />
				    <input type="hidden" class="jr_text" style="width:150px;" name="zd_agent_fac" id="zd_agent_fac" value="<%=CommonString.getFormatPara(factoryInfo.get("id")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">代理地区</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_city" id="zd_city" value="<%=CommonString.getFormatPara(model.get("city")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">代理地区电话</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_city_tel" id="zd_city_tel" value="<%=CommonString.getFormatPara(model.get("city_tel")) %>" />
				</div>
					<div style="clear:left;"></div>
			
				<div style="clear:left;"></div>
				<div class="formLeft">厂家图片</div>
				<div class="formRight">
					<input type="text" class="jr_text" style="width:350px;" name="zd_img1" id="zd_img1" value="<%=CommonString.getFormatPara(model.get("img1")) %>" />
				</div>
					<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img1',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img1");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">是否显示</div>
				<div class="formRight" style="width: 80px;">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %>
				</div>
				<div class="formLeft">级<span class="span2">&nbsp;</span>别</div>
				<div class="formRight" style="width: 130px;">
					<%
						String levelflag = CommonString.getFormatPara(model.get("levelflag"));
					%>
					<%=CommonForm.createRadio(levelflagMap,levelflag,"zd_levelflag") %>
				</div>
				<div class="formRight" style="width: 130px;">
				<%
					if("1".equals(levelflag)){
						%><select name="zd_parent_id" id="zd_parent_id" style="width: 100%;"><%
					}else{
						%><select name="zd_parent_id" id="zd_parent_id" style="width: 100%;display: none;"><%
					}
				%>
						<option value="">--选择总代理--</option>
						<%=CommonForm.createSelect(dailiMap,CommonString.getFormatPara(model.get("parent_id"))) %>
					</select>
				</div>
				<div style="clear:left;"></div>			
		  </div>		
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
		<input type="hidden" name="zd_flag" id="zd_flag" value="2"/>
		<input type="hidden" name="zd_agent_fac" id="zd_agent_fac" value="<%=CommonString.getFormatPara(model.get("agent_fac")) %>"/>
		<input type="hidden" name="zd_passw" id="zd_passw" value="1"/>
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/admin/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
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
		var rs = Validator.Validate(document.getElementById("theform"),1);
		var result = 0 ;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					result = rs ;
					if (rs > 0 ) {
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
		}
		if(result>0)
		{
		  return true ;
		}
	}
	var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_introduce',
    	autoHeightEnabled:false,
    	minFrameHeight:120
    });
    ue_introduce.render('editor_introduce');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_introduce").value=ue_introduce.getContent();
	});
	document.getElementById("zd_introduce").value=ue_introduce.getContent();
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
    hs.wrapperClassName = 'wide-border';
	function smallToBig(o,id){
	jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
	return hs.expand(o);
	}
	// 日期控件
// 	jQuery("#zd_order_start_time").ligerDateEditor({width:150});
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>