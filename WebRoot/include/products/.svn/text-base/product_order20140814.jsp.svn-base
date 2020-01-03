<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %><% 
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
<div style="font-size:14px; height:20px; line-height:20px; padding:10px 0px 10px 15px;font-weight:bold; background:#f1f1f1">
想了解 <%=CommonString.getFormatPara(one_product.get("factoryname"))%><%=frombrand.equals("yes")?"产品":CommonString.getFormatPara(one_product.get("name"))+CommonString.getFormatPara(one_product.get("catalogname")) %>最低价？请填写如下信息：<!--<font style="color:grey">（成功询价后，我们会24小时之内与您联系！）</font>--></div>
<div class="orderbg" style="margin:5px 0px 0px 10px; position:relative; padding-bottom:15px;">
  <img src="/images/xj_tel.png" width="210" height="45" style="position:absolute; right:20px; bottom:0px;" />
  <script type="text/javascript">
  jQuery(function(){
	  jQuery(".list_border_bg .btn02").hover(function(){
		  jQuery(this).toggleClass("hover");
	  },function(){
		  jQuery(this).removeClass("hover");
	  });
  })
  </script>
  <form action="/action/order_save.jsp" method="post" name="theform" id="theform" onSubmit="return submitYN(this);">
    <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0" class="list_border_bg">
      <tr>
        <th height="22" align="right" nowrap="nowrap" class="list_left_title" style="padding:5px 0px;">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</th>
        <td height="22" nowrap="nowrap" class="list_cell_bg "><input class="input01" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
          *</td>
      </tr>
       <tr>
        <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px;">手机/固话：</th>
        <td nowrap="nowrap" class="list_cell_bg"><input class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
          *</td>
      </tr>
      <tr>
      <th height="22" align="right" nowrap="nowrap" class="list_left_title" style="padding:5px 0px;">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区：</th>
     <td><select name="zd_province" id="zd_province" onChange="set_my_city(this);" style="width:87px;"  dataType="Require"  msg="请选择省份">
         		<%
         			if(null!=areas&&areas.size()>0){
         				for(Map m : areas){
         					%><option value="<%=CommonString.getFormatPara(m.get("area_name")) %>" area_id="<%=CommonString.getFormatPara(m.get("area_id")) %>"><%=CommonString.getFormatPara(m.get("area_name")) %></option><%
         				}
         			}
         		%>
        </select>
        <select  name="zd_city" id="zd_city"  style="width:100px;" dataType="Require"  msg="请选择城市">
          <option value="">选择城市</option>
        </select>*</td>
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
     	 <option value="">请选择</option>
     	 <%= CommonForm.createSelect(buyTimeMap,"") %>
     	 </select>
          *
          <!--<span style="color:#000;margin-left:5px;*vertical-align:3px;">（如果有合适的二手设备，您会考虑吗？）&nbsp;&nbsp;是<input type="radio" style="vertical-align:-3px;" name="heshi" value="1" checked="checked" />&nbsp;&nbsp;否<input style="vertical-align:-3px;" type="radio" name="heshi" value="0" /></span>-->
          </td>
      </tr>
	   <tr>
        <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px;">付款方式：</th>
        <td nowrap="nowrap" class="list_cell_bg">
     	 <select name="zd_buy_type" id="zd_buy_type"   dataType="Require"  msg="请选择付款方式">
     	 <option value="">请选择</option>
		 <option value="全款付车">全款付车</option>
		 <option value="银行按揭">银行按揭</option>
		 <option value="融资租赁">融资租赁</option>
		 <option value="其他">其他</option>
     	 </select>
          *
          </td>
      </tr>
      <tr>
        <th height="22" align="right" nowrap="nowrap" class="list_left_title" style="padding:5px 0px;">留言内容：</th>
        <td height="22" colspan="3" class="list_cell_bg" style="padding:0 0 10px 0;"><textarea class="input03" name="zd_message" cols="77" rows="5"  id="zd_message"></textarea></td>
      </tr>
      <tr>
	 <%if(inquriyCount>=6){%>
        <th>验证码:</th>
           <td height="30" colspan="2"><input name="rand" type="text" id="rand" size="15"  style="width:100px; height:18px; line-height:18px;" tabindex="3" maxlength="4"/>
         <img src="/webadmin/authImgServlet" align="absmiddle" id="authImg" onClick="refresh();" title="如果您看不清，请在图片上单击，可以更换验证码！"/> <span onClick="refresh();" style=" color:#999999;cursor:pointer">(点击验证码刷新)</span></td>
      <%}%>
		<td height="22"  style="padding-top:0px; padding-left:0px; font-size:0; line-height:0; height:auto;">
          <span class="list_cell_bg" style="margin-left:15px">
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
         <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/><!-- 属于公司或个人 -->
         <input type="hidden" name="zd_is_first" id="zd_is_first" value="1"/>
          </span></td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <td height="30" colspan="2"><input class="btn02" name="Submit" type="submit" value="获取最低价"/></td>
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
		if(jQuery("#zd_city").val()==''){
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
	jQuery("#zd_province option:contains("+province+")").attr("selected",true);
	jQuery("#zd_province").change();
	set_my_city(document.getElementById("zd_province"),city);
	// jQuery("#zd_contact_address").val(province+city) ;
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