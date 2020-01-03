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
				
				List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		String factoryid = "" ;
		if(null!=model){
			factoryid = CommonString.getFormatPara(model.get("factoryid")) ;  // 品牌 id 
		}
		
	List<Map> procatalogAppList = dbHelper.getMapList(" select id,parentid,num,catalogname from pro_factory_category where factoryid=?",new Object[]{factoryid}) ;
	List <Map> procatalogList = null ;
	  if(procatalogAppList!=null){
		  procatalogList = CommonApplication.getTreeByPno("0", procatalogAppList , "parentid","num");
	  }
	  
	   List<Map> daili = dbHelper.getMapList(" select  name,city from pro_agent_factory where is_cooperate=?",new Object[]{1}) ;
	  
	   Map ishotMap = new HashMap() ;
	  ishotMap.put("0","多产品") ;
	  ishotMap.put("1","单产品") ;
	  String no = CommonString.getFormatPara(model.get("catalognum")); // 
	  String category = CommonString.getFormatPara(model.get("catalognum"));
	  List<Map> list = Tools.getCategoryParam(category,"106001");//获得设置为礼品网的枚举
				
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
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
<form name="theform" id="theform" action="/backend/action/crud.jsp">
<div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
</span>  
<span class="groupTitle">基本信息</span>
</div>
  <div class="formDiv">
  <div style="clear:left;"></div>
	<div class="formLeft">活动类别</div>
		  		<div class="formRight"> <%=CommonForm.createRadio(ishotMap,CommonString.getFormatPara(model.get("pro_type")),"zd_pro_type") %></div>
	<div class="formRight"></div>
	<div style="clear: left;"></div>
    <div class="formLeft"> 活动标题 </div>
	<div class="formRight" >
			      <input style="width:328px;" type="text" class="jr_text" name="zd_title" id="zd_title" value="<%=CommonString.getFormatPara(model.get("title")) %>"/>
		
	</div>
    <div style="clear:left;"></div>
	<div style="clear:left;"></div>
    <div class="formLeft">代理商</div>
    <div class="formRight">
	
      <select class="jr_select" id="zd_pro_factoryname" name="zd_pro_factoryname" onchange="getarea(this.options[this.selectedIndex].value);">
	 
        <option value="">--请选择代理商--</option>
        <%if(daili != null){for(Map dai : daili){%>
       <option value="<%=dai.get("name")%>" <%if(CommonString.getFormatPara(model.get("pro_factoryname")).equals(dai.get("name"))){%> selected="selected"<%}%>><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(dai.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=dai.get("name")%></option>
        
        <%}}%>
      </select>
    </div>
    
    <div class="formLeft">代理地区</div>
    <div class="formRight" style="width:250px; text-align:left" id="pr_place">
     <input type="text" class="jr_text" name="zd_agent_area" id="zd_agent_area" value="<%=CommonString.getFormatPara(model.get("agent_area"))%>" style="width:250px" />
      </div>
	  <div style="clear:left;"></div>
    <div class="formLeft">品<span class="span2">&nbsp;</span>牌</div>
    <div class="formRight">
      <select class="jr_select" id="zd_factoryid" name="zd_factoryid" onchange="jQuery('#zd_factoryname').val(jQuery('#zd_factoryid').find('option:selected').text());jQuery('#fa_id').val(this.options[this.selectedIndex].value);getProName(this.options[this.selectedIndex].value);">
        <option value="">--请选择品牌--</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(CommonString.getFormatPara(model.get("factoryid")).equals(m.get("id").toString())){%> selected="selected"<%}%>><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    
      <input type="hidden" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>"  style="width:270px"/>
   <input type="hidden" class="jr_text" name="fa_id" id="fa_id"   style="width:270px"/>
   
    <div class="formLeft">类<span class="span2">&nbsp;</span>别</div>
    <div class="formRight">
      <select class="jr_select" id="zd_pro_catanum" name="zd_pro_catanum" onchange="jQuery('#zd_pro_cataname').val(jQuery.trim(jQuery('#zd_pro_catanum').find('option:selected').text()));jQuery('#pro_id').val(this.options[this.selectedIndex].value);getProNameed(this.options[this.selectedIndex].value);">
        <option value="">--请选择产品类别--</option>
      <%if(catalogList != null){for(Map m : catalogList){%>
       <option value="<%=m.get("num")%>" <%if(CommonString.getFormatPara(model.get("pro_catanum")).equals(m.get("num").toString())){%> selected="selected"<%}%>><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
         <%}}%>
      </select>
    </div>
    <div class="formRight">
      <input type="hidden" class="jr_text" name="zd_pro_cataname" id="zd_pro_cataname" value="<%=CommonString.getFormatPara(model.get("pro_cataname")) %>" style="width:270px" />
	  <input type="hidden" class="jr_text" name="pro_id" id="pro_id" value="" style="width:270px" />
    </div>
       <div style="clear:left;"></div>
     <div class="formLeft">产品型号</div>
    <div class="formRight">
	 <select class="jr_select" id="zd_pro_name" name="zd_pro_name">
        <option value="<%=CommonString.getFormatPara(model.get("pro_name")) %>" pp="<%=CommonString.getFormatPara(model.get("pro_catanum")) %>"  bb="<%=CommonString.getFormatPara(model.get("factoryid")) %>"><%=CommonString.getFormatPara(model.get("pro_name")) %></option>
      </select>
    </div>
    <div style="clear:left;"></div>
        <div class="formLeft">活动图片</div>
        <div class="formRight">
          <input type="text" style="width: 400px;" class="jr_text" name="zd_img2" id="zd_img2" value="<%=CommonString.getFormatPara(model.get("img2")) %>" />
        </div>
		<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img2',700,480);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img2");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
    <div style="clear:left;"></div>
    <div class="formLeft">活动价格</div>
    <div class="formRight" style="width:155px; text-align:left">
      <input type="text" class="jr_text" name="zd_pro_start_price" id="zd_pro_start_price" value="<%=CommonString.getFormatPara(model.get("pro_start_price")).equals("")?"0":CommonString.getFormatPara(model.get("pro_start_price")) %>" style="width:130px" />
      &nbsp;万 </div>
    <!--<div class="formLeft" style="width:10px; text-align:left">-</div>
    <div class="formRight" style="width:200px; text-align:left">
      <input type="text" class="jr_text" name="zd_pro_end_price" id="zd_pro_end_price" value="<%=CommonString.getFormatPara(model.get("pro_end_price")).equals("")?"0":CommonString.getFormatPara(model.get("pro_end_price")) %>" style="width:130px" />
      &nbsp;万 </div>-->
     
<div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
</span>
<span class="groupTitle">拓展信息</span>
</div>
    <div style="clear:left;"></div>
    <div class="formLeft">是否显示</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> </div>
    <div style="clear:left;"></div>
    <div class="formLeft">产品介绍</div>
    <div class="formRight" style="height: 320px; text-align: left;"> 
      <textarea  style="width:428px; height:80px;" class="jr_textarea" name="zd_description" id="zd_description" ><%=CommonString.getFormatPara(model.get("description"))%></textarea>
    </div>
    <div style="clear:left;"></div>
   
  </div>
  <div style="clear: left;"></div>
  <div id="pr_other">
   <input type="hidden" name="zd_pro_catanum" id="zd_pro_catanum" value="<%=CommonString.getFormatPara(model.get("pro_catanum")) %>" />
   <input type="hidden" name="zd_pro_factoryid" id="zd_pro_factoryid" value="<%=CommonString.getFormatPara(model.get("pro_factoryid")) %>" />
  <div>
  <input type="hidden" name="tableName" id="tableName" value="pro_ymt_activity" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <!--<input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=UUID.randomUUID().toString() %>"/>-->
  <!-- 产品参数 -->
  <input type="hidden" name="eventAfter" value="productsCreate" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js"
	type="text/javascript"></script>
	<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
	<script type="text/javascript">
/*function getlei(){
	var factoryname=$('#zd_factoryname').val();
	$.post("/backend/pro_tuan/tools/ajax_peo_name.jsp",{flag:getlei,factoryname:factoryname},function(data){
		$("#zd_pro_catanum").html(data);
		});
	}*/
	
  function getProName(a){
    var name=$('#zd_factoryname').val();
	name = name.substr(2, name.length);
	$('#zd_factoryname').val(name);

   var factoryid=$('#pro_id').val();
	jQuery.post("/backend/pro_tuan/tools/ajax_peo_name.jsp",{"fa_id":factoryid,"factoryname":a},function(data){jQuery("#zd_pro_name").html(data);});
		}
		function getProNameed(a){
		var name=$('#zd_pro_cataname').val();
	   name = name.substr(2, name.length);
	    $('#zd_pro_cataname').val(name);
		
		var fa_ids=$('#fa_id').val();
		jQuery.post("/backend/pro_tuan/tools/ajax_peo_name.jsp",{"fa_id":a,"factoryname":fa_ids},function(data){
		jQuery("#zd_pro_name").html(data);
		});
		}
		
	function getarea(a){
	jQuery.post("/backend/pro_tuan/tools/ajax_peo_ares.jsp",{"place":a},function(data){jQuery("#pr_place").html(data);});
		}
		
	
</script>
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

  /*var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_introduce',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_introduce.render('editor_introduce');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_introduce").value=ue_introduce.getContent();
	});
  
	document.getElementById("zd_introduce").value = ue_introduce.getContent();
	function smallToBig(o,id){
		jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
		return hs.expand(o);
	}*/

	function doSub(){
		var bb=$("#zd_pro_name").find("option:selected").attr("bb");
		var pp=$("#zd_pro_name").find("option:selected").attr("pp");
		$("#zd_pro_catanum").val(pp);
		$("#zd_pro_factoryid").val(bb);
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