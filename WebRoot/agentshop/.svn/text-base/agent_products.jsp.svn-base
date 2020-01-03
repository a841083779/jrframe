<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map brandUsernMap = (Map)application.getAttribute("brandUsernMap");
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		
		String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
		String agentid = CommonString.getFormatPara(map.get("id"));
		String offset = CommonString.getFormatPara(request.getParameter("offset"));
		String whereStr = " and agentid = '"+agentid+"' and is_show = 1 ";
		if(!catalognum.equals("")){
			whereStr += " and catalognum = '"+catalognum+"' ";	
		}
		PageBean pageBean = new PageBean() ; // 分页程序
		pageBean.setPageSize(16) ; // 每页显示条数
		pageBean.setCondition(whereStr.toString()) ;
		
		Integer nowPage = 1 ;
		if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
		}
		pageBean.setNowPage(nowPage) ;   
		pageBean.setOrderBy(" id asc ") ;  // 默认排序
		String url = CommonString.getFormatPara(request.getQueryString()) ;
		url = url.replace("/"+usern+"/agent_products.shtm","/agent_products.jsp?usern="+usern);
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
		pageBean.setFields(" id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end ") ;
		pageBean.setTableName("pro_agent_product_vi") ;
		Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
				map.get("id")
			},connection);
		String title = "代理机型_"+CommonString.getFormatPara(map.get("full_name"))+"-中国工程机械商贸网"  ;
		String keywords = "代理机型,"+CommonString.getFormatPara(map.get("full_name"))+",工程机械" ;
		String description = "中国工程机械商贸网提供"+ CommonString.getFormatPara(map.get("full_name"))+"代理机型栏目，让您对"+CommonString.getFormatPara(map.get("full_name"))+"更加了解，欢迎光临"+CommonString.getFormatPara(map.get("full_name"))+"品牌旗舰店。";
		String catalogname = "" ;
		HashMap catalogMap = (HashMap)application.getAttribute("catalogMap") ;
		if(!"".equals(catalognum)){
			catalogname = CommonString.getFormatPara(catalogMap.get(catalognum)) ;
		}
		if(!"".equals(catalogname)){
			title = catalogname+"_"+catalogname+"价格-"+CommonString.getFormatPara(map.get("full_name"))+"- 中国工程机械商贸网" ;
			keywords = catalogname+","+catalogname+"价格,"+CommonString.getFormatPara(map.get("full_name"))+",工程机械" ;
			description = "中国工程机械商贸网提供"+CommonString.getFormatPara(map.get("full_name"))+"询价系统，让您对"+CommonString.getFormatPara(map.get("full_name"))+catalogname+"更加了解， 欢迎光临"+CommonString.getFormatPara(map.get("full_name"))+"品牌旗舰店。" ;
		}
		// 自定义 seo
		if(!"".equals(CommonString.getFormatPara(map.get("seo_title")))){
			title = CommonString.getFormatPara(map.get("seo_title")) ;
		}
		if(!"".equals(CommonString.getFormatPara(map.get("seo_keyword")))){
			keywords = CommonString.getFormatPara(map.get("seo_keyword")) ;
		}
		if(!"".equals(CommonString.getFormatPara(map.get("seo_desc")))){
			description = CommonString.getFormatPara(map.get("seo_desc")) ;
		}	
		
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/style/shop.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="http://product.21-sun.com/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.form.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<script src="/scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('div,ul,img,li,input,td,a'); 
</script>
<![endif]-->
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
<!--公司名称-->
<div class="sTop01">
  <div class="contain980 h93px">
    <h2 class="companyName"> <%=CommonString.getFormatPara(map.get("full_name"))%><span class="intro"><%=CommonString.getFormatPara(map.get("sub_title")) %></span> </h2>
    <div class="approve">
      <div class="star"><span class="star01"></span></div>
    </div>
  </div>
