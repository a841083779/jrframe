<%@ page contentType="text/html; charset=utf-8" language="java" import="com.jerehnet.util.dbutil.PageBean,java.util.List,com.jerehnet.util.common.CommonApplication,java.util.LinkedHashMap,com.jerehnet.util.common.Common,java.util.Map,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.sql.*" errorPage="" %><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
	connection = dbHelper.getConnection();
	Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
	if(map == null){
		Common.do302(response,"/agent");
		return;
	}
	// 预计购买时间
	LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
	Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
			map.get("id")
		},connection);
	List<Map> areas = dbHelper.getMapList(" SELECT area_id,area_name FROM comm_area WHERE parent_area_id = 0 ",connection);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%="在线询价_"+CommonString.getFormatPara(map.get("full_name"))%>-中国工程机械商贸网</title>
<meta name="keywords" content="在线询价,<%= CommonString.getFormatPara(map.get("full_name"))%>,工程机械" />
<meta name="description" content="中国工程机械商贸网提供<%= CommonString.getFormatPara(map.get("full_name"))%>在线询价栏目，让您对<%= CommonString.getFormatPara(map.get("full_name"))%>更加了解，欢迎光临<%= CommonString.getFormatPara(map.get("full_name"))%>品牌旗舰店。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/shop01.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<!--[if (IE 6)]>
<script src="/scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
EvPNG.fix('div,ul,img,li,input,td,a'); 
</script>
<![endif]-->
<script type="text/javascript" src="/scripts/pinyin.js"></script>
</head>
<body class="style01">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="sTop00 whitebg">
  <div class="contain980">
    <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/agent/">代理商专区</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name")) %></h3>
  </div>
</div>
<!--面包屑结束-->
<div class="sTop01">
  <div class="contain980 h93px">
    <h2 class="companyName"> <%=CommonString.getFormatPara(map.get("full_name"))%><span class="intro"><%=CommonString.getFormatPara(map.get("sub_title")) %></span> </h2>
    <div class="approve">
      <div class="star"><span class="star01"></span></div>
    </div>
  </div>
