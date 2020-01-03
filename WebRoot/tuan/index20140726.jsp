<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
    String catalog = CommonString.getFormatPara(request.getParameter("catalog")).toString();
	String factory = CommonString.getFormatPara(request.getParameter("factory")).toString();
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String orderby = CommonString.getFormatPara(request.getParameter("orderby"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("ton"));
	String agent_area = CommonString.getFormatPara(request.getParameter("agent_area"));

	
	String orderStr="order_no desc,id desc";
    DBHelper dbHelper = DBHelper.getInstance();
	String province = "";
	String city = "";
	String ip  = Common.getIp(request);

	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String objStr = Tools.getMyProvinceAndCity(ip);
		JSONObject obj = new JSONObject(objStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
    StringBuffer whereStr = new StringBuffer(" and is_show=1");
	if (!"".equals(catalog)&&!catalog.equals("other")) {
			whereStr.append(" and pro_catanum like '%" + catalog + "%'");
	}
	if (catalog.equals("other")) {
			whereStr.append(" and (pro_catanum not like '101001%' and pro_catanum not like '101002%' and  pro_catanum not like '106001%' and pro_catanum not like '103%' and pro_catanum not like '113001%') ");
	}
	if (!"".equals(factory)) {  
			whereStr.append(" and pro_factoryid=" + factory);
	}
	//地区
	if (!"".equals(agent_area)) {  
			whereStr.append("  and agent_area like '%"+agent_area+"%' or  agent_area like '%全国%' ");
	}
	
	//吨位
	if (tonandmeter.equals("big")) {
			whereStr.append(" ");
	}
	if (tonandmeter.equals("mid")) {
			whereStr.append(" ");
	}
	if (tonandmeter.equals("small")) {
			whereStr.append(" ");
	}
	//顺序
	if ("sell".equals(orderby)) {  
			orderStr="view_count desc";
	}
	if ("price".equals(orderby)) {  
			orderStr="pro_start_price desc";
	}
	if ("date".equals(orderby)) {  
			orderStr="add_date desc";
	}
	if (!"catalog".equals("")) {  
			orderStr="catanum_no desc";
	}
	
	PageBean pageBean = new PageBean(); // 分页程序
	pageBean.setPageSize(32); // 每页显示条数
	pageBean.setCondition(whereStr.toString());
	Integer nowPage = 1;
	if("".equals(offset) || Integer.parseInt(offset)<=0){
		offset = "0" ;
	}
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	pageBean.setNowPage(nowPage);
	String url = CommonString.getFormatPara(request.getQueryString());
	if (!"".equals(url)) {
		if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
			url = "";
		} else if (url.indexOf("offset") != -1) {
			url = "&" + url.substring(url.indexOf("&") + 1);
		} else {
			url = "&" + url;
		}
	}
	pageBean.setParams(url);
	pageBean.setIsShowSql(false);
	pageBean.setFields("*");
	pageBean.setTableName("pro_ymt_activity");
	pageBean.setOrderBy(orderStr); 

	//左侧品牌
	 List<Map> list = dbHelper.getMapList(" select factoryname,factoryid  from pro_ymt_activity where is_show=1 and factoryname!='' group by factoryname,factoryid ",connection) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>优买团</title>
<meta name="keywords" content="装载机,挖掘机优惠促销，工程机械优惠活动" />
<meta name="description" content="装载机,挖掘机，工程机械促销,买工程机械就来铁臂商城4006-521-526" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>

<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<jsp:include page="/tuan/top_index.jsp" flush="true"/>
<div class="nav">
	<ul class="wrap">
    	<li class="quick">快速导航</li>
    	<li><a href="index.jsp">首页</a></li>
        <li><a href="index.jsp?catalog=101001">挖掘机</a></li>
        <li><a href="index.jsp?catalog=101002">装载机</a></li>
        <li><a href="part.jsp" target="_blank">配件</a></li>
        <li><a href="index.jsp?catalog=113001">破碎锤</a></li>
        <li><a href="index.jsp?catalog=other">其他设备</a></li>
        <li><a href="http://koubei.21-sun.com" target="blank">铁臂口碑</a></li>
        <li><a href="activity.jsp">专题活动</a></li>
    </ul>
</div>
<div class="homeCon wrap">
	<div class="h_left">
    	<ul class="subNav">
        	<li class="l1"><a href="index.jsp?catalog=101001"><i class="ico ic0"></i>挖掘机<em>Excavator</em></a>
            	<dl class="menu">
                	<dt>品牌：</dt>
					<%
					
					for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
						String factoryname=(String)CommonString.getFormatPara(m.get("factoryname"));
						String factoryid=(String)CommonString.getFormatPara(m.get("factoryid"));
					%>
					
                    <dd><a href="index.jsp?factory=<%=factoryid%>&catalog=101001"><%=factoryname%></a></dd>
					<%}%>
                </dl>
            </li>
            <li class="l2"><a href="index.jsp?catalog=101002"><i class="ico ic2"></i>装载机<em>Loaders</em></a>
            	<dl class="menu">
                	<dt>品牌：</dt>
					<%
					
					for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
						String factoryname=(String)CommonString.getFormatPara(m.get("factoryname"));
						String factoryid=(String)CommonString.getFormatPara(m.get("factoryid"));
					%>
                    <dd><a href="index.jsp?factory=<%=factoryid%>&catalog=101002"><%=factoryname%></a></dd><%}%>

                </dl>
            
            </li>
            <li class="l3"><a href="index.jsp?catalog=106001"><i class="ico ic3"></i>压路机<em>Roller</em></a>
            <dl class="menu">
                	<dt>品牌：</dt>
					<%
					
					for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
						String factoryname=(String)CommonString.getFormatPara(m.get("factoryname"));
						String factoryid=(String)CommonString.getFormatPara(m.get("factoryid"));
					%>
                    <dd><a href="index.jsp?factory=<%=factoryid%>&catalog=106001"><%=factoryname%></a></dd><%}%>
           
                </dl>
            </li>
            <li class="l4"><a href="index.jsp?catalog=103"><i class="ico ic4"></i>混凝土<em>Concrete</em></a>
            <dl class="menu">
                	<dt>品牌：</dt>
					<%
					
					for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
						String factoryname=(String)CommonString.getFormatPara(m.get("factoryname"));
						String factoryid=(String)CommonString.getFormatPara(m.get("factoryid"));
					%>
                    <dd><a href="index.jsp?factory=<%=factoryid%>&catalog=103"><%=factoryname%></a></dd><%}%>
 
                </dl>
            
            </li>
            <li class="l5"><a href="part.htm" target="_blnk"> <i class="ico ic5"></i>配件<em>Parts</em></a>
            	<dl class="menu">
  
                </dl>
            </li>
            <li class="l6"><a href="index.jsp?catalog=113001"><i class="ico ic6"></i>破碎锤<em>Breaker</em></a>
            <dl class="menu">
                	<dt>品牌：</dt>
					<%
					
					for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
						String factoryname=(String)CommonString.getFormatPara(m.get("factoryname"));
						String factoryid=(String)CommonString.getFormatPara(m.get("factoryid"));
					%>
                    <dd><a href="index.jsp?factory=<%=factoryid%>&catalog=113001"><%=factoryname%></a></dd><%}%>
                </dl>
            </li>
            <li class="l7"><a href="index.jsp?catalog=other"><i class="ico ic7"></i>其他设备<em>Other</em></a>
            <dl class="menu">
          
             </dl>
            </li>
            <li class="l8"><a href="http://m.product.21-sun.com/"><i class="ico ic8"></i>手机app</a>
			       <dl class="menu">
                          
             </dl>
			 </li>
        </ul>
        <dl class="h_left_mid" id="fw">
        	<dt>我们的服务</dt>
            <dd><em>服务顾问：</em><br />解答用户购买设备的疑惑</dd>
             <dd><em>优惠专家：</em><br />为用户争取最优惠的购机价格</dd>
              <dd><em>6S认证：</em><br />为您提供正规代理商渠道，放心
