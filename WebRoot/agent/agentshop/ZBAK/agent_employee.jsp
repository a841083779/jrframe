<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%
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
		Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
				map.get("id")
			},connection);
		String agentId = CommonString.getFormatPara(map.get("id")) ;  // 代理商 id 
		List<Map> personalList = dbHelper.getMapList("select * from pro_agent_personnel where agent_id=?",new Object[]{agentId}) ;
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
<style>
.companyInfo ul{
  border-bottom: 1px dotted #CCCCCC;float: left;margin-bottom: 10px; padding: 0 0 10px 20px;width: 700px;
}
.companyInfo ul li{
	float:left;   height: 240px;    line-height: 1.5em;    overflow: hidden;    width: 210px;
	}
.companyInfo ul li img {
    border: 1px solid #CCCCCC;
    display: block;
    height: 120px;
    margin-bottom: 5px;
    width: 120px;
}
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
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
  			agentbanner = "/uploadfiles/"+agentbanner;
  		}
  	%>
    <ul class="imgs">
      <li><img src="<%=agentbanner %>" width="960" height="200" onerror="showImgDelay(this,'/images/agentshop_logo.jpg',2);"  /></li>
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
      <!--推荐产品--><!--主营产品--><!--公司简介-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>企业员工</h2>
        </div>
        <div class="sContent companyInfo">
       <ul>
       <%
       	if(null!=personalList && personalList.size()>0){
       		for(Map oneMap:personalList){
       			%>
       	  <li style="float:left;"> 
           <img title="<%=CommonString.getFormatPara(oneMap.get("name")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("name")) %>" src="<%=CommonString.getFormatPara(oneMap.get("img")) %>"/>
            <p>姓名：<%=CommonString.getFormatPara(oneMap.get("name")) %>
            <i class="jiangzhang"></i>
             </p>
            <p>职务：金牌销售顾问</p>
            <p id="tel400Container" name="tel400Container">电话：<span name="tel400Tag" id="tel400Tag"><%=CommonString.getFormatPara(oneMap.get("phone")) %></span></p>
          </li>
       			<%
       		}
       	}
       %>
			</ul>
        </div>
      </div>
      <!--在线询价--></div>
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
  <script type="text/javascript">
  		//主营品牌
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandAgentCatalogListShop","agentid":"<%=CommonString.getFormatPara(map.get("id"))%>","agent_fac":"<%=CommonString.getFormatPara(map.get("agent_fac"))%>","agent_fac_name":"<%=CommonString.getFormatPara(map.get("agent_fac_name"))%>","usern":"<%=usern%>"},
		success:function(data){
			jQuery("#brandId").html(jQuery.trim(data));	
			if(jQuery.trim(data)==""){
				jQuery("#brandId").removeClass("agentLeftPart mb10");	
			}
		}
	});
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
</div>
</body>
<!--<script type="text/javascript" src="/scripts/agent_banner.js"></script>-->
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>