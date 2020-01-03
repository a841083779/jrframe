<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;

	//rec
	List<Map> recProductsList = new ArrayList() ;
	String rec_sql = "select top 3 * from pro_agent_product_vi where agentid=282 and id in (select max(id) as id  from  pro_agent_product_vi where agentid=282 and is_show=1 group by factoryid)" ; 
	recProductsList = dbHelper.getMapList(rec_sql+"order by order_no") ;

	//doosan
	List<Map> doosanProductsList = new ArrayList() ;
	String doosan_rec_sql = "select top 4 * from pro_agent_product_vi where agentid=282 and factoryid=192 and id<>'406' and is_show=1" ; 
	doosanProductsList = dbHelper.getMapList(doosan_rec_sql+"order by view_count desc") ;
	
	//kato
	List<Map> katoProductsList = new ArrayList() ;
	String kato_rec_sql = "select top 4 * from pro_agent_product_vi where agentid=282 and factoryid=189 and id<>'15096' and is_show=1" ; 
	katoProductsList = dbHelper.getMapList(kato_rec_sql+"order by order_no ,view_count desc") ;
	
	//liugong-wajueji
	List<Map> liugongWProductsList = new ArrayList() ;
	String liugong_wrec_sql = "select top 4 * from pro_agent_product_vi where agentid=282 and factoryid=136 and catalognum like '101001%' and id<>'7645' and id<>'813' and is_show=1" ; 
	liugongWProductsList = dbHelper.getMapList(liugong_wrec_sql+"order by order_no ,view_count desc") ;
	
	//liugong-zhuangzaiji
	List<Map> liugongZProductsList = new ArrayList() ;
	String liugong_zrec_sql = "select top 4 * from pro_agent_product_vi where agentid=282 and factoryid=136 and catalognum like '101002%' and id<>'7645' and id<>'813' and is_show=1" ; 
	liugongZProductsList = dbHelper.getMapList(liugong_zrec_sql+"order by order_no ,view_count desc") ;
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>松宇企业集团_中国工程机械商贸网</title>
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
<jsp:include page="top.jsp" flush="true"></jsp:include>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>

<div class="slide shopBanner">
  <div class="ban_c"><img src="images/banner01.jpg" width="1920" height="550" /></div>
  <div class="ban_c"><img src="images/banner01.jpg" width="1920" height="550" /></div>
</div>
<div class="brand_logos">
  <div class="wrap">
    <ul class="fix">
      <li><a href="#doosan"><img src="images/brand_logo01.png" alt="斗山机械" width="315" height="98" /></a></li>
      <li><a href="#kato"><img src="images/brand_logo02.png" alt="广西加藤" width="315" height="98" /></a></li>
      <li><a href="#liugong"><img src="images/brand_logo03.png" alt="柳工机械" width="315" height="98" /></a></li>
    </ul>
  </div>
</div>
<div class="recPro">
  <div class="hd">
    <div class="shopWrap">
      <h2 class="hide">产品推荐</h2>
      <a href="list.jsp" class="fs_more">查看更多</a>
    </div>
  </div>
  <div class="bd">
    <div class="shopWrap shop_list">
      <ul class="fix">
      <%
	    if(recProductsList!=null && recProductsList.size()>0){
	    	for(Map m:recProductsList){
	    		String id = CommonString.getFormatPara(m.get("id"));
	    		String file_name = CommonString.getFormatPara(m.get("file_name"));
	    		String name = CommonString.getFormatPara(m.get("name"));
	    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
	    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
	    		String img2 = CommonString.getFormatPara(m.get("img2"));
	    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
	    %>
        <li><a  href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles<%=img2 %>" width="230px" height="230px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/>
          <p class="text">
            产品：<%=factoryname+catalogname %><br />
            型号：<%=name %>
          </p></a><a class="xj_btn" href="javascript:void(0);" onclick="showinquery('<%=id %>','')">立即询价</a>
        </li>
		<%}} %>
      </ul>
    </div>
  </div>
