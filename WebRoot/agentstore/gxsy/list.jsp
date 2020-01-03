<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	
	String whereStr = " and agentid=282";
	if(!factoryid.equals("")){
		whereStr += " and factoryid = "+factoryid;
	}
	if(!catalognum.equals("")){
		whereStr += " and catalognum like '"+catalognum+"%' ";
	}
	
	List<Map> productsList = null ;
	PageBean pageBean = new PageBean() ; 
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	pageBean.setTableName("pro_agent_product_vi") ;
	pageBean.setFields(" factoryname,name,img2,id,file_name,catalogname") ;
	 pageBean.setCondition(whereStr) ;
	pageBean.setOrderBy(" id desc") ;
	pageBean.setPageSize(9) ;
	Integer nowPage = 1;
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}; // 当前页
	pageBean.setNowPage(nowPage) ;
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
	pageBean.setIsShowSql(false) ;
	productsList = pageBean.getDatas() ;
	
	String sortName = "全部产品";
	if(factoryid.equals("192")){
		sortName = "斗山产品";
	}else if(factoryid.equals("189")){
		sortName = "加藤产品";
	}else if(factoryid.equals("136")){
		sortName = "柳工产品";
		if(catalognum.equals("101001")){
			sortName = "柳工挖掘机产品";
		}else if(catalognum.equals("101001")){
			sortName = "柳工装载机产品";
		}
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=sortName %> - 松宇企业集团_中国工程机械商贸网</title>
<meta name="keywords" content="松宇,松宇企业集团,广西松宇,斗山产品报价斗山产品斗山产品图片斗山产品介绍斗山介绍,加藤产品报价加藤产品加藤产品图片加藤产品介绍加藤介绍,柳工产品报价柳工产品柳工产品图片柳工产品介绍柳工介绍" />
<meta name="description" content="中国工程机械商贸网为您提供松宇企业集团介绍斗山产品介绍斗山产品报价斗山产品图片斗山产品展示等斗山产品信息，加藤产品报价加藤产品加藤产品图片加藤产品介绍加藤介绍,柳工产品报价柳工产品柳工产品图片柳工产品介绍柳工介绍,帮助您全面了解松宇企业集团。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]><script src="/scripts/pngfix.js">/* s,i,.pngfix,.pngimg img */</script><![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true">
<jsp:param value="<%=factoryid %>" name="factoryid" />
</jsp:include>
<div class="shopWrap fix channelBox">
  <!--left-->
  <div class="channelLeft">
    <div class="hd">
      <strong>所有产品分类&gt;&gt;</strong>
    </div>
    <div class="bd">
      <ul class="shopListMenu">
        <li <% if(factoryid.equals("192")){ %> class="select" <%} %>><a href="list.jsp?factoryid=192">斗山产品</a></li>
        <li <% if(factoryid.equals("189")){ %> class="select" <%} %>><a href="list.jsp?factoryid=189">加藤产品</a></li>
        <li <% if(factoryid.equals("136")){ %> class="select" <%} %>><a href="list.jsp?factoryid=136">柳工产品</a>
          <ul>
            <li <% if(catalognum.equals("101001")){ %> class="select" <%} %>><a href="list.jsp?factoryid=136&catalognum=101001">挖掘机</a></li>
            <li <% if(catalognum.equals("101002")){ %> class="select" <%} %>><a href="list.jsp?factoryid=136&catalognum=101002">装载机</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <!--right-->
  <div class="channelRight">
    <div class="hd">
      <strong><%=sortName %></strong>
    </div>
    <div class="bd">
      <div class="proList01">
        <ul class="fix">
        <%
        	if(null!=productsList && productsList.size()>0){
        		for(Map m:productsList){
        			String id = CommonString.getFormatPara(m.get("id"));
		    		String file_name = CommonString.getFormatPara(m.get("file_name"));
		    		String name = CommonString.getFormatPara(m.get("name"));
		    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
		    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
		    		String img2 = CommonString.getFormatPara(m.get("img2"));
        %>
          <li>
            <div class="img"><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles/<%=img2 %>" width="225px" height="174px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a></div>
            <h3><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><%=factoryname+name+catalogname %></a></h3>
            <span class="links"><a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a> | <a href="/proDetail/<%=file_name.replace(".shtm", "_message.shtm") %>" title="<%=factoryname+name+catalogname %>评论" target="_blank">评论</a></span>
            <a href="javascript:;" onclick="showinquery('<%=id %>','');" class="priceBtn">立即询价</a>
          </li>
          <% }} %>
        </ul>  
        <div class="shopListPage" style="<%=pageBean.getPageCount()<=1?"display:none;":"" %>">
         <tags:page pageBean="<%=pageBean %>"/>
        </div>
      </div>
    </div>
  </div>
</div>
<!--foot-->
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript">
function addShop(){// 收藏店铺
	var url = window.location.href;
    try{
       window.external.addFavorite(url, '松宇企业集团');
   }catch (e){
       try{
           window.sidebar.addPanel('松宇企业集团',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
</body>
</html>