购机。</dd>
        </dl>
        <div class="img"><img src='images/tel2.gif'/></div>
    </div>
	<div style="margin-top: 10px;"><a href="http://product.21-sun.com/activity/rongrun/index.jsp" target="_blank"><img src="images/rrhf.jpg" style="padding-left: 17px;"></a></div>
 	<div class="h_right">
	
	    <%if(catalog.equals("")){%>

        <div class="opt mt10">
        	<a href="?orderby=normal<%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("normal")||orderby.equals("")){%>class="active"<%}%>>默认</a>
            <!--<a href="?orderby=sell<%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("sell")){%>class="active"<%}%>>销量</a>-->
            <a href="?orderby=price<%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("price")){%>class="active"<%}%>>价格</a>
            <a href="?orderby=date<%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("date")){%>class="active"<%}%>>最新</a>
         <span><a href="#fw"><i class="ico ic1"></i>我们能为客户提供什么？</a></span>  
        </div>
		
		
		<div class="order">
        	<div class="l"><span style="width:60px">合作伙伴：</span>
              <div class="label">
                  <a href="index.jsp" <%if(factory.equals("")){%>class="cur"<%}%> >全部</a>
				  <%
					
					for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
						String factoryname=(String)CommonString.getFormatPara(m.get("factoryname"));
						String factoryid=(String)CommonString.getFormatPara(m.get("factoryid"));
					%>
                  <a href="index.jsp?factory=<%=factoryid%>" <%if(factoryid.equals("174")){%>class="cur"<%}%> ><%=factoryname%></a>
                 <%}%>
              </div>
              <div class="pbtn"></div> 
            </div>
            <div class="l"><span style="width:60px">按类型：</span>
             <div class="label">
            <a href="index.jsp<%=factory.equals("")?"":"?factory="+factory%>" class="cur">全部</a>
            <a href="index.jsp?catalog=101001" >挖掘机</a>
            <a href="index.jsp?catalog=101002" >装载机</a>
            <a href="index.jsp?catalog=106001" >压路机</a>
			<a href="index.jsp?catalog=103" >混凝土</a>
            <a href="index.jsp?catalog=113001" >破碎锤</a>

            </div>
            </div>
        </div>
		
		<%}else{%>
		<div class="opt mt10">
        	<a href="?orderby=normal<%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("normal")||orderby.equals("")){%>class="active"<%}%>>默认</a>
          <!--  <a href="?orderby=sell<%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("sell")){%>class="active"<%}%>>销量</a>-->
            <a href="?orderby=price<%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("price")){%>class="active"<%}%>>价格</a>
            <a href="?orderby=date<%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%>" <%if(orderby.equals("date")){%>class="active"<%}%>>最新</a>
         <span><i class="ico ic1"></i>我们能为客户提供什么？</span>   
        </div>
		
		
		<%if(!catalog.equals("")){%>
		
		
		
		<jsp:include page="/tuan/select.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=orderby%>" name="orderby"/>
			<jsp:param value="<%=factory%>" name="factory"/>
        </jsp:include> 
		
		<%}%>
		
		
		
		
		
		<%}%>
		
		
        <ul class="hlist">
		<%List<Map> activities = pageBean.getDatas(connection); 
            if (activities != null && activities.size() > 0) {
				for (Map oneMap : activities) {
		%>
		<li> 
		<%
		if(CommonString.getFormatPara(oneMap.get("pro_type")).equals("0")){
		%>
		<a target="_blank" href="detail.jsp?id=<%=CommonString.getFormatPara(oneMap.get("id")) %>">
		<%}else{%>
			<a target="_blank" href="detail_dan.jsp?id=<%=CommonString.getFormatPara(oneMap.get("id")) %>">
		<%}%>
		<img width="371" height="212" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a>
		<h3>
		<%if(CommonString.getFormatPara(oneMap.get("flag")).equals("2")){%>
		<%=CommonString.getFormatPara(oneMap.get("factoryname")) %>
		<%}%>
		<%=CommonString.getFormatPara(oneMap.get("title")) %></h3>
		<div class="price">
		<%if(!CommonString.getFormatPara(oneMap.get("pro_start_price")).equals("0")&&!CommonString.getFormatPara(oneMap.get("pro_end_price")).equals("0")){%>
		<span>参考价格：<b><%=CommonString.getFormatPara(oneMap.get("pro_start_price"))%>万<!--<%=CommonString.getFormatPara(oneMap.get("pro_end_price"))%>万--></b></span>
		<%}else{%>
		<span class="t">拨打热线电话询最低价</span>
		<%}%>
		<%
		if(CommonString.getFormatPara(oneMap.get("pro_type")).equals("0")){
		%>
	<a target="_blank" href="detail.jsp?id=<%=CommonString.getFormatPara(oneMap.get("id")) %>" class="btn"></a>
		<%}else{%>
		<a target="_blank" href="detail_dan.jsp?id=<%=CommonString.getFormatPara(oneMap.get("id")) %>" class="btn"></a>
		<%}%>
		
		</div>
		</li>
		<% }} else { %>
							暂无相关信息
		<%}%>
        </ul>
    </div>
