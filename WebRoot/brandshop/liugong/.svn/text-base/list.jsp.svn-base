<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 

   	String catalogName="所有产品";
   if(catalog.equals("101001")){catalogName="挖掘机";}
   if(catalog.equals("102001")){catalogName="装载机";}
   
   String whereStr = "and is_show=1 and factoryid = 136 ";
   DBHelper dbHelper = DBHelper.getInstance() ;
   PageBean pageBean = new PageBean() ; 
   String offset = CommonString.getFormatPara(request.getParameter("offset"));
   pageBean.setTableName("pro_products") ;
   pageBean.setFields(" factoryname,name,catalogname,img2,id,factoryid_sub,file_name") ;
   pageBean.setOrderBy(" view_count desc,id desc") ;
   if(!"".equals(catalog)){
	   whereStr += " and  catalognum like '"+catalog+"%'";
	}
   pageBean.setCondition(whereStr);
   pageBean.setPageSize(9) ;
   Integer nowPage = 1;
   if (!"".equals(offset) && !"0".equals(offset)) {
   	nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
   }; // 当前页
   pageBean.setNowPage(nowPage) ;
   pageBean.setIsShowSql(false) ;
   Map catalogMap = null ;
   List<Map> productsList = null ;
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
   productsList = pageBean.getDatas() ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="author" content="design by www.21-sun.com" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<title>柳工旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="柳工,柳工产品报价,柳工产品,柳工产品图片,柳工产品介绍,柳工介绍" />
<meta name="description" content="中国工程机械商贸网为您提供柳工介绍,柳工产品介绍,柳工产品报价,柳工产品图片,柳工产品展示等柳工产品信息，帮助您全面了解柳工。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/com.css" rel="stylesheet" />
<link href="style/style.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script>window.jQuery || document.write('<script src="scripts/jq1.10.2.js"><\/script>')</script>
<!--[if IE 6]>
<script src="./scripts/iepng.js"></script>
<script>
   EvPNG.fix('s')
</script>
<![endif]-->
</head>

<body>
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--头部-->
<div class="lg_logo">
  <div class="contain980"><a href=""><img src="images/logo.jpg" alt="柳工旗舰店" data-bd-imgshare-binded="1"></a></div>
</div>
<div class="lg_nav">
  <ul class="fix contain980">
    <li><a href="index.jsp">店铺首页</a></li>
    <li><a href="list.jsp?catalog=101002">装载机</a></li>
    <li><a href="list.jsp?catalog=101001">挖掘机</a></li>
    <li class="last"><a href="javascript:void(0);" onclick="addShop();return false;">收藏店铺</a></li>
  </ul>
</div>
<!--main start-->
<div class="contain980 lg_mian_ny fix">
  <div class="l lg_ny_left">
    	<div class="all_cat"><a href="javascript:void(0);">所有产品分类&gt;&gt;</a></div>
    	<ul class="lg_menu">
			<li <% if(catalog.equals("101002")){%>class="cur"<%}%>><a href="list.jsp?catalog=101002">装载机</a></li>
			<li <% if(catalog.equals("101001")){%>class="cur"<%}%>><a href="list.jsp?catalog=101001">挖掘机</a></li>
		</ul>
	</div>
    <div class="r lg_ny_right">
    	<div class="lg_ny_T fix"><span class="zh_cn"><%=catalogName %></span><span class="en">LIUGONG Products List</span></div>
    	<div class="lg_main_nr">
        	<ul class="fix lg_nypro_list">
			<%
        	if(null!=productsList && productsList.size()>0){
        		for(Map m:productsList){
        			String id = CommonString.getFormatPara(m.get("id"));
    	    		String file_name = CommonString.getFormatPara(m.get("file_name"));
    	    		String name = CommonString.getFormatPara(m.get("name"));
    	    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
    	    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
    	    		String img2 = CommonString.getFormatPara(m.get("img2"));
    	    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
        	%>
            	<li>
                	<p class="lgnp_img"><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">
					<img src="/uploadfiles/<%=img2 %>" width="225px" height="212px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>" /></a></p>
                    <div class="lgnp_nr">
                    	<div><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><%=catalogname+" "+name %></a></div>
                        <div class="fix">
                        	<p class="l"><span><a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a></span> | <span><a href="/proDetail/<%=file_name.replace(".shtm", "_message.shtm") %>" title="<%=factoryname+name+catalogname %>评论" target="_blank">评论</a></span></p>
                            <p class="r np_xunjia"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','')" >立即询价</a></p>
                        </div>
                    </div>
                </li>				       
            	<%
        		}
        	}
        %>
            </ul>
            <div class="shopListPage" style="<%=pageBean.getPageCount()<=1?"display:none;":"" %>">
	         <tags:page pageBean="<%=pageBean %>"/>
	        </div>
        </div>
    </div>
</div>
<!--main end-->
<!--foot-->
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
</body>
<script type="text/javascript">
function addShop(){// 收藏店铺
	var url = window.location.href;
    try{
       window.external.addFavorite(url, '广西柳工机械股份有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('广西柳工机械股份有限公司',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
</body>
</html>