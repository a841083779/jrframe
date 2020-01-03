<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.util.dbutil.*"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	if(!"".equals(factory) && "".equals(factoryid)){
		factoryid = factory ;
	}
	if(!"".equals(catalogid) && "".equals(catalog)){
		catalog = catalogid ;
	}
	
	DBHelper dbHelper = DBHelper.getInstance();
	String type = CommonString.getFormatPara(request.getParameter("type"));
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String keywords = CommonString.getFormatPara(request.getParameter("keywords")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	Map model = new HashMap();
	ArrayList<Map> allSubCataList = new ArrayList<Map>();
	for(Map subCata : catalogList){
		if(CommonString.getFormatPara(subCata.get("num")).length() == 6){
			allSubCataList.add(subCata);
		}
	}
	
		//List <Map> catalogLists = CommonApplication.getTreeByPno("0", catalogList );
	//
	String factoryName = "";
	String catalogName = "";
	if(factoryid!=null && !factoryid.equals("")){
		factoryName = CommonString.getFormatPara(brandMap.get(factoryid));
	}
	if(catalog!=null && !catalog.equals("")){
		catalogName = CommonString.getFormatPara(catalogMap.get(catalog));
	}
	
	StringBuffer whereStr = new StringBuffer(" and image is not null and is_show=1  ") ;
	if(!"".equals(type)){
		whereStr.append(" and sort_num like '%"+type+"%'") ;
	}
	if(!"".equals(catalogName)){
		whereStr.append(" and keywords like '%"+catalogName+"%'") ;
	}
	if(!"".equals(factoryName)){
		whereStr.append(" and brand_keywords like '%"+factoryName+"%'") ;
	}
	
	String sortName = "";
	if(type.equals("107001")){
		sortName = "行业图片";
	}else if(type.equals("107003")){
		sortName = "施工图片";
	}else if(type.equals("107004")){
		sortName = "维修图片";
	}else if(type.equals("107005")){
		sortName = "展会类别";
	}else if(type.equals("107006")){
		sortName = "趣味图片";
	}else if(type.equals("107007")){
		sortName = "更多图片";
	}
	
	 List<Map> daili = dbHelper.getMapList(" select  id,name,city from pro_agent_factory where is_cooperate=?",new Object[]{1}) ;//代品牌
	 List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	 
		
	
	
	//拆分吨位
	String[] parttonandmeters = null;
	String firsttonandmeter = "";
	String sectonandmeter = "";
	
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(16) ; // 每页显示条数
	if(order.equals("view")){
		pageBean.setOrderBy(" view_count desc ");
	}else if(order.equals("is_hot")){
		pageBean.setOrderBy(" is_hot desc ");
	}else{
		pageBean.setOrderBy(" pub_date desc ");
	}
	pageBean.setCondition(whereStr.toString()) ;

	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
		nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;   
	String url = CommonString.getFormatPara(request.getQueryString()) ;
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
	String parentcatalogname = CommonString.getFormatPara(catalogMap.get(catalog.length()>6?catalog.substring(0,6):catalog));
    pageBean.setParams(url) ;
    pageBean.setFields(" id,image,title") ;
    pageBean.setTableName("pro_photo_group") ;
	
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
%><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>图片上传</title>
<meta name="renderer" content="webkit">
<meta name="keywords" content="工程机械图片,工程机械图片大全,工程机械,铁臂图库" />
<meta name="description" content="铁臂图库为您提供各种品牌工程机械高清图片，买工程机械就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<style type="text/css">
.uploadImg { width:600px; margin:0 auto; position:relative; padding-bottom:15px;}
.uploadImg .qqq { width:140px; position:absolute; right:0px; bottom:0px; padding-left:33px; font-family:"Microsoft Yahei"; text-align:right;}
.uploadImg .qqq .qq { position:absolute; left:0; top:0;}
.uploadImg .qqq .ar { text-align:right;}
.uploadImg .qqq .ar a { text-decoration:underline;}
.uploadImg .tip { text-align:right;}
.uploadImg .inp { width:360px; height:20px; line-height:20px;}
.uploadImg font { font-size:16px; font-weight:bold; color:#ff9000; vertical-align:middle;}
.uploadForm { clear:both;}
.uploadForm th,.uploadForm td { vertical-align:top; padding:5px;}
.uploadForm th { width:100px; text-align:right;}
.upload_btn { display:inline-block; width:120px; height:28px; vertical-align:middle; margin-right:5px;}
.upload_imgs { clear:both; overflow:hidden;}
.upload_imgs li { width:114px; height:auto; float:left; border:#cdcdcb 1px solid; margin:0px 15px 10px 0; position:relative;}
.upload_imgs .img { display:block; width:114px; height:84px;}
.upload_imgs strong { display:block; text-align:center; height:18px; line-height:18px; text-align:center; font-weight:normal; border-top:#cdcdcb 1px solid;}
</style>
</head>
<body>
<div class="uploadImg">
  <div class="tip"><font>*</font>为必填</div>
    <form name="comment_form" id="comment_form" method="post" action="/action/ajax_photo.jsp">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uploadForm">
    <tr>
      <th><font>*</font>标 题：</th>
      <td><input type="text" name="zd_title" id="zd_title" class="inp" dataType="Require" msg="请输入标题!" maxlength="30"/></td>
    </tr>
    <tr>
      <th><font>*</font>分 类：</th>
      <td><select name="zd_type" id="zd_type" class="inp" dataType="Require" msg="请输入分类!" >
		<option value="<%=sortName%>"><%=sortName%></option>
      </select></td>
    </tr>
	<input type="hidden" name="zd_sort_num" id="zd_sort_num" class="inp" value="<%=type%>"/>
	<%if(type.equals("107005")){%>
	  <tr>
      <th>展会类别：</th>
      <td><select name="zd_zhanhui_num" id="zd_zhanhui_num" class="inp" dataType="Require" msg="展会类别!" >
		<option value="0">选择展会类别</option>
		<option value="107005001">北京展BICES</option>
		<option value="107005002">上海宝马展</option>
		<option value="107005003">法国国际工程机械展</option>
      </select></td>
    </tr>
	<%}%>
    <tr>
      <th> 类别：</th>
	  <td>  <select id="zd_pro_catanum" name="zd_pro_catanum" onchange="jQuery('#zd_pro_cataname').val(jQuery.trim(jQuery('#zd_pro_catanum').find('option:selected').text()));jQuery('#pro_id').val(this.options[this.selectedIndex].value);getProNameed(this.options[this.selectedIndex].value);">
         <option>选择类别</option>
		  
        <option value="101">土方机械</option>
        
        <option value="101001">挖掘机</option>
        
        <option value="106001">压路机</option>
        
        <option value="105027">其它桩工机械</option>
        
        <option value="102013">桥梁式起重机</option>
        
        <option value="105028">截桩机/破桩机</option>
        
        <option value="118003">消防车</option>
        
        <option value="107010">专用叉车</option>
        
        <option value="118004">牵引车</option>
        
        <option value="110017">隧道轨道设备</option>
        
        <option value="119001">煤炭机械</option>
        
        <option value="111008">海工装备</option>
        
        <option value="110018">扒渣机</option>
        
        <option value="104002011">路面破碎机</option>
        
        <option value="120">风机</option>
        
        <option value="103021">A8 砂浆大师成套设备</option>
        
        <option value="103022">V8 城镇先锋混凝土成套设备</option>
        
        <option value="101001004">轮式挖掘机</option>
        
        <option value="101002">装载机</option>
        
        <option value="101002007">轮式装载机</option>
        
        <option value="101003001">推土机</option>
        
        <option value="101004001">自行式铲运机</option>
        
        <option value="101005002">自行式平地机</option>
        
        <option value="102">起重机</option>
        
        <option value="102007">汽车起重机</option>
        
        <option value="103001">混凝土泵车</option>
        
        <option value="103002003">搅拌楼</option>
        
        <option value="103005002">布料机</option>
        
        <option value="104004001">沥青混合料转运车</option>
        
        <option value="104008">稳定土厂拌设备</option>
        
        <option value="113002">液压剪</option>
        
        <option value="109006">砂浆车</option>
        
        <option value="106001009">振动压路机</option>
        
        <option value="101008003">矿用车</option>
        
        <option value="106003">压实机</option>
        
        <option value="118002">专用车辆</option>
        
        <option value="104002010">环卫机械</option>
        
        <option value="105026">多轴钻孔机</option>
        
        <option value="104001006">混凝土摊铺机</option>
        
        <option value="111007">推耙机</option>
        
        <option value="101001006">正铲挖掘机</option>
        
        <option value="101003">推土机</option>
        
        <option value="101003004">轮式推土机</option>
        
        <option value="102006">随车起重机</option>
        
        <option value="103">混凝土机械</option>
        
        <option value="103017">车载泵</option>
        
        <option value="103002">混凝土搅拌设备</option>
        
        <option value="103002002">搅拌站</option>
        
        <option value="104004008">碎石撒布机</option>
        
        <option value="107001003">侧面叉车</option>
        
        <option value="109005">检测车</option>
        
        <option value="103005001">布料杆</option>
        
        <option value="104007">沥青混合料搅拌设备</option>
        
        <option value="104001005">滑模摊铺机</option>
        
        <option value="101008002">刚性自卸卡车</option>
        
        <option value="113001">破碎锤</option>
        
        <option value="111006">场桥</option>
        
        <option value="106001008">静碾压路机</option>
        
        <option value="104002008">清扫机</option>
        
        <option value="106004">夯实机</option>
        
        <option value="110016">全液压凿岩钻机</option>
        
        <option value="101001007">其它挖掘机</option>
        
        <option value="101004">铲运机</option>
        
        <option value="102008">履带式起重机</option>
        
        <option value="103018">拖泵</option>
        
        <option value="103002001">搅拌机</option>
        
        <option value="104">筑养路机械</option>
        
        <option value="104001004">熨平板</option>
        
        <option value="104004005">沥青搅拌机</option>
        
        <option value="107001002">重型叉车</option>
        
        <option value="107005">仓储叉车</option>
        
        <option value="109004">提梁机</option>
        
        <option value="111003">吊具</option>
        
        <option value="101002004">其它装载机</option>
        
        <option value="106001006">冲击式压路机</option>
        
        <option value="104006">稳定土拌合机</option>
        
        <option value="101008001">铰接式自卸卡车</option>
        
        <option value="104002007">洒水车</option>
        
        <option value="110015">输送和辅助设备</option>
        
        <option value="101004003">地下铲运机</option>
        
        <option value="101005">平地机</option>
        
        <option value="102002">塔式起重机</option>
        
        <option value="103019">混凝土搅拌运输车</option>
        
        <option value="104001002">履带式摊铺机</option>
        
        <option value="104002009">沥青洒布车</option>
        
        <option value="105">桩工机械</option>
        
        <option value="106001005">轮胎压路机</option>
        
        <option value="107001001">普通内燃叉车</option>
        
        <option value="107003">电动叉车</option>
        
        <option value="109002">运梁车</option>
        
        <option value="111002">堆高机</option>
        
        <option value="101002008">挖掘装载机</option>
        
        <option value="104005">铣刨机</option>
        
        <option value="101001008">反铲挖掘机</option>
        
        <option value="103020">输送泵</option>
        
        <option value="110014">连续采煤机和隧道掘进机</option>
        
        <option value="102003">高空作业平台</option>
        
        <option value="104001001">轮式摊铺机</option>
        
        <option value="104002">养护机械</option>
        
        <option value="104002006">开槽机</option>
        
        <option value="106">压实机械</option>
        
        <option value="106001004">光轮压路机</option>
        
        <option value="107001">内燃叉车</option>
        
        <option value="109001">架桥机</option>
        
        <option value="111001">正面吊</option>
        
        <option value="101002009">滑移装载机</option>
        
        <option value="103005">混凝土布料设备</option>
        
        <option value="101008">自卸卡车</option>
        
        <option value="110013">装载及搬运设备</option>
        
        <option value="102010">高空作业车</option>
        
        <option value="104004">其它路面机械</option>
        
        <option value="104002005">灌缝机械</option>
        
        <option value="106001003">三轮压路机</option>
        
        <option value="107">叉车</option>
        
        <option value="103010">喷湿机</option>
        
        <option value="110012">筛分机</option>
        
        <option value="101002010">叉装机</option>
        
        <option value="104001">摊铺机</option>
        
        <option value="104002004">再生机械</option>
        
        <option value="106001002">双钢轮压路机</option>
        
        <option value="113">破碎设备</option>
        
        <option value="103008">干粉砂浆生产设备</option>
        
        <option value="110011">凿岩机和钻机</option>
        
        <option value="102011">施工升降机</option>
        
        <option value="106001001">单钢轮压路机</option>
        
        <option value="110">地下及矿山机械</option>
        
        <option value="104009">沥青搅拌站</option>
        
        <option value="103009">粉粒物料运输车</option>
        
        <option value="110010">凿岩钻车</option>
        
        <option value="105019">多功能钻机</option>
        
        <option value="102012">伸缩臂叉装机</option>
        
        <option value="103011">沥青砂浆车</option>
        
        <option value="105018">长螺旋钻孔机</option>
        
        <option value="110009">破碎机</option>
        
        <option value="119">煤炭机械</option>
        
        <option value="109">桥梁机械</option>
        
        <option value="105017">强夯机</option>
        
        <option value="110008">凿岩台车</option>
        
        <option value="103012">干混砂浆生产线</option>
        
        <option value="119002">采煤机</option>
        
        <option value="111">港口机械</option>
        
        <option value="105015">打桩锤</option>
        
        <option value="110002">矿用掘进机</option>
        
        <option value="118">专用汽车</option>
        
        <option value="103014">干混砂浆背罐车</option>
        
        <option value="110001">盾构掘进机</option>
        
        <option value="105013">液压步履式桩架</option>
        
        <option value="103015">其它混凝土设备</option>
        
        <option value="105011">打桩机</option>
        
        <option value="105016">连续墙钻机</option>
        
        <option value="105009">液压静力压桩机</option>
        
        <option value="105007">连续墙抓斗</option>
        
        <option value="105005">水平定向钻</option>
        
        <option value="105004">潜孔钻机</option>
        
        <option value="105003">旋挖钻机</option>
        
        </select>
        </select>
		<input type="hidden" class="jr_text" name="zd_pro_cataname" id="zd_pro_cataname" value="<%=CommonString.getFormatPara(model.get("catalogname")) %>" style="width:270px" />
	  <input type="hidden" class="jr_text" name="pro_id" id="pro_id" value="" style="width:270px" />
    
        品 牌：
       <select id="zd_factoryid" name="zd_factoryid" onchange="jQuery('#zd_factoryname').val(jQuery.trim(jQuery('#zd_factoryid').find('option:selected').text()));jQuery('#fa_id').val(this.options[this.selectedIndex].value);getProName(this.options[this.selectedIndex].value);" >
        <option>选择品牌</option>
		<%if(brandList != null){for(Map dai : brandList){%>
        <option value="<%=dai.get("id")%>"><%=dai.get("name")%></option>
        <%}}%>
      </select>
	  <input type="hidden" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>" style="width:270px"/>
	
    <input type="hidden" class="jr_text" name="fa_id" id="fa_id"   style="width:270px"/>
        型号：
        <select id="zd_pro_name" name="zd_pro_name"  onchange="jQuery('').val(jQuery('#zd_pro_name').find('option:selected').text());">
          <option>选择型号</option>
        </select></td>
    </tr>
    <tr>
      <th>上 传</th>
      <td><span id="addImgs"></span>未选择文件</td>
    </tr>
    <tr>
      <th colspan="2">
	  <ul class="upload_imgs" id="addImgs_show">
	   
       </ul>
        
      </th>
    </tr>
    <tr>
      <th>&nbsp;</th>
      <td><a href="javascript:;" title="确定上传"><img src="images/upload_btn.png"  onclick="doComments();" alt="确定上传" width="110" height="28" /></a></td>
    </tr>
  </table> 
      <input type="hidden" name="flag" value="new_save_photo" />
  </form>
  <div class="qqq">
  <img src="images/qq01.png" width="30" height="30" class="qq" />
  产品咨询群：250469589<br />
  活动咨询群：215179483
  <div class="ar"><a href="http://photo.21-sun.com/photo_domain/new_help02.jsp" target="_blank">使用说明</a></div>
  </div>
</div>
</body>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript" src="/scripts/validator.alert.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script>
function getProName(a){
	var name=$('#zd_factoryname').val();
	//name = name.substr(2, name.length);
	$('#zd_factoryname').val(name);
   var factoryid=$('#pro_id').val();
	jQuery.post("/tools/ajax_peo_name.jsp",{"flag":"getxinhao","fa_id":factoryid,"factoryname":a},function(data){jQuery("#zd_pro_name").html(data);});
		}
		
		function getProNameed(a){
		var name=$('#zd_pro_cataname').val();
	  // name = name.substr(2, name.length);
	    $('#zd_pro_cataname').val(name);
		 var factoryid=$('#pro_id').val();
		
		jQuery.post("/tools/ajax_peo_name.jsp",{"flag":"getpinpai","fa_id":a,"factoryname":factoryid},function(data){
		jQuery("#zd_factoryid").html(data);
		});
	}
	
	
	jQuery(function(){
		jQuery("#addImgs").JrUpload({
			remotUrl : "http://resource.21-sun.com/upload.jsp",
			folder : "product/photo" ,
			sizeLimit:10*1024*1024, //10M
			multi : true,
			beforeCallback : "beforeCallback",
			callback : "setImgs" ,
			style : "width:98px;height:30px;",
			buttonImg : "<%=Common.getDomain(request) %>/activity/koubei/images/1_22.jpg" ,
			buttonImgWidth : 77 ,
			buttonImgHeight : 30
		});
	});
	function beforeCallback(){
		$.jBox.tip("图片上传中，请稍后。。。", "loading");
	}
	function setImgs(data){
		var imgs = data.split(",");
		var htm = '';
		var f = 'http://resource.21-sun.com';
		for(var i=0;i<imgs.length;i++){
			htm += '<li><img class="img" src="'+f+imgs[i]+'" width="90" height="60" /><input type="hidden" name="img" value="'+f+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:2px;right:2px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
		}
		jQuery("#addImgs_show").append(htm);
		regEvent();
		$.jBox.closeTip();
	}
	function regEvent(){
		jQuery("#addImgs_show>li").mouseover(function(){
			jQuery(".img_delete").hide();
			jQuery(this).find(".img_delete").show();
		});
		jQuery("#addImgs_show>li").mouseout(function(){
			jQuery(".img_delete").hide();
		});
	}
	function removeThis(o){
		var attrId = jQuery(o).attr("attrId")+"";
		if(attrId=='0'){
			jQuery(o).parent().remove();
		}else{
			if(confirm("确定删除该张图片吗？")){
				jQuery(o).parent().remove();
			}
		}
	}
	
	function doComments(){
		var rs = Validator.Validate(document.getElementById("comment_form"),1);
		if(rs){
		   
		   var  zd_type = jQuery.trim(jQuery("#zd_type").val()) ;//判断分类
		   var  zd_factoryid = jQuery.trim(jQuery("#fa_id").val()) ;//判断品牌
		   var  zd_pro_catanum = jQuery.trim(jQuery("#zd_pro_cataname").val()) ;//判断类别
		   var  zd_pro_name = jQuery.trim(jQuery("#zd_pro_name").val()) ; //判断型号
		   if(zd_type=='选择分类'){alert('请您选择分类!') ;	return false ;}
		 
		  
			
			jQuery("#comment_form").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data){
					if($.trim(data)=="login"){
						login();
					}else{
						alert("图片上传成功！");
						window.location.reload();
					}
					
				}					  
			});
		}
	}
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>