</div>
<!--公司名称结束--> 
<!--店铺导航-->
<jsp:include page="nav_top.jsp"></jsp:include>
<!--店铺导航结束--> 
<!--主体-->
<div class="shopContain whitebg mb10"> 
  <!--banner-->
  <div class="bannerShow">
  	<%
  		String agentbanner= CommonString.getFormatPara(map.get("agentbanner"));
  		if(!"".equals(agentbanner)&&agentbanner.indexOf("http://")!=-1){
  			agentbanner = agentbanner+"";
  		}else{
  			agentbanner = "http://product.21-sun.com/uploadfiles/"+agentbanner;
  		}
  	%>
    <ul class="imgs">
      <li><img src="<%=agentbanner %>" width="960" height="200" onerror="showImgDelay(this,'http://product.21-sun.com/images/agentshop_logo.jpg',2);"  /></li>
    </ul>
    <ul class="nums" style="display:none;">
      <li value="1" class="cur"></li>
    </ul>
  </div>
  <!--banner end-->
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
        <%
        	String id = CommonString.getFormatPara(map.get("id")) ;
        	String agent_fac= CommonString.getFormatPara(map.get("agent_fac")) ;
        	String agent_fac_name = CommonString.getFormatPara(map.get("agent_fac_name")) ;
        	out.println(CommonHtml.getHTMLByURL("http://product.21-sun.com/action/ajax_list.jsp?flag=brandAgentCatalogListShop&agentid="+id+"&agent_fac="+agent_fac+"&agent_fac_name="+agent_fac_name+"&usern="+usern+"")) ;
        %>
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
          <%=CommonString.getFormatPara(map.get("saleqq")).equals("")?"":"销售QQ："+CommonString.getFormatPara(map.get("saleqq"))+"<br />"%>
          <%=CommonString.getFormatPara(map.get("serviceqq")).equals("")?"":"服务QQ："+CommonString.getFormatPara(map.get("serviceqq"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("fax")).equals("")?"":"传真："+CommonString.getFormatPara(map.get("fax"))+"<br />"%>
               <!--   邮政编码：<%=CommonString.getFormatPara(map.get("postcode"))%><br />  -->
           <%=CommonString.getFormatPara(map.get("address")).equals("")?"":" 地址："+CommonString.getFormatPara(map.get("address"))%> </div>
        </div>
      </div>
      <!--公司资料 结束-->
      
    </div>
    <!--left end--> 
    <!--right-->
    <div class="shopRight"> 
      <!--推荐产品--><!--主营产品-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>代理机型</h2>
        </div>
        <div class="sContent">
          <ul class="slist">
            <%
        List<Map> list = pageBean.getDatas();
        if(list != null && list.size() > 0){
		for(int i = 0;list != null && i < list.size();i++){
    %>
            <li>
              <div class="img"><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_small.gif',2);" width="176px" height="147px" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" /></a></div>
              <h3><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></a></h3>
              <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(list.get(i).get("id")) %>','<%=agentid%>','<%=CommonString.getFormatPara(list.get(i).get("factoryid"))%>')" class="btn">我要询价</a> 
              <!-- <div class="w100 l pt5">
        <div class="star"><span class="star01"></span></div>
        (已有2769人评论) </div>--> 
            </li>
            <%
				}
			}
	  	  %>
          </ul>
        </div>
      </div>
      <%
		if(list != null && list.size() > 0){
	  %>
      <div class="wfull l">
        <div id="pagination" class="page" style="margin-right:10px">
          <tags:page pageBean="<%=pageBean %>" url="/agentshop/agent_products.jsp"/>
        </div>
      </div>
      <%
		}
	  %>
      <!--公司简介--><!--在线询价--></div>
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
</div>
<script type="text/javascript" src="http://product.21-sun.com/scripts/citys.js"></script>
<!--<script type="text/javascript" src="/scripts/agent_banner.js"></script>-->
<script type="text/javascript">
	
	jQuery("#zd_message").text("您好，我对<%=CommonString.getFormatPara(map.get("full_name"))%>的产品感兴趣，想要咨询，请您给我回复，谢谢。");
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		alert("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		alert("请输入正确的电话号码!");
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
				alert("提交成功！") ;
				jQuery("#zd_mobile_phone").val("");
				jQuery("#zd_message").val("");
			}
		}) ;
		return false ;
}

function showinquery(pid,agentid,factoryid){
	jQuery.jBox("iframe:http://product.21-sun.com/include/products/product_order_agent.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName=<%=CommonString.getFormatPara(map.get("name")) %>", {
	title: "在线询价",
	width: 720,
	height: 450,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
	jQuery(function(){
	 jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'<%=CommonString.getFormatPara(map.get("id"))%>'} ,
    	success:function(msg){
    	}
    }) ;
	}) ;
</script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>