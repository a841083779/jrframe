<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "ipt_product_temp_products";
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
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		String pro_id = CommonString.getFormatPara(request.getParameter("pro_id")) ;  // 如果该Id存在，则更新产品中心数据库中该产品，否则则插入产品中心数据库
		
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
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
</head>

<body style="margin: 0;padding: 0; overflow-x: hidden;overflow-y: auto; ">
<form name="theform" id="theform" action="/backend/action/crud.jsp">
  <div class="formDiv">
   <div class="group">
	<span>
    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
     </span>
	<span class="groupTitle">抓取产品信息</span>
	</div>
    <div style="clear:left;"></div>
    <div class="formLeft">产品型号</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" onblur="setFileName(this.value);" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">品<span class="span2">&nbsp;</span>牌</div>
    <div class="formRight">
      <select class="jr_select" id="zd_factoryid" name="zd_factoryid" onchange="jQuery('#zd_factoryname').val(jQuery('#zd_factoryid').find('option:selected').text())">
        <option value="">--请选择品牌--</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(CommonString.getFormatPara(model.get("factoryid")).equals(m.get("id").toString())){%> selected="selected"<%}%>><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>"  style="width:270px"/>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">类<span class="span2">&nbsp;</span>别</div>
    <div class="formRight">
      <select class="jr_select" id="zd_import_pro_catalognum" name="zd_import_pro_catalognum" onchange="jQuery('#zd_catalogname').val(jQuery.trim(jQuery('#zd_catalognum').find('option:selected').text()))">
       	<option value="">--请选择产品类别--</option>
		  				<%if(catalogList != null){for(Map m : catalogList){%>
                        	<option value="<%=m.get("num")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
                        <%}}%>
      </select>
    </div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_catalogname" id="zd_catalogname" value="<%=CommonString.getFormatPara(model.get("catalogname")) %>" style="width:270px" />
    </div>
    <div style="clear: left;"></div>
        <div class="formLeft">产品图片</div>
        <div class="formRight">
          <input type="text" readonly="readonly" style="width: 400px;" class="jr_text" name="zd_img2" id="zd_img2" value="<%=CommonString.getFormatPara(model.get("img2")).equals("")?"/":CommonString.getFormatPara(model.get("img2")) %>" />
        </div>
		<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img2',700,480);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img2");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
    <div style="clear:left;"></div>
    <!-- 
    <div class="formLeft">吨位/米</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_tonandmeter" id="zd_tonandmeter" value="<%=CommonString.getFormatPara(model.get("tonandmeter")) %>" />
    </div>
     -->
    <div style="clear:left;"></div>
    <div class="formLeft">点击次数</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_view_count" id="zd_view_count" value="<%=CommonString.getFormatPara(model.get("view_count")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">产品介绍</div>
    <div class="formRight" style="height: 320px; text-align: left;"> 
      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonHtml.filterHTML(CommonString.getFormatPara(model.get("introduce"))) %></script>
      <input type="hidden" name="zd_introduce" id="zd_introduce" value='' />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">产品参数</div>
    <div class="formRight" style="height: 300px; text-align: left;"> 
      <script type="text/plain" id="editor_paras" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("paras")) %></script>
      <input type="hidden" name="zd_paras" id="zd_paras" value='' />
    </div>
    <div style="clear:left;"></div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <input type="hidden" name="pro_id" id="pro_id" value="<%=pro_id %>"/>
  <input type="hidden" name="zd_flag" id="zd_flag" value="<%=pro_id.equals("")?"6":"1" %>"/> 
  <input type="hidden" name="if_tag" id="if_tag" value="1"/><!-- 确定是否导入产品中心 -->
  <input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=UUID.randomUUID().toString() %>"/>
  <!-- 如果为空 -->
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
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
	}
    var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_introduce',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_introduce.render('editor_introduce');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_introduce").value=ue_introduce.getContent();
	});
    var ue_paras = new baidu.editor.ui.Editor({
    	textarea : 'zd_paras',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_paras.render('editor_paras');
    ue_paras.addListener("selectionchange",function(){
	    var state_paras = ue_paras.queryCommandState("source");
	    document.getElementById("zd_paras").value=ue_paras.getContent();
	});
	document.getElementById("zd_paras").value = ue_paras.getContent();
	document.getElementById("zd_introduce").value = ue_introduce.getContent();
	function smallToBig(o,id){
		jQuery(o).attr("href","/uploadfiles"+jQuery("#"+id).val());
		return hs.expand(o);
	}
	function setFileName(value){
		var jsonData = {"name":value,"flag":"file_name"};
		jQuery.ajax({
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:jsonData,
				success:function(data){
					jQuery("#zd_file_name").val(jQuery.trim(data));
				}
				
			})
	}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>