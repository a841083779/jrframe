<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
  Map oneMap = null ;
  DBHelper dbHelper = DBHelper.getInstance() ;
  //路面养护/再生系列
  String sql_lm = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=16327 and is_show=1 and catalognum_spe ='101' order by view_count desc" ;
  List<Map> productsListLm = null ;
  productsListLm = dbHelper.getMapList(sql_lm) ;
  //沥青喷洒|灌缝系列
  String sql_lq = "select top 2 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=16327 and is_show=1 and catalognum_spe ='102' order by view_count desc" ;
  List<Map> productsListLq = null ;
  productsListLq = dbHelper.getMapList(sql_lq) ;
  //压实机械系列
  String sql_ys = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=16327 and is_show=1 and catalognum_spe = '103' order by view_count desc" ;
  List<Map> productsListYs = null ;
  productsListYs = dbHelper.getMapList(sql_ys) ;
  //破拆机械系列
  String sql_pc = "select top 4  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=16327 and is_show=1 and catalognum_spe = '104'  order by view_count desc" ;
  List<Map> productsListPc = null ;
  productsListPc = dbHelper.getMapList(sql_pc) ;
  //首页推荐
    String sql = "select top 5 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=16327 and is_show=1 and zoomlion_hot=11   order by view_count desc" ;
  List<Map> productList = null ;
  productList = dbHelper.getMapList(sql) ;
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
    <div class="r"><a href="javascript:void(0);" onclick="addShop();return false;" title="店铺收藏"><img src="images/sc.gif"/></a></div>
  </div>
</div>
<div class="youyi_nav">
  <ul class="fix contain980">
    <li class="cur"><a href="/brandshop/youyi/">首页</a></li>
    <li><a href="/brandshop/youyi/pro_list.jsp?catalog=101">路面养护/再生系列</a></li>
    <li><a href="/brandshop/youyi/pro_list.jsp?catalog=103">压实机械系列</a></li>
    <li><a href="/brandshop/youyi/pro_list.jsp?catalog=104">破拆机械系列</a></li>
    <li><a href="/brandshop/youyi/pro_list.jsp?catalog=102">沥青喷洒|灌缝系列</a></li>
    <li><a href="/brandshop/youyi/pro_list.jsp?catalog=105">照明车系列</a></li>
    <li><a href="/brandshop/youyi/pro_list.jsp?catalog=106">其他机械系列</a></li>
  </ul>
</div>
<!--banner-->
<div class="youyi_banner">
  <div class="ban_c_yy"></div>
</div>
<!--banner end--> 
<!--main-->
<div class="youyi_main">
	<div class="contain980 youyi_bg">
    	<div class="yy_lant"><a href="/brandshop/youyi/pro_list.jsp" title="友一机械全部产品"><img src="images/lant_01.gif"/></a></div>
        <div class="yytj_pro">
        	<div class="bd">
            	<ul class="fix">
                <% 
                  String fullName="";
                  String imgSrc="";
                  if(null!=productList && productList.size()>0){
                    for(int i=0;i<productList.size();i++){
                      oneMap = (HashMap)productList.get(i);
                      fullName=CommonString.getFormatPara(oneMap.get("catalogname"))+" "+CommonString.getFormatPara(oneMap.get("name"));
                      if(fullName.length()>15){fullName=fullName.substring(0,15)+"...";}
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
                      if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
                	<li>
                    	<div class="tjpro_img"><a title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" width="455" height="265"/></a></div>
                        <div class="fix tjpro_nr">
                        	<div class="l tjpro_name">
                            	<a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="tjname1"><%=CommonString.getFormatPara(oneMap.get("name"))%></a>
                                <span class="tjname2"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></span>
                            </div>
                            <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" class="r tjsee_more">查看详情</a>
                        </div>
                    </li>
                   <%}}%>
                </ul>
            </div>
            <div class="hd">
            	<a class="newsImgprev"></a><a class="newsImgnext"></a>
            </div>
        </div>
        <div class="yy_pro_val">
        	<div class="yy_lant"><a href="/brandshop/youyi/pro_list.jsp?catalog=101" title="友一机械路面养护/再生系列"><img src="images/lant_02.gif"/></a></div>
            <div class="yy_lanban">
            <img src="images/lanban_02.jpg" alt="询价路面再生修补车FAHZ08DY"/>
            <a href="javascript:void(0);" onclick="showinquery('21392','135')" title="点击询价" class="youyi_xj"></a>
            <a href="http://product.21-sun.com/proDetail/LMZSXBCFAHZ08DY.shtm" title="路面再生修补车FAHZ08DY" target="_blank" class="youyi_link"></a>
            </div>
            <div class="yypro_list">
            	<ul class="fix">
                <%
                if(null!=productsListLm && productsListLm.size()>0){
                  for(int i=0;i<productsListLm.size();i++){
                    oneMap = (HashMap)productsListLm.get(i);
                    fullName=CommonString.getFormatPara(oneMap.get("catalogname"))+" "+CommonString.getFormatPara(oneMap.get("name"));
                  if(fullName.length()>7){fullName=fullName.substring(0,7)+"...";}
                  imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
                  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                %>
                	<li>
                      <div class="ipro_img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" width="227" height="221"/></a></div>
                        <div class="ipro_nr fix">
                          <p class="ipt1"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("name"))%></a></p>
                            <p class="ipt2"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a></p>
                            <p class="ipt3"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank">详细</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_parameter.shtm"  target="_blank">参数</a></p>
                            <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135')" title="点击询价" class="ipro_xj"></a>
                        </div>
                    </li>
                <%}}%>
                </ul>
            </div>
        </div>
        <div class="yy_pro_val">
        	<div class="yy_lant"><a href="/brandshop/youyi/pro_list.jsp?catalog=103" title="友一机械压实机械系列"><img src="images/lant_03.gif"/></a></div>
            <div class="yy_lanban">
            <img src="images/lanban_03.jpg" alt="询价座驾式压路机FAYL-850"/>
            <a href="javascript:void(0);" onclick="showinquery('21424','135')" title="点击询价" class="youyi_xj"></a>
            <a href="http://product.21-sun.com/proDetail/FAYL-850.shtm" title="座驾式压路机FAYL-850" target="_blank" class="youyi_link"></a>
            </div>
            <div class="yypro_list">
            	<ul class="fix">
                <%
                if(null!=productsListYs && productsListYs.size()>0){
                  for(int i=0;i<productsListYs.size();i++){
                    oneMap = (HashMap)productsListYs.get(i);
                    fullName=CommonString.getFormatPara(oneMap.get("catalogname"))+" "+CommonString.getFormatPara(oneMap.get("name"));
                  if(fullName.length()>7){fullName=fullName.substring(0,7)+"...";}
                  imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
                  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                %>
                  <li>
                      <div class="ipro_img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" width="227" height="221"/></a></div>
                        <div class="ipro_nr fix">
                          <p class="ipt1"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("name"))%></a></p>
                            <p class="ipt2"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a></p>
                            <p class="ipt3"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank">详细</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_parameter.shtm"  target="_blank">参数</a></p>
                            <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135')" title="点击询价" class="ipro_xj"></a>
                        </div>
                    </li>
                <%}}%>
                </ul>
            </div>
        </div>
        <div class="yy_pro_val">
        	<div class="yy_lant"><a href="/brandshop/youyi/pro_list.jsp?catalog=104" title="友一机械破拆机械系列"><img src="images/lant_04.gif"/></a></div>
            <div class="yy_lanban">
            <img src="images/lanban_04.jpg" alt="询价FAKC180开槽机"/>
            <a href="http://product.21-sun.com/proDetail/FAKC180.shtm" title="FAKC180开槽机" target="_blank" class="youyi_xj2"></a>
            <a href="javascript:void(0);" onclick="showinquery('21425','135')" title="点击询价" class="youyi_link2"></a>
            </div>
            <div class="yypro_list">
            	<ul class="fix">
                <%
                if(null!=productsListPc && productsListPc.size()>0){
                  for(int i=0;i<productsListPc.size();i++){
                    oneMap = (HashMap)productsListPc.get(i);
                    fullName=CommonString.getFormatPara(oneMap.get("catalogname"))+" "+CommonString.getFormatPara(oneMap.get("name"));
                  if(fullName.length()>7){fullName=fullName.substring(0,7)+"...";}
                  imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
                  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                %>
                  <li>
                      <div class="ipro_img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>" alt="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" width="227" height="221"/></a></div>
                        <div class="ipro_nr fix">
                          <p class="ipt1"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("name"))%></a></p>
                            <p class="ipt2"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a></p>
                            <p class="ipt3"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>" target="_blank">详细</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_parameter.shtm"  target="_blank">参数</a></p>
                            <a href="javascript:void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','135')" title="点击询价" class="ipro_xj"></a>
                        </div>
                    </li>
                <%}}%>
                </ul>
            </div>
        </div>
        <div class="yy_pro_val">
        	<div class="yy_lant"><a href="/brandshop/youyi/pro_list.jsp?catalog=102" title="友一机械沥青喷洒|灌缝系列"><img src="images/lant_05.gif"/></a></div>
            <div class="ipro2_list">
            	<ul class="fix">
                <li>
                  <div class="ipro2_img"><a href="/proDetail/FALH160.shtm" target="_blank"><img src="images/pro1.jpg" alt="乳化沥青喷洒车FALH160" width="475" height="375"></a></div>
                  <div class="ipro2_nr fix">
                    <a href="/proDetail/FALH160.shtm" title="乳化沥青喷洒车FALH160" target="_blank" class="ipro2_name">乳化沥青喷洒车</a>
                    <a href="/proDetail/FALH160.shtm" title="乳化沥青喷洒车FALH160" target="_blank" class="ipro2_more">查看详情</a>
                  </div>
                </li>
                <li>
                  <div class="ipro2_img"><a href="/proDetail/FAGF-60.shtm" target="_blank"><img src="images/pro2.jpg" alt="灌缝机FAGF-60" width="475" height="375"></a></div>
                  <div class="ipro2_nr fix">
                    <a href="/proDetail/FAGF-60.shtm" title="灌缝机FAGF-60" target="_blank" class="ipro2_name">灌缝机</a>
                    <a href="/proDetail/FAGF-60.shtm" title="灌缝机FAGF-60" target="_blank" class="ipro2_more">查看详情</a>
                  </div>
                </li>
              </ul>
            </div>
        </div>
        <div class="yy_pro_val">
        	<div class="yy_lant"><a href="/inquiry/0_0_16327_0_0.shtm" target="_blank" title="友一机械产品订单"><img src="images/lant_06.gif"/></a></div>
            <div class="lg_order_nr fix">
      <div class="wfull " id="myTab2_ContentA5">
        <div class="w960 border03  mb10 list08 fix">
        	<div class="fix lg_more_order">
        	<div class="l lgmo_title">友一产品订单</div>
            <div class="r lgmo_more"><a href="/inquiry/0_0_16327_0_0.shtm" target="_blank" title="更多">更多&gt;&gt;</a></div>
        </div>
        <%
        List<Map> orderList = null ;
        PageBean pageBean = new  PageBean() ;
        pageBean.setPageSize(10) ;
        pageBean.setTableName("pro_product_form") ;
        pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
        pageBean.setCondition("and factoryid=16327 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
        pageBean.setNowPage(1) ;
        pageBean.setOrderBy(" add_date desc") ;
        pageBean.setParams("#to_order") ;
        orderList = pageBean.getDatas() ;
        %>
        	<div class="title08">
              <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
              <span>共有<font><%=pageBean.getTotal() %></font>个符合条件</span> 
           </div>
          <ul class="ti">
            <li class="i1">编号</li>
            <li class="i2">询价产品</li>
            <li class="i3">联系人</li>
            <li class="i4">电话</li>
            <li class="i5">询价品牌</li>
            <li class="i6">询价区域</li>
            <li class="i7">询价时间</li>
          </ul>
          <div class="li">
		  	   <%
    if(null!=orderList && orderList.size()>0){
      int k = orderList.size()>10?10:orderList.size() ;
         String showtel = "" ; 
       for(int i=0;i<k;i++){
        oneMap = orderList.get(i) ;
        showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("mobile_phone")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
        
        if(showtel.length()>7&&showtel.length()<=20){
          showtel = showtel.substring(0,2)+"***"+showtel.substring(showtel.length()-2) ;
        }else if(showtel.length()>3){
          showtel = showtel.substring(0,4)+"***" ;
        }else
        {
          showtel = showtel+"***" ;
        }
     %>
        <ul class="libg01">
          <li class="i1"><%=i+1 %></li>
          <li class="i2"><a title="<%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %>" target="_blank" href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm"><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel %></li>
          <li class="i5"><a href="/inquiry/0_0_1742_0_0.shtm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
          <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
        </ul>

         <%}}%> 
          </div>
          <!--翻页--> 
          <!-- 
  <div class="w755 l">
    <div id="pagination" class="page"> <span> <a onclick="goToTop();" href="#" target="_self" class="goTop">返回顶部</a> </span> </div>
  </div>
   --> 
          <!--翻页--> 
        
        </div>
      </div>
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