</div>
<div class="brand">
	<div class="wrap">
    	<div class="img"><img src='images/br.gif'/></div>
        <a href="http://product.21-sun.com/cat/" target='_blank'><img src='images/br1.jpg'/></a> 
        <a href="http://product.21-sun.com/brandshop/cql/" target='_blank'><img src='images/br2.jpg'/></a> 
        <a href="http://product.21-sun.com/agent/shcj/" target='_blank'><img src='images/br3.jpg'/></a>
        <a href="http://product.21-sun.com/tuan/doosan_ganen/index.htm" target='_blank'><img src='images/br4.jpg'/></a> 
        <a href="http://product.21-sun.com/tuan/juhe/" target='_blank'><img src='images/br5.jpg'/></a> 
        <a href="http://product.21-sun.com/agentstore/hfxy/" target='_blank'><img src='images/br6.jpg'/></a>
        <a href="http://syzl.product.21-sun.com/" target='_blank'><img src='images/br7.jpg'/></a>
        <a href="http://product.21-sun.com/brand/xcmg/" target='_blank'><img src='images/br8.jpg'/></a>
        <a href="http://product.21-sun.com/brandshop/lovol/" target='_blank'><img src='images/br9.jpg'/></a> 
        <a href="http://product.21-sun.com/agent/rongrun/" target='_blank'><img src='images/br10.jpg'/></a> 
        <a href="http://product.21-sun.com/agent/gztc/" target='_blank'><img src='images/br11.jpg'/></a>
        <a href="http://product.21-sun.com/agent/scsh/" target='_blank'><img src='images/br12.jpg'/></a> 
        <a href="http://product.21-sun.com/brand/htzg/" target='_blank'><img src='images/br13.jpg'/></a> 
        <a href="http://product.21-sun.com/brand/bd70/" target='_blank'><img src='images/br14.jpg'/></a> 
        <a href="http://product.21-sun.com/brandshop/dlgb/index.jsp" target='_blank'><img src='images/br15.jpg'/></a> 
        <a href="http://product.21-sun.com/tuan/junheng/index.html" target='_blank'><img src='images/br16.jpg'/></a>
        <a href="#" target='_blank'><img src='images/br17.jpg'/></a>
        <a href="http://product.21-sun.com/brandshop/johndeere/" target='_blank'><img src='images/br18.jpg'/></a>
    </div>
