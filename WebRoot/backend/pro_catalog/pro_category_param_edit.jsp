<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	Map enumMap = new TreeMap();
	String tableName = "pro_catalog_param";
	String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
	String category = CommonString.getFormatPara(request.getParameter("category"));
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	try{
		String id = CommonString.getFormatPara(request.getParameter("id"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where uuid = ? ",new Object[]{id});
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
		
		String no = "";
		String name = "";
				
		List<Map> enumGiftList = (List)application.getAttribute("enumGiftList");
		if(enumGiftList == null){
			enumGiftList = dbHelper.getMapList(" select no,name from pro_common_enum where is_param=1 and len(no)=6 order by order_no desc,no asc  ");
		}
		enumMap.put("","-请选择-");
		if(enumGiftList!=null){
			for(Map m : enumGiftList){
				no = (String)m.get("no");
				name = (String)m.get("name");
				name = CommonForm.getHtmlSpaceByString((String)m.get("parent_no"))+name;
				enumMap.put(no,name);
			}
		}
		no = CommonString.getFormatPara(model.get("no"));
		if("".equals(no)){
			no = Tools.getNo(category,tableName,"106001");
		}
		String pno=category;
		if(!CommonString.getFormatPara(model.get("parent_no")).equals("")){
			pno=CommonString.getFormatPara(model.get("parent_no"));
		}
		List<Map> cataList=null;
		cataList= dbHelper.getMapList(" select id,name  from pro_category   where parent_no='"+pno+"'");
			
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
</head>
<body style="margin: 0;padding: 0;">
<form name="theform" id="theform" action="/backend/action/crud.jsp?enumNo=106013">
  <div class="formDiv">
    <div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span> <span class="groupTitle">基础信息</span> </div>
    <div class="formLeft">项目类别</div>
    <div class="formRight" style="width: 190px; display: block;" >
      <select class="jr_select" name="zd_category_id" id="zd_category_id">
        <option  value="">-请选择-</option>
        <%
		    if(cataList != null){
			    for(Map m : cataList){
		%>
        <option  value="<%=CommonString.getFormatPara(m.get("id"))%>"  <%if(CommonString.getFormatPara(model.get("category_id")).equals(CommonString.getFormatPara(m.get("id")))){%>selected="selected"<%}%>  ><%=CommonString.getFormatPara(m.get("name"))%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft"><span style="color:#F00">* </span>参数名称</div>
    <div class="formRight">
      <input type="text" style="width:140px" dataType="Require" msg="请输入参数名称" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" maxlength="50"/>
    </div>
    <input type="hidden" style="width:140px" name="zd_no" class="jr_text" id="zd_no" value="<%=no %>"/>
    <div style="clear:left;"></div>
    <div class="formLeft">核心参数</div>
    <div class="formRight" style="width:80px"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_key")).equals("")?"0":CommonString.getFormatPara(model.get("is_key")),"zd_is_key") %> </div>
    <div style="clear:left;"></div>
  </div>
  <input type="hidden" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
  <input type="hidden" name="zd_parent_no" id="zd_parent_no" value="<%=CommonString.getFormatPara(model.get("parent_no")).equals("")?category:CommonString.getFormatPara(model.get("parent_no")) %>" />
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <input type="hidden" name="zd_channel_uuid" id="zd_channel_uuid" value="<%=channelUUID %>" />
  <input type="hidden" name="zd_type" id="zd_type" value="1" />
  <input type="hidden" name="zd_is_show" id="zd_is_show" value="1" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js?tab" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	jQuery("#equi_img").JrUpload({
		remotUrl : "http://resource.21-sun.com/upload.jsp",
		folder : "main" ,
		watermark:false,
		callback : "setEquiImg"
	});
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
					type : "POST",
					async : false ,
					success : function(data) {
						var rs = parseInt(jQuery.trim(data), 10);
						if (rs > 0) {
							jrSuccess("保存成功！");
						
							window.location.reload();
				
						} 
					}
				});
		}
	}
	
	function showEnum(flag){
		if(flag==2){
			jQuery("#enumId1").css("display","block");
			jQuery("#enumId2").css("display","block");
		}else{
			jQuery("#enumId1").css("display","none");
			jQuery("#enumId2").css("display","none");	
		}
	}
	showEnum(<%=CommonString.getFormatPara(model.get("type"))%>);
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>