<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%	
	DBHelper dbHelper = DBHelper.getInstance() ;
	//推土机
	String ttj_sql = "select top 6 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=154 and is_show=1 and catalognum like '101003%'  order by id desc" ;
	List<Map> productsListTtj = null ;
	productsListTtj = dbHelper.getMapList(ttj_sql) ;
	//挖掘机
	String wjj_sql = "select top 3 id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=154 and is_show=1 and catalognum like '101001%' order by id desc" ;
	List<Map> productsListWjj = null ;
	productsListWjj = dbHelper.getMapList(wjj_sql) ;
	//新品推荐
	List<Map> newProductsList = new ArrayList() ;
	String new_sql = "select top 2 * from pro_products where factoryid=154 and is_show=1  and zoomlion_hot=11 order by id desc" ; 
	newProductsList = dbHelper.getMapList(new_sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>河北宣化官方旗舰店 - 铁臂商城</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript">
   //EvPNG.fix('.png'); 
</script>
</head>
<body class="flag_shop home">
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
<div class="nav">
	<ul class="wrap">
        <li><a href="/brandshop/xuangong/">首页</a></li>
        <li><a href="/brandshop/xuangong/list.jsp?catalog=101001">宣工挖掘机</a></li>
        <li><a href="/brandshop/xuangong/list.jsp?catalog=101003">宣工推土机</a></li>
        <li><a href="/brandshop/xuangong/introduce.jsp">关于宣工</a></li>
    </ul>
</div>
<div class="banner"></div>
<div class="wrap">
	<div class="con1 clearfix">
    	<div class="tit clearfix">
       		 <i></i>
        	<h3>最新产品<span>New</span> </h3>
    
        </div>
        <ul class="picList">
		<%
			if(null!=newProductsList && newProductsList.size()>0){
				Map oneMap = null ;
				for(int i=0;i<newProductsList.size();i++){
					oneMap = (HashMap)newProductsList.get(i);
		%>
        	<li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img  src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>"/></a>
            	<div class="info" style="width: 360px">
                	<div class="l">
                   	 <h3 style="width:250px;">宣工<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></h3>
                     <a href="http://product.21-sun.com/inquiry/?factory=154" target="_blank">订单</a>
                      <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a>
                       <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" target="_blank">评论</a>
                    </div>
                	<a class="orderBtn r" href="javasrcipt:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');""></a>
                </div>
            </li>
		<%
				}
			}
		%>
        </ul>
    </div>
    <div class="blank"></div>
    <div class="con2 clearfix">
    	<div class="tit clearfix">
       		 <i></i>
        	<h3>宣工推土机<span>Bulldozer</span> </h3>
            <a class="more" href="/brandshop/xuangong/list.jsp?catalog=101003"></a>
        </div>
        <ul class="picList">
	    <%
			if(null!=productsListTtj && productsListTtj.size()>0){
				Map oneMap = null ;
				for(int i=0;i<productsListTtj.size();i++){
					oneMap = (HashMap)productsListTtj.get(i);
		%>
        	<li>
            	<a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img width="310" height="249"  src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>"/></a>
                <div class="info2">
                <div class="l">
                	<h3>宣工<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></h3>
                    <a href="http://product.21-sun.com/inquiry/?factory=154" target="_blank">订单</a>
                      <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a>
                       <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" target="_blank">评论</a>
                </div>
                <a class="btn r" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');">立即询价</a>
                </div>
            </li>
		<%
				}
			}
		%>
        </ul>
    </div>
     <div class="blank"></div>
     <div class="con3 con2 clearfix">
    	<div class="tit clearfix">
       		 <i></i>
        	<h3>宣工挖掘机<span>Excavator</span> </h3>
            <a class="more" href="/brandshop/xuangong/list.jsp?catalog=101001" ></a>
        </div>
        <ul class="picList">
		<%
			if(null!=productsListWjj && productsListWjj.size()>0){
				Map oneMap = null ;
				for(int i=0;i<productsListWjj.size();i++){
					oneMap = (HashMap)productsListWjj.get(i);
		%>
		
        	<li>
            <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">	<img width="310" height="249"  src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>"/></a>
                <div class="info2">
                <div class="l">
                	<h3>宣工<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></h3>
                    <a href="http://product.21-sun.com/inquiry/?factory=154" target="_blank">订单</a>
                      <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a>
                       <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" target="_blank">评论</a>
                </div>
                <a class="btn r" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');">立即询价</a>
                </div>
            </li>
		<%
				}
			}
		%>
        </ul>
    </div>
    <div class="blank"></div>
	
     <div class="con4 clearfix">
    	<div class="tit clearfix">
       		 <i></i>
        	<h3>产品订单<span>Orders</span> </h3>
            <a class="more" href="http://product.21-sun.com/inquiry/?factory=154" target="_blank"></a>
        </div>
        
        <div class="picList" style="height:410px;">
        	<div class="w755 border03 l mb10 list08">
          <div class="title12">
       
            <h3>宣工产品订单</h3>
            <span><a href="/inquiry/?factory=154" target="_blank">更多&gt;&gt;</a></span> </div>
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
    		 <ul class="libg01">
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
		        <div class="page" style="margin-left:450px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
        </div>
        
         </div>
        
        
     </div>
     <div class="blank"></div>
</div>
<div class="foot">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<script type="text/javascript">
   function showAuto3(){} 
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
</script>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>