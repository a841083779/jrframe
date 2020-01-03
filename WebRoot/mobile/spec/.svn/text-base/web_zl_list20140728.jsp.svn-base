<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
    StringBuffer whereStr = new StringBuffer(" and is_show=1");
	if("".equals(catalog)&&"".equals(factory)&&"".equals(offset)){
	catalog="101001";
	}
	
	if (!"".equals(catalog)) {
	       
			whereStr.append(" and catalognum like '" + catalog + "%'");
			//catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
	}
	if (!"".equals(factory)) {  
			whereStr.append(" and factoryid=" + factory);
	}
	try{
	    connection = dbHelper.getConnection();
		
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(12); // 每页显示条数
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
		pageBean.setOrderBy(" view_count desc"); // 点击量排序
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum,price_start,price_end,view_count");
		pageBean.setTableName("pro_products");
		List<Map> searchProducts = pageBean.getDatas(connection); // 根据条件查出的产品
		
		//TDK
		String factory1=CommonString.getFormatPara(brandMap.get(factory));
		String catalog1=CommonString.getFormatPara(catalogMap.get(catalog));
		String title="";String keyword="";String description="";
		
		
		
		if(!catalog.equals("")){
		title="【"+factory1+""+catalog1+"】"+factory1+""+catalog1+"价格表_"+factory1+""+catalog1+"型号大全 - "+catalog1+"专栏";
        keyword=""+factory1+""+catalog1+","+factory1+""+catalog1+"价格表,"+factory1+""+catalog1+"型号大全,"+factory1+""+catalog1+"大全";
        description=""+factory1+""+catalog1+","+factory1+""+catalog1+"专栏为您提供最新的"+factory1+""+catalog1+"价格表,"+factory1+""+catalog1+"型号大全,买"+factory1+""+catalog1+"就上铁臂商城";
        }else  if(!catalog.equals("")){
		title="【"+catalog1+"】"+catalog1+"价格表_"+catalog1+"型号大全 - "+catalog1+"专栏";
        keyword=""+catalog1+","+catalog1+"价格表,"+catalog1+"型号大全,"+catalog1+"大全";
        description=""+catalog1+","+catalog1+"专栏为您提供最新的"+catalog1+"价格表,"+catalog1+"型号大全,买"+catalog1+"就上铁臂商城";
		}else if(!factory.equals("")){
		title="【"+factory1+"】"+factory1+"价格表_"+factory1+"型号大全 - "+factory1+"专栏";
        keyword=""+factory1+","+factory1+"价格表,"+factory1+"型号大全,"+factory1+"大全";
        description=""+factory1+","+factory1+"专栏为您提供最新的"+factory1+"价格表,"+factory1+"型号大全,买"+factory1+"就上铁臂商城";
		}else{
		title="挖掘机_装载机_挖掘机专栏";
        keyword="挖掘机价格表，装载机价格表，工程机械，挖掘机，装载机，起重机，破碎锤，混凝土机械 ";
        description="挖掘机专栏为您提供挖掘机、装载机、起重机、破碎锤、路面机械、混凝土机械等挖掘机价格表、型号大全、二手、参数等信息，同时也为您提供最新的挖掘机报价。";

		}
%><!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title><%=title%></title>
<meta name="keywords" content="<%=keyword%>" />
<meta name="description" content="<%=description%>"/>


<link href="Static/css/style.css" rel="stylesheet" />
</head>
<body class="zlbg">
<header>
  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a href="javascript:history.back()" class="bc"><img src="Static/img/back.png"></a>
  <a href="brands_list.jsp?catalog=<%=catalog%>" class="search">筛选<img src="Static/img/search_ico.png"></a>
</header>

<nav>
<ul>
	   <li><a href="/web_zl_list.jsp?catalog=101001<%=factory.equals("")?"":"&factory="+factory%>" <%if(catalog.equals("101001")){%>class="cur"<%}%>>挖掘机</a></li>
    <li><a href="/web_zl_list.jsp?catalog=101002<%=factory.equals("")?"":"&factory="+factory%>" <%if(catalog.equals("101002")){%>class="cur"<%}%>>装载机</a></li>
    <li><a href="/web_zl_list.jsp?catalog=113001<%=factory.equals("")?"":"&factory="+factory%>" <%if(catalog.equals("101005")){%>class="cur"<%}%>>破碎锤</a></li>
    <li class="more"><span class="n">更多</span>
      <div class="box">
        <a href="/web_zl_list.jsp?catalog=104<%=factory.equals("")?"":"&factory="+factory%>">路面机械</a>
        <a href="/web_zl_list.jsp?catalog=103<%=factory.equals("")?"":"&factory="+factory%>">混凝土</a>
        <a href="/web_zl_list.jsp?catalog=107<%=factory.equals("")?"":"&factory="+factory%>">搅拌站</a>
        <a href="/web_zl_list.jsp?catalog=105<%=factory.equals("")?"":"&factory="+factory%>">桩工</a>
        <a href="/web_zl_list.jsp?catalog=102<%=factory.equals("")?"":"&factory="+factory%>">起重机</a>
      </div>
    </li>
    </ul>
 
</nav>
<div class="zl_val">
	<ul class="fix zl_list">
	 <%	 
        String orderCount="";
		if (searchProducts != null && searchProducts.size() > 0) {
			for (Map oneMap : searchProducts) {
			String id=CommonString.getFormatPara(oneMap.get("id"));
			String file_name=CommonString.getFormatPara(oneMap.get("file_name"));
			String factoryname=CommonString.getFormatPara(oneMap.get("factoryname"));
			String catalogname=CommonString.getFormatPara(oneMap.get("catalogname"));
			String name=CommonString.getFormatPara(oneMap.get("name"));
			String img2=CommonString.getFormatPara(oneMap.get("img2"));
			String content=CommonString.getFormatPara(oneMap.get("content"));
			if(content.length()>50){
			content=content.substring(0,50);
			}
			//String pubDateOne=CommonString.getFormatDatea("yyyy-MM-dd",oneMap.get("add_date"));
			String price_start=CommonString.getFormatPara(oneMap.get("price_start"));
			String price_end=CommonString.getFormatPara(oneMap.get("price_end"));
  %>
    	<li>
        	<div class="_border">
        		<div class="_img"><a href="/proDetail/<%=file_name%>"><img width="256" height="171" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  src="/uploadfiles/<%=img2%>" alt=""/></a></div>
                <div class="_pname"><a href="/proDetail/<%=file_name%>"><%=factoryname%>-<%=name%>-<%=catalogname%></a></div>
                <div class="_price">参考价格表：
				<%if(CommonString.getFormatPara(oneMap.get("price_start")).equals("0")&&CommonString.getFormatPara(oneMap.get("price_end")).equals("0")){%>
	           <font>面议</font>
	            <%}else{%>
	           <span><%=price_start%>-<%=price_end%>万</span>
	            <%}%>
				</div>
                <div class="_gnbtn fix">
                	<a href="tel:4006-521-526" class="_b1"><img src="Static/img/btn_tel.png"/> 询问底价</a>
                    <a href="/proDetail/<%=file_name%>#00c" class="_b2" target="_blank"><img src="Static/img/btn_buy.png"/> 订购</a>
                </div>
            </div>
        </li>
      <%}}%>
    </ul>
	<div class="paging">
    <tags:page_mobile pageBean="<%=pageBean%>" />

</div>
</div>
<script type="text/javascript" src="modules/jquery.min.js"></script>
<script type="text/javascript" src="Static/js/app/validator.js"></script>
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="/mobile/web_kb_list.jsp" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="http://m.koubei.21-sun.com/" target="_blank"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
	
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>