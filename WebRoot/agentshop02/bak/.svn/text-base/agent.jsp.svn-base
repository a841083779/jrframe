<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
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
		String agentid = CommonString.getFormatPara(map.get("id"));
		String offset = CommonString.getFormatPara(request.getParameter("offset"));
		String whereStr = " and agent_id = '"+agentid+"' and is_approval = 1 ";
		PageBean pageBean = new PageBean() ; // 分页程序
		pageBean.setPageSize(16) ; // 每页显示条数
		pageBean.setCondition(whereStr.toString()) ;
		
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
<title><%=CommonString.getFormatPara(map.get("full_name"))%>- 代理商旗舰店 - 中国工程机械商贸网</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("full_name"))%>,<%=CommonString.getFormatPara(map.get("city"))%><%=CommonString.getFormatPara(map.get("agent_fac_name"))%>代理" />
<meta name="description" content="中国工程机械商贸网为您提供<%=CommonString.getFormatPara(map.get("full_name"))%>简介、<%=CommonString.getFormatPara(map.get("full_name"))%>代理品牌、<%=CommonString.getFormatPara(map.get("full_name"))%>经营产品及其他详细资料，帮助您全面了解<%=CommonString.getFormatPara(map.get("full_name"))%>。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/shop.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
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
          <div class="intro"> 代理地区：<%=CommonString.getFormatPara(map.get("city"))%> <br />
            代理品牌：<%=CommonString.getFormatPara(map.get("agent_fac_name"))%><br />
            销售电话：<%=CommonString.getFormatPara(map.get("telphone"))%> <br />
            联系人：<%=CommonString.getFormatPara(map.get("concatus"))%><br />
            电子邮件：<a href="mailto:<%=CommonString.getFormatPara(map.get("email"))%>"><%=CommonString.getFormatPara(map.get("email"))%></a><br />
            传真：<%=CommonString.getFormatPara(map.get("fax"))%><br />
            邮政编码：<%=CommonString.getFormatPara(map.get("postcode"))%><br />
            地址：<%=CommonString.getFormatPara(map.get("address"))%> </div>
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
          <h2>企业动态</h2>
        </div>
        <div class="sContent">
            <%
        	List<Map> list = pageBean.getDatas();
        	if(list != null && list.size() > 0){
        		Map news_typeMap = new HashMap() ;
        		   news_typeMap.put("0","企业动态") ;
        		   news_typeMap.put("2","新品推荐") ;
        		   news_typeMap.put("1","产品导购") ;
        		   news_typeMap.put("3","维修保养") ;
        		%>
        		<table width="100%">
        		<tr style="background-color: #F7F7F7;">
        			<th width="60%">标题</th>
        			<th width="20%">动态类型</th>
        			<th width="20%">发布日期</th>
        		</tr>
        		<%
        		Map m = null;
				for(int i = 0;list != null && i < list.size();i++){
					m = list.get(i);
    				%>
    				<tr>
    					<td style="height: 30px; line-height: 30px;"><a href="/news/detail.jsp?id=<%=CommonString.getFormatPara(m.get("id")) %>&t_flag=product"><%=CommonString.getFormatPara(m.get("title")) %></a></td>
    					<td style="text-align: center;"><%=CommonString.getFormatPara(news_typeMap.get(CommonString.getFormatPara(m.get("news_type")))) %></td>
    					<td style="text-align: center;"><%=CommonDate.getFormatDate("yyyy-MM-dd",m.get("pub_date")) %></td>
    				</tr>
    				<%
				}
        		%></table><%
			}
	  	  %>
        </div>
      </div>
      <%
		if(list != null && list.size() > 0){
	  %>
      <div class="wfull l">
        <div id="pagination" class="page" style="margin-right:10px">
          <tags:page pageBean="<%=pageBean %>" url="/agentshop/agent_news.jsp"/>
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
<div class="shopFoot"> <span onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');" style="cursor: pointer;">广告服务</span> | <span onclick="window.open('http://aboutus.21-sun.net/contact/');" style="cursor: pointer;"> 联系方式</span> | <span onclick="window.open('http://aboutus.21-sun.net/');" style="cursor: pointer;"> 关于我们</span> | <span onclick="window.open('http://aboutus.21-sun.net/news/');" style="cursor: pointer;"> 本网动态</span> | <span onclick="window.open('http://aboutus.21-sun.net/contact/legal.jsp');" style="cursor: pointer;">法律声明</span> | <span onclick="window.open('http://aboutus.21-sun.net/map.htm');" style="cursor: pointer;">网站导航</span> | <span onclick="window.open('http://www.21-sun.com/guestbook/index.jsp');" style="cursor: pointer;"> 访问留言</span> <br/>
  主编:<a href="mailto:webmaster@21-sun.com" class="link09" rel="nofollow">webmaster@21-sun.com</a> 　市场部:<a href="mailto:market@21-sun.com" class="link09" rel="nofollow">market@21-sun.com</a>　 技术部:<a href="mailto:tech@21-sun.com" class="link09" rel="nofollow">tech@21-sun.com</a> 　广告部:<a href="mailto:ads@21-sun.com" class="link09" rel="nofollow">ads@21-sun.com</a><br/>
  产品询价专线:0535-6792733 　业务联系:(总机)0535-6722555 　传真:0535-6723239<br/>
  <span onclick="window.open('http://www.21-sun.com');" style="cursor: pointer;">中国工程机械商贸网</span> Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script> 
</div>
<!--foot end-->
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
</body>
<script type="text/javascript" src="/scripts/citys.js"></script>
<!--<script type="text/javascript" src="/scripts/agent_banner.js"></script>-->
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
	jQuery.jBox("iframe:/include/products/product_order_agent.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName=<%=CommonString.getFormatPara(map.get("name")) %>", {
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