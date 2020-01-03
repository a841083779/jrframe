<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_photo_group";
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
		//类型
		Map sortMap = new LinkedHashMap();
		sortMap = CommonApplication.getEnumChildren("107", application);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
	<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
  </head>
  
  <body style="margin: 0;padding: 0; overflow-x: hidden; ">
	<form name="theform" id="theform" action="/backend/action/crud.jsp">
		<div class="formDiv">
					<div class="group">
					<span>
				    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
				     </span>
					<span class="groupTitle">基础信息</span>
					</div>
				<div style="clear:left;"></div>
				<div class="formLeft">标<span class="span2">&nbsp;</span>题</div>
				<div class="formRight">
					<input type="text" class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>" />
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">栏<span class="span2">&nbsp;</span>栏</div>
			    <div class="formRight" style="width:80%;"> 
			      <%=CommonForm.createCheckbox(sortMap,CommonString.getFormatPara(model.get("sort_num")),"sortNum") %>
			      <input type="hidden" class="jr_text" name="zd_sort_num" id="zd_sort_num" value="<%=CommonString.getFormatPara(model.get("sort_num")) %>" dataType="Require" msg="请选择分类" />
			    </div>
			    <div style="clear:left;"></div>
					
				<div class="formLeft">展<span class="span2">&nbsp;</span>会</div>
			 <select style="margin-left: -440px;" id="zd_zhanhui_num" name="zd_zhanhui_num" >
			 <% if(CommonString.getFormatPara(model.get("zhanhui_num")).equals("")){ %>
                  <option>选择类别</option>
				  <%}else{%>
				   <option value="<%=CommonString.getFormatPara(model.get("zhanhui_num"))%>">
				   <% if(CommonString.getFormatPara(model.get("zhanhui_num")).equals("107005001")){%>北京展BICES<%}else if(CommonString.getFormatPara(model.get("zhanhui_num")).equals("107005002")){%> 上海宝马展<%} else  if(CommonString.getFormatPara(model.get("zhanhui_num")).equals("107005003")){%> 法国国际工程机械展<%}%></option>
				  <%}%>
		          <option value="107005001">北京展BICES</option>
				  <option value="107005002">上海宝马展</option>
				  <option value="107005003">法国国际工程机械展</option>
            </select>
			    <div style="clear:left;"></div>
			    <div class="formLeft">封<span class="span2">&nbsp;</span>面</div>
				<div class="formRight">
		          <input type="text" style="width: 400px;" class="jr_text" name="zd_image" id="zd_image" value="<%=CommonString.getFormatPara(model.get("image")) %>" />
		        </div>
				<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
					<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_image',700,480);" value="选择图片" />
					<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_image");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">类型关键字</div>
				<div class="formRight" style="width:80%;text-align:left;">
					<input type="text" class="jr_text"  style="width:80%;" name="zd_keywords" id="zd_keywords" value="<%=CommonString.getFormatPara(model.get("keywords")) %>" /> 多个以"-"分隔
				</div>
				<div style="clear:left;"></div>
				<div class="formLeft">品牌关键字</div>
				<div class="formRight" style="width:80%;text-align:left;">
					<input type="text" class="jr_text"  style="width:80%;" name="zd_brand_keywords" id="zd_brand_keywords" value="<%=CommonString.getFormatPara(model.get("brand_keywords")) %>" /> 多个以"-"分隔
				</div>
				<div style="clear:left;"></div>
				<div class="group">
					<span>
				    <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
				     </span>
					<span class="groupTitle">扩展信息</span>
					</div>
				<div class="formLeft">发布时间</div>
				<div class="formRight">
					<%
					String pubDate = CommonString.getFormatPara(model.get("pub_date"));
					if(pubDate==null || pubDate.equals("")){
						pubDate = CommonDate.getToday("yyyy-MM-dd");
					}
					
					%>
					<input type="text" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" style="width:160px;" name="zd_pub_date" id="zd_pub_date" value="<%=pubDate %>" dataType="Require" msg="请输入发布时间" />
				</div>
				<div class="formLeft">显<span class="span2">&nbsp;</span>示</div>
				<div class="formRight">
					<%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %>
				</div>
				<div style="clear:left;"></div>
		</div>
		<div style="clear: left;"></div>
		<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
		<input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
	</form>
  </body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script src="/plugin/other/highslide/highslide.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
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
		//设置分类
		var sortVal = "";
		var product_flag_checkbox = jQuery("input[name='sortNum']") ;
		jQuery.each(product_flag_checkbox,function(i,n){
			var v = jQuery(n).val();
			if(jQuery(n).attr("checked")=="checked"){
			 sortVal += v+",";
			}
		}) ;
		$("#zd_sort_num").val(sortVal);
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
	jQuery(function(){
		var product_flag_checkbox = jQuery("input[name='sortNum']") ;
		jQuery.each(product_flag_checkbox,function(i,n){
		  if('<%=model.get("sort_num")%>'.indexOf(jQuery(n).attr("value"))!=-1){
		  	jQuery(n).attr("checked","checked") ;
		  }
		}) ;
	}) ;
</script><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>