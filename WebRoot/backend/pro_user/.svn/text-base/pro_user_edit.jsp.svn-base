<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_weixiu_info";
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
		String factoryid = "" ;
		if(null!=model){
			factoryid = CommonString.getFormatPara(model.get("factory")) ;  // 品牌 id 
		}
		
	List<Map> procatalogAppList = dbHelper.getMapList(" select id,parentid,num,catalogname from pro_factory_category where factoryid=?",new Object[]{factoryid}) ;
	List <Map> procatalogList = null ;
	  if(procatalogAppList!=null){
		  procatalogList = CommonApplication.getTreeByPno("0", procatalogAppList , "parentid","num");
	  }
	  Map ishotMap = new HashMap() ;
	  ishotMap.put("10","否") ;
	  ishotMap.put("11","是") ;
	  String no = CommonString.getFormatPara(model.get("catalog")); // 
	  String category = CommonString.getFormatPara(model.get("catalog"));
	  List<Map> list = Tools.getCategoryParam(category,"106001");//获得设置为礼品网的枚举
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
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
</head>

<body style="margin: 0;padding: 0; overflow-x: hidden;overflow-y: auto; ">
<form name="theform" id="theform" action="/backend/action/crud.jsp">
<div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
</span>  
<span class="groupTitle">基本信息</span>
</div>
  <div class="formDiv">
    <div style="clear:left;"></div>
    <div class="formLeft">新闻标题</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>"<%if(id.equals("")){ %> onblur="setFileName(this.value);" <%} %>/> 
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">品<span class="span2">&nbsp;</span>牌</div>
    <div class="formRight">
      <select class="jr_select" id="zd_factory" name="zd_factory" onchange="jQuery('#zd_factoryname').val(jQuery('#zd_factoryid').find('option:selected').text())">
        <option value="">--请选择品牌--</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(CommonString.getFormatPara(model.get("factory")).equals(m.get("id").toString())){%> selected="selected"<%}%>><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">类<span class="span2">&nbsp;</span>别</div>
    <div class="formRight">
      <select class="jr_select" id="zd_catalog" name="zd_catalog" onchange="jQuery('#zd_catalogname').val(jQuery.trim(jQuery('#zd_catalognum').find('option:selected').text()));showParam(this.options[this.selectedIndex].value);">
        <option value="">--请选择产品类别--</option>
      <%if(catalogList != null){for(Map m : catalogList){%>
       <option value="<%=m.get("num")%>" <%if(CommonString.getFormatPara(model.get("catalog")).equals(m.get("num").toString())){%> selected="selected"<%}%>><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
         <%}}%>
      </select>
    </div>
		<div style="clear:left;"></div>
    		<div class="formLeft">作<span class="span2">&nbsp;</span>者</div>
  		    <div class="formRight">
      		<input type="text" class="jr_text" style="width:100%;" name="zd_username" id="zd_username" value="<%=CommonString.getFormatPara(model.get("username")).equals("")?"front":CommonString.getFormatPara(model.get("username"))%>"/>
   			 </div>
      <div id="paramId"> 
    <div class="group"> </div>
</div>
<span class="groupTitle"></span>
    <div class="formLeft">是否显示</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> </div>
   <div style="clear:left;"></div>
    <div class="formLeft"></div>
    <div class="formRight" style="height: 320px; text-align: left;"> 
      <script type="text/plain" id="editor_content" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("content")) %></script>
      <input type="hidden" name="zd_content" id="zd_content" value='' />
    </div>
    <div style="clear:left;"></div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <!--<input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=UUID.randomUUID().toString() %>"/>-->
  <!-- 产品参数 -->
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
		savaProductAndParam(); 
		}
		if(result>0)
		{
		  return true ;
		}
	}
	//保存方法
	function savaProductAndParam(){
		//参数保存----
		var paramV = document.getElementsByName("param");
		var zd_param = "["
		for(var i =0;paramV.length > 0 && i<paramV.length;i++){
			//组装json
			if(i==paramV.length-1){
				zd_param += "{"+paramV[i].lang+",'value':'"+paramV[i].value+"'}";	
			}else{
				zd_param += "{"+paramV[i].lang+",'value':'"+paramV[i].value+"'},";
			}
		}
		zd_param += "]";
		jQuery("#zd_param").val(zd_param);
		
		jQuery.ajax({
			url : '/backend/action/ajax_cud.jsp',	
			data : { paramStr:zd_param , product_no:'<%=no%>' , flag:'saveParamValue' , enumNo:'106013' },
			type : 'post',
			async : false
		});
		//参数保存----
		//关键参数项保存，设置该产品有的关键参数项
		var keyparam = "[";
		jQuery.each(jQuery("table[id^=key_]"),function(){
			keyparam += "{"+jQuery(this).attr("lang")+",'param':[";
			var pKey = jQuery(this).find("input:checkbox");
			for(var i = 0; i < pKey.length; i++){
				if(pKey[i].checked){
					keyparam += pKey[i].value+",";	
				}
			}
			if(keyparam.substring(keyparam.length-1) == ","){
				keyparam = keyparam.substring(0,keyparam.length-1);
			}
			keyparam += "]},";
		});
		if(keyparam.substring(keyparam.length-1) == ","){
			keyparam = keyparam.substring(0,keyparam.length-1);
		}
		keyparam += "]";
		jQuery("#zd_param_key").val(keyparam);
		
		jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
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
	}
    var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_content',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_introduce.render('editor_content');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_content").value=ue_introduce.getContent();
	});
    var ue_paras = new baidu.editor.ui.Editor({
    	textarea : 'zd_paras',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
   
    ue_paras.addListener("selectionchange",function(){
	    var state_paras = ue_paras.queryCommandState("source");
	    document.getElementById("zd_paras").value=ue_paras.getContent();
	});
	document.getElementById("zd_paras").value = ue_paras.getContent();
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
function showParam(category){
		jQuery.ajax({
			url : 'get_param_html.jsp',
			data : { category : category , no : '<%=no%>' } ,
			type : 'post' ,
			async : false ,
			success : function(data){
				jQuery("#paramId").css("display","block");
				jQuery("#paramId").html(data);
			}
		});
	}
	//为参数赋值
	var param = <%=CommonString.getFormatPara(model.get("param")).equals("")?"[]":CommonString.getFormatPara(model.get("param"))%>;
	for(var i = 0; i < param.length; i++){
		if(jQuery("#"+param[i].no) != null){
			jQuery("#"+param[i].no).val(param[i].value);
		}
	}
	//为关键参数项赋值
	var paramKey = <%=CommonString.getFormatPara(model.get("param_key")).equals("")?"[]":CommonString.getFormatPara(model.get("param_key"))%>;
	for(var i = 0; i < paramKey.length; i++){
		for(var j = 0; j < paramKey[i].param.length; j++){
			var paramA = paramKey[i].param[j];
			jQuery("#"+paramA.no).attr("checked","checked");
		}
	}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>