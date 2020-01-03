<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	List <Map> catalog=null;
	List <Map> brandList = null;
	String tableName = tablePrefix+"machine_products";
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
		catalog=dbHelper.getMapList(" select * from pro_machine_catalog where is_show=1  order by order_no,id  ",connection);
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalog , "parentid","id");
		brandList = dbHelper.getMapList(" select * from  pro_machine_brand where is_show=1   order by  first_letter,id ",connection);
		
		String factoryid = "" ;
		if(null!=model){
			factoryid = CommonString.getFormatPara(model.get("factoryid")) ;  // 品牌 id 
		}
		

	  Map ishotMap = new HashMap() ;
	  ishotMap.put("10","否") ;
	  ishotMap.put("11","是") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config_normal.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
</head>

<body style="margin: 0;padding: 0; overflow-x: hidden;overflow-y: auto; ">
<form name="theform" id="theform" action="/backend/action/crud.jsp">
  <div class="formDiv">
    <div style="clear:left;"></div>
    <div class="formLeft">产品型号</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>"<%if(id.equals("")){ %> onblur="setFileName(this.value);" <%} %>/> 
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">品<span class="span2">&nbsp;</span>牌</div>
    <div class="formRight">
      <select class="jr_select" id="zd_brand_id" name="zd_brand_id" onchange="jQuery('#zd_brand_name').val(jQuery('#zd_brand_id').find('option:selected').attr('id'))">
        <option value="">--请选择品牌--</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" id="<%=m.get("name")%>"  <%if(CommonString.getFormatPara(model.get("brand_id")).equals(m.get("id").toString())){%> selected="selected"<%}%>><%=m.get("first_letter")%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
	  
    </div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_brand_name" id="zd_brand_name" value="<%=CommonString.getFormatPara(model.get("brand_name")) %>"  style="width:270px"/>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">类<span class="span2">&nbsp;</span>别</div>
    <div class="formRight">
      <select class="jr_select" id="zd_catalog_num" name="zd_catalog_num" onchange="jQuery('#zd_catalog_name').val(jQuery.trim(jQuery('#zd_catalog_num').find('option:selected').text()));">
        <option value="">--请选择产品类别--</option>
      <%if(catalogList != null){for(Map m : catalogList){%>
       <option value="<%=m.get("num")%>" <%if(CommonString.getFormatPara(model.get("catalog_num")).equals(m.get("num").toString())){%> selected="selected"<%}%> <%if(m.get("num").equals("102")||m.get("num").equals("103")||m.get("num").equals("104")||m.get("num").equals("105")||m.get("num").equals("106")||m.get("num").equals("107")||m.get("num").equals("108")||m.get("num").equals("109")){%> disabled=true<%}%>><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
         <%}}%>
      </select>
    </div>
    <div class="formRight">
     <input type="text" class="jr_text" name="zd_catalog_name" id="zd_catalog_name" value="<%=CommonString.getFormatPara(model.get("catalog_name")) %>" style="width:270px" />
    </div>
 
    <div style="clear: left;"></div>
        <div class="formLeft">产品图片</div>
        <div class="formRight" style="width:490px;">
          <input type="text" style="width: 350px;" class="jr_text" name="zd_img" id="zd_img" value="<%=CommonString.getFormatPara(model.get("img")) %>" />
          <span style="float:right; margin-right: 5px;color:red;">logo尺寸：414×290</span>
        </div>
		<div class="formRight" style="padding-left: 30px;  position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img',700,480);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
    
    <div style="clear:left;"></div>
    <div class="formLeft">是否显示</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> </div>
    
    <div style="clear:left;"></div> 
    <div class="formLeft">文件名称</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_file_name" id="zd_file_name" value="<%=CommonString.getFormatPara(model.get("file_name")) %>" />
    </div>

   <div style="clear:left;"></div>
    <div class="formLeft">产品介绍</div>
    <div class="formRight" style="height: 320px; text-align: left;"> 
      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("content")) %></script>
      <input type="hidden" name="zd_content" id="zd_content" value='' />
    </div>
    
    <div style="clear:left;"></div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <input type="hidden" name="eventAfter" value="productsMachineCreate" /> 
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
	   var result = 0 ;
		var rs = Validator.Validate(document.getElementById("theform"),1);
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
    	textarea : 'zd_content',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_introduce.render('editor_introduce');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_content").value=ue_introduce.getContent();
	});
    
	document.getElementById("zd_content").value = ue_introduce.getContent();
	function smallToBig(o,id){
		jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
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
		DBHelper.freeConnection(connection);
	}
%>