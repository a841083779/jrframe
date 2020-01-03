<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;  // 厂家 id
	String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;
	Map model = new HashMap();
	String id = CommonString.getFormatPara(request.getParameter("id")) ;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String tableName = tablePrefix+"factory_category";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	try{
		connection = dbHelper.getConnection();
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where id =? ",new Object [] {id} , connection);
		}
	List <Map> catalogAppList_pre = (ArrayList<Map>)application.getAttribute("catalogList");
	List<Map> catalogList_pre = CommonApplication.getTreeByPno("0", catalogAppList_pre , "parentid","id");
	List<Map> catalogAppList = dbHelper.getMapList(" select id,parentid,num,catalogname from pro_factory_category where factoryid=?",new Object[]{factoryid}) ;
	List <Map> catalogList = null ;
	  if(catalogAppList!=null){
		  catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","num");
	  }
	String no = "";
	if(model!=null){
		no = CommonString.getFormatPara(model.get("num"));
		if("".equals(no)){
			no = Common.getNo("0",tableName,"parentid","num",factoryid);   //  生成一级类别编号
		}
	}else{
		no = Common.getNo("0",tableName,"parentid","num",factoryid);   //  生成一级类别编号
	}
	
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

<body style="margin: 0;padding: 0; overflow-x: hidden; ">
<form name="theform" id="theform" action="/backend/action/crud.jsp">
  <div class="formDiv">
  <div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /></span> <span class="groupTitle">基础信息</span> </div>
  <div style="clear: left;"></div>
  <div class="formLeft">所属类别</div>
  <div class="formRight">
    <select class="jr_select" name="zd_parentid" id="zd_parentid">
      <option value="0">一级类别</option>
      <%=model==null?"":CommonForm.createSelect(catalogList,catalognum,"num","catalogname") %>
    </select>
  </div>
  <div style="clear: left;"></div>
  <div class="formLeft">编号</div>
  <div class="formRight">
    <input type="text" name="zd_num" class="jr_text" readonly="readonly" id="zd_num" value="<%=no %>"  />
  </div>
  <div style="clear: left;"></div>
  <div class="formLeft">名称</div>
  <div class="formRight">
    <input type="text" dataType="Require" msg="请您输入名称！" class="jr_text" name="zd_catalogname" id="zd_catalogname" value="<%=model==null?"":CommonString.getFormatPara(model.get("name")) %>" />
  </div>
  <div style="clear: left;"></div>
  <div class="formLeft">是否显示</div>
  <div class="formRight"> <%=CommonForm.createIsRadio("1","zd_is_show") %> </div>
  <div style="clear: left;"></div>
    <div class="formLeft">原类别</div>
  <div class="formRight">
    <select class="jr_select" name="catalogname_old" id="catalogname_old">
      <option value="0">一级类别</option>
      <%=CommonForm.createSelect(catalogList_pre,CommonString.getFormatPara("0"),"num","name") %>
    </select>
  </div>
    <div style="clear: left;"></div>
    <div class="formLeft">原类别编号</div>
  <div class="formRight">
  	<input type="text" name="zd_catalogid_old" class="jr_text" readonly="readonly" id="zd_catalogid_old" style="width:160px;" value="0"  />
  </div>
    <input type="hidden" name="zd_catalogname_old" id="zd_catalogname_old" value="一级类别" />
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=model==null?"":CommonString.getFormatPara(model.get("id")) %>" />  
  <input type="hidden" name="eventAfter" id="eventAfter" value="updateApplicationCatalog" />
  <input type="hidden" name="zd_factoryid" id="zd_factoryid" value="<%=factoryid %>" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js?tab" type="text/javascript"></script>
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
	}

	jQuery(function(){
		jQuery("#zd_parentid").change(function(){
			jQuery.post("/backend/action/ajax_r.jsp",{'tableName':'<%=tableName%>','flag':'get_no_catalog','pno':this.value,'factoryid':'<%=factoryid%>'},function(data){
				jQuery("#zd_num").val(jQuery.trim(data));
			});
		});
	});
	function smallToBig(o,id){
		jQuery(o).attr("href",jQuery("#"+id).val());
		return hs.expand(o);
	}
	jQuery(function(){
		jQuery("#catalogname_old").change(function(){
				jQuery("#zd_catalogid_old").val(jQuery(this).val());
				jQuery("#zd_catalogname_old").val(jQuery.trim(jQuery(this).find("option:selected").text())) ;
		});
	});
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>