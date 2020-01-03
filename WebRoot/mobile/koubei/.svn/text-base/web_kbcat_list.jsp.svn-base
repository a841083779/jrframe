<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map model = new HashMap();
    Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	
    StringBuffer whereStr = new StringBuffer(" and id!='' ");
	if (!"".equals(catalog)) {
			whereStr.append(" and catalognum like '" + catalog + "%'");
			
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
		pageBean.setOrderBy(" add_date desc"); // 时间排序
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" *");
		pageBean.setTableName("pro_mobile_koubei_list");
		List<Map> koubeiProducts=null;
		koubeiProducts= pageBean.getDatas(connection); // 根据条件查出的产品
		
		
		
		
//TDK
		String factory1=CommonString.getFormatPara(brandMap.get(factory));
		String catalog1=CommonString.getFormatPara(catalogMap.get(catalog));
		String title="";String keyword="";String description="";
		if(!factory.equals("")&&!catalog.equals("")){
		title="【"+factory1+""+catalog1+"怎么样?】"+factory1+""+catalog1+"口碑_"+factory1+""+catalog1+"优点缺点投诉 - 铁臂口碑";
        keyword=""+factory1+""+catalog1+"哪个好,"+factory1+""+catalog1+"口碑,"+catalog1+"";
        description="铁臂口碑包含了大量"+factory1+""+catalog1+"产品口碑,帮助您通过网络了解"+factory1+""+catalog1+"产品怎么样,哪个好,买"+factory1+""+catalog1+"产品就上铁臂商城。";

		}else if(factory.equals("")&&!catalog.equals("")){
		title="【"+catalog1+"怎么样?】"+catalog1+"口碑_"+catalog1+"优点缺点投诉 - 铁臂口碑";
        keyword=""+catalog1+"哪个好, "+catalog1+"口碑, "+catalog1+"";
        description="铁臂口碑包含了大量"+catalog1+"产品口碑,帮助您通过网络了解"+catalog1+"产品怎么样,哪个好,买"+catalog1+"产品就上铁臂商城。";
		}else if(catalog.equals("")&&!factory.equals("")){
		title="【"+factory1+"怎么样?】"+factory1+"口碑_"+factory1+"优点缺点投诉 - 铁臂口碑";
        keyword=""+factory1+"哪个好,"+factory1+"口碑,"+catalog1+"";
        description="铁臂口碑包含了大量"+factory1+"产品口碑,帮助您通过网络了解"+factory1+"产品怎么样,哪个好,买"+factory1+"产品就上铁臂商城。";
		}else{
		title="【工程机械产品口碑】口碑大全_优点_缺点 – 铁臂口碑";
		keyword="工程机械产品口碑,工程机械产品口碑大全";
		description="铁臂口碑包含了大量真实用户的工程机械产品口碑,帮助您通过网络了解工程机械产品,买工程机械产品就上铁臂商城。";
		}
		
		if(catalog.length()>6){
			catalog=catalog.substring(0,6);
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
<meta name="author" content="design by www.21-sun.com" />
<title><%=title%></title>
<meta name="keywords" content="<%=keyword%>" />
<meta name="description" content="<%=description%>" />
<link href="Static/css/style.css" rel="stylesheet" />
</head>
<body>
<jsp:include page="top.jsp" flush="true"/>
<div style=" text-align: center;">
	<a href="http://m.koubei.21-sun.com/index_activity.jsp"><img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/banner.jpg" alt="铁臂口碑"></a>
</div>
<div class="fix kbcat">
	<div class="kbcat_t"><%=factory1%><%=catalog1%>口碑</div>
    <ul class="fix kbcat_list">
	 <%	 
        
		
			for (Map koubeiMap : koubeiProducts) {
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
			String username=CommonString.getFormatPara(koubeiMap.get("username"));//口碑name
			if(username.equals("")){
			username=name;
			}
			if(content.length()>50){
			content=content.substring(0,50);
			}
			if(catalognum.length()>6){
			catalognum=catalognum.substring(0,6);
			}
			 String add_date = CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(koubeiMap.get("add_date")));

  %>
    	<li>
        	<div class="_name"><a href="/web_kb_detail.jsp?id=<%=product_id%>" ><%=factoryname%><%=name1%><%=catalognum%></a></div>
            <div class="_img"><a href="/web_kb_detail.jsp?id=<%=product_id%>" ><img src="/uploadfiles/<%=img2%>" alt="<%=name1%>"/></a></div>
            <div class="_canshu fix">
            	<p class="c_namedate"><span class="_t1"><%=username%></span><span class="_t2"><%=add_date%></span></p>
				<%
				model = dbHelper.getMap(" select count(*) as counts from pro_mobile_koubei_list where id = ? ",new Object [] {product_id} , connection);
				%>
                <p class="p_num">评论数（<span><%=CommonString.getFormatPara(model.get("counts"))%>条</span>）</p>
				
            </div>
            <div class="_sum">
            <%=content%>
            </div>
        </li>
        <%}%>
    </ul>
	<div class="paging">
    <tags:page_mobile pageBean="<%=pageBean%>" />

</div>
</div>
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="brands_list_news.jsp?catalog=<%=catalog%>"><img src="Static/img/fdj_03.png" class="io">品牌</a></div>
</div>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script type="text/javascript" src="Static/js/modules/jquery.min.js"></script>
<script>

function loginOut(){
	$.post("/action/ajax_mobile.jsp",{message:"exit"},function(data){
		if($.trim(data)=="loginOut"){
			 location.reload();
		}
	});
}
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