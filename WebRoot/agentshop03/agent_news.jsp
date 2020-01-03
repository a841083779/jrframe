<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%

String usern = CommonString.getFormatPara(request.getParameter("usern"));
DBHelper dbHelper = DBHelper.getInstance();
Connection connection = null;
String factoryid = "" ;
try{
	connection = dbHelper.getConnection();
	Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
	if(map == null){
		Common.do302(response,"/agent");
		return;
	}
	if(map != null && !CommonString.getFormatPara(map.get("is_qijiandian")).equals("3")){ // 使用模板二
		Common.do302(response,"/agent/"+CommonString.getFormatPara(request.getParameter("usern"))+"/");
		return;	
	}
	factoryid = CommonString.getFormatPara(map.get("agent_fac")) ;  // 代理的品牌
	String agentid =CommonString.getFormatPara(map.get("id")) ;  // 代理商的品牌
	String sel_sql = " select * from pro_agent_product_vi where factoryid in("+factoryid.substring(0,factoryid.length()-1)+") and recommend=1 and agentid=?" ;

		String offset = CommonString.getFormatPara(request.getParameter("offset"));
		String whereStr = " and agent_id = '"+agentid+"' and is_approval = 1 ";
		PageBean pageBean = new PageBean() ; // 分页程序
		pageBean.setPageSize(11) ; // 每页显示条数
		pageBean.setCondition(whereStr.toString()) ;
		Map news_typeMap = new HashMap() ;
	   news_typeMap.put("0","企业动态") ;
	   news_typeMap.put("2","新品推荐") ;
	   news_typeMap.put("1","产品导购") ;
	   news_typeMap.put("3","维修保养") ;
		Integer nowPage = 1 ;
		if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
		}
		pageBean.setNowPage(nowPage) ;   
		pageBean.setOrderBy(" pub_date desc , id desc ") ;  // 默认排序
		String url = CommonString.getFormatPara(request.getQueryString()) ;
		url = url.replace("/"+usern+"/agent_news.shtm","/agent_news.jsp?usern="+usern);
		if(!"".equals(url)){
			if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
				url="" ;
			}else if(url.indexOf("offset")!=-1 ){
				url = "&"+url.substring(url.indexOf("&")+1) ;
			}else{
				url = "&"+url ;
			}
		}
		pageBean.setParams(url) ;
		pageBean.setFields("*") ;
		pageBean.setTableName("pro_agent_news") ;	




%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%="在线询价_"+CommonString.getFormatPara(map.get("full_name"))%>-中国工程机械商贸网</title>
<meta name="keywords" content="在线询价,<%= CommonString.getFormatPara(map.get("full_name"))%>,工程机械" />
<meta name="description" content="中国工程机械商贸网提供<%= CommonString.getFormatPara(map.get("full_name"))%>在线询价栏目，让您对<%= CommonString.getFormatPara(map.get("full_name"))%>更加了解，欢迎光临<%= CommonString.getFormatPara(map.get("full_name"))%>品牌旗舰店。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/shop02.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<script src="/scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
EvPNG.fix('div,ul,img,li,input,td,a'); 
</script>
<![endif]-->
<script type="text/javascript" src="/scripts/pinyin.js"></script>
</head>
<body class="style02">
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
</div>
<!--店铺导航-->
<jsp:include page="nav_top.jsp" flush="true">
<jsp:param name="flag" value="0"/>
</jsp:include>
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
        <div class="sContent" id="brandId"> </div>
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
	  <%
		List<Map> list = pageBean.getDatas(connection);
  %>
      <!--企业动态-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>企业动态</h2>
        </div>
        <div class="sContent">
          <table width="100%">
            <tr style="background-color: #F7F7F7;">
              <th width="60%">标题</th>
              <th width="20%">动态类型</th>
              <th width="20%">发布日期</th>
            </tr>
            <tr>
	 <%
	  	if(list != null && list.size() > 0){
	  		Map m = null;
	  		for(int i = 0;list != null && i < list.size();i++){
	  			m = list.get(i);
	  %>
  <td style="height: 30px; line-height: 30px;"><a target="_blank" href="/news/detail.jsp?id=<%=CommonString.getFormatPara(m.get("id")) %>&t_flag=product"><%=CommonString.getFormatPara(m.get("title")) %></a>
</td>
              <td style="text-align: center;"> <%=CommonString.getFormatPara(news_typeMap.get(CommonString.getFormatPara(m.get("news_type")))) %></td>
              <td style="text-align: center;"><%=CommonDate.getFormatDate("yyyy-MM-dd",m.get("pub_date")) %></td>
			        <%
			}
		}else{
	  %> 
      	<span class="textStyle">暂无信息</span>
      <%}%> 
            </tr>
          </table>
        </div>
      </div>
      <div class="wfull l">
        <div id="pagination" class="page" style="margin-right:10px">
          <div class='paging page' id='pagination'> <span class="current" style="cursor: default;border:none;color:#000;"><b>&nbsp;1&nbsp;</b></span> </div>
        </div>
      </div>
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
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<!--<script type="text/javascript" src="/scripts/agent_banner.js"></script>-->
<script type="text/javascript">	

	jQuery("#zd_message").text("您好，我对南京钢加工程机械实业有限公司的产品感兴趣，想要咨询，请您给我回复，谢谢。");
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
  if(jQuery("#zd_ifgroup").val()=='公司'){
		if(jQuery("#zd_company").val()=='公司名字' || jQuery.trim(jQuery("#zd_company").val())==''){
			jQuery.jBox.tip("请输入公司名字") ;
			jQuery("#zd_company").focus() ;
			return false ;
		}
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
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	jQuery("#theform").ajaxSubmit(function(msg){
			if("0"!=jQuery.trim(msg)){
				jQuery.jBox.tip("提交成功！") ;
				//  询价成功，把用户名和电话放入 cookie 中
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
	set_city(document.getElementById("zd_province"),document.getElementById("zd_province").value,document.theform.zd_city,'');
	document.getElementById("zd_city").value = city;
	 jQuery("#zd_contact_address").val(province+city) ;
}) ;

function showinquery(pid,agentid,factoryid){
		jQuery.jBox("iframe:/include/products/product_order_agent.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName="+encodeURIComponent("南京钢加"), {
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
    if(''!=order_name && null!=order_name &&'null' != order_name){
    	jQuery("#zd_name").val(order_name) ;
    }
    if(''!=order_phone && null!=order_phone && "null"!=order_phone){
    	jQuery("#zd_mobile_phone").val(order_phone) ;
    }
   	setTimeout(function(){
		if(jQuery.trim(jQuery("#recommendPro ul").html())==''){	
			jQuery("#recommendProT").parent("div").remove() ;  // 如果没有推荐产品则隐藏推荐产品标题
		}
		},0) ;
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
</script>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>