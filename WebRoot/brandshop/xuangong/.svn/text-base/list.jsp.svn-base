<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%	
	DBHelper dbHelper = DBHelper.getInstance() ;
	String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
	//机器列表
	String pro_sql = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=154 and is_show=1 and catalognum like '"+catalog+"%'  order by id desc" ;
	List<Map> newProductsList = null ;
	newProductsList = dbHelper.getMapList(pro_sql) ;
   //公司信息
   String  company="select introduce from pro_agent_factory where id=154";
   List<Map> companyInfo = null ;
   companyInfo = dbHelper.getMapList(company) ;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>河北宣化官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
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
           <li <%if(catalog.equals("101001")){%>class="select"<%}%>><a href="/brandshop/xuangong/list.jsp?catalog=101001">宣工挖掘机</a></li>
           <li  <%if(catalog.equals("101003")){%>class="select"<%}%>><a href="/brandshop/xuangong/list.jsp?catalog=101003">宣工推土机</a></li>
          <li class=""><a href="/brandshop/xuangong/introduce.jsp">关于宣工</a></li>		
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
      	<div class="title">
          <h3><strong>河北宣化工程机械</strong>
           <span class="en"><em>HUATONG Products list</em><br />
           Asphalt Mixing Series
           </span>
          </h3>
         </div>
        <ul class="shopPros01" style="padding-bottom:15px;">
        <%
			if(null!=newProductsList && newProductsList.size()>0){
				Map oneMap = null ;
				for(int i=0;i<newProductsList.size();i++){
					oneMap = (HashMap)newProductsList.get(i);
		%>
         <li>
            <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="225" height="212" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"/></a></div>
            <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("name")) %></a></h3>
            <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" target="_blank">评论</a></span>
            <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="priceBtn">立即询价</a>
          </li>
       <%
				}
			}
		%>		
 
        			
        </ul>
        <div class="shopListPage" style="display:none;">
         <div class='paging page' id='pagination'> <span class="current" style="cursor: default;border:none;color:#000;"><b>&nbsp;1&nbsp;</b></span> </div>
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
            <span>共有<font><%=pageBean.getTotal()  %></font>个符合条件</span> </div>
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



<div style="width:980px; margin:0 auto; clear:both; position:relative;" class="proFoot">
<div style="position:absolute; right:-18px; top:36px; width:160px; text-align:center;"><img src="/images/ewm_new.gif" width="90" height="90" /><br />关注工程机械产品查询中心<br />抢先查询新品信息</div>
<link rel="stylesheet" href="http://www.21-sun.com/00css/new_21sun_include.css" type="text/css" />
<div class="New_website">
  <div class="New_linksContain">
    <strong><span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span>旗下网站：</strong>
    <span class="New_links" onclick="window.open('http://part.21-sun.com/');">中国工程机械配件网</span>
    <span class="New_links" onclick="window.open('http://www.21-cmjob.com/');">中国工程机械人才网</span>
    <span class="New_links" onclick="window.open('http://www.21-rent.com/');">中国工程机械租赁网</span>
    <span class="New_links" onclick="window.open('http://www.21-used.com/');">中国工程机械二手网</span>
    <span class="New_links" onclick="window.open('http://www.21part.com/');">配件商城</span>
    <span class="New_links" onclick="window.open('http://www.21peitao.com/');">配套网</span>
    <span class="New_links" onclick="window.open('http://www.cmbol.com/');">工程机械外贸网</span>
    <span class="New_links" onclick="window.open('http://product.21-sun.com/');">铁臂商城</span>
  </div>
</div>
<div class="New_foot">
  <span class="New_links" onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');">广告服务</span><em>|</em>
  <span class="New_links" onclick="window.open('http://aboutus.21-sun.com/contact/');">联系方式</span><em>|</em>
  <span class="New_links" onclick="window.open('http://aboutus.21-sun.com');">关于我们</span><em>|</em>
  <span class="New_links" onclick="window.open('http://aboutus.21-sun.com/news/');">本网动态</span><em>|</em>
  <span class="New_links" onclick="window.open('http://aboutus.21-sun.com/contact/legal.jsp');">法律声明</span><em>|</em>
  <span class="New_links" onclick="window.open('http://aboutus.21-sun.com/map.htm');">网站导航</span><em>|</em>
  <span class="New_links" onclick="window.open('http://www.21-sun.com/contact/');">联系客服</span><br/>
  主编：<a href="mailto:webmaster@21-sun.com" rel="nofollow">webmaster@21-sun.com</a><em>&nbsp;</em>
  市场部：<a href="mailto:market@21-sun.com" rel="nofollow">market@21-sun.com</a><em>&nbsp;</em>
  技术部：<a href="mailto:tech@21-sun.com" rel="nofollow">tech@21-sun.com</a><em>&nbsp;</em>
  广告部：<a href="mailto:ads@21-sun.com" rel="nofollow">ads@21-sun.com</a><br/>
  产品询价专线：4006-521-526<em>&nbsp;</em>业务联系：(总机)0535-6722555<br/>
  <span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span>
  Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>
</div>
</div>
<div style="display:none"> 
  <script type="text/javascript">
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
  </script>
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://product.21-sun.com', "");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<!-- Baidu Button BEGIN -->
<div style="width:300px; margin:0px auto;" >
<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare" style="padding-left:50px;" >
<a class="bds_qzone"></a>
<a class="bds_tsina"></a>
<a class="bds_tqq"></a>
<a class="bds_renren"></a>
<a class="bds_t163"></a>
<span class="bds_more">更多</span>
</div>
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=0" ></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
</script>
</div>
<!-- Baidu Button END -->
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