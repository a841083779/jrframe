<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
    DBHelper dbHelper = DBHelper.getInstance() ;
	 Map oneMap = null ;
    String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
	 String sql_sql = "select id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1 and catalognum like '"+catalog+"%' order by view_count desc" ;
	List<Map> newProductsList = null ;
    newProductsList = dbHelper.getMapList(sql_sql) ;
	String catalogNames="所有产品";
   if(catalog.equals("103002")){catalogNames="混凝土搅拌设备";}
   if(catalog.equals("102002")){catalogNames="塔式起重机";}
   if(catalog.equals("102011")){catalogNames="施工升降机";}
   if(catalog.equals("104006")){catalogNames="稳定土拌和站";}
   if(catalog.equals("103019")){catalogNames="混凝土搅拌运输车";}
   if(catalog.equals("103020")){catalogNames="输送泵";}
   if(catalog.equals("105")){catalogNames="桩工机械";}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>方圆旗舰店-中国工程机械商贸网</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/fangyuan.css" rel="stylesheet" type="text/css" />
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
<body class="fy_body">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end--> 
<!--main-->
<div class="fy_top">
  <div class="contain980 fix">
    <h2 class="fy_logo"><a href="/brandshop/fangyuan/" title="方圆集团"><img src="images/fy_logo.gif" alt="方圆集团"/></a></h2>
    <ul class="fy_nav fix">
     <li <% if(catalog.equals("")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/"  title="首页">首页</a></li>
     <li <% if(catalog.equals("103002")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/list.jsp?catalog=103002" title="混凝土搅拌设备">混凝土搅拌设备</a></li>
      <li <% if(catalog.equals("102002")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/list.jsp?catalog=102002" title="塔式起重机">塔式起重机</a></li>
     <li <% if(catalog.equals("102011")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/list.jsp?catalog=102011" title="施工升降机">施工升降机</a></li>
     <li <% if(catalog.equals("104006")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/list.jsp?catalog=104006" title="稳定土拌和站">稳定土拌和站</a></li>
     <li <% if(catalog.equals("103019")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/list.jsp?catalog=103019" title="混凝土搅拌运输车">混凝土搅拌运输车</a></li>
     <li <% if(catalog.equals("103020")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/list.jsp?catalog=103020" title="输送泵">输送泵</a></li>
     <li <% if(catalog.equals("105")){%>class="cur"<%}%>><a href="/brandshop/fangyuan/list.jsp?catalog=105" title="桩工机械">桩工机械</a></li>
    </ul>
  </div>
</div>
<!--banner-->
<div class="fy_banner">
  <div class="bd">
    <ul>
      <li style="background-image:url(images/banner_01.jpg);"></li>
      <li style="background-image:url(images/banner_02.jpg);"></li>
    </ul>
  </div>
  <div class="hd"></div>
</div>
<!--banner end-->
<div class="fymain_bg">
  <div class="contain980 fix">
    <div class="fy_about">
      <div class="fy_channel_t"><a href="/brandshop/fangyuan/list.jsp?catalog=<%=catalog%>" title="<%=catalogNames%>"><%=catalogNames%></a></div>
      <div class="fy_listpro">
        <ul class="fix fypro_list">
           <% 
					
                  String fullName=null;
                  String imgSrc=null;
				  String catalogName=null;
				  String name=null;
				  String file_name=null;
				   String     id =null;
                  if(null!=newProductsList && newProductsList.size()>0){
				  
                    for(int i=0;i<newProductsList.size();i++){
                      oneMap = (HashMap)newProductsList.get(i);					
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></div>
                    <div class="fy_name">
						<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购<%=fullName+catalogName%>" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
        </ul>
      </div>
    </div>
    <div class="fy_about">
      <div class="fy_channel_t"><a href="/inquiry/0_0_671_0_0.shtm" title="方圆集团产品订单">产品订单</a></div>
      <div class="fy_about_n">
        <div class="order_list fix">
          <div class=" border03 l list08 fix">
            <div class="order_title">
              <h3>方圆集团产品订单</h3>
              <span class="more"><a target="_blank" href="/inquiry/0_0_671_0_0.shtm" title="方圆集团产品订单">更多&gt;&gt;</a></span> </div>
				 <%
        List<Map> orderList = null ;
        PageBean pageBean = new  PageBean() ;
        pageBean.setPageSize(10) ;
        pageBean.setTableName("pro_product_form") ;
        pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
        pageBean.setCondition("and factoryid=671 and is_deleted=0 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
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
          <li class="i5"><a href="/inquiry/0_0_671_0_0.shtm" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
          <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
        </ul>

         <%}}%> 
          </div>
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
<script type="text/javascript">
$(".fy_banner").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true,autoPage:true,interTime:4000});
</script>
</body>
</html>