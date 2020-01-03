<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,org.json.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_products";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	String adminName="";
	if(adminInfo!=null){
	adminName=CommonString.getFormatPara(adminInfo.get("usern"));
	}
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
		
		//List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		List <Map> brandList =  dbHelper.getMapList(" select id,name,upper_index from pro_agent_factory where is_show=1 and flag=1 order by upper_index",connection) ;
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		String factoryid = "" ;
		String no="";
		if(null!=model){
			factoryid = CommonString.getFormatPara(model.get("factoryid")) ;  // 品牌 id 
			no = CommonString.getFormatPara(model.get("catalognum")); // 

		}
		
	List<Map> procatalogAppList = dbHelper.getMapList(" select id,parentid,num,catalogname from pro_factory_category where factoryid=?",new Object[]{factoryid}) ;
	List <Map> procatalogList = null ;
	  if(procatalogAppList!=null){
		  procatalogList = CommonApplication.getTreeByPno("0", procatalogAppList , "parentid","num");
	  }
	  Map ishotMap = new HashMap() ;
	  ishotMap.put("10","否") ;
	  ishotMap.put("11","是") ;
	   List<Map> list = Tools.getCategoryParam(no,"106001");
	  
	  Map isCheckMap = new HashMap() ;
	  isCheckMap.put("0","否") ;
	  isCheckMap.put("1","是") ;
	 
	  
	 List <Map> categoryParamsList =  dbHelper.getMapList(" select id,name,category_id,no,order_no from pro_catalog_param where parent_no="+no);//参数字段
     List <Map> categoryList =  dbHelper.getMapList(" select id,name   from pro_category where parent_no="+no); //参数再分类别
	
	 if((categoryParamsList ==null || categoryParamsList.size()<=0)&&no.length()>=6){
				//list = getCategoryParam(category.substring(0,category.length()-3),enumNo);
				categoryParamsList =  dbHelper.getMapList(" select id,name,category_id,no,order_no from pro_catalog_param where parent_no='"+no.substring(0,no.length()-3)+"'");//参数字段
                categoryList =  dbHelper.getMapList(" select id,name   from pro_category where parent_no='"+no.substring(0,no.length()-3)+"'"); //参数再分类别
				 if((categoryParamsList ==null || categoryParamsList.size()<=0)&&no.length()>=6){
					categoryParamsList =  dbHelper.getMapList(" select id,name,category_id,no,order_no from pro_catalog_param where parent_no='"+no.substring(0,3)+"'");//参数字段
                    categoryList =  dbHelper.getMapList(" select id,name   from pro_category where parent_no='"+no.substring(0,3)+"'"); //参数再分类别
				 }
	}
    
	 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name")+" select id,name,category_id,no,order_no from pro_catalog_param where parent_no="+no %></title>
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

	
	     <div id="paramId"> 
    <div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span> <span class="groupTitle">产品参数</span> </div>
    <%
		if(categoryParamsList != null && categoryParamsList.size() > 0){
		for(Map catalog_group:categoryList){
		String group_id=CommonString.getFormatPara(catalog_group.get("id"));
		int i = 0;
		Map enumMap = null;
	   String group_name= CommonString.getFormatPara(catalog_group.get("name"));
		%>
		<div style="clear:left;"></div>
		<div class="formLeft" style="width:145px;font-weight: bold;color: red;"><%=group_name%></div>
		<div style="clear:left;"></div>
		<%
			for(Map m : categoryParamsList){
				
			 String cataolgryId= CommonString.getFormatPara(m.get("category_id"));
			 String cataolgryName= CommonString.getFormatPara(m.get("name"));
			 String cataolgryParamId= CommonString.getFormatPara(m.get("id"));

			  
			if(group_id.equals(cataolgryId)){
			  //参数信息
			  String param=CommonString.getFormatPara(model.get("param"));
			  String param_product_no="",param_id="",param_name="",param_type="",param_order_no="",param_enum_no="",param_value=""; 
			  if(!param.equals("")&&!param.equals("[]")){
			  JSONArray keyParaAry = new JSONArray(param); //关键参数列表
          		if(keyParaAry!=null && keyParaAry.length()>0){
				   for(int j=0;j<keyParaAry.length();j++){
          				JSONObject keyParaObj = keyParaAry.getJSONObject(j);
							 param_product_no = CommonString.getFormatPara(keyParaObj.get("product_no"));
				
							 param_id = CommonString.getFormatPara(keyParaObj.get("no"));
				
							 param_name = CommonString.getFormatPara(keyParaObj.get("name"));
							 param_type = CommonString.getFormatPara(keyParaObj.get("type"));
							 param_order_no = CommonString.getFormatPara(keyParaObj.get("order_no"));
							 param_enum_no = CommonString.getFormatPara(keyParaObj.get("enum_no"));
							 param_value = CommonString.getFormatPara(keyParaObj.get("value"));
		        if(cataolgryParamId.equals(param_id)){
	%>
	
	<div class="formLeft" style="width:145px"><%=m.get("name")%></div>
	<div class="formRight" style="width:190px">
	  <input style="width:190px" type="text" class="jr_text" name="param" id="<%=CommonString.getFormatPara(model.get("id"))%>" lang="'product_no':'<%=param_product_no%>' ,'no':'<%=cataolgryParamId%>' , 'name':'<%=param_name%>' , 'type':'1', 'order_no':'<%=param_order_no%>' , 'enum_no':'<%=param_enum_no%>' " value="<%=param_value%>" maxlength="50"/>
	</div>
	
	<%}else {%>
	<div class="formLeft" style="width:145px"><%=m.get("name")%></div>
	<div class="formRight" style="width:190px">
	  <input style="width:190px" type="text" class="jr_text" name="param" id="<%=CommonString.getFormatPara(model.get("id"))%>" lang="'product_no':'<%=no%>' ,'no':'<%=cataolgryParamId%>' , 'name':'<%=cataolgryName%>' , 'type':'1', 'order_no':'<%=param_order_no%>' , 'enum_no':'<%=param_enum_no%>' " value="<%=param_value%>" maxlength="50"/>
	</div>
	
	<%}}}}else{%>
	<div class="formLeft" style="width:145px"><%=m.get("name")%></div>
	<div class="formRight" style="width:190px">
	  <input style="width:190px" type="text" class="jr_text" name="param" id="<%=CommonString.getFormatPara(model.get("id"))%>" lang="'product_no':'<%=no%>' ,'no':'<%=cataolgryParamId%>' , 'name':'<%=m.get("name")%>' , 'type':'1', 'order_no':'0' , 'enum_no':'0' " value="" maxlength="50"/>
	</div>
	<%}%>
	
	
    <%
	  }
	  }
		i++;}	
		}
	%>  
</div>


  </div>
  <%if(adminName.equals("mujie")||adminName.equals("admin")){%>
	<div class="formLeft">是否审核</div>
    <div class="formRight" style="width:100px;"> 
	<%=CommonForm.createRadio(isCheckMap,CommonString.getFormatPara(model.get("is_check")).equals("")?"0":CommonString.getFormatPara(model.get("is_check")),"zd_is_check") %> 
	</div>
  <%}%>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
   <input type="hidden" name="zd_param" id="zd_param" value="<%=CommonString.getFormatPara(model.get("param")) %>" />
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
			result = rs ;

		}
		if(result>0)
		{
		  window.location.reload();
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
	function getarea(a){
	jQuery.post("/backend/pro_products/tools/ajax_catalog_new.jsp",{"catalognum":a},function(data){$('#zd_catalognum_new').val(data);});
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
	/*
	var param = <%=CommonString.getFormatPara(model.get("param")).equals("")?"[]":CommonString.getFormatPara(model.get("param"))%>;
	for(var i = 0; i < param.length; i++){
		if(jQuery("#"+param[i].no) != null){
			jQuery("#"+param[i].no).val(param[i].value);
		}
	}
	*/
	
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