</div>
<div class="sp doosan" id="doosan">
  <div class="hd">
    <div class="shopWrap">
      <h2 class="hide">斗山机械</h2>
      <a href="list.jsp?factoryid=192" class="fs_more">查看更多</a>
    </div>
  </div>
  <div class="bd">
    <div class="sp_rec"><a class="xj_btn" href="http://product.21-sun.com/proDetail/DX60.shtm" target="_blank">立即询价</a></div>
    <div class="shopWrap shop_list01">
      <ul class="fix">
      <%
	    if(doosanProductsList!=null && doosanProductsList.size()>0){
	    	for(Map m:doosanProductsList){
	    		String id = CommonString.getFormatPara(m.get("id"));
	    		String file_name = CommonString.getFormatPara(m.get("file_name"));
	    		String name = CommonString.getFormatPara(m.get("name"));
	    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
	    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
	    		String img2 = CommonString.getFormatPara(m.get("img2"));
	    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
	    %>
        <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles<%=img2 %>" width="230px" height="230px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a>
          <p class="text">
            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><strong><%=name+" "+catalogname %></strong></a>
            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">详情</a> | <a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a>
          </p><a class="xj_btn" href="javascript:void(0);" onclick="showinquery('<%=id %>','')">立即询价</a>
        </li>
        <%}} %>
      </ul>
    </div>
  </div>
</div>

<div class="sp kato" id="kato">
  <div class="hd">
    <div class="shopWrap">
      <h2 class="hide">广西加藤</h2>
      <a href="list.jsp?factoryid=189" class="fs_more">查看更多</a>
    </div>
  </div>
  <div class="bd">
    <div class="sp_rec"><a class="xj_btn" href="http://product.21-sun.com/proDetail/HD2048R.shtm" target="_blank">立即询价</a></div>
    <div class="shopWrap shop_list01">
      <ul class="fix">
       <%
	    if(katoProductsList!=null && katoProductsList.size()>0){
	    	for(Map m:katoProductsList){
	    		String id = CommonString.getFormatPara(m.get("id"));
	    		String file_name = CommonString.getFormatPara(m.get("file_name"));
	    		String name = CommonString.getFormatPara(m.get("name"));
	    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
	    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
	    		String img2 = CommonString.getFormatPara(m.get("img2"));
	    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
	    %>
        <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles<%=img2 %>" width="230px" height="230px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a>
          <p class="text">
            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><strong><%=name+" "+catalogname %></strong></a>
            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">详情</a> | <a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a>
          </p><a class="xj_btn" href="javascript:void(0);" onclick="showinquery('<%=id %>','')">立即询价</a>
        </li>
        <%}} %>
      </ul>
    </div>
  </div>
</div>

<div class="sp liugong" id="liugong">
  <div class="hd">
    <div class="shopWrap">
      <h2 class="hide">柳工机械</h2>
    </div>
  </div>
  <div class="bd">
    <div class="shopWrap">
      <div class="fix">
        <div class="li">
          <div class="li-hd">
            <h3>柳工挖掘机</h3>
            <a class="fs_more" href="list.jsp?factoryid=136&catalognum=101001">查看更多</a>
          </div>
          <div class="li-bd">
            <a href="http://product.21-sun.com/proDetail/915D.shtm" target="_blank" title="柳工915D挖掘机"><img src="images/lingongim-02.jpg" width="473" height="380" alt="柳工915D挖掘机" /><strong>915D挖掘机</strong></a>
            <a onclick="showinquery('7645','')" href="javascript:void(0);" class="xj_btn">立即询价</a>
          </div>
          <div class="shop_list01">
            <ul class="fix">
            <%
		    if(liugongWProductsList!=null && liugongWProductsList.size()>0){
		    	for(Map m:liugongWProductsList){
		    		String id = CommonString.getFormatPara(m.get("id"));
		    		String file_name = CommonString.getFormatPara(m.get("file_name"));
		    		String name = CommonString.getFormatPara(m.get("name"));
		    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
		    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
		    		String img2 = CommonString.getFormatPara(m.get("img2"));
		    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
		    %>
              <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles<%=img2 %>" width="230px" height="230px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a>
		          <p class="text">
		            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><strong><%=name+" "+catalogname %></strong></a>
		            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">详情</a> | <a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a>
		          </p><a class="xj_btn" href="javascript:void(0);" onclick="showinquery('<%=id %>','')">立即询价</a>
		        </li>
             <%}} %>
            </ul>
          </div>
        </div>
        <div class="li">
          <div class="li-hd">
            <h3>柳工装载机</h3>
            <a class="fs_more" href="list.jsp?factoryid=136&catalognum=101002">查看更多</a>
          </div>
          <div class="li-bd">
            <a href="http://product.21-sun.com/proDetail/CLG856.shtm" target="_blank" title="柳工CLG856轮式装载机"><img src="images/lg_img01.jpg" width="473" height="380" alt="柳工CLG856轮式装载机" /><strong>CLG856轮式装载机</strong></a>
            <a onclick="showinquery('813','')" href="javascript:void(0);" class="xj_btn">立即询价</a>
          </div>
          <div class="shop_list01">
            <ul class="fix">
              <%
		    if(liugongZProductsList!=null && liugongZProductsList.size()>0){
		    	for(Map m:liugongZProductsList){
		    		String id = CommonString.getFormatPara(m.get("id"));
		    		String file_name = CommonString.getFormatPara(m.get("file_name"));
		    		String name = CommonString.getFormatPara(m.get("name"));
		    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
		    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
		    		String img2 = CommonString.getFormatPara(m.get("img2"));
		    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
		    %>
              <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles/<%=img2 %>" width="230px" height="230px" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"/></a>
		          <p class="text">
		            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><strong><%=name+" "+catalogname %></strong></a>
		            <a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank">详情</a> | <a href="/proDetail/<%=file_name.replace(".shtm", "_parameter.shtm") %>" title="<%=factoryname+name+catalogname %>参数" target="_blank">参数</a>
		          </p><a class="xj_btn" href="javascript:void(0);" onclick="showinquery('<%=id %>','')">立即询价</a>
		        </li>
             <%}} %>
            </ul>
          </div>
        </div>
      </div>
    </div>
    
  </div>