</div>
<div class="bottom">
	<div class="wrap">
	<span class="l">中国工程机械商贸网 Copyright © 2000-2014 </span>	
    <div class="r">客服：9:00-21:00<em>|</em>4006-521-526</div>
    </div>
 </div>
 <script type="text/javascript" src="scripts/comm.js"></script>
 <script>
 var nameArr=['卡特彼勒308E挖掘机','山工ZL50F-II装载机','山推SL50W装载机','合肥湘元SY55-SY60','斗山感恩回馈-大型让利促销','工兵破碎锤-水山破碎锤销售','龙工全系产品优惠促销','湖南中旺三一C9系列2013款SY60C-9挖掘机','陕西徐工XE60CA挖掘机购机均赠送破碎锤一台','烟台宏通三一C9系列2013款SY65C-9挖掘机','神娃SW60-7履带挖掘机','永弘集团斗山DH55GOLD挖掘机','临沂亚华三一C9系列2013款SY75C-9挖掘机','烟台普堃江麓CN70-6挖掘机','南京力好三一C9系列2013款SY95C-9挖掘机','重庆国杰三一C9系列2013款SY75C-9挖掘机','广州巨和三一C9系列2013款SY205C-9挖掘机','吉林三君三一C9系列2013款SY215C-9挖掘机','新疆京泓三一C9系列2013款SY225C-9挖掘机','广西山宁三一C9系列2013款SY235C-9挖掘机','XE80C两款机型购机均赠送破碎锤一台',"山东骏大现代R225LC-9T挖掘机","江苏福仁中联重科ZE85E挖掘机","江西驰恒福田雷沃FR80H挖掘机","北京徐工海虹徐工LW500K-LNG挖掘机","上海成基小松PC200-8M0液压挖掘机","江西小松PC200LC-8M0液压挖掘机","四川盛和三一C9系列2013款SY225C-9挖掘机","贵州通程兄弟三一C9系列2013款SY265C-9挖掘机","浙江成峰三一C9系列2013款SY305C-9H挖掘机","三一众力三一C9系列2013款SY365H-9挖掘机","河南山推SD16-3CE履带推土机","恒特重工恒久品质，特别奉献","宝鼎挖掘机优惠促销","赤峰恒工机械恒特恒特HT80-9挖掘机","贵州嘉龙龙工LG818D轮式装载机","湖南嘉龙龙工LG855D轮式装载机","湖南嘉龙龙工LG818D轮式装载机","河北迈威斗山DH500LC-7挖掘机","广西韩山斗山DH60-7挖掘机","广西松宇斗山DH55GOLD挖掘机","广西松宇加藤HD1023R挖掘机","广西松宇柳工CLG877Ⅲ轮式装载机","贵州松宇斗山DX150LC挖掘机","福建山重JCM906D挖掘机","重庆永集才龙工LG6085挖掘机","厦门尧鼎厦工XG836LC挖掘机","友一机械FAYL-850座驾式压路机","广西千里通机械设备柳工CLG907D挖掘机","广西千里通柳工机械营销柳工CLG842轮式装载机","广西加藤HD1638R挖掘机","广州加藤HD1023R挖掘机","云南加藤HD2048R挖掘机","贵州加藤HD820V挖掘机","湖北柳通柳工915D挖掘机","四川汇发成工装载机","四川汇发神钢挖掘机"];
 var urlArr=["http://product.21-sun.com/cat/","http://product.21-sun.com/brandshop/cql/","http://product.21-sun.com/brandshop/shantui/","http://product.21-sun.com/agentstore/hfxy/","http://product.21-sun.com/tuan/doosan_ganen/index.htm","http://product.21-sun.com/brandshop/dlgb/index.jsp","http://product.21-sun.com/brandshop/longgong/","http://product.21-sun.com/agent/hnzw/","http://product.21-sun.com/agent/sxzljx/","http://ytht.product.21-sun.com/","http://product.21-sun.com/brand/qzsw/","http://product.21-sun.com/agent/sdyh/","http://jh.product.21-sun.com/","http://pukun.product.21-sun.com/","http://product.21-sun.com/agent/lhjx/","http://product.21-sun.com/brandshop/gjjx/","http://product.21-sun.com/brandshop/gjjx/","http://product.21-sun.com/agent/jlsj123/","http://jh.product.21-sun.com/","http://product.21-sun.com/agent/guangxisn/","http://product.21-sun.com/agent/sxzljx/","http://product.21-sun.com/agentstore/shandongjunda/","http://product.21-sun.com/agent/wxfuren/","http://product.21-sun.com/agent/jxch/","http://product.21-sun.com/agent/bjhaihong/","http://product.21-sun.com/agent/shcj/","http://product.21-sun.com/agent/jxxiaosong/","http://product.21-sun.com/agent/scsh/","http://product.21-sun.com/agent/gztc/","http://dingfengjixie.product.21-sun.com/","http://syzl.product.21-sun.com/","http://product.21-sun.com/agent/hnshantui/","http://product.21-sun.com/brand/htzg/","http://product.21-sun.com/brand/htzg/","http://product.21-sun.com/agent/cfhg/","http://product.21-sun.com/agent/gzjljx/","http://hnjl.product.21-sun.com/","http://hnjl.product.21-sun.com/","http://product.21-sun.com/agent/myway/","http://product.21-sun.com/agent/hanshanjx/","http://product.21-sun.com/agent/gxsy/","http://product.21-sun.com/agent/gxsy/","http://product.21-sun.com/agent/gxsy/","http://product.21-sun.com/agent/gzsongyu/","http://product.21-sun.com/brandshop/fjjcm/","http://product.21-sun.com/proDetail/LG6085.shtm","http://product.21-sun.com/agent/xiamenyaoding/","http://product.21-sun.com/brand/youyi/","http://product.21-sun.com/agent/gxqltsb/","http://product.21-sun.com/agent/qianlitong/","http://product.21-sun.com/agent/guangxijiateng/","http://product.21-sun.com/agent/guangzhoujiateng/","http://product.21-sun.com/agent/yunnanjiateng/","http://product.21-sun.com/agent/gzjiateng/","http://product.21-sun.com/agent/liutong/","http://product.21-sun.com/agentshop03/sichuanhuifa/","http://product.21-sun.com/agentshop03/sichuanhuifa/"];
