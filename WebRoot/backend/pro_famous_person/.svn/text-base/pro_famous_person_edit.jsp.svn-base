<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_famous_person";
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
			factoryid = CommonString.getFormatPara(model.get("factoryid")) ;  // 品牌 id 
		}
		
	List<Map> procatalogAppList = dbHelper.getMapList(" select id,parentid,num,catalogname from pro_factory_category where factoryid=?",new Object[]{factoryid}) ;
	List <Map> procatalogList = null ;
	  if(procatalogAppList!=null){
		  procatalogList = CommonApplication.getTreeByPno("0", procatalogAppList , "parentid","num");
	  }
	  Map ishotMap = new HashMap() ;
	  ishotMap.put("10","否") ;
	  ishotMap.put("11","是") ;
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
    <div class="formLeft">姓名</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>" />
    </div>
     <div class="formLeft">英文名</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_name_en" id="zd_name_en" value="<%=CommonString.getFormatPara(model.get("name_en")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">厂	家</div>
    <div class="formRight">
      <select class="jr_select" id="zd_factoryid" name="zd_factoryid" onchange="jQuery('#zd_factoryname').val(jQuery('#zd_factoryid').find('option:selected').text())">
        <option value="">--请选择厂家--</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(CommonString.getFormatPara(model.get("factoryid")).equals(m.get("id").toString())){%> selected="selected"<%}%>><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>"  style="width:270px"/>
    </div>
    <div style="clear: left;"></div>
        <div class="formLeft">人物图片</div>
        <div class="formRight">
          <input type="text" style="width: 400px;" class="jr_text" name="zd_img" id="zd_img2" value="<%=CommonString.getFormatPara(model.get("img")) %>" />
        </div>
		<div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
			<input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img2',700,480);" value="选择图片" />
			<a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img2");'><input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" /></a>
		</div>
        
   <div style="clear:left;"></div>
    <div class="formLeft">职位</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_position" id="zd_position" value="<%=CommonString.getFormatPara(model.get("position")) %>" />
    </div>
     <div class="formLeft">国籍</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_nationality" id="zd_nationality" value="<%=CommonString.getFormatPara(model.get("nationality")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft" style=" height:50px">简介</div>
				<div class="formRight">
					<textarea class="jr_textarea" name="zd_intro" id="zd_intro" style="heigth:50px;"><%=CommonString.getFormatPara(model.get("intro")) %></textarea>
				</div>
<div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/>
</span>
<span class="groupTitle">拓展信息</span>
</div>
    <div style="clear:left;"></div>
    <div class="formLeft">微博链接</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_weibo_url" id="zd_weibo_url" value="<%=CommonString.getFormatPara(model.get("weibo_url")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">民族</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_nation" id="zd_nation" value="<%=CommonString.getFormatPara(model.get("nation")) %>" />
    </div>
    <div class="formLeft">出生地</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_birthplace" id="zd_birthplace" value="<%=CommonString.getFormatPara(model.get("birthplace")) %>" />
    </div>
    <div class="formLeft">出生日期</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_birthday" id="zd_birthday" value="<%=CommonString.getFormatPara(model.get("birthday")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">职业</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_profession" id="zd_profession" value="<%=CommonString.getFormatPara(model.get("profession")) %>" />
    </div>
     <div class="formLeft">毕业院校</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_graduate" id="zd_graduate" value="<%=CommonString.getFormatPara(model.get("graduate")) %>" />
    </div>
    <div style="clear:left;"></div>
       <div class="formLeft">主要成就</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_achieve" id="zd_achieve" value="<%=CommonString.getFormatPara(model.get("achieve")) %>" />
    </div>
     <div class="formLeft">点击量</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_view_count" id="zd_view_count" value="<%=CommonString.getFormatPara(model.get("view_count")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">是否显示</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> </div>
    <div style="clear:left;"></div>
    <div class="formLeft">详细介绍</div>
    <div class="formRight" style="height: 320px; text-align: left;"> 
      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("introduce")) %></script>
      <input type="hidden" name="zd_introduce" id="zd_introduce" value='' />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">微博秀</div>
    <div class="formRight" style="height: 200px; text-align: left;"> 
      <script type="text/plain" id="editor_paras" style="width:650px; height:160px;"><%=CommonString.getFormatPara(model.get("weibo")) %></script>
      <input type="hidden" name="zd_weibo" id="zd_weibo" value='' />
    </div>
    <div style="clear:left;"></div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <input type="hidden" name="eventAfter" value="" />
  <input type="hidden" name="zd_last_modify_date" id="zd_last_modify_date"  value="<%=CommonDate.getToday("yyyy-MM-dd HH:mm:ss") %>"/>
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
    	textarea : 'zd_weibo',
    	autoHeightEnabled:false,
    	minFrameHeight:160
    });
    ue_paras.render('editor_paras');
    ue_paras.addListener("selectionchange",function(){
	    var state_paras = ue_paras.queryCommandState("source");
	    document.getElementById("zd_weibo").value=ue_paras.getContent();
	});
	document.getElementById("zd_weibo").value = ue_paras.getContent();
	document.getElementById("zd_introduce").value = ue_introduce.getContent();
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
	jQuery("#zd_birthday").ligerDateEditor({width:150});
	jQuery("#zd_birthday").val('<%=CommonDate.getFormatDate("yyyy-MM-dd",model.get("birthday"))%>') ;
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>