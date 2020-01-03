<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
   	DBHelper dbHelper = DBHelper.getInstance() ;
	String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
	String childCatalog=CommonString.getFormatPara(request.getParameter("childCatalog")); 
	String whereStr="";
	if(!childCatalog.equals("")){whereStr+="and catalognum_spe_second='"+childCatalog+"'";}
	String orderBy=" order by catalognum_spe_second asc,view_count desc";
	if(catalog.equals("102")){orderBy=" order by tonandmeter asc";}
	if(catalog.equals("104")){orderBy=" order by order_no asc";}
    //产品列表
	String pro_sql = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=135 and is_show=1 and catalognum_spe like '"+catalog+"%' "+whereStr+orderBy ;
	List<Map> newProductsList = null ;
	newProductsList = dbHelper.getMapList(pro_sql) ;
   //公司信息
   //String  company="select introduce from pro_agent_factory where id=135";
   //List<Map> companyInfo = null ;
   //companyInfo = dbHelper.getMapList(company) ;
   String catalogName="";
   if(catalog.equals("101")){catalogName="装载机";}
   if(catalog.equals("102")){catalogName="挖掘机";}
   if(catalog.equals("103")){catalogName="路面机械";}
   if(catalog.equals("104")){catalogName="叉车";}
   if(catalog.equals("105")){catalogName="推土机";}
   if(catalog.equals("106")){catalogName="旋挖钻";}
   String childCatalogName="";
   if(childCatalog.equals("101001")){childCatalogName="60系列";}
   if(childCatalog.equals("101002")){childCatalogName="50系列";}
   if(childCatalog.equals("101003")){childCatalogName="40系列";}
   if(childCatalog.equals("101004")){childCatalogName="30系列";}
   if(childCatalog.equals("101005")){childCatalogName="石料叉装机";}
   if(childCatalog.equals("101006")){childCatalogName="小型装载机(A系列)";}
   if(childCatalog.equals("101007")){childCatalogName="小型装载机(B系列)";}
   if(childCatalog.equals("101008")){childCatalogName="小型装载机(D系列)";}
   if(childCatalog.equals("101009")){childCatalogName="滑移装载机";}
   if(childCatalog.equals("103001")){childCatalogName="轮胎压路机";}
   if(childCatalog.equals("103002")){childCatalogName="机械驱动单钢轮振动压路机";}
   if(childCatalog.equals("103003")){childCatalogName="全液压单钢轮振动压路机";}
   if(childCatalog.equals("103004")){childCatalogName="光轮静碾压路机";}
   if(childCatalog.equals("104001")){childCatalogName="内燃叉车（LG系列）";}
   if(childCatalog.equals("104002")){childCatalogName="内燃叉车（FD系列）";}
   if(childCatalog.equals("104003")){childCatalogName="蓄电池叉车";}
   if(childCatalog.equals("104004")){childCatalogName="仓储叉车";}
   if(childCatalog.equals("104005")){childCatalogName="港口叉车";}
   if(childCatalog.equals("104006")){childCatalogName="其他产品";}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>龙工旗舰店-中国工程机械商贸网</title>
<meta name="keywords" content="龙工,龙工产品报价,龙工产品,龙工产品图片,龙工产品介绍,龙工介绍" />
<meta name="description" content="中国工程机械商贸网为您提供龙工介绍,龙工产品介绍,龙工产品报价,龙工产品图片,龙工产品展示等龙工产品信息，帮助您全面了解龙工。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/longgong.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
</head>
<body class="longgong_body_ny">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end-->
<div class="lg_logo">
  <div class="contain980"><a href="/brandshop/longgong/"><img src="images/logo.gif"  alt="龙工旗舰店"/></a></div>
</div>
<div class="lg_nav">
  <ul class="fix contain980">
    <li class="first_home"><a href="/brandshop/longgong/">首页</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=101">装载机</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=102">挖掘机</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=103">路面机械</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=104">叉车</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=105">推土机</a></li>
    <li><a href="/brandshop/longgong/pro_list.jsp?catalog=106">旋挖钻</a></li>
    <li  style="background:none;"><a href="/brandshop/longgong/about.jsp">公司简介</a></li>
    <li class="last"><a href="javascript:void(0);" onclick="addShop();return false;"></a></li>
  </ul>
