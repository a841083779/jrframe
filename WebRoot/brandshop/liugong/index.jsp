<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
  Map oneMap = null ;
  DBHelper dbHelper = DBHelper.getInstance() ;
  //推荐
  String sql_tj = "select top 4 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=136 and is_show=1 order by view_count desc" ;
  List<Map> productsListTj = null ;
  productsListTj = dbHelper.getMapList(sql_tj) ;
  //挖掘机
  String sql_wjj = "select top 6 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=136 and is_show=1 and catalognum like '101001%' order by view_count desc" ;
  List<Map> productsListWjj = null ;
  productsListWjj = dbHelper.getMapList(sql_wjj) ;
  //装载机
  String sql_zzj = "select top 6 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=136 and is_show=1 and catalognum like '101002%' order by view_count desc" ;
  List<Map> productsListZzj = null ;
  productsListZzj = dbHelper.getMapList(sql_zzj) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<div class="lg_logo shop_topbg">
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
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>
<!--banner-->
<div class="slide shopBanner">
  <div class="ban_c"><img src="images/banner.jpg" ></div>
</div>
<div class="contain980">
  <div class="pro_tuijian">
    <ul class="fix">
    <% 
		if(null!=productsListTj && productsListTj.size()>0){
			for(Map m : productsListTj){
				String id = CommonString.getFormatPara(m.get("id"));
	    		String file_name = CommonString.getFormatPara(m.get("file_name"));
	    		String name = CommonString.getFormatPara(m.get("name"));
	    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
	    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
	    		String img2 = CommonString.getFormatPara(m.get("img2"));
	    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
        %>
      <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">
        <p><%=catalogname+" "+name %></p>
        <img src="/uploadfiles<%=img2 %>" width="232px" height="183px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a></li>
      <%}}%>
    </ul>
  </div>
</div>
<div class="contain980 mt20"><a href="/proDetail/CLG855N-5T.shtm" title="柳工CLG855N-5t轮式装载机" target="_blank"><img src="images/pro_tui.jpg" width="980" height="563"/></a></div>
<!--柳工挖掘机-->
<div class="contain980 mt30">
  <div class="channel">
    <div class="l channelIT"><span class="x_tubiao"><i class="ico icoposition"></i></span>
      <div class="channelIN"><span class="p1">柳工挖掘机</span><span>致力于为客户提供卓越的工程机械产品和服务</span></div>
    </div>
    <a href="list.jsp?catalog=101001" class="r more" target="_blank">查看更多</a></div>
  <div class="img"><a href="http://product.21-sun.com/proDetail/CLG933E.shtm" title="柳工CLG933E挖掘机" target="_blank"><img src="images/pro_zzj.jpg"/></a></div>
</div>
<div class="contain980">
  <div class="pro_list">
    <ul class="fix">
    <% 
		if(null!=productsListWjj && productsListWjj.size()>0){
			for(Map m : productsListWjj){
				String id = CommonString.getFormatPara(m.get("id"));
	    		String file_name = CommonString.getFormatPara(m.get("file_name"));
	    		String name = CommonString.getFormatPara(m.get("name"));
	    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
	    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
	    		String img2 = CommonString.getFormatPara(m.get("img2"));
	    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
        %>
      <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"> <img src="/uploadfiles/<%=img2 %>" width="296px" height="232px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a>
        <div class="intro">
          <h3><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><%=catalogname+" "+name %></a></h3>
          <span><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">详情</a><em>|</em><a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a></span><a href="javascript:void(0);" onclick="showinquery('<%=id %>','')" class="xunjia">立即询价</a></div>
      </li>
       <%}}%>
    </ul>
  </div>
</div>
<!--柳工装载机-->
<div class="contain980 mt30">
  <div class="channel">
    <div class="l channelIT"><span class="x_tubiao"><i class="ico icoposition1"></i></span>
      <div class="channelIN"><span class="p1">柳工装载机</span><span>致力于为客户提供卓越的工程机械产品和服务</span></div>
    </div>
    <a href="list.jsp?catalog=101002" class="r more" target="_blank">查看更多</a></div>
  <div class="img"><a href="http://product.21-sun.com/proDetail/856H.shtm" title="柳工856H轮式装载机" target="_blank"><img src="images/zzj_03.jpg"/></a></div>
</div>
<div class="contain980">
  <div class="pro_list">
    <ul class="fix">
      <% 
		if(null!=productsListZzj && productsListZzj.size()>0){
			for(Map m : productsListZzj){
				String id = CommonString.getFormatPara(m.get("id"));
	    		String file_name = CommonString.getFormatPara(m.get("file_name"));
	    		String name = CommonString.getFormatPara(m.get("name"));
	    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
	    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
	    		String img2 = CommonString.getFormatPara(m.get("img2"));
	    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
        %>
      <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"> <img src="/uploadfiles/<%=img2 %>" width="296px" height="232px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a>
        <div class="intro">
          <h3><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><%=catalogname+" "+name %></a></h3>
          <span><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">详情</a><em>|</em><a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a></span><a href="javascript:void(0);" onclick="showinquery('<%=id %>','')" class="xunjia">立即询价</a></div>
      </li>
       <%}}%>
    </ul>
  </div>
</div>
<!--产品订单-->
<div class="contain980 mt30 bg">
  <div class="channel">
    <div class="l channelIT"><span class="x_tubiao"><i class="ico icoposition2"></i></span>
      <div class="channelIN"><span class="p1">产品订单</span><span>致力于为客户提供卓越的工程机械产品和服务</span></div>
    </div>
    <a href="http://product.21-sun.com/inquiry/0_0_136_0_0.shtm" target="_blank" title="更多柳工订单" class="r more">查看更多</a></div>
</div>
<div class="contain980 bg">
  <div class="order_list fix">
  <div class=" border03 l list08 fix">
	 <%
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
	   pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition("and is_deleted=0 and factoryid=136 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(1) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
	  %>
      <div class="title08">
        <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
        <span>共有<font><%=pageBean.getTotal()  %></font>个符合条件</span> </div>
      <ul class="ti fix">
        <li class="i1">编号</li>
        <li class="i2">询价产品</li>
        <li class="i3">联系人</li>
        <li class="i4">电话</li>
        <li class="i5">询价品牌</li>
        <li class="i6">询价区域</li>
        <li class="i7">询价时间</li>
      </ul>
      <div class="li fix">
	  <%
	  if(null!=orderList && orderList.size()>0){
		  int k = orderList.size()>10?10:orderList.size() ;
      	 String showtel = "" ; 
	  	 for(int i=0;i<k;i++){
	  		oneMap = orderList.get(i) ;
    		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
    		
    		if(showtel.length()>7&&showtel.length()<=20){
    			showtel = showtel.substring(0,2)+"***"+showtel.substring(showtel.length()-2) ;
    		}else if(showtel.length()>2){
    			showtel = showtel.substring(0,3)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
      %>
        <ul class="libg01">
            <li class="i1"><%=i+1 %></li>
            <li class="i2"><a href="/inquiry/details_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
            <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
            <li class="i4"><%=showtel %></li>
            <li class="i5"><a target="_blank" href="/inquiry/?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
            <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
            <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
          </ul>
     <%
	  	 }
	  }
	  %>
      
      </div>
    </div>
  </div>
</div>
<!--foot-->
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
</body>
<script type="text/javascript">
jQuery(function(){
	  jQuery(".shop_topbg").scrollTo(700);
	});
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
</html>