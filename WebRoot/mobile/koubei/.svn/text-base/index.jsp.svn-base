<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
    Connection connection = null;
	Map model = new HashMap();
	DBHelper dbHelper = DBHelper.getInstance();

    StringBuffer whereStr = new StringBuffer(" and id!='' ");
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
		pageBean.setPageSize(6); // 每页显示条数
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
		pageBean.setOrderBy(" add_date desc"); // 点击量排序
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" *");
		pageBean.setTableName("pro_mobile_koubei_list");
		List<Map> koubeiProducts = pageBean.getDatas(connection); // 根据条件查出的产品
		
		
		
		
		
		String catalog1="";
	    
		catalog1=CommonString.getFormatPara(catalogMap.get(catalog));
		String title="";String keyword="";String description="";
		if(catalog.equals("")){
		title="【工程机械产品口碑】口碑大全_优点_缺点 – 铁臂口碑";
		keyword="工程机械产品口碑,工程机械产品口碑大全";
		description="铁臂口碑包含了大量真实用户的工程机械产品口碑,帮助您通过网络了解工程机械产品,买工程机械产品就上铁臂商城。";
		}else{
		title="【"+catalog1+"哪个品牌好?】"+catalog1+"口碑_"+catalog1+"优点缺点投诉 - 铁臂口碑";
		keyword=""+catalog1+"哪个品牌好,"+catalog1+"哪个好,"+catalog1+"口碑,"+catalog1+"";
		description="铁臂口碑包含了大量"+catalog1+"产品口碑，帮助您通过网络了解"+catalog1+"产品怎么样,哪个好,买"+catalog1+"产品就上铁臂商城。";
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
<meta name="description" content="<%=description%>" />
<link href="Static/css/style.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="top.jsp" flush="true"/>
<div class="kb_tab">
	<ul class="fix kb_tab_list">
	<li class="_t1 <%if(catalog.equals("")){%>cur<%}%>"><a href="/web_kb_list.jsp">全部口碑</a></li>
	<li class="_t1 <%if(catalog.equals("101001")){%>cur<%}%>"><a href="/web_kb_list.jsp?catalog=101001<%=factory.equals("")?"":"&factory="+factory%>" >挖掘机</a></li>
    <li class="_t2 <%if(catalog.equals("101002")){%>cur<%}%>"> 
	<a href="/web_kb_list.jsp?catalog=101002<%=factory.equals("")?"":"&factory="+factory%>" >装载机</a></li>
    <li class="_t4 <%if(!catalog.equals("101002")&&!catalog.equals("101001")&&!catalog.equals("")){%>cur<%}%>">
	<a href="javascript:;" class="pointt">其他</a>
	 <div class="box" style="display: none;">
        <a href="/web_kb_list.jsp?catalog=101003<%=factory.equals("")?"":"&factory="+factory%>">推土机</a>
        <a href="/web_kb_list.jsp?catalog=104001<%=factory.equals("")?"":"&factory="+factory%>">摊铺机</a>
        <a href="/web_kb_list.jsp?catalog=107<%=factory.equals("")?"":"&factory="+factory%>">叉车</a>
        <a href="/web_kb_list.jsp?catalog=102<%=factory.equals("")?"":"&factory="+factory%>">起重机</a>
        <a href="/web_kb_list.jsp?catalog=106001<%=factory.equals("")?"":"&factory="+factory%>">压路机</a>
      </div>
	  </li>
	  

    	
    </ul>
</div>
<div class="fix kb_val">
	<ul class="fix kb_nrlist">
	 <%	 
        String orderCount="";
		if (koubeiProducts != null && koubeiProducts.size() > 0) {
			for (Map koubeiMap : koubeiProducts) {
			String vote_id=CommonString.getFormatPara(koubeiMap.get("id"));
			String product_id=CommonString.getFormatPara(koubeiMap.get("product_id"));
			String file_name=CommonString.getFormatPara(koubeiMap.get("file_name"));
			String factoryname=CommonString.getFormatPara(koubeiMap.get("factoryname"));
			String factoryid=CommonString.getFormatPara(koubeiMap.get("factoryid"));
			String catalognum=CommonString.getFormatPara(koubeiMap.get("catalognum"));
			String catalogname=CommonString.getFormatPara(koubeiMap.get("catalogname"));
			String name=CommonString.getFormatPara(koubeiMap.get("name"));//口碑name
			String name1=CommonString.getFormatPara(koubeiMap.get("name1"));//产品name
			String img2=CommonString.getFormatPara(koubeiMap.get("img2"));
			String content=CommonString.getFormatPara(koubeiMap.get("content"));
			if(content.length()>50){
			content=content.substring(0,50);
			}
			
			 String add_date = CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(koubeiMap.get("add_date")));
  %>
    	<li>
		 
        	<div class="_name"><a href="/web_kb_detail.jsp?catalog=<%=catalognum%>&factory=<%=factoryid%>&id=<%=product_id%>" ><%=factoryname%><%=name1%><%=catalogname%></a></div>
            <div class="_canshu fix">
            	<p class="c_namedate"><span class="_t1"><%=name%></span><span class="_t2"><%=add_date%></span></p>
				<%
					model = dbHelper.getMap(" select count(*) as counts from pro_mobile_koubei_list where id = ? ",new Object [] {product_id} , connection);
				%>
                <p class="p_num">评论数（<span><%=CommonString.getFormatPara(model.get("counts"))%></span>）</p>
				
            </div>
            <div class="_sum">
            <%=content%>
            </div>
			 <%
              	String imgSql = "select top 10 * from pro_comments_image where comment_id='"+vote_id+"' and is_show=1";
              	List<Map> imgsList = dbHelper.getMapList(imgSql);
              	if(imgsList!=null && imgsList.size()>0){
              %>
              <div class="_imgl fix">
             
              <% 
              	for(Map m:imgsList){
              		String image = CommonString.getFormatPara(m.get("image"));
              %>
            <p><img src="<%=image%>" alt="<%=name1%>"/></p>
              <%} %>
              </div>
              <%} %>
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
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="brands_list_news.jsp?catalog=<%=catalog%>"><img src="Static/img/fdj_03.png" class="io">品牌</a></div>
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