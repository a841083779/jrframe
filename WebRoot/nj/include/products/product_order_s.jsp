<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %>
<% 
	String url  = CommonString.getFormatPara(request.getHeader("referer")) ;
	String frombrand = "" ;  // 来自品牌的询价
	String productid=CommonString.getFormatPara(request.getParameter("productid"));
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map one_product = new HashMap() ;
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		if(!"".equals(productid) && !"undefined".equals(productid)){
		 	one_product = dbHelper.getMap(" select id,name,catalog_name,brand_name,catalog_num,brand_id from pro_machine_products where id='"+productid+"'",connection) ;
		}

		if(one_product==null || one_product.size()==0){
		%>
<script type="text/javascript">
			   window.parent.jBox.tip("该产品已不存在") ;
			    window.parent.jBox.close(); 
			    setTimeout(function(){ window.parent.location.href="<%=url%>" ; },1000) ;
			 </script>
<%
			return;
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线询价</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/Static/css/ui.css" rel="stylesheet" />
<link href="/Static/css/common.css" rel="stylesheet" />
<link href="/Static/css/style.css" rel="stylesheet" />
<style type="text/css">
.txd_xunjia {
	border: 0px solid #ff9000;
}
.txj_main {
	padding: 0px 20px 20px 90px
}
body {
	padding: 5px 10px;
	font-family: 'Microsoft Yahei'
}
.top_t {
	color: #4e5762;
	font-size: 25px;
	border-bottom: 1px solid #dfdfdf;
	padding-bottom: 7px;
}
.top_t1 {
	font-size: 16px;
	height: 20px;
	line-height: 20px;
	padding: 10px 0px 10px 0px;
	font-weight: bold;
}
</style>
</link>
</head>
<body>
<h3 class="top_t">在线询价 </h3>
<div class="top_t1"> 想了解 <%=CommonString.getFormatPara(one_product.get("brand_name"))%><%=CommonString.getFormatPara(one_product.get("name"))+CommonString.getFormatPara(one_product.get("catalog_name")) %>最低价？请填写如下信息： </div>
<div class="txd_xunjia mt15" id="prodetailOrder">
  <div class="txj_main fix" style="height:500px;">
    <div class="_form">
      <form action="/nj/action/order_save_new_s.jsp" method="post" name="theform" id="theform" onSubmit="return submitYN(this);">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
          <tbody>
            <tr>
              <th align="right">您在什么地方：</th>
              <td><div class="txd_address"> <a href="javascript:void(0);" class="cityboxbtn"> <span class="tadd_p" id="the_province"></span><span class="tadd_c" id="the_city"></span> </a>
                  <div class="citybox citybox_tab">
                    <ul class="city_keylist fix">
                      <li class="city_key city_key_01 cur">请选择省份</li>
                      <li class="city_key city_key_02">请选择城市</li>
                    </ul>
                    <div class="city_val city_val_01 hide" style="display: block;">
                      <div class="cityshow fix"> <span data-province="山东***100110"><a href="javascript:void(0)">山东</a></span> <span data-province="安徽***101800"><a href="javascript:void(0)">安徽</a></span> <span data-province="江西***103100"><a href="javascript:void(0)">江西</a></span> <span data-province="浙江***104200"><a href="javascript:void(0)">浙江</a></span> <span data-province="上海***105290"><a href="javascript:void(0)">上海</a></span> <span data-province="北京***105499"><a href="javascript:void(0)">北京</a></span> <span data-province="天津***105689"><a href="javascript:void(0)">天津</a></span> <span data-province="重庆***105879"><a href="javascript:void(0)">重庆</a></span> <span data-province="河北***106400"><a href="javascript:void(0)">河北</a></span> <span data-province="山西***108300"><a href="javascript:void(0)">山西</a></span> <span data-province="内蒙古***109700"><a href="javascript:void(0)">内蒙古</a></span> <span data-province="江苏***110900"><a href="javascript:void(0)">江苏</a></span> <span data-province="广西***113000"><a href="javascript:void(0)">广西</a></span> <span data-province="西藏***115000"><a href="javascript:void(0)">西藏</a></span> <span data-province="宁夏***116000"><a href="javascript:void(0)">宁夏</a></span> <span data-province="新疆***117000"><a href="javascript:void(0)">新疆</a></span> <span data-province="吉林***119000"><a href="javascript:void(0)">吉林</a></span> <span data-province="辽宁***120000"><a href="javascript:void(0)">辽宁</a></span> <span data-province="黑龙江***122000"><a href="javascript:void(0)">黑龙江</a></span> <span data-province="湖北***124000"><a href="javascript:void(0)">湖北</a></span> <span data-province="湖南***126000"><a href="javascript:void(0)">湖南</a></span> <span data-province="广东***128000"><a href="javascript:void(0)">广东</a></span> <span data-province="河南***130000"><a href="javascript:void(0)">河南</a></span> <span data-province="贵州***132000"><a href="javascript:void(0)">贵州</a></span> <span data-province="青海***133000"><a href="javascript:void(0)">青海</a></span> <span data-province="甘肃***134000"><a href="javascript:void(0)">甘肃</a></span> <span data-province="陕西***135500"><a href="javascript:void(0)">陕西</a></span> <span data-province="云南***137000"><a href="javascript:void(0)">云南</a></span> <span data-province="四川***139000"><a href="javascript:void(0)">四川</a></span> <span data-province="海南***141500"><a href="javascript:void(0)">海南</a></span> <span data-province="福建***142000"><a href="javascript:void(0)">福建</a></span> </div>
                    </div>
                    <div class="city_val city_val_02 hide">
                      <div class="cityshow fix" id="zd_citys"></div>
                    </div>
                    <span class="city_close"></span> </div>
                  <input type="hidden" name="zd_province" id="zd_province" value="山东">
                  <input type="hidden" name="zd_city" id="zd_city" value="烟台">
                </div></td>
            </tr>
            <tr>
              <th align="right">您怎么称呼：</th>
              <td><input class="txj_inp" name="zd_name" type="text" id="zd_name" size="30" maxlength="20"></td>
            </tr>
            <tr>
              <th align="right">您的电话号：</th>
              <td><input class="txj_inp" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" placeholder="请填写正确手机号，获取最低价短信"></td>
            </tr>
            <tr>
              <td height="30" colspan="2"><input class="btn02 hover"  type="submit" name="Submit" value=""></td>
              <td height="22" style="padding-top:5px; padding-left:10px;"></td>
            </tr>
          </tbody>
        </table>
        <input name="zd_factoryid" type="hidden" id="zd_factoryid" value="<%=CommonString.getFormatPara(one_product.get("brand_id"))%>" />
        <input name = "zd_product_id" type="hidden" id="zd_product_id" value="<%=CommonString.getFormatPara(one_product.get("id"))%>"/>
        <input name = "zd_factoryname" type="hidden" id="zd_factoryname" value="<%=CommonString.getFormatPara(one_product.get("brand_name"))%>"/>
        <input name = "zd_product_name" type="hidden" id="zd_product_name" value="<%=CommonString.getFormatPara(one_product.get("name"))%>"/>
        <input type="hidden" name="zd_contact_address" id="zd_contact_address"/>
        <input type="hidden" name="zd_cataname" id="zd_cataname" value="<%=frombrand.equals("yes")?"":CommonString.getFormatPara(one_product.get("catalog_name")) %>" />
        <input type="hidden" name="zd_catanum" id="zd_catanum" value="<%=frombrand.equals("yes")?"":CommonString.getFormatPara(one_product.get("catalog_num"))%>"/>
        <input type="hidden" name="tableName" id="tableName" value="pro_machine_products_inquiry"/>
        <input name="zd_province" type="hidden" id="zd_province"  />
        <input name="zd_city" type="hidden" id="zd_city"  />
        <input name="zd_message" type="hidden" id="zd_message"  />
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script src="http://script.v.jerei.com/recv.js" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css">
<div style="display:none">
  <script type="text/javascript">
var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_2697829'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s17.cnzz.com/stat.php%3Fid%3D2697829%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
</script>
  <script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
</script>
</div>
<script>
	if (window.jereiReceiver) { 
    var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
    _jrTracker.track(); 
	}
   jQuery("#zd_message").val("您好，我对<%=CommonString.getFormatPara(one_product.get("factoryname"))%><%=frombrand.equals("yes")?"产品":CommonString.getFormatPara(one_product.get("name"))+CommonString.getFormatPara(one_product.get("catalogname")) %>感兴趣，想要咨询，请您给我回复，谢谢。");
    function submitYN(event) {
	var factoryname=$("#zd_factoryname").val(); 
	//var mobile_phone_reg = /^1([\d]{10})$/;
	var mobile_phone_reg = /^1[34587][0-9]\d{8}$/
	var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;	
	var  content = jQuery.trim(jQuery("#zd_message").val()) ;
		   if(content!=content.replace(/<\/?[^>]*>/g,'').replace('&lt','').replace('&gt','') || (content.indexOf("www")!=-1 || content.indexOf("http")!=-1)){
    }
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() { jQuery("#zd_name").focus(); }, 0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		jQuery.jBox.tip("请输入您的手机或固定电话！");
		setTimeout(function() { jQuery("#zd_mobile_phone").focus(); }, 10);
		return false;
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的电话号码!");
		setTimeout(function() { jQuery("#zd_mobile_phone").focus(); jQuery("#zd_mobile_phone").select();  }, 10);
		return false;
	}

	if(jQuery("#zd_province").val()==''){
			jQuery.jBox.tip("选择省份") ;
			jQuery("#zd_city").focus() ;
		     return false ;
	}
	if(jQuery("#zd_city").val()==''||jQuery("#zd_city").val()=='-请选择-'){
			jQuery.jBox.tip("选择城市") ;
			jQuery("#zd_city").focus() ;
		     return false ;
	}

	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
 
    return true ;
}

//询价城市选择
	$.fn.tab=function(){
		var $key=$(this).find('.city_key'),
			 $val=$(this).find('.city_val');
		$key.first().addClass('cur');
		$val.first().show();
		$key.each(function(index){
			$(this).click(function(event){
				event.preventDefault();
				$(this).addClass('cur').siblings().removeClass('cur');
				$val.hide().eq(index).show();
				})
			})
	};
	$('.citybox_tab').each(function() { $(this).tab()});
	$('.cityboxbtn').click(function(e) {
		$(this).addClass('cityboxbtn_on');
		$('.citybox').show();
	});
	
	$('.city_val_01 .cityshow span').click(function(e) {
		var prov = $(this).data('province');
		var prov_noe=prov.split('***');
		var area_id=prov_noe[1];
		$('#zd_province').val(prov_noe[0]);/*省份*/
		$('.city_key_01').html(prov_noe[0]);
		$('.city_key_01').removeClass('cur');
		$('.city_key_02').addClass('cur');
		$('.city_val_01').hide();
		$('.city_val_02').show();
		jQuery.ajax({
					url : '/tools/ajax_city.jsp',
					async : false,
					type : 'post',
					data : {
						flag : 'get_city_new',
						p : area_id
					},
					success : function(data){
						$("#zd_citys").html($.trim(data));	
								$('#zd_citys span').click(function(e) {
								var city = $(this).data('city');
								$('#zd_city').val(city);/*城市*/
								$('.city_key_02').html(city);
								var prov = $('.city_key_01').html();
								$('.city_key_02').removeClass('cur');
								$('.city_key_01').addClass('cur');
								$('.city_val_02').hide();
								$('.city_val_01').show();
								$('.cityboxbtn .tadd_p').html(prov);
								$('.cityboxbtn .tadd_c').html(city);
								$('.citybox').hide();
								$('.cityboxbtn').removeClass('cityboxbtn_on');
							});
					}
		});
	});
	
	jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	jQuery.ajax({
					url : '/action/ajax.jsp',
					async : false,
					type : 'post',
					data : {
						flag : 'get_city_name',
						city : city
					},
					success : function(data){
			                city= $.trim(data);
					}
	});
	
	document.getElementById("the_city").innerHTML=city;
    document.getElementById("the_province").innerHTML=province;
	document.getElementById("zd_province").value=province;
	document.getElementById("zd_city").value=city;
    }) ;
  
    function refresh(){
		document.getElementById("authImg").src='/webadmin/authImgServlet?now=' + new Date();
    }


//把下过订单的信息取出
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
jQuery("#zds_ifgroup").bind("click",function(){
	jQuery("#zd_ifgroup").val(jQuery(this).val()) ;  // 个人或公司
}) ;

 
	
	function selectCity(obj){
	    jQuery("#zd_city").val($(obj).text()) ;
	    document.getElementById("thecity").innerHTML=$(obj).text();
}
</script>
</body>
</html>