</div>
<div class="shopWrap fix pb10 proOrder">
  <div class="hd">
    <h3>产品订单</h3>
    <span class="more"><a href="/inquiry/" target="_blank">更多&gt;&gt;</a></span>
  </div>
  <div class="bd fix">
    <div class="w978 border03 l list08">
    <%
		String offset = CommonString.getFormatPara(request.getParameter("offset"));
       	List<Map> orderList = null ;
       	PageBean pageBean = new  PageBean() ;
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setTableName("pro_agent_products_form") ;
		pageBean.setFields("factory_id factoryid ,id,factory_name factoryname,product_name,contact_address,cata_name cataname,user_name name,contact_tel mobile_phone,province,city,add_date") ;
		pageBean.setPageSize(10) ;
		pageBean.setCondition(" and agent_id=282 and factory_name <>'' and factory_name is not null and user_name is not null and user_name<>'' and product_name is not null and product_name<>''") ;
		pageBean.setNowPage(nowPage) ;
		pageBean.setOrderBy(" add_date desc") ;
		pageBean.setParams("#to_order") ;
		orderList = pageBean.getDatas() ;
       %>
      <div class="title08">
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
    <div class="page" style="margin-left:467px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
  </div>
</div>
<!--foot-->
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript" src="scripts/slide.js"></script>
<script type="text/javascript">
(function(jQuery){
 jQuery.extend(jQuery.fn,{
 scrollTo:function(time,to){
 time=time||800;
 to=to||1;
            jQuery('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
location.hostname == this.hostname) {
      var jQuerytarget = jQuery(this.hash);
     jQuerytarget = jQuerytarget.length && jQuerytarget || jQuery('[name=' + this.hash.slice(1) + ']');
                    if (jQuerytarget.length) {
                        if (to == 1) {
                            jQuery('html,body').animate({
                                scrollTop: jQuerytarget.offset().top
                            }, time);
                        }
                        else if(to==2){
                            jQuery('html,body').animate({
                                scrollLeft: jQuerytarget.offset().left
                            }, time);
                        }else{
alert('argument error');
  }
                        return false;
                    }
                }
            });
  }
 });
})(jQuery);
</script> 
<script type="text/javascript" language="javascript">
jQuery(function(){
  jQuery(".shop_topbg").scrollTo(700);
});
</script>
<script type="text/javascript" language="javascript">
//营销宝统计
jQuery(function(){
  jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'282'} ,
    	success:function(msg){
    	}
    }) ;
});
</script> 
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