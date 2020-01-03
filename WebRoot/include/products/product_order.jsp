<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %>
<% 
	String url  = CommonString.getFormatPara(request.getHeader("referer")) ;
	String frombrand = "" ;  // 来自品牌的询价
	if(url.indexOf("/brand/")!=-1 || url.indexOf("tower.21-sun.com")!=-1|| url.indexOf("introduce.jsp")!=-1){
		frombrand = "yes" ;
	}
	//获取询价的session信息
	int inquriyCount=0;
	if( session.getAttribute(Common.getIp(request,1))!=null){
	inquriyCount=(Integer) session.getAttribute(Common.getIp(request,1)) ;
	}
	String agentid=CommonString.getFormatPara(request.getParameter("agentid"));
	String agentName=CommonString.getFormatPara(request.getParameter("agentName"));
	String productid=CommonString.getFormatPara(request.getParameter("productid"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String source = CommonString.getFormatPara(request.getParameter("source")) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map one_product = new HashMap() ;
	Connection connection = null;
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
			%>
<script type="text/javascript">
			   window.parent.jBox.tip("该产品已不存在") ;
			    window.parent.jBox.close(); 
			    setTimeout(function(){
			    	window.parent.location.href="<%=url%>" ;
			    },1000) ;
			 </script>
<%
			return;
		}
		List<Map> areas = dbHelper.getMapList(" SELECT area_id,area_name FROM comm_area WHERE parent_area_id = 0 ",connection);
		// 预计购买时间
		LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线询价</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body { padding: 5px 10px; font-family: 'Microsoft Yahei' }
.top_t { color: #4e5762; font-size: 25px; border-bottom: 1px solid #dfdfdf; padding-bottom: 7px; }
.top_t1 { font-size: 16px; height: 20px; line-height: 20px; padding: 10px 0px 10px 0px; font-weight: bold; }
.list_border_bg th { height: 22px; padding: 11px 30px 11px 0px; color: #767b7f; font-size: 16px; text-align:right; white-space:nowrap; }
.list_border_bg td{ white-space:nowrap;}
.list_border_bg td b.x{ padding:0 10px; color:#ff6600; font-size:16px;}
.list_border_bg input[type=text],.sele,textarea{ width: 300px; height: 23px; line-height: 23px; border: 1px solid #e3e9ef; border-top: 1px solid #abadb3; padding: 3px; border-radius: 3px; }
.list_border_bg textarea{ width:485px; height:70px; padding:5px; font-size:16px;font-family: 'Microsoft Yahei'; color:#b2b2b2}
.orderbg .img{position:absolute; right:80px; bottom:30px; width:210px; height:45px;}
/*下拉(组件)*/
.sele{position:relative;width:172px;cursor:pointer; color:#767b7f; font-size:16px;}
.sele span { font-weight:bold}
.sele .r{ float:right; margin:9px 0 0; display:inline-block; width:16px; height:8px; background:url(images/sele_b.png) no-repeat;}
.sele_{display:none;position:absolute;width:100%;left:-1px;top:30px;background:#fff;border:1px solid #e4e4e4; border-bottom:0;max-height:150px; overflow-y:auto}
.sele_ a{display:block; height:40px; line-height:40px; padding-left:10px; border-bottom:1px solid #e4e4e4}
.sele_ a:hover{background:#ff6600;color:#fff;}

.xj_btn{ width:267px; height:61px; background:url(images/xj_btn.png) no-repeat; border:0; cursor:pointer}
.STYLE1 { color: #FF0000 }
-->
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css">
</link>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script>
function selectCity(obj){
     //console.log(obj);
     //console.log($(obj).text());
	jQuery("#zd_city").val($(obj).text()) ;
	    document.getElementById("thecity").innerHTML=$(obj).text();
}
</script>
</head>
<body>
<h3 class="top_t">在线询价</h3>
<div class="top_t1"> 想了解 <%=CommonString.getFormatPara(one_product.get("factoryname"))%><%=frombrand.equals("yes")?"产品":CommonString.getFormatPara(one_product.get("name"))+CommonString.getFormatPara(one_product.get("catalogname")) %>最低价？请填写如下信息：<!--<font style="color:grey">（成功询价后，我们会24小时之内与您联系！）</font>--></div>
<div class="orderbg"> <img src="/images/xj_tel.png" alt="客服热线" class="img" /> 
  <script type="text/javascript">
  jQuery(function(){
	  jQuery(".list_border_bg .xj_btn").hover(function(){
		  jQuery(this).toggleClass("hover");
	  },function(){
		  jQuery(this).removeClass("hover");
	  });
  })
  </script>
  <form action="/action/order_save_new.jsp" method="post" name="theform" id="theform" onSubmit="return submitYN(this);">
    <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0" class="list_border_bg">
      <tr>
        <th>您的姓名</th>
        <td><input style="width:172px;" class="input01" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
          <b class="x">*</b></td>
      </tr>
      <tr>
        <th>手机</th>
        <td><input  style="width:172px;" class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
          <b class="x">*</b><span style="color:#7f868c; line-height:30px; font-size:14px;">请填写正确手机号，获取最低价短信</span></td>
      </tr>
      <tr>
        <th>地区</th>
        <td><div class="l sele">
            <b class="r"></b><span id="theprovince">-请选择-</span>
            <div class="sele_" style="display: none;"> <a area_id="100110" onClick="set_my_city(100110,'山东');">山东</a> <a area_id="101800" onClick="set_my_city(101800,'安徽');">安徽</a> <a area_id="103100" onClick="set_my_city(103100,'江西');">江西</a> <a area_id="104200" onClick="set_my_city(104200,'浙江');">浙江</a> <a area_id="105290" onClick="set_my_city(105290,'上海');">上海</a> <a area_id="105499" onClick="set_my_city(105499,'北京');">北京</a> <a area_id="105689" onClick="set_my_city(105689,'天津');">天津</a> <a area_id="105879" onClick="set_my_city(105879,'重庆');">重庆</a> <a area_id="106400" onClick="set_my_city(106400,'河北');">河北</a> <a area_id="108300" onClick="set_my_city(108300,'山西');">山西</a> <a area_id="109700" onClick="set_my_city(109700,'内蒙古');">内蒙古</a> <a area_id="110900" onClick="set_my_city(110900,'江苏');">江苏</a> <a area_id="113000" onClick="set_my_city(113000,'广西');">广西</a> <a area_id="115000" onClick="set_my_city(115000,'西藏');">西藏</a> <a area_id="116000" onClick="set_my_city(116000,'宁夏');">宁夏</a> <a area_id="117000" onClick="set_my_city(117000,'新疆');">新疆</a> <a area_id="119000" onClick="set_my_city(119000,'吉林');">吉林</a> <a area_id="120000" onClick="set_my_city(120000,'辽宁');">辽宁</a> <a area_id="122000" onClick="set_my_city(122000,'黑龙江');">黑龙江</a> <a area_id="124000" onClick="set_my_city(124000,'湖北');">湖北</a> <a area_id="126000" onClick="set_my_city(126000,'湖南');">湖南</a> <a area_id="128000" onClick="set_my_city(128000,'广东');">广东</a> <a area_id="130000" onClick="set_my_city(130000,'河南');">河南</a> <a area_id="132000" onClick="set_my_city(132000,'贵州');">贵州</a> <a area_id="133000" onClick="set_my_city(133000,'青海');">青海</a> <a area_id="134000" onClick="set_my_city(134000,'甘肃');">甘肃</a> <a area_id="135500" onClick="set_my_city(135500,'陕西');">陕西</a> <a area_id="137000" onClick="set_my_city(137000,'云南');">云南</a> <a area_id="139000" onClick="set_my_city(139000,'四川');">四川</a> <a area_id="141500" onClick="set_my_city(141500,'海南');">海南</a> <a area_id="142000" onClick="set_my_city(142000,'福建');">福建</a> </div>
         </div>
         <div class="l sele" style="margin-left:10px;">
            <b class="r"></b><span id="thecity">-请选择-</span>
            <div class="sele_" style="display: none;" id="citys">
            </div>
         </div><b class="x">*</b>
         </td>
      </tr>
      <!--  <tr>
      <th height="22" align="right" nowrap="nowrap" class="list_left_title">地区</th>
     <td><select name="zd_province" id="zd_province" onChange="set_my_city(this);" style="width:87px;"  dataType="Require"  msg="请选择省份">
        </select>
        <select  name="zd_city" id="zd_city"  style="width:100px;" dataType="Require"  msg="请选择城市">
          <option value="">选择城市</option>
        </select>*</td>
        </tr>-->
      <tr>
        <th>采购性质</th>
        <td><input class="input01" name="zd_ifgroup" type="radio" checked value="个人" />
         <span  style="font-size:16px; color:#626e79; font-weight:bold">个人</span>
          <input class="input01" name="zd_ifgroup" type="radio"  value="公司" />
          <span style="font-size:16px; color:#626e79;font-weight:bold">公司</span>
          <input type="text" value="公司名字" id="zd_company" name="zd_company" style="display:none;" maxlength="20"/>
          <b class="x">*</b></td>
      </tr>
      <tr>
        <th>预计购买时间</th>
        <td>
          <div class="l sele">
            <b class="r"></b><span>请选择</span>
            <div class="sele_" style="display: none;">
     	<a value="102007" onClick="buyTime('102007');">1个周内</a>
		<a value="102001" onClick="buyTime('102001');">1个月内</a>
		<a value="102002" onClick="buyTime('102002');">1—3个月</a>
		<a value="102003" onClick="buyTime('102003');">4—6个月</a>
		<a value="102004" onClick="buyTime('102004');">7—12个月</a>
		<a value="102005" onClick="buyTime('102005');">1年后</a>
		<a value="102006" onClick="buyTime('102006');">不确定</a>			
            </div>
         </div>
		 <script>

		 </script>
          <b class="x">*</b> 
          <!--<select name="zd_buy_time" id="zd_buy_time" >
            <option value="">请选择</option>
          </select>-->
          <!--<span style="color:#000;margin-left:5px;*vertical-align:3px;">（如果有合适的二手设备，您会考虑吗？）&nbsp;&nbsp;是<input type="radio" style="vertical-align:-3px;" name="heshi" value="1" checked="checked" />&nbsp;&nbsp;否<input style="vertical-align:-3px;" type="radio" name="heshi" value="0" /></span>--></td>
      </tr>
      <tr>
        <th>付款方式</th>
        <td>
         <div class="l sele">
            <b class="r"></b><span>请选择</span>
            <div class="sele_" style="display: none;">
               <a href="全款付车" onClick="buyType('全款付车');">全款付车</a>
               <a href="银行按揭" onClick="buyType('银行按揭');">银行按揭</a>
			   <a href="融资租赁" onClick="buyType('融资租赁');">融资租赁</a>
			   <a href="其他" onClick="buyType('其他');">其他</a>
            </div>
         </div><b class="x">*</b> 
      <!--  <select name="zd_buy_type" id="zd_buy_type"   dataType="Require"  msg="请选择付款方式">
            <option value="">请选择</option>
            <option value="全款付车">全款付车</option>
            <option value="银行按揭">银行按揭</option>
            <option value="融资租赁">融资租赁</option>
            <option value="其他">其他</option>
          </select>-->
          </td>
      </tr>
      <tr>
        <th>留言内容</th>
        <td colspan="3" class="list_cell_bg" style="padding:0 0 10px 0;"><textarea class="input03" name="zd_message" cols="77" rows="5"  id="zd_message" ></textarea></td>
      </tr>
      <tr>
        <%if(inquriyCount>=6){%>
        <th>验证码</th>
        <td height="30" colspan="2"><input name="rand" type="text" id="rand" size="15"  style="width:100px; height:18px; line-height:18px;" tabindex="3" maxlength="4"/>
          <img src="/webadmin/authImgServlet" align="absmiddle" id="authImg" onClick="refresh();" title="如果您看不清，请在图片上单击，可以更换验证码！"/> <span onClick="refresh();" style=" color:#999999;cursor:pointer">(点击验证码刷新)</span></td>
        <%}%>
        <td height="22"  style="padding-top:0px; padding-left:0px; font-size:0; line-height:0; height:auto;"><span class="list_cell_bg" style="margin-left:15px"> 
          <!--   <input name="zd_id" type="hidden" id="zd_id" value="0" />  -->
          <%
					String mytag = CommonString.getFormatPara(request.getParameter("mytag"));
					if("".equals(mytag)){
						mytag = "3";
					}
				%>
          <input name="tag" type="hidden" id="tag" value="<%=mytag %>" />
          <input name="zd_agentid" type="hidden" id="zd_agentid" value="<%=frombrand.equals("yes")?"":agentid%>" />
          <input name="zd_factoryid" type="hidden" id="zd_factoryid" value="<%=CommonString.getFormatPara(one_product.get("factoryid"))%>" />
          <input name = "zd_product_id" type="hidden" id="zd_product_id" value="<%=frombrand.equals("yes")?"":CommonString.getFormatPara(one_product.get("id"))%>"/>
          <input name = "zd_factoryname" type="hidden" id="zd_factoryname" value="<%=CommonString.getFormatPara(one_product.get("factoryname"))%>"/>
          <input name = "zd_product_name" type="hidden" id="zd_product_name" value="<%=frombrand.equals("yes")?"":CommonString.getFormatPara(one_product.get("name"))%>"/>
          <input type="hidden" name="zd_contact_address" id="zd_contact_address"/>
          <input type="hidden" name="zd_cataname" id="zd_cataname" value="<%=frombrand.equals("yes")?"":CommonString.getFormatPara(one_product.get("catalogname")) %>" />
          <input type="hidden" name="zd_catanum" id="zd_catanum" value="<%=frombrand.equals("yes")?"":CommonString.getFormatPara(one_product.get("catalognum"))%>"/>
          <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
          <input type="hidden" name="zd_referer" id="zd_referer" value="<%=url %>" />
          <input type="hidden" name="source" id="source" value="<%=source %>" />
          <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
		  <input name="zd_province" type="hidden" id="zd_province"  />
		  <input name="zd_city" type="hidden" id="zd_city"  />
		  <input name="zd_buy_type" type="hidden" id="zd_buy_type"  />
		  <input name="zd_buy_time" type="hidden" id="zd_buy_time"  />
          <!-- 属于公司或个人 -->
          <input type="hidden" name="zd_is_first" id="zd_is_first" value="1"/>
          </span></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <td height="30" colspan="2"><input class="xj_btn" name="Submit" type="submit" value=""/></td>
        <td height="22"  style="padding-top:5px; padding-left:10px;"></td>
      </tr>
    </table>
  </form>
</div>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script> 
<script type="text/javascript" src="/scripts/pinyin.js"></script> 
<script type="text/javascript">
jQuery("#zd_message").text("您好，我对<%=CommonString.getFormatPara(one_product.get("factoryname"))%><%=frombrand.equals("yes")?"产品":CommonString.getFormatPara(one_product.get("name"))+CommonString.getFormatPara(one_product.get("catalogname")) %>感兴趣，想要咨询，请您给我回复，谢谢。");
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	
	var  content = jQuery.trim(jQuery("#zd_message").val()) ;
		   if(content!=content.replace(/<\/?[^>]*>/g,'').replace('&lt','').replace('&gt','') || (content.indexOf("www")!=-1 || content.indexOf("http")!=-1)){
		       //alert('您的留言内容不符合规则，请重新输入!') ;	
		      // jQuery("#zd_message").val("") ;
		      // jQuery("#zd_message").focus() ;
		        //return false ;
    }
	
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
	if(jQuery("#zd_ifgroup").val()=='公司'){
		if(jQuery("#zd_company").val()=='公司名字' || jQuery.trim(jQuery("#zd_company").val())==''){
			jQuery.jBox.tip("请输入公司名字") ;
			jQuery("#zd_company").focus() ;
		     return false ;
		}
	} 
		if(jQuery("#zd_province").val()==''){
			jQuery.jBox.tip("选择省份") ;
			jQuery("#zd_city").focus() ;
		     return false ;
	}
	    	jQuery("#zd_city").val(  document.getElementById("thecity").innerHTML ) ;
	if(jQuery("#zd_city").val()==''||jQuery("#zd_city").val()=='-请选择-'){
			jQuery.jBox.tip("选择城市") ;
			jQuery("#zd_city").focus() ;
		     return false ;
	}
	

	
	if($.trim($("#zd_buy_time").val()) == ""){
 		$.jBox.tip("请选择预计购买时间！");
 		$("#zd_buy_time").focus();
 		return false;
 	}
	if (null == jQuery("#zd_buy_type").val() || jQuery("#zd_buy_type").val().length == 0) {
		jQuery.jBox.tip("请输入您的付款方式!");
		setTimeout(function() {
			jQuery("#zd_buy_type").focus();
		},
		0);
		return false;
	}
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	// jQuery("#theform").submit() ;
   return true ;
}
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
    document.getElementById("thecity").innerHTML=city;
    document.getElementById("theprovince").innerHTML=province;
	jQuery("a:contains("+province+")").click();
	jQuery("a:contains("+city+")").click();

    jQuery("#zd_province").val(province) ;
	jQuery("#zd_city").val(city) ;
	jQuery("#zd_contact_address").val(province+city) ;
}) ;
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
	
	function set_my_city(o,b){
		var area_id = o;
		 jQuery("#zd_province").val(b) ;
		jQuery("#zd_city").val('') ;
    document.getElementById("thecity").innerHTML="-请选择-";

		jQuery.ajax({
			url : '/tools/ajax.jsp',
			async : false,
			type : 'post',
			data : {
				flag : 'get_city_new',
				p : area_id
			},
			success : function(data){
                 $("#citys").html(data);
				//var zd_city = document.getElementById("citys");
				//zd_city.html(data);
			}
		});
	}
	//下拉
$.fn.sele=function() {
	var ev=($(this).data('sele')?$(this).data('sele').act:'mouseenter').split(" ");
	$(this).bind(ev[0],function(){sele_show(this,ev[0])}).bind('mouseleave',function(){sele_hide(this)});
	function sele_show(me,evt){
		$(me).find('.sele_').show().children('a').click(function(event){
			event.stopPropagation();
			if(!$(this).attr('target')){
				event.preventDefault();
				if($(me).find('.btn').length){
					$(me).find('.btn').attr('href',$(this).attr('href'))
				};
				$(this).parent().hide().parents('.sele').find('span').text($(this).text());
			}
		})
	};
	function sele_hide(me){
		$(me).find('.sele_').hide();
	};
};
var $sele=$('.sele');
$sele.each(function(i) {$(this).css('z-index',$sele.length-i).sele()});
</script>
<div style="display:none"> 
  <script type="text/javascript">
var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_2697829'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s17.cnzz.com/stat.php%3Fid%3D2697829%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
</script> 
  <script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
</script> 



<script>
function buyTime(obj){
    	jQuery("#zd_buy_time").val(obj) ;
}
function buyType(obj){
    	jQuery("#zd_buy_type").val(obj) ;
}

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