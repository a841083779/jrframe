<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
    DBHelper dbHelper = DBHelper.getInstance() ;
    String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
    String whereStr="";
    String orderBy=" order by catalognum_spe_second asc,view_count desc";
    //if(catalog.equals("102")){orderBy=" order by tonandmeter asc";}
    //if(catalog.equals("104")){orderBy=" order by order_no asc";}
    //产品列表
    String pro_sql = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=16327 and is_show=1 and catalognum_spe like '"+catalog+"%' "+whereStr+orderBy ;
    List<Map> newProductsList = null ;
    newProductsList = dbHelper.getMapList(pro_sql) ;
   //公司信息
   //String  company="select introduce from pro_agent_factory where id=16327";
   //List<Map> companyInfo = null ;
   //companyInfo = dbHelper.getMapList(company) ;
   String catalogName="所有产品";
   if(catalog.equals("101")){catalogName="路面养护/再生系列";}
   if(catalog.equals("102")){catalogName="沥青喷洒|灌缝系列";}
   if(catalog.equals("103")){catalogName="压实机械系列";}
   if(catalog.equals("104")){catalogName="破拆机械系列";}
   if(catalog.equals("105")){catalogName="照明车系列";}
   if(catalog.equals("106")){catalogName="其他机械系列";}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>友一机械旗舰店-中国工程机械商贸网</title>
<meta name="keywords" content="友一机械,友一机械产品报价,友一机械产品,友一机械产品图片,友一机械产品介绍,友一机械介绍" />
<meta name="description" content="中国工程机械商贸网为您提供友一机械介绍,友一机械产品介绍,友一机械产品报价,友一机械产品图片,友一机械产品展示等友一机械产品信息，帮助您全面了解友一机械。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/youyi.css" rel="stylesheet" type="text/css" />
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
<body>
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end-->
<div class="youyi_logo">
  <div class="contain980 fix">
  	<div class="l"><a href="/brandshop/youyi/"><img src="images/logo.gif"  alt="友一机械旗舰店"/></a></div>
    <div class="r"><a href="javascript:void(0);" onclick="addShop();return false;"><img src="images/sc.gif"/></a></div>
  </div>
</div>
<div class="youyi_nav">
  <ul class="fix contain980">
    <li <% if(catalog.equals("")){%>class="cur"<%}%>><a href="/brandshop/youyi/">首页</a></li>
    <li <% if(catalog.equals("101")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=101">路面养护/再生系列</a></li>
    <li <% if(catalog.equals("103")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=103">压实机械系列</a></li>
    <li <% if(catalog.equals("104")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=104">破拆机械系列</a></li>
    <li <% if(catalog.equals("102")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=102">沥青喷洒|灌缝系列</a></li>
    <li <% if(catalog.equals("105")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=105">照明车系列</a></li>
    <li <% if(catalog.equals("106")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=106">其他机械系列</a></li>
  </ul>
</div>
<!--main-->
<div class="youyi_main pt15 pb15">
<div class="contain980 lg_mian_ny fix">
	<div class="l lg_ny_left">
    	<div class="all_cat"><a href="/brandshop/youyi/pro_list.jsp">所有产品分类&gt;&gt;</a></div>
        <ul class="lg_menu">
        	<li <% if(catalog.equals("101")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=101">路面养护/再生系列</a></li>
            <li <% if(catalog.equals("103")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=103">压实机械系列</a></li>
            <li <% if(catalog.equals("104")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=104">破拆机械系列</a></li>
            <li <% if(catalog.equals("102")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=102">沥青喷洒|灌缝系列</a></li>
            <li <% if(catalog.equals("105")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=105">照明车系列</a></li>
            <li <% if(catalog.equals("106")){%>class="cur"<%}%>><a href="/brandshop/youyi/pro_list.jsp?catalog=106">其他机械系列</a></li>
        </ul>
    </div>
    <div class="r lg_ny_right">
    	<div class="lg_ny_T fix"><span class="zh_cn"><%=catalogName %></span><span class="en">YouYi Products List</span></div>
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
                	<p class="lgnp_img"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %>"/></a></p>
                    <div class="lgnp_nr">
                    	<div><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %> <%=CommonString.getFormatPara(oneMap.get("name")) %></a></div>
                        <div class="fix">
                        	<p class="l"><span><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm"  target="_blank">参数</a></span> | <span><a  href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" target="_blank">评论</a></span></p>
                            <p class="r np_xunjia"><a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135');">立即询价</a></p>
                        </div>
                    </div>
                </li>
            <%}}%>
            </ul>
        </div>
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
$(".yytj_pro").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:2,scroll:1,autoPlay:true,autoPage:true,interTime:4000});
</script>
<script type="text/javascript">
function addShop(){　 // 收藏店铺
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/youyi/', '济宁友一道路机械有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('济宁友一道路机械有限公司','http://product.21-sun.com/brandshop/youyi/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
</body>
</html>