</div>
<!--main-->
<div class="contain980 lg_mian_ny fix">
	<div class="l lg_ny_left">
    	<div class="all_cat"><a href="javascript:void(0);"><%=catalogName%>分类&gt;&gt;</a></div>
        <ul class="lg_menu">
		    <!--装载机-->
		    <%if(catalog.equals("101")){%>
				<li <%if(childCatalog.equals("101001")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101001">60系列</a></li>
				<li <%if(childCatalog.equals("101002")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101002">50系列</a></li>
				<li <%if(childCatalog.equals("101003")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101003">40系列</a></li>
				<li <%if(childCatalog.equals("101004")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101004">30系列</a></li>
				<li <%if(childCatalog.equals("101005")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101005">石料叉装机</a></li>
				<li <%if(childCatalog.equals("101006")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101006">小型装载机(A系列)</a></li>
				<li <%if(childCatalog.equals("101008")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101008">小型装载机(D系列)</a></li>
				<li <%if(childCatalog.equals("101009")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=101&childCatalog=101009">滑移装载机</a></li>
			<%}%>
		    <!--挖掘机-->
			<%if(catalog.equals("102")){%>
			    <li class="cur" ><a href="/brandshop/longgong/pro_list.jsp?catalog=102">挖掘机</a></li>
			<%}%>
			<!--路面机械-->
			<%if(catalog.equals("103")){%>
			    <li <%if(childCatalog.equals("103001")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=103&childCatalog=103001">轮胎压路机</a></li>
				<li <%if(childCatalog.equals("103002")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=103&childCatalog=103002">机械驱动单钢轮振动压路机</a></li>
                <li <%if(childCatalog.equals("103003")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=103&childCatalog=103003">全液压单钢轮振动压路机</a></li>
                <li <%if(childCatalog.equals("103004")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=103&childCatalog=103004">光轮静碾压路机</a></li>
			<%}%>
			<!--叉车-->
			<%if(catalog.equals("104")){%>
                <li <%if(childCatalog.equals("104001")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=104&childCatalog=104001">内燃叉车（LG系列）</a></li>
				<li <%if(childCatalog.equals("104002")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=104&childCatalog=104002">内燃叉车（FD系列）</a></li>
                <li <%if(childCatalog.equals("104003")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=104&childCatalog=104003">蓄电池叉车</a></li>
                <li <%if(childCatalog.equals("104004")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=104&childCatalog=104004">仓储叉车</a></li>
				<li <%if(childCatalog.equals("104005")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=104&childCatalog=104005">港口叉车</a></li>
                <li <%if(childCatalog.equals("104006")){%>class="cur"<%}%> ><a href="/brandshop/longgong/pro_list.jsp?catalog=104&childCatalog=104006">其他产品</a></li>
			<%}%>
			<!--推土机-->
			<%if(catalog.equals("105")){%>
                <li class="cur" ><a href="/brandshop/longgong/pro_list.jsp?catalog=105">推土机</a></li>
			<%}%>
			<%if(catalog.equals("106")){%>
                <li class="cur" ><a href="/brandshop/longgong/pro_list.jsp?catalog=106">旋挖钻</a></li>
			<%}%>
        </ul>
        <div class="lg_shop_js">
        	<div class="shop_T">店铺介绍</div>
            <div class="shop_N">
            中国龙工控股有限公司，简称“龙工”，系由全国人大代表、全国劳动模范、全国优秀中国特色社会主义事业建设者、全国光彩事业先进个人李新炎先生，于1993年在福建龙岩创立的一家大型工程机械企业。2005年率中国工程机械行业之先在香港主板上市（股票代码03339），名列“全球工程机械50强”、“中国机械工业核心竞争力100强”、“全国百家侨资明星企业”。
              <p class="shopjs_more"><a href="/brandshop/longgong/about.jsp">更多&gt;&gt;</a></p>
            </div>
        </div>
    </div>
    <div class="r lg_ny_right">
    	<div class="lg_ny_T fix"><span class="zh_cn"><%=catalogName%><%=childCatalogName.equals("")?"":"-"+childCatalogName%></span><span class="en">Lonking Products List</span></div>
    	<div class="lg_main_nr">
        	<ul class="fix lg_nypro_list">
			<%
			String imgSrc="";
			if(null!=newProductsList && newProductsList.size()>0){
				Map oneMap = null ;
				for(int i=0;i<newProductsList.size();i++){
					oneMap = (HashMap)newProductsList.get(i);
					imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
		    %>
            	<li>
                	<p class="lgnp_img"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">
					<img  title="<%=CommonString.getFormatPara(oneMap.get("catalogname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %>" width="225" height="212" src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %>"/></a></p>
                    <div class="lgnp_nr">
                    	<div><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %> <%=CommonString.getFormatPara(oneMap.get("name")) %></a></div>
                        <div class="fix">
                        	<p class="l"><span><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm"  target="_blank">参数</a></span> | <span><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" target="_blank">评论</a></span></p>
                            <p class="r np_xunjia"><a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135');">立即询价</a></p>
                        </div>
                    </div>
                </li>
				       <%}}%>
            </ul>
        </div>
    </div>
</div>
<!--main end-->
<!--foot-->
<div class="john_foot">
  <jsp:include page="/include/foot.jsp"/>
</div>
<!--foot end--> 
<script type="text/javascript" src="scripts/comm.js"></script> 
<script type="text/javascript">
$(".lg_tuijian").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:5,scroll:1,autoPlay:true,autoPage:true,interTime:4000});
</script>

<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"slide":{"type":"slide","bdImg":"0","bdPos":"right","bdTop":"100"}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
<script type="text/javascript">
function addShop(){　 // 收藏店铺
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/longgong/', '中国龙工控股有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('中国龙工控股有限公司','http://product.21-sun.com/brandshop/longgong/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
</body>
</html>