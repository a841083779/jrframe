<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %><% 
	String url  = CommonString.getFormatPara(request.getHeader("referer")) ;
	String frombrand = "" ;  // 来自品牌的询价
	if(url.indexOf("/brand/")!=-1 || url.indexOf("tower.21-sun.com")!=-1|| url.indexOf("introduce.jsp")!=-1){
		frombrand = "yes" ;
	}
	String productid=CommonString.getFilterStr(request.getParameter("id"));
	if(productid.indexOf("<object")!=-1||productid.indexOf("data")!=-1||productid.indexOf("object")!=-1){productid="";}
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String source = CommonString.getFormatPara(request.getParameter("source")) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map one_product = new HashMap() ;
	Connection connection = null;
	String factoryname = "";
	String name = "";
	String catalogname = "";
	String inquiryProName = "";
	try{
		connection = dbHelper.getConnection();	
		// 先查询出子公司的产品
		if(!"".equals(productid) && !"undefined".equals(productid)){
		 	one_product = dbHelper.getMap(" select id,name,factoryid_sub factoryid, factoryname, catalognum,catalogname_spe catalogname from pro_products where id='"+productid+"'",connection) ;
		}
		if(null!=one_product&&!"".equals(productid) && !"undefined".equals(productid) && "".equals(CommonString.getFormatPara(one_product.get("factoryid")))){
			one_product = dbHelper.getMap(" select id,name,factoryid,factoryname,catalognum,catalogname from pro_products where id='"+productid+"'",connection) ;
		}
		if(null!=one_product&&(!"".equals(factoryid) && ("".equals(productid)||"undefined".equals(productid)))){
			one_product = dbHelper.getMap(" select top 1 id,name,factoryid,factoryname,catalognum,catalogname from pro_products where factoryid='"+factoryid+"'",connection) ;
		}
		if(one_product==null || one_product.size()==0){
			inquiryProName = "卡特挖掘机";
			//return;
		}else{
			factoryname = CommonString.getFormatPara(one_product.get("factoryname"));
			name = CommonString.getFormatPara(one_product.get("name"));
			catalogname = CommonString.getFormatPara(one_product.get("catalogname"));
			inquiryProName = factoryname+name+catalogname;
		}
		List<Map> areas = dbHelper.getMapList(" SELECT area_id,area_name FROM comm_area WHERE parent_area_id = 0 ",connection);
		//预计购买时间
		LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
		
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特挖掘机预约购机 –铁臂商城卡特彼勒(Cat)专区</title>
<meta name="Keywords" content="卡特挖掘机预约购机,卡特挖掘机价格" />
<meta name="Description" content="铁臂商城卡特彼勒专区提供卡特挖掘机预约购机，产品询价服务。" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/scripts/citys.js"></script> 
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
</head>
<body>

<!--top--begin-->
<jsp:include page="include/top.jsp" flush="true"></jsp:include>
<jsp:include page="include/nav.jsp" flush="true"></jsp:include>
<!--top--end-->

<div class="wrap_inside order clearfix">
  <!-- <div class="log">如果您已注册请点击登录 <a href="#"><img src="images/btn01.gif" alt="立即登录" style="vertical-align:middle;" /></a></div> -->
  <form action="/action/order_save_cat_model.jsp" method="post" name="theform" id="theform" onSubmit="return submitYN(this);">
  <div class="formCon">
    <div><span class="redWord">您好！您只要简单的填写信息，就可以免费对您中意的机型进行询价。</span><br />
      <i class="redWord">*</i>为必填项目</div>
    <h3>基本信息</h3>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="41%" align="right"><span class="shortTxt"><i class="redWord">*</i>您的姓名：</span></td>
        <td width="59%" align="left"><input type="text" name="zd_name" id="zd_name" maxlength="20" class="bd"/></td>
      </tr>
      <tr>
        <td align="right"><i class="redWord">*</i>手机号码：</td>
        <td align="left"><input type="text" name="zd_mobile_phone" id="zd_mobile_phone" maxlength="15" class="bd"/></td>
      </tr>
 
      <tr>
        <td align="right">采购性质：</td>
        <td align="left"><input name="zd_ifgroup" type="radio" id="radio" value="个人" checked="checked" class="radio" />
          个人
          <input type="radio" name="zd_ifgroup" id="radio2" value="公司" class="radio" />
公司<input type="text" value="公司名字" id="zd_company" name="zd_company" style="display:none;" maxlength="20"/></td>
      </tr>
    </table>
    <h3>产品需求</h3>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="41%" align="right"><i class="redWord"></i>预计购买时间：</td>
        <td width="59%" align="left">
        <select name="zd_buy_time" id="zd_buy_time" class="select">
     	 <option value="">请选择</option>
     	 <%= CommonForm.createSelect(buyTimeMap,"") %>
     	 </select>
        </td>
      </tr>
      <tr>
        <td align="right" valign="top"><i class="redWord">*</i>您感兴趣的挖掘机：</td>
        <td align="left">
        	<table border="0" cellspacing="0" cellpadding="0" class="order-model-table" width="100%">
      			<tr>
      				<td width="30%" style="padding:0;" valign="top">
      					<input type="checkbox" name="order_category" id="order_category_xiao" class="order-category"  checked  /><label for="order_category_xiao">小型挖机</label>
      					<ul id="ul_category_xiao" class="order_prod_list" style="display:block">
						
						<li><input type="checkbox" name="order_model" id="order_model_31921" class="checkbox" value="31921" <% if(productid.equals("31921")){ %> checked<%} %>/><label for="order_model_31921">CAT®310</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31920" class="checkbox" value="31920" <% if(productid.equals("31920")){ %> checked<%} %>/><label for="order_model_31920">CAT®308.5</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31919" class="checkbox" value="31919" <% if(productid.equals("31919")){ %> checked<%} %>/><label for="order_model_31919">CAT®307.5</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31807" class="checkbox" value="31807" <% if(productid.equals("31807")){ %> checked<%} %>/><label for="order_model_31807">CAT®302 CR</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31806" class="checkbox" value="31806" <% if(productid.equals("31806")){ %> checked<%} %>/><label for="order_model_31806">CAT®301.5</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31805" class="checkbox" value="31805" <% if(productid.equals("31805")){ %> checked<%} %>/><label for="order_model_31805">CAT®301.7 CR</label></li>
						
						
						
		      				<li><input type="checkbox" name="order_model" id="order_model_20163" class="checkbox" value="20163" <% if(productid.equals("20163")){ %> checked<%} %>/><label for="order_model_20163">307E</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_4561" class="checkbox" value="4561" <% if(productid.equals("4561")){ %> checked<%} %>/><label for="order_model_4561">305.5E</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20472" class="checkbox" value="20472" <% if(productid.equals("20472")){ %> checked<%} %>/><label for="order_model_20472">313D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_21514" class="checkbox" value="21514" <% if(productid.equals("21514")){ %> checked<%} %>/><label for="order_model_21514">308E</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20473" class="checkbox" value="20473" <% if(productid.equals("20473")){ %> checked<%} %>/><label for="order_model_20473">312D2 GC</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23912" class="checkbox" value="23912" <% if(productid.equals("23912")){ %> checked<%} %>/><label for="order_model_23912">306E2</label></li>
							<li><input type="checkbox" name="order_model" id="order_model_21607" class="checkbox" value="21607" <% if(productid.equals("21607")){ %> checked<%} %>/><label for="order_model_21607">	M315D2</label></li>
		      			</ul>
      				</td>
      				<td width="40%" style="padding:0;" valign="top">
      					<input type="checkbox" name="order_category" id="order_category_zhong" class="order-category"   checked /><label for="order_category_zhong">中型挖机</label>
      					<ul id="ul_category_zhong" class="order_prod_list"  style="display:block">
						<li><input type="checkbox" name="order_model" id="order_model_30221" class="checkbox" value="30221" <% if(productid.equals("30221")){ %> checked<%} %>/><label for="order_model_30221">CAT® 320 GC</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_30220" class="checkbox" value="30220" <% if(productid.equals("30220")){ %> checked<%} %>/><label for="order_model_30220">CAT® 320</label></li>
						
						<li><input type="checkbox" name="order_model" id="order_model_30220" class="checkbox" value="31918" <% if(productid.equals("31918")){ %> checked<%} %>/><label for="order_model_31918">CAT® 330 GC</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31913" class="checkbox" value="31913" <% if(productid.equals("31913")){ %> checked<%} %>/><label for="order_model_31913">CAT® 330</label></li>
						
		      				<li><input type="checkbox" name="order_model" id="order_model_445" class="checkbox" value="445" <% if(productid.equals("445")){ %> checked<%} %>/><label for="order_model_445">324D</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_3503" class="checkbox" value="3503" <% if(productid.equals("3503")){ %> checked<%} %>/><label for="order_model_3503">329D/329DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20440" class="checkbox" value="20440" <% if(productid.equals("20440")){ %> checked<%} %>/><label for="order_model_20440">320D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_11366" class="checkbox" value="11366" <% if(productid.equals("11366")){ %> checked<%} %>/><label for="order_model_11366">326DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_8351" class="checkbox" value="8351" <% if(productid.equals("8351")){ %> checked<%} %>/><label for="order_model_8351">M322D</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_8337" class="checkbox" value="8337" <% if(productid.equals("8337")){ %> checked<%} %>/><label for="order_model_8337">M316D</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_21958" class="checkbox" value="21958" <% if(productid.equals("21958")){ %> checked<%} %>/><label for="order_model_21958">323D2L</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23369" class="checkbox" value="23369" <% if(productid.equals("23369")){ %> checked<%} %>/><label for="order_model_23369">318D2L</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_21959" class="checkbox" value="21959" <% if(productid.equals("21959")){ %> checked<%} %>/><label for="order_model_21959">326D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_19947" class="checkbox" value="19947" <% if(productid.equals("19947")){ %> checked<%} %>/><label for="order_model_19947">M318D</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_22613" class="checkbox" value="22613" <% if(productid.equals("22613")){ %> checked<%} %>/><label for="order_model_22613">M317D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_21960" class="checkbox" value="21960" <% if(productid.equals("21960")){ %> checked<%} %>/><label for="order_model_21960">329D2</label></li>
							<li><input type="checkbox" name="order_model" id="order_model_23922" class="checkbox" value="23922" <% if(productid.equals("23922")){ %> checked<%} %>/><label for="order_model_23922">M320D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23364" class="checkbox" value="23364" <% if(productid.equals("23364")){ %> checked<%} %>/><label for="order_model_23364">320D2 GC</label></li>
						</ul>
      				</td>
      				<td width="30%" style="padding:0;" valign="top">
      					<input type="checkbox" name="order_category" id="order_category_da" class="order-category"checked /><label for="order_category_da">大型挖机</label>
      					<ul id="ul_category_da" class="order_prod_list"  style="display:block" >
						
						<li><input type="checkbox" name="order_model" id="order_model_31914" class="checkbox" value="31914" <% if(productid.equals("31914")){ %> checked<%} %>/><label for="order_model_31914">CAT® 345 GC</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31829" class="checkbox" value="31829" <% if(productid.equals("31829")){ %> checked<%} %>/><label for="order_model_31829">CAT® 336 GC</label></li>
						<li><input type="checkbox" name="order_model" id="order_model_31828" class="checkbox" value="31828" <% if(productid.equals("31828")){ %> checked<%} %>/><label for="order_model_31828">CAT® 336</label></li>
						
						
		      				<li><input type="checkbox" name="order_model" id="order_model_3525" class="checkbox" value="3525" <% if(productid.equals("3525")){ %> checked<%} %>/><label for="order_model_3525">336D/336DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_9552" class="checkbox" value="9552" <% if(productid.equals("9552")){ %> checked<%} %>/><label for="order_model_9552">349D/349DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20735" class="checkbox" value="20735" <% if(productid.equals("20735")){ %> checked<%} %>/><label for="order_model_20735">336D2/D2L</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23921" class="checkbox" value="23921" <% if(productid.equals("23921")){ %> checked<%} %>/><label for="order_model_23921">336D2 GC</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_21524" class="checkbox" value="21524" <% if(productid.equals("21524")){ %> checked<%} %>/><label for="order_model_21524">349D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23905" class="checkbox" value="23905" <% if(productid.equals("23905")){ %> checked<%} %>/><label for="order_model_23905">336D2 XE</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23371" class="checkbox" value="23371" <% if(productid.equals("23371")){ %> checked<%} %>/><label for="order_model_23371">340D2 L</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23906" class="checkbox" value="23906" <% if(productid.equals("23906")){ %> checked<%} %>/><label for="order_model_23906">390F L</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_25477" class="checkbox" value="25477" <% if(productid.equals("25477")){ %> checked<%} %>/><label for="order_model_25477">390D/390DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_23907" class="checkbox" value="23907" <% if(productid.equals("23907")){ %> checked<%} %>/><label for="order_model_23907">374F L</label></li>
							<li><input type="checkbox" name="order_model" id="order_model_25480" class="checkbox" value="25480" <% if(productid.equals("25480")){ %> checked<%} %>/><label for="order_model_25480">374DL</label></li>
						</ul>
      				</td>
      			</tr>
      		</table>
        </td>
      </tr>

      <tr>
        <td align="right" valign="top">&nbsp;</td>
        <td align="left">
            <input type="submit" name="button" id="button" value="&nbsp;" class="btn" />
          	<input name="zd_factoryid" type="hidden" id="zd_factoryid" value="174" />
          	<input name="zd_product_id" type="hidden" id="zd_product_id" value="<%=CommonString.getFormatPara(one_product.get("id"))%>"/>
          	<input name="zd_factoryname" type="hidden" id="zd_factoryname" value="卡特彼勒"/>
          	<input name="zd_product_name" type="hidden" id="zd_product_name" value="<%=CommonString.getFormatPara(one_product.get("name"))%>"/>
			<input type="hidden" name="zd_contact_address" id="zd_contact_address"/>
         	<input type="hidden" name="zd_cataname" id="zd_cataname" value="<%=CommonString.getFormatPara(one_product.get("catalogname")) %>" />
         	<input type="hidden" name="zd_catanum" id="zd_catanum" value="<%=CommonString.getFormatPara(one_product.get("catalognum"))%>"/>
         	<input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
         	<input type="hidden" name="zd_referer" id="zd_referer" value="<%=url %>" />
	 		<input type="hidden" name="source" id="source" value="catshop" />
         	<input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/><!-- 属于公司或个人 -->
         	<input type="hidden" name="zd_is_first" id="zd_is_first" value="1"/>
         	<input type="hidden" name="zd_product_ids" id="zd_product_ids" />
         	<input type="hidden" name="zd_message" id="zd_message" value="您好，我对卡特彼勒的产品感兴趣，想要咨询，请您给我回复，谢谢。"/>
        </td>
      </tr>
    </table>
    <p></p>
  </div>
  </form>
  	<!--foot--begin-->
	<jsp:include page="include/foot.jsp" flush="true"></jsp:include>
	<!--foot--end-->
  
</div>
<script type="text/javascript" src="scripts/comm.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
<script type="text/javascript">
$(function(){
	$("table.order-model-table").find("input.order-category").click(function(){
		if($(this)[0].checked){
			$(this).siblings("ul").show();
		}else{
			$(this).siblings("ul").hide();
			var catChk = $(this);
			catChk.siblings("ul").find("input.checkbox").each(function(){
				$(this)[0].checked = false;
			});
		}
	});
});

function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery.trim(jQuery("#zd_name").val()) || jQuery.trim(jQuery("#zd_name").val()).length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").val("");
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery.trim(jQuery("#zd_mobile_phone").val()) || jQuery.trim(jQuery("#zd_mobile_phone").val()).length == 0)) {
		jQuery.jBox.tip("请输入正确的手机号码！");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").val("");
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	if (jQuery.trim(jQuery("#zd_mobile_phone").val()).length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").val("");
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		return false;
	}
	if(jQuery.trim(jQuery("#zd_ifgroup").val())=='公司'){
		if(jQuery.trim(jQuery("#zd_company").val())=='公司名字' || jQuery.trim(jQuery("#zd_company").val())==''){
			jQuery.jBox.tip("请输入公司名字") ;
			jQuery("#zd_company").val("");
			jQuery("#zd_company").focus() ;
		     return false ;
		}
	} 
		if(jQuery.trim(jQuery("#zd_city").val())==''){
 
	}
	if($.trim($("#zd_buy_time").val()) == ""){
 		//$.jBox.tip("请选择预计购买时间！");
 		//$("#zd_buy_time").focus();
 		//return false;
 	}
	var catChecked = false;
	var chkCat = document.getElementsByName("order_model");
	
	for(var i=0; i<chkCat.length; i++){
		if(chkCat[i].checked){
			catChecked = true;
			break;
		}
	}
	if(!catChecked){
		$.jBox.tip("请选择您感兴趣的挖掘机！");
		return false;
	}
	var pro_ids = "";
	/**var cat_chk_ary = document.getElementsByName("order_category");
	alert(cat_chk_ary);
	for(var i=0; i<cat_chk_ary.length; i++){
		if(cat_chk_ary[i].checked){
			var modelIdStr = "";
			$(cat_chk_ary[i]).siblings("ul").find("input.checkbox").each(function(){
				var modelChk = $(this)[0];
				if(modelChk.checked){
					modelIdStr += modelChk.value + ",";
				}
			});
			if(modelIdStr == ""){
				pro_ids += cat_chk_ary[i].value + ",";
			}else{
				pro_ids += modelIdStr;
			}
		}
	}**/
	for(var i=0; i<chkCat.length; i++){
		if(chkCat[i].checked){
			//alert(chkCat[i].value);
			pro_ids+=chkCat[i].value+",";
		}
	}

	if(pro_ids != ""){
		pro_ids = pro_ids.substring(0, pro_ids.length - 1);
		$("#zd_product_ids").val(pro_ids);
	}
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	jQuery("#theform").ajaxSubmit({
	 	type:'post',
	    url:'/action/order_save_cat_model.jsp' ,
	    success:function(msg){
	        if(jQuery.trim(msg)=='phone'){
		    	jQuery.jBox.success("因该号码多次恶意询价已被加入黑名单，如有误，请联系客服4006-521-526!", "出错");
		    	jQuery("#zd_mobile_phone").focus() ;
		    	return ;
		    }else if(jQuery.trim(msg)=='name'){
		    	jQuery.jBox.success("姓名请填写中英文不要填写纯数字，如有误，请联系客服4006-521-526!", "出错");
		    	jQuery("#zd_name").focus() ;
		    	return ;
		    }else if(jQuery.trim(msg)!=0){
		    	jQuery.jBox.success("询价单提交成功!", "提示");
		    	SetCookie("order_name",jQuery("#zd_name").val()) ;
			    SetCookie("order_phone",jQuery("#zd_mobile_phone").val()) ;
		    	jQuery("#rand").val("");
		    	jQuery("input[name='order_category']").each(function(){
		    		jQuery(this).attr("checked",false);
		    	});
		    	jQuery("input[name='order_model']").each(function(){
		    		jQuery(this).attr("checked",false);
		    	});
		    }
	    }
	 }) ;
	return false ;
}
 
function refresh(){
		document.getElementById("authImg").src='/webadmin/authImgServlet?now=' + new Date();
}
jQuery(function(){
	jQuery("#zd_buy_time option:eq(0)").attr("selected","selected") ;
})

// 把下过订单的信息取出
jQuery(function(){
	var order_name = jQuery.trim(unescape(GetCookie("order_name"))) ;  // 订单人
    var order_phone = jQuery.trim(GetCookie("order_phone")) ;  // 订单电话
    if(''!=order_name && null!=order_name && "null"!=order_name){
    	jQuery("#zd_name").val(order_name) ;
    }
    if(''!=order_phone && null!=order_phone && "null"!=order_phone){
    	jQuery("#zd_mobile_phone").val(order_phone) ;
    }
})
jQuery("input:radio").bind("click",function(){
	jQuery("#zd_ifgroup").val(jQuery(this).val()) ;  // 个人或公司
	if(jQuery(this).val()=='公司'){
		jQuery("#zd_company").attr("style","width:150px;") ;
	}else{
		jQuery("#zd_company").attr("style","display:none;") ;
	}
}) ;
jQuery("#zd_company").focus(function(){
	if(jQuery(this).val()=='公司名字'){
	   jQuery(this).val("") ;
	}
})
	jQuery(function(){
		jQuery("#zd_province option").each(function(){
			jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
		}) ;
	}) ;
	
	function set_my_city(o,cked){
		var area_id = o.options[o.selectedIndex].getAttribute("area_id");
		jQuery.ajax({
			url : '/tools/ajax.jsp',
			async : false,
			type : 'post',
			data : {
				flag : 'get_city',
				p : area_id
			},
			success : function(data){
				var arr = eval(data);
				var zd_city = document.getElementById("zd_city");
				zd_city.length = 1;
				var opt;
				var aname;
				var hname;
				for(var i=0;i<arr.length;i++){
					aname = arr[i].area_name;
					hname = aname;
					aname = codefans_net_CC2PY(aname).substring(0,1)+"-"+aname;
					opt = new Option(aname,hname);
					if(aname.indexOf(cked)!=-1){
						opt.selected = true;
					}
					zd_city.options.add(opt);
				}
			}
		});
	}
</script>
<script>
    var ref = ''; 
    if (document.referrer.length > 0) { 
        ref = document.referrer; 
    } 
    try { 
       if (ref.length == 0 && opener.location.href.length > 0) { 
       ref = opener.location.href; 
        } 
    }catch (e) {}
   	jQuery.ajax({
    	type:'post',
    	url:'ajax.jsp',
    	data:{flag:'visitHistory',ref:ref} ,
    	success:function(msg){
    	}
    });
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>