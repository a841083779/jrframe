<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
Map memberInfo = (Map)session.getAttribute("memberInfo");
	String user_name = "";
	if(memberInfo != null){
		user_name = CommonString.getFormatPara(memberInfo.get("username"));
	}
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
    String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
    Connection connection = null;
	Map model = new HashMap();
	DBHelper dbHelper = DBHelper.getInstance();

    StringBuffer whereStr = new StringBuffer(" and  id!='' ");
	
	if (!"".equals(user_name)) {  
			whereStr.append(" and username like '%"+user_name+"%' ");
	}
	System.out.println(whereStr);
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
%><!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<meta content="" name="Keywords">
<meta content="" name="Description">
<title>index</title>
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="apple-mobile-web-app-title" content="Web Starter Kit">
<link rel="apple-touch-icon" href="/web/img/apple-touch-icon.png" />
<link rel="apple-touch-startup-image" href="/web/img/screen.png" />
<meta name="format-detection" content="telephone=no">
<meta name="author" content="design by www.21-sun.com">
<link href="../web/css/style.css" rel="stylesheet" />
<!--[if lt IE 9]><script src="../web/lib/H5shiv.js"></script><![endif]-->
</head>
<body class="body_bottom">
<jsp:include page="top.jsp" flush="true"></jsp:include>
<div class="kba_nav">
	<ul class="fix">
    	<li><a href="index.jsp">首页</a></li>
        <li><a href="guize.jsp">活动规则</a></li>
        <li><a href="jiangpin.jsp">活动奖品</a></li>
        <li><a href="index_lg.jsp">柳工专区</a></li>
    </ul>
</div>
<div class="kba_fbwz">我的口碑</div>
<div class="kba_kblist">
	<ul class="fix">
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
			String username=CommonString.getFormatPara(koubeiMap.get("username"));//口碑name
			String content=CommonString.getFormatPara(koubeiMap.get("content"));//口碑name
			String name1=CommonString.getFormatPara(koubeiMap.get("name1"));//产品name
			String img2=CommonString.getFormatPara(koubeiMap.get("img2"));
			String name=CommonString.getFormatPara(koubeiMap.get("name"));
			if(username.equals("")){
			username=name;
			}
			if(content.length()>50){
			content=content.substring(0,50);
			}
			
			 String add_date = CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(koubeiMap.get("add_date")));
  %>
    	<li>
        	<a href="/web_kb_detail.jsp?id=<%=vote_id%>" title="<%=factoryname%><%=name1%><%=catalogname%>">
        	<div class="kba_topt fix">
            	<div class="kb_title"><%=factoryname%><%=name1%><%=catalogname%></div>
                <span class="kb_date"><%=add_date%></span>
            </div>
            <div class="kba_sum"><%=content%></div>
            <div class="kba_img"> <%
              	String imgSql = "select top 10 * from pro_comments_image where comment_id='"+vote_id+"' and is_show=1";
              	List<Map> imgsList = dbHelper.getMapList(imgSql);
              	if(imgsList!=null && imgsList.size()>0){
              	for(Map m:imgsList){
              		String image = CommonString.getFormatPara(m.get("image"));
              
              %>
            	<img src="<%=image%>" alt="<%=name1%>"/>
                <%}}%>
            </div>
            </a>
        </li>
        <%}}%>
    </ul>
</div>
<div class="kba_page">
	
    <tags:page_mobile pageBean="<%=pageBean%>" />

</div>
<!--foot-->
<jsp:include page="foot.jsp" flush="true"></jsp:include>
<!--foot end-->
</body>
<script src="../modules/seajs/sea.js" id="seanode" ></script>
<script src="../web/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('../web/app/guize.js')
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>