</div>
<!--公司名称--> 
<!--公司名称结束--> 
<!--店铺导航-->
<jsp:include page="nav_top.jsp"><jsp:param value="5" name="flag"/></jsp:include>
<!--店铺导航结束--> 
<!--主体-->
<div class="shopContain whitebg mb10"> 
  <div class="h10px c"></div>
  <div class="w100 l shopLeftbg"> 
    <!--left-->
    <div class="shopLeft"> 
      <!--代理产品-->
      <div class="brand">
        <div class="sTitle">
          <h2>代理品牌</h2>
        </div>
        <div class="sContent" id="brandId">
        </div>
      </div>
      <!--代理产品 结束-->
      <div class="w100 l h10px whitebg"></div>
      <!--公司资料-->
      <div class="sLeftPart companyInfo">
        <div class="sTitle">
          <h2>公司资料</h2>
        </div>
        <div class="sContent">
          <h3 class="companyName"><%=CommonString.getFormatPara(map.get("full_name"))%></h3>
          <span class="approve">官方认证旗舰店（第1年）</span>
          <div class="star"><span class="star01"></span></div>
          <div class="intro"> 
            <%=CommonString.getFormatPara(map.get("city")).equals("")?"":"代理地区："+CommonString.getFormatPara(map.get("city"))+" <br />"%>
            <%=CommonString.getFormatPara(map.get("agent_fac_name")).equals("")?"":"代理品牌："+CommonString.getFormatPara(map.get("agent_fac_name"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("telphone")).equals("")?"":"销售电话："+CommonString.getFormatPara(map.get("telphone"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("concatus")).equals("")?"":"联系人："+CommonString.getFormatPara(map.get("concatus"))+"<br />"%>
           <%
           	if(!"".equals(CommonString.getFormatPara(map.get("email")))){
           		%>
           		  电子邮件：<a href="mailto:<%=CommonString.getFormatPara(map.get("email"))%>">
                          <%=CommonString.getFormatPara(map.get("email"))%></a><br />
           		<%
           	}
           %>
            <%=CommonString.getFormatPara(map.get("fax")).equals("")?"":"传真："+CommonString.getFormatPara(map.get("fax"))+"<br />"%>
               <!--   邮政编码：<%=CommonString.getFormatPara(map.get("postcode"))%><br />  -->
           <%=CommonString.getFormatPara(map.get("address")).equals("")?"":" 地址："+CommonString.getFormatPara(map.get("address"))%>
          </div>
        </div>
      </div>
      <!--公司资料 结束--> 
    </div>
    <!--left end--> 
    <!--right-->
    <div class="shopRight"> 
      <!--banner-->
       <!-- 三张banner图 -->
     <%
     String agentbanner =CommonString.getFormatPara(map.get("agentbanner"))  ;
     String agentbanner2 =CommonString.getFormatPara(map.get("agentbanner2"))  ;
     String agentbanner3 =CommonString.getFormatPara(map.get("agentbanner3"))  ;
     %>
     <jsp:include page="agent_banners.jsp" flush="true">
      <jsp:param value="<%=agentbanner%>" name="agentbanner"/>
      <jsp:param value="<%=agentbanner2 %>" name="agentbanner2"/>
      <jsp:param value="<%=agentbanner3%>" name="agentbanner3"/>
     </jsp:include>
      <!--banner end-->
      <!--公司简介-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>在线询价</h2>
        </div>
        <div class="sContent"> 
          <script type="text/javascript">
        jQuery(function(){
            jQuery(".inquiry .btn02").hover(function(){
                jQuery(this).toggleClass("hover");
            },function(){
                jQuery(this).removeClass("hover");
            });
        jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'13086'} ,
    	success:function(msg){
    	}
    }) ;
        })
        </script>
          <form action="/action/order_save.jsp" method="post" name="theform" id="theform" onsubmit="return submitYN(this);">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="inquiry">
              <tr>
                <th width="13%" style="padding:5px 0px;">姓名：</th>
                <td width="87%"><input class="input01" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">手机/固话：</th>
                <td><input class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">地区：</th>
                <td><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:79px;"  dataType="Require"  msg="请选择省份">
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
                  </select>
                  *</td>
              </tr>
              <tr>
                <th width="13%" style="padding:5px 0px;">采购性质：</th>
                <td width="87%"><input name="zd_ifgroup" type="radio" checked value="个人" />
                  <font color="#434343">个人</font>
                  <input  name="zd_ifgroup" type="radio"  value="公司" />
                  <font color="#434343">公司</font>
                  <input type="text" value="公司名字" id="zd_company" name="zd_company" style="display:none;" />
                  *</td>
              </tr>
              <tr>
                <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px">预计购买时间：</th>
                <td nowrap="nowrap" class="list_cell_bg"><select name="zd_buy_time" id="zd_buy_time" >
                    <option value='102001'>1个月内</option>
                    <option value='102002'>1—3个月</option>
                    <option value='102003'>4—6个月</option>
                    <option value='102004'>7—12个月</option>
                    <option value='102005'>1年后</option>
                    <option value='102006'>不确定</option>
                  </select>
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">留言内容：</th>
                <td><textarea class="textarea01" name="zd_message" cols="45" rows="5"  id="zd_message"></textarea></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><input type="submit" name="button2" id="button2" value="提交" class="btn02" /></td>
              </tr>
            </table>
            <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
            <input type="hidden" name="zd_contact_address" id="zd_contact_address" />
            <input type="hidden" name="zd_agentid" id="zd_agentid" value="13086"/>
            <input type="hidden" name="zd_agentname" id="zd_agentname" value="三北创新"/>
            <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
            <!-- 属于公司或个人 -->
          </form>
        </div>
      </div>
            <%
			String whereStr = " ";
			String offset = CommonString.getFormatPara(request.getParameter("offset"));
			String agent_area = CommonString.getFormatPara(map.get("city")) ;  // 代理商代理地区
			String agent_factory = CommonString.getFormatPara(map.get("agent_fac")) ;  // 代理品牌
			String[] agent_factorys = null ;
			String agent_factory_str = "" ;
			 if(agent_factory.length()>0 && agent_factory.indexOf(",")>0){
				 agent_factorys = agent_factory.split(",") ;
			 }else{
				 whereStr+=" and factoryid="+agent_factory ;
			 }
			 if(null!=agent_factorys){
				 for(int i=0;i<agent_factorys.length;i++){
					 if(agent_factorys[i].length()>0 ){
						 agent_factory_str+=agent_factorys[i]+"," ;
					 }
				 }
			 }
			 if(agent_factory_str.length()>0 && agent_factory_str.lastIndexOf(",")!=0){
				 agent_factory_str = agent_factory_str.substring(0,agent_factory_str.length()-1) ;
			 }
			 if(agent_factory_str.length()>0){
				 whereStr += " and factoryid in("+agent_factory_str+")" ;
			 }
			 if(agent_area.length()>0 && agent_area.indexOf(",")==-1){ 
				  whereStr+= " and contact_address like'%"+agent_area+"%'" ;
			 }
			 String where = "" ;
			 if(agent_area.length()>0 && agent_area.indexOf(",")>0){  // 代理多个区域
				 String[] agent_areas = agent_area.split(",") ;
				 for(int i=0;i<agent_areas.length;i++){
					 where+=" or contact_address like '%"+agent_areas[i]+"%'" ;
				 }
			 }
			 if(where.length()>0 && where.indexOf("or")>0){
				 where = where.replaceFirst("or","") ;
			 }
			 if(where.length()>0){
				 whereStr+= " and ( "+where+" )" ;
			 }
			PageBean pageBean = new PageBean() ; // 分页程序
			pageBean.setPageSize(25) ; // 每页显示条数
			pageBean.setCondition(whereStr) ;
			
			Integer nowPage = 1 ;
			if(!"".equals(offset) && !"0".equals(offset)){
			   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
			}
			pageBean.setNowPage(nowPage) ;   
			pageBean.setOrderBy(" id desc ") ;  // 默认排序
			String url = CommonString.getFormatPara(request.getQueryString()) ;
			//url = url.replace("/"+usern+"/agent_products.shtm","/agent_products.jsp?usern="+usern);
			if(!"".equals(url)){
				if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
					url="#order" ;
				}else if(url.indexOf("offset")!=-1 ){
					url = "&"+url.substring(url.indexOf("&")+1)+"#order" ;
				}else{
					url = "&"+url+"#order" ;
				}
			}
			pageBean.setParams(url) ;
			pageBean.setFields(" id,factoryname,cataname,product_name,add_date,name,mobile_phone,province,city,contact_address ") ;
			pageBean.setTableName("pro_product_form") ;
			List<Map> list = pageBean.getDatas();
	  %>
      <%
	  	if(list != null && list.size() > 0){
	  %>
      <div class="sRightPart list08">
        <div class="sTitle">
          <h2>产品订单<a name="order" id="order"></a></h2>
        </div>
        <ul class="ti">
          <li class="i1">编号</li>
          <li class="i2">询价产品</li>
          <li class="i3">联系人</li>
          <li class="i4">电话</li>
          <li class="i5">询价品牌</li>
          <li class="i6">询价区域</li>
          <li class="i7">询价时间</li>
        </ul>
        <div class="li">
          <%
			String showtel = "";
			for(int i = 0;list != null && i < list.size();i++){
				showtel = "".equals(CommonString.getFormatPara(list.get(i).get("mobile_phone")))?CommonString.getFormatPara(list.get(i).get("contact_tel")):CommonString.getFormatPara(list.get(i).get("mobile_phone")) ;
				if(showtel.length()>7&&showtel.length()<=20){
					showtel = showtel.substring(0,3)+"***"+showtel.substring(showtel.length()-3) ;
				}else if(showtel.length()>3){
					showtel = showtel.substring(0,4)+"***" ;
				}else
				{
					showtel = showtel+"***" ;
				}	
		%>
          <ul class="libg0<%=i%2+1%>">
            <li class="i1"><%=i+1%></li>
            <li class="i2"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm" target="_blank"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%></a></li>
            <li class="i3"><%=(CommonString.getFormatPara(list.get(i).get("name")).length()>0)?CommonString.getFormatPara(list.get(i).get("name")).substring(0,1)+"***":"张**" %></li>
            <li class="i4"><%=showtel%></li>
            <li class="i5"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%></li>
            <li class="i6"><%="".equals(CommonString.getFormatPara(list.get(i).get("contact_address")))?"-":CommonString.getFormatPara(list.get(i).get("contact_address"))  %></li>
            <li class="i7"><%=(CommonString.getFormatPara(list.get(i).get("add_date")).length()>15)?CommonString.getFormatPara(list.get(i).get("add_date")).substring(0,16):CommonString.getFormatPara(list.get(i).get("add_date")) %></li>
          </ul>
          <%}%>
        </div>
      </div>
      <%
		}
	%>
      <%
		if(list != null && list.size() > 0){
	  %>
      <div class="wfull l">
        <div id="pagination" class="page" style="margin-right:10px">
          <tags:page pageBean="<%=pageBean %>" url="/agentshop/agent_message.jsp"/>
        </div>
      </div>
      <%
		}
	  %>
    </div>
    <!--right end-->
    <div class="w100 l shopLeftLine"></div>
  </div>
  <div class="clear"></div>
</div>
<!--主体 结束--> 
<!--foot-->
<div class="shopFoot">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--foot end-->
<div style="display:none"> 
<script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
<script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
</body>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script type="text/javascript" src="/scripts/agent_banner.js"></script>
<script type="text/javascript">
	//主营品牌
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandAgentCatalogListShop2","agentid":"<%=CommonString.getFormatPara(map.get("id"))%>","agent_fac":"<%=CommonString.getFormatPara(map.get("agent_fac"))%>","agent_fac_name":"<%=CommonString.getFormatPara(map.get("agent_fac_name"))%>","usern":"<%=usern%>"},
		success:function(data){
			jQuery("#brandId").html(jQuery.trim(data));	
			if(jQuery.trim(data)==""){
				jQuery("#brandId").removeClass("agentLeftPart mb10");	
			}
		}
	});
	
	jQuery("#zd_message").text("您好，我对<%=CommonString.getFormatPara(map.get("full_name"))%>的产品感兴趣，想要咨询，请您给我回复，谢谢。");
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
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	jQuery("#theform").ajaxSubmit(function(msg){
			if("0"!=jQuery.trim(msg)){
				jQuery.jBox.tip("提交成功！") ;
					// 询价成功，把用户名和电话放入 cookie 中
				 SetCookie("order_name",jQuery("#zd_name").val()) ;
				 SetCookie("order_phone",jQuery("#zd_mobile_phone").val()) ;
				jQuery("#zd_mobile_phone").val("");
				jQuery("#zd_message").val("");
			}
		}) ;
		return false ;
}
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	jQuery("#zd_province option:contains("+province+")").attr("selected",true);
	jQuery("#zd_province").change();
	set_my_city(document.getElementById("zd_province"),city);
	// jQuery("#zd_contact_address").val(province+city) ;
}) ;

function showinquery(pid,agentid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order_agent.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName=<%=CommonString.getFormatPara(map.get("name")) %>", {
	title: "在线询价",
	width: 720,
	height: 450,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
		// 把下过订单的信息取出
jQuery(function(){
	var order_name = jQuery.trim(unescape(GetCookie("order_name"))) ;  // 订单人
    var order_phone = jQuery.trim(GetCookie("order_phone")) ;  // 订单电话
    if(''!=order_name && null!=order_name && "null"!=order_name){
    	jQuery("#zd_name").val(order_name) ;
    }
    if(''!=order_phone && null!=order_phone && "null"!=order_name){
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
	 jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'<%=CommonString.getFormatPara(map.get("id"))%>'} ,
    	success:function(msg){
    	}
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
	jQuery(function(){
		jQuery("#zd_province option").each(function(){
			jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
		}) ;
	}) ;
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>