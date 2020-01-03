<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %><% 
	String url  = CommonString.getFormatPara(request.getHeader("referer")) ;
	String frombrand = "" ;  // 来自品牌的询价
	if(url.indexOf("/brand/")!=-1 || url.indexOf("tower.21-sun.com")!=-1|| url.indexOf("introduce.jsp")!=-1){
		frombrand = "yes" ;
	}
	String agentid=CommonString.getFormatPara(request.getParameter("agentid"));
	String agentName=CommonString.getFormatPara(request.getParameter("agentName"));
	String productid=CommonString.getFormatPara(request.getParameter("productid"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map one_product = new HashMap() ;
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>卡特彼勒</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/scripts/citys.js"></script> 
</head>
<body class="cat">
<div class="top">
  <div class="wrapper clearfix">
    <h1 class="logo l"><img src="images/logo_cat.gif" alt="卡特彼勒" width="201" height="59" /></h1>
    <span class="tel r">客服中心：(0535) 6792745</span>
  </div>
</div>
<div class="form-con">
  <div class="formbg png">
    <h2 class="formTitle">填写以下信息<br />报价将以短信的形式发送到您的手机上</h2>
    <form action="/action/order_save_tuiguang_model.jsp" method="post" name="theform" id="theform" onSubmit="return submitYN(this);">
    <table width="650" border="0" cellspacing="0" cellpadding="0" class="formTable">
      <tr>
        <th width="120">姓名</th>
        <td width="395"><input type="text" name="zd_name" id="zd_name" class="input" /></td>
      </tr>
      <tr>
        <th>电话</th>
        <td><input type="text" name="zd_mobile_phone" id="zd_mobile_phone" class="input" /></td>
      </tr>
      <tr>
      	<th valign="top">车型</th>
      	<td valign="top">
      		<table border="0" cellspacing="0" cellpadding="0" class="order-model-table" width="100%">
      			<tr>
      				<td width="33%" style="padding:0;" valign="top">
      					<input type="checkbox" name="order_category" id="order_category_xiao" class="order-category" value="20472" /><label for="order_category_xiao">小型挖机(20吨以下)</label>
      					<ul id="ul_category_xiao" class="order_prod_list">
      						<li><input type="checkbox" name="order_model" id="order_model_4561" class="checkbox" value="4561" /><label for="order_model_4561">305.5E</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20164" class="checkbox" value="20164" /><label for="order_model_20164">306E</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20163" class="checkbox" value="20163" /><label for="order_model_20163">307E</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20473" class="checkbox" value="20473" /><label for="order_model_20473">312D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_20472" class="checkbox" value="20472" /><label for="order_model_20472">313D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_9548" class="checkbox" value="9548" /><label for="order_model_9548">318D/318DL</label></li>
		      			</ul>
      				</td>
      				<td width="33%" style="padding:0;" valign="top">
      					<input type="checkbox" name="order_category" id="order_category_zhong" class="order-category" value="20440" /><label for="order_category_zhong">中型挖机(20吨-30吨)</label>
      					<ul id="ul_category_zhong" class="order_prod_list">
		      				<li><input type="checkbox" name="order_model" id="order_model_20440" class="checkbox" value="20440" /><label for="order_model_20440">320D2</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_400" class="checkbox" value="400" /><label for="order_model_400">320DGC/320D/320DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_9550" class="checkbox" value="9550" /><label for="order_model_9550">323D/323DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_445" class="checkbox" value="445" /><label for="order_model_445">324D</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_11366" class="checkbox" value="11366" /><label for="order_model_11366">326DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_3503" class="checkbox" value="3503" /><label for="order_model_3503">329D/329DL</label></li>
		      			</ul>
      				</td>
      				<td width="33%" style="padding:0;" valign="top">
      					<input type="checkbox" name="order_category" id="order_category_da" class="order-category" value="3525" /><label for="order_category_da">大型挖机(30吨以上)</label>
      					<ul id="ul_category_da" class="order_prod_list">
		      				<li><input type="checkbox" name="order_model" id="order_model_3525" class="checkbox" value="3525" /><label for="order_model_3525">336D/336DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_9551" class="checkbox" value="9551" /><label for="order_model_9551">340DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_9552" class="checkbox" value="9552" /><label for="order_model_9552">349D/349DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_9554" class="checkbox" value="9554" /><label for="order_model_9554">374DL</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_19946" class="checkbox" value="19946" /><label for="order_model_19946">385CFS</label></li>
		      				<li><input type="checkbox" name="order_model" id="order_model_9555" class="checkbox" value="9555" /><label for="order_model_9555">390D/390DL</label></li>
		      			</ul>
      				</td>
      			</tr>
      		</table>
      	</td>
      </tr>
      <tr>
        <td colspan="2" align="center"><input type="submit"  align="middle"  name="button" id="button" value="&nbsp;" class="btn png" onclick="sumit();"/>
		<br />
		<input name="zd_factoryid" type="hidden" id="zd_factoryid" value="174" />
        <input name = "zd_factoryname" type="hidden" id="zd_factoryname" value="卡特彼勒"/>
		<input name="zd_province" type="hidden" id="zd_province" value="" />
        <input name = "zd_city" type="hidden" id="zd_city" value=""/>
		<input name = "zd_contact_address" type="hidden" id="zd_contact_address" value=""/>
		<input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
        <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
        <input type="hidden" name="zd_is_first" id="zd_is_first" value="1"/>
		<input type="hidden" name="zd_product_ids" id="zd_product_ids" />
		<input type="hidden" name="zd_product_name" id="zd_product_name" value="306E"/>
		<input type="hidden" name="zd_catanum" id="zd_catanum" value="101001001"/>
		<input type="hidden" name="zd_cataname" id="zd_cataname" value="小型液压挖掘机"/>
		<input type="hidden" name="zd_message" id="zd_message" value="您好，我对贵公司的产品感兴趣，想要咨询，请您给我回复，谢谢。"/>
		</td>
        </tr>
    </table>
    </form>
	
  </div>
</div>
<div class="zs"><img src="images/zs.gif" width="948" height="48" /></div>
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

jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	//alert(province);
	//alert(city);
	jQuery("#zd_province").val(province);
	jQuery("#zd_city").val(city);
	jQuery("#zd_contact_address").val(province+city) ;
}) ;
jQuery("#zd_message").text("您好，我对<%=CommonString.getFormatPara(one_product.get("factoryname"))%><%=frombrand.equals("yes")?"产品":CommonString.getFormatPara(one_product.get("name"))+CommonString.getFormatPara(one_product.get("catalogname")) %>感兴趣，想要咨询，请您给我回复，谢谢。");
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		jQuery.jBox.tip("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		return false;
	}
	
	var catChecked = false;
	var chkCat = document.getElementsByName("order_category");
	for(var i=0; i<chkCat.length; i++){
		if(chkCat[i].checked){
			catChecked = true;
			break;
		}
	}
	if(!catChecked){
		$.jBox.tip("请选择要询价的机型！");
		return false;
	}
	
	var pro_ids = "";
	var cat_chk_ary = document.getElementsByName("order_category");
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
	}
	if(pro_ids != ""){
		pro_ids = pro_ids.substring(0, pro_ids.length - 1);
		$("#zd_product_ids").val(pro_ids);
	}
	
   return true ;
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
<div style="display:none">
<script type="text/javascript">
var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_2697829'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s17.cnzz.com/stat.php%3Fid%3D2697829%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
</script>
</div> 
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>