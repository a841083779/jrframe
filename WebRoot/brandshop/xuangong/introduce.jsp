<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String factoryid_sub = CommonString.getFormatPara(request.getParameter("factoryid_sub")) ; // 品牌 id
String sel_sql = " select catalogname from pro_factory_category where factoryid=? and num =?" ;
DBHelper dbHelper = DBHelper.getInstance() ;
//选出所有的类别
String sel_sql2 = " select num,catalogname from dbo.pro_factory_category where factoryid=1236 order by id" ;
List<Map> catalogList = dbHelper.getMapList(sel_sql2) ;
String catalogname = "" ;
if(null!=catalogList && catalogList.size()>0){
	for(Map oneMap:catalogList){
		if(catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))){
			catalogname = CommonString.getFormatPara(oneMap.get("catalogname")) ;
			break ;
		}
	}
}
   //公司信息
   String  company="select introduce from pro_agent_factory where id=154";
   List<Map> companyInfo = null ;
   companyInfo = dbHelper.getMapList(company) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>河北宣化官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="河北宣化" />
<meta name="description" content="河北宣化官方旗舰店" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<div class="bar">
	<div class="wrap clearfix">
    	<div class="logo l"></div>
        <h1>河北宣化工程机械股份有限公司</h1>
        <a class="collect"  onclick="addShop()"></a>
        <p class="tel">
        <span><i class="ii1"></i>400-6126-033</span>
        <span><i class="ii2"></i>0313-3186191</span>
        </p>
    </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
        <li><a href="/brandshop/xuangong/">首页</a></li>
        <li><a href="/brandshop/xuangong/list.jsp?catalog=101001">宣工挖掘机</a></li>
        <li><a href="/brandshop/xuangong/list.jsp?catalog=101003">宣工推土机</a></li>
        <li><a href="/brandshop/xuangong/introduce.jsp">关于宣工</a></li>
    </ul>
  </div>
</div>
<!--main-->
<div class="shopPart03">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain">
      <div class="shopLeftPart">
        <h2>所有产品分类&gt;&gt;</h2>
        <ul class="shopListMenu">
           <li class=""><a href="/brandshop/xuangong/list.jsp?catalog=101001">宣工挖掘机</a></li>
           <li class=""><a href="/brandshop/xuangong/list.jsp?catalog=101003">宣工推土机</a></li>
          <li class="select"><a href="/brandshop/xuangong/introduce.jsp">关于宣工</a></li>		
        </ul>
        
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro">
             <strong class="name">河北宣化工程机械</strong>
              <a href="/brandshop/xuangong/introduce.jsp" target="_blank" style="color:#434343;">
			  <%
			  if(null!=companyInfo && companyInfo.size()>0){
				Map oneMap = null ;
				for(int i=0;i<companyInfo.size();i++){
					oneMap = (HashMap)companyInfo.get(i);
					String intro=CommonHtml.filterHTML(CommonString.getFormatPara(oneMap.get("introduce")));
					if(intro.length()>70){intro=intro.substring(0,70);}
		     %>
			    <%=intro%>
				<%}}%>
			  </a>
              <span class="more"><a href="/brandshop/xuangong/introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
          </div>
        </div>
        
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><a title="河北宣化官方旗舰店" target="_blank" href="/brandshop/huatong/"><img src="images/inbanner.jpg"  /></a></div>
        
        <div class="intro_text">
           <div style="width:650px;">　 
		   			  <%
			  if(null!=companyInfo && companyInfo.size()>0){
				Map oneMap = null ;
				for(int i=0;i<companyInfo.size();i++){
					oneMap = (HashMap)companyInfo.get(i);
		     %>
			   <%=CommonString.getFormatPara(oneMap.get("introduce")) %>
				<%}}%>
		   
</div>
        </div>
              
        <div class="l bdintro" style="width:720px; padding:10px 0px;">
        
          <div class="l"><img width="188" height="45" onclick="showinquery('','154')" src="/images/pd_btn.gif" style="cursor:pointer"></div>
          
          <div class="r"><a href="/admin/login.jsp" target="_blank">厂家登录</a> </div>
          <div class="checkContact"> 
          <span style="background:url(/images/contact_layer_point.gif) right no-repeat;display:block" onclick="document.getElementById('contactLayer').style.display='block';">联系电话</span>
          <div style="display: none; position: relative;" id="contactLayer"> <a onclick="jQuery('#contactLayer').hide();" class="ContactCloseBtn" href="javascript:void(0);"></a>
            <h3>联系电话</h3>
            <div class="cc">联系本站（4006-521-526）<br>
           </div>
            <div style="padding-left:20px; line-height:18px;">联系我们时，请说是在 <strong>中国工程机械商贸网</strong> 上看到的。</div>
            <div class="cb"><a href="javascript:void(0)"><img onclick="showinquery('','154')" src="/images/pd_btn.gif"></a></div>
          </div>
        </div>
        </div>
        
        <div class="w755 border03 l mb10 list08">
          <div class="title12">
            <h3>宣工产品订单</h3>
            <span><a target="_blank" href="/inquiry/?factory=154">更多&gt;&gt;</a></span> </div>
          <div class="title08">
		  		 <%
   	    String offset = CommonString.getFormatPara(request.getParameter("offset"));
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
       pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition(" and factoryid=154 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
            <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
            <span>共有<font><%=pageBean.getTotal() %></font>个符合条件</span> </div>
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
      	 Map oneMap = null ;
	  	 for(int i=0;i<k;i++){
	  		oneMap = orderList.get(i) ;
    		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
    		
    		if(showtel.length()>7&&showtel.length()<=20){
    			showtel = showtel.substring(0,3)+"***"+showtel.substring(showtel.length()-3) ;
    		}else if(showtel.length()>3){
    			showtel = showtel.substring(0,4)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
    	%>  
    		 <ul class='libg01'>
            <li class="i1"><%=i+1 %></li>
            <li class="i2"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
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
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="flagshopbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot-->
<script type="text/javascript">
jQuery(function(){
	jQuery(".shopPros01 li").hover(function(){ 
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
</script>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/xuangong/', '宣工官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('宣工官方旗舰店', 'http://product.21-sun.com/brandshop/xuangong/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
DK.load('scripts/core.js', function(){ 
	DK.index.init();
});
</script> 
</body>
</html>