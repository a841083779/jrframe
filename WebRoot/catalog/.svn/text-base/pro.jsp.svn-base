<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.regex.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
    String usernn = CommonString.getFormatPara(request.getParameter("usern"));
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection connection = null;
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	Map brandMap = (Map) application.getAttribute("brandMap");

	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_products_second where english_name = ? ",new Object []{usernn},connection);
		if(map == null){
			Common.do302(response,"http://product.21-sun.com/");
			return;
		}
	String catalognum=CommonString.getFormatPara(map.get("catalognum"));
	String catalogname=CommonString.getFormatPara(map.get("catalogname"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	StringBuffer whereStr = new StringBuffer(" and is_show=1  and catalognum like '"+catalognum+"%'") ;

    if(!factoryid.equals("0")&&!factoryid.equals(""))
    {
			whereStr.append(" and factoryid =" + factoryid + "");
	}	
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(12) ; // 每页显示条数
	pageBean.setOrderBy(" view_count desc ");
    pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum ");
	pageBean.setTableName("pro_products");
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;  
	List<Map> searchProducts = pageBean.getDatas(connection); // 根据条件查出的产品
	List<Map> brandList = dbHelper.getMapList("select top 15 id,name from pro_agent_factory where is_show=1 and flag=1 and id in (select distinct factoryid from pro_products where  is_show=1 and catalognum like '"+catalognum+"%' ) order by view_count desc") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%if(factoryid.equals("")||factoryid.equals("0")){%>
<title><%=catalogname %>_<%=catalogname %>品牌大全_<%=catalogname %>型号 – 铁臂<%=catalogname %>专区</title>
<meta name="keywords" content="<%=catalogname %>,<%=catalogname %>品牌大全,<%=catalogname %>型号" />
<meta name="description" content="铁臂<%=catalogname %>专区,为您提供最全的<%=catalogname %>品牌,帮助您全面了解<%=catalogname %>品牌,买<%=catalogname %>产品就上铁臂商城。" />
<%}else{%>
<title><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>_<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>型号_<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>参数 -铁臂<%=catalogname %>专区</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>,<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>型号,<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>参数" />
<meta name="description" content="铁臂<%=catalogname %>专区,为您<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>图片,<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>型号、参数配置,让您全面了解<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>产品,买<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname %>产品就上铁臂商城。" />
<%}%>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/brandshow/style/brands.css" rel="stylesheet" type="text/css" />
<link href="/catalog/style/products.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--top end-->
<div class="contain980 fix">
  <div class="nc_channT"><h1 style="font-size:24px;"><%=catalogname %></h1></div>
  <div class="s_mainSite"><a target="_blank" href="http://product.21-sun.com/">访问首页</a></div>
  <div class="s_tel">铁臂商城客服电话：<b>4006-521-526</b></div>
</div>
<div class="s_navBar">
  <div class="contain980">
    <ul class="fix">
      <li><a href="http://<%=usernn%>.21-sun.com/"><%=catalogname%>首页</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/news.htm"><%=catalogname%>动态</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/koubei.htm"><%=catalogname%>口碑</a></li>
      <li><a href="http://<%=usernn%>.21-sun.com/pic.htm"><%=catalogname%>图片</a></li>
      <li  class="selected"><a href="http://<%=usernn%>.21-sun.com/pro.htm"><%=catalogname%>品牌</a></li>
      <li><a href="http://product.21-sun.com/inquiry/0_0_0_<%=catalognum%>_0.shtm" target="_blank"><%=catalogname%>询价单</a></li>
    </ul>
  </div>
</div>
<div class="contain980 mb10 mt10">
  <div class="breadCrumbs"><a href="/">铁臂<%=catalogname%>专区</a> &gt;&gt; <%=catalogname%>品牌<%if(!factoryid.equals("")&&!factoryid.equals("0")){%> &gt;&gt; <%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=catalogname%><%}%></div>
</div>
<!--main-->
<div class="contain980 fix">
	<div class="s_mleft">
        <div class="comBox">
            <div class="cg mb10 cp_brandmore"> 
              <strong>品牌：</strong>
			  <%	  
				if (brandList != null && brandList.size() > 0) {
						for (Map oneMap : brandList) {
			  %>
			  <a href="/pro_<%=CommonString.getFormatPara(oneMap.get("id"))%>_0.htm" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))%></a><em>|</em>
              <%}}%>
			 <br> <a style="float:right" href="http://product.21-sun.com/products/prolist.jsp?catalog=<%=catalognum%>"  title="<%=catalogname%>品牌大全" target="_blank"><%=catalogname%>品牌大全</a>
              <a  href="javascript:void(0)" class="cp_bmore">更多</a>
            </div>
         </div>
         <script type="text/javascript">
		 $('.cp_bmore').click(function(){
		 	if($(this).hasClass('act')){
				$(this).removeClass('act');
				$(this).parent('.cp_brandmore').removeAttr('style');
			}else{
				$(this).addClass('act');
				$(this).parent('.cp_brandmore').css('height','auto');
			}
		 })
		 </script>
        <div class="pcpic_val">
        	<ul class="pc_piclist fix">
			 <%	  
				if (searchProducts != null && searchProducts.size() > 0) {
						for (Map oneMap : searchProducts) {
							 String img=CommonString.getFormatPara(oneMap.get("img2"));
			                 if(img.indexOf("uploadfiles")==-1){
			                      img="http://product.21-sun.com/uploadfiles/"+img;
			                 }else{
			                       img="http://product.21-sun.com/"+img;
			                 }
			%>
            	<li>
                	<div class="pcpic_img"><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" target="_blank"><img title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" src="<%=img%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>"/></a></div>
                    <div class="pcpic_name"><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>"  target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a></div>
                </li>
            <%}}%>
            </ul>
        </div>
		  <div class="pages">
	        <form id="theform" name="theform" method="post" action="">
			<div id="pagination" class="paging  page" style="margin-right:3px;">
				<tags:page_catalog_pro pageBean="<%=pageBean%>"  />
			</div>
	        </form>
      	</div>
    </div>
    <div class="s_right">
	<!--热门产品-->
	<jsp:include page="/include/catalogshow/product_hot.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
	<!--产品关注排行-->
	<jsp:include page="/include/catalogshow/product_rank.jsp" flush="true">
      <jsp:param name="catalogname" value='<%=catalogname%>'></jsp:param>
      <jsp:param name="catalognum" value='<%=catalognum%>'></jsp:param>
    </jsp:include>
    </div>
</div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--foot end-->
</body>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>