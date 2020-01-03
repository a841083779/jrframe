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
			    window.parent.jBox.close() ; 
			    setTimeout(function(){
			    	window.parent.location.href="/products/prolist.jsp" ;
			    },1000) ;
			 </script>
			<%
			return;
		}
		List<Map> areas = dbHelper.getMapList(" SELECT area_id,area_name FROM comm_area WHERE parent_area_id = 0 ",connection);
		// 预计购买时间
		LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线询价</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
-->
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/scripts/citys.js"></script> 
</head>
<body>
<h3>
<%=CommonString.getFormatPara(one_product.get("factoryname"))%><%=frombrand.equals("yes")?"产品":CommonString.getFormatPara(one_product.get("name"))+CommonString.getFormatPara(one_product.get("catalogname")) %>询价<!--<font style="color:grey">（成功询价后，我们会24小时之内与您联系！）</font>--></h3>
<div class="form-con">
  <script type="text/javascript">
  jQuery(function(){
	  jQuery(".list_border_bg .btn02").hover(function(){
		  jQuery(this).toggleClass("hover");
	  },function(){
		  jQuery(this).removeClass("hover");
	  });
  })
  </script>
  <form action="/action/order_save_include.jsp" method="post" name="theform" id="theform" onSubmit="return submitYN(this);">
    <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0" class="list_border_bg">
      <tr>
        <th height="22" align="right" nowrap="nowrap" class="list_left_title" style="padding:5px 0px;">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</th>
        <td height="22" nowrap="nowrap" class="list_cell_bg "><input class="input01" name="zd_name" type="text" id="zd_name" size="20" maxlength="20" />
          *</td>
      </tr>
       <tr>
        <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px;">手机/固话：</th>
        <td nowrap="nowrap" class="list_cell_bg"><input class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="20" maxlength="15" />
          *</td>
      </tr>
      
         <tr>
           <th height="22" align="right" nowrap="nowrap" class="list_left_title" style="padding:5px 0px;">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区：</th>
           <td height="22" nowrap="nowrap" class="list_cell_bg "><span class="list_cell_bg">
             <input class="input01" name="zd_contact_address" type="text" id="zd_contact_address" size="20" maxlength="15" />
           </span></td>
         </tr>
         <tr>
        <th height="22" align="right" nowrap="nowrap" class="list_left_title" style="padding:5px 0px;">采购性质：</th>
        <td height="22" nowrap="nowrap" class="list_cell_bg ">
        <input class="input01" name="zd_ifgroup" type="radio" checked value="个人" /><font color="#434343">个人</font>
        <input class="input01" name="zd_ifgroup" type="radio"  value="公司" /><font color="#434343">公司</font>
        <input type="text" value="公司名字" id="zd_company" name="zd_company" style="display:none;" maxlength="20"/>
          *</td>
      </tr>
       <tr>
        <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px;">预计购买时间：</th>
        <td nowrap="nowrap" class="list_cell_bg">
     	 <select name="zd_buy_time" id="zd_buy_time" >
     	 <%= CommonForm.createSelect(buyTimeMap,"1个月内") %>
     	 </select>
          *
          <!--<span style="color:#000;margin-left:5px;*vertical-align:3px;">（如果有合适的二手设备，您会考虑吗？）&nbsp;&nbsp;是<input type="radio" style="vertical-align:-3px;" name="heshi" value="1" checked="checked" />&nbsp;&nbsp;否<input style="vertical-align:-3px;" type="radio" name="heshi" value="0" /></span>-->          </td>
      </tr>
      
      <tr>
        <th align="right" nowrap="nowrap">验证码：</th>
        <td height="30" colspan="2"><input name="rand" type="text" id="rand" size="10"  style="width:60px; height:18px; line-height:18px;" tabindex="3" maxlength="4"/>
         <img src="/webadmin/authImgServlet" align="absmiddle" id="authImg" onClick="refresh();" title="如果您看不清，请在图片上单击，可以更换验证码！"/></td>
        <td height="22"  style="padding-top:5px; padding-left:10px;">
          <span class="list_cell_bg" style="margin-left:15px">
        <!--   <input name="zd_id" type="hidden" id="zd_id" value="0" />  -->
          <%
					String mytag = CommonString.getFormatPara(request.getParameter("mytag"));
					if("".equals(mytag)){
						mytag = "3";
					}
				%>
			<input name="zd_province" type="hidden" id="zd_province" value="" />
        <input name = "zd_city" type="hidden" id="zd_city" value=""/>
			
	     <input type="hidden" name="zd_message" id="zd_message" value="您好，我对贵公司的产品感兴趣，想要咨询，请您给我回复，谢谢。"/>	
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
         <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/><!-- 属于公司或个人 -->
         <input type="hidden" name="zd_is_first" id="zd_is_first" value="1"/>
          </span></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <td height="30" colspan="2"><input class="btn02" name="Submit" type="submit" value="提交"/></td>
        <td height="22"  style="padding-top:5px; padding-left:10px;"></td>
      </tr>
    </table>
  </form>
</div>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
<script type="text/javascript">
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	//alert(province);
	//alert(city);
	jQuery("#zd_province").val(province);
	jQuery("#zd_city").val(city);
	jQuery("#zd_contact_address").val(province+city) ;
}) ;

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
	if(jQuery("#zd_ifgroup").val()=='公司'){
		if(jQuery("#zd_company").val()=='公司名字' || jQuery.trim(jQuery("#zd_company").val())==''){
			jQuery.jBox.tip("请输入公司名字") ;
			jQuery("#zd_company").focus() ;
		     return false ;
		}
	} 
		if(jQuery("#zd_city").val()==''){
			jQuery.jBox.tip("选择城市") ;
			jQuery("#zd_city").focus() ;
		     return false ;
	}
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	// jQuery("#theform").submit() ;
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