//  console.log(nameArr.length)
 	$(function(){
	  for(var i=1;i<58;i++)
	  {
	   if(i==9){
			//$('.hlist').append("<li> <a href="+urlArr[i-1]+"><img src=images/img/"+String(i)+".jpg /></a><h3>"+nameArr[i-1]+"</h3><div class='price'><span>参考价格：<b>36万</b></span><a href="+urlArr[i-1]+" class='btn'></a></div></li>")
			//return;
		}else if(i==21){
			//$('.hlist').append("<li> <a href="+urlArr[i-1]+"><img src=images/img/"+String(i)+".jpg /></a><h3>"+nameArr[i-1]+"</h3><div class='price'><span>参考价格：<b>49万</b></span><a href="+urlArr[i-1]+" class='btn'></a></div></li>")
		}else{
		
	//$('.hlist').append("<li> <a href='"+urlArr[i-1]+"'><img src=images/img/"+String(i)+".jpg /></a><h3>"+nameArr[i-1]+"</h3><div class='price'><span class='t'>拨打热线电话询最低价</span><a href="+urlArr[i-1]+" class='btn'></a></div></li>")		
		}
	  }
	})
 
 </script>
 
 
 
 
 <div class="n_tools">
  <ul>
    <li class="nt06"><a href="javascript:void(0);" class="gotop"><i></i><span class="te">返回顶部</span></a></li>
  </ul>
</div>
<script type="text/javascript">
$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
$('.pbtn').click(function(){
	if($(this).hasClass('pbon')){
		$(this).removeClass('pbon');
		$(this).prev('.label').removeAttr('style');
	}else{
		$(this).addClass('pbon');
		$(this).prev('.label').css('height','auto');
	}
})
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>