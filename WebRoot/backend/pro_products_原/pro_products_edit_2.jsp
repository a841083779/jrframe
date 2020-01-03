<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_products";
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
<form name="form1" method="post" action="">
			<table width="482" height="396" border="1" align="center"
				cellpadding="0" cellspacing="0" bordercolor="C4BED8">
				<tr bgcolor="#F2EDFF">
					<th height="34" colspan="2" scope="col">
						招聘邮件发送
					</th>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td width="150" height="32">
						<div align="right" style="width:100px;">
							招聘岗位：
						</div>
					</td>
					<td width="406">
						<div align="center">
							<input type="text" name="rname" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="26">
						<div align="right">
							姓名：
						</div>
					</td>
					<td>
						<div align="center">
							<input type="text" name="sname" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="28">
						<div align="right">
							性别：
						</div>
					</td>
					<td>
						<div align="left">
							<input type="radio" name="sex" value="1"/>男
							<input type="radio" name="sex" value="0"/>女
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							年龄：
						</div>
					</td>
					<td>
						<div align="center">
							<input type="text" name="title" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							学历：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							毕业院校：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							专业：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							工作经历：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							联系电话：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							邮箱：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="27">
						<div align="right">
							现住详址：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51"/>
						</div>
					</td>
				</tr>
				<tr bgcolor="#F2EDFF">
					<td height="34">
						<div align="right">
							简历：
						</div>
					</td>
					<td>
						<div align="center">
							<input name="content" size="51" id="zd_img2" name="zd_img2"/>
						</div>
						 <div class="formRight" style="width: 100px;"> <a href="" id="zd_img2" onclick='return hs.expand(this)'><img src="/backend/images/yulan.gif" /></a> <span id="equi_img"></span> </div>
					</td>
				</tr>
				<tr align="center" valign="middle" bgcolor="#F2EDFF">
					<td height="30" colspan="2">
						<input type="submit" name="Submit2" value="提交"/>
						&nbsp;
						<input type="reset" name="Submit3" value="重置"/>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script> 
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	jQuery("#equi_img").JrUpload({
		remotUrl : "http://resource.21-sun.com/upload.jsp",
		folder : "rent" ,
		callback : "setEquiImg"
	});
	function setEquiImg(data){
		var imgUrl = "http://resource.21-sun.com"+data;
		jQuery("#a_img").attr("href",imgUrl);
		jQuery("#zd_img1").val(imgUrl);
	}
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
	document.getElementById("zd_paras").value = ue_paras.getContent();
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
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>