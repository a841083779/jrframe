<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
  	String proId = CommonString.getFormatPara(request.getParameter("id"));
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	if(proId.equals("")){proId="0";}
	DBHelper dbHelper = DBHelper.getInstance() ;
    Map proMap = dbHelper.getMap("select id,name,factoryid,factoryname,catalognum,catalogname,img2,file_name from pro_products where id="+proId);
    String id="";  String name="";  String factoryid="";  String factoryname="";  String catalognum="";  String catalogname="";  String img2=""; String file_name="";
	String cataNum="";  String cataName="";  String topNum="";
    if(proMap!=null){
	    id = CommonString.getFormatPara(proMap.get("id"));
		name = CommonString.getFormatPara(proMap.get("name"));
		factoryid = CommonString.getFormatPara(proMap.get("factoryid"));
		factoryname = CommonString.getFormatPara(proMap.get("factoryname"));
		catalognum = CommonString.getFormatPara(proMap.get("catalognum"));
		catalogname = CommonString.getFormatPara(proMap.get("catalogname"));
		img2 = CommonString.getFormatPara(proMap.get("img2"));
		file_name=CommonString.getFormatPara(proMap.get("file_name"));
		if(catalognum.length()>6){cataNum=catalognum.substring(0,6); cataName=CommonString.getFormatPara(catalogMap.get(cataNum));}
		else{cataNum=catalognum; cataName=CommonString.getFormatPara(catalogMap.get(cataNum));}
		if(cataNum.length()>3){topNum=cataNum.substring(0,3);}else{topNum=cataNum;}
	}else{
		Common.do302(response,"http://koubei.21-sun.com/");
	    return;
	}
	//分类查询
    List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where len(num) = 6");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=factoryname%><%=name%><%=catalogname%>对比 - 铁臂口碑</title>
<meta name="keywords" content="<%=factoryname%><%=name%><%=catalogname%>" />
<meta name="description" content="铁臂口碑为您提供<%=factoryname%><%=name%><%=catalogname%>对比，从详情对比、口碑对比、关注度对比等方面让您全面了解<%=factoryname%><%=name%><%=catalogname%>好不好，买挖掘机，就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
//导航选中状态
var jrChannel='1#0'
</script>

</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂口碑</a> &gt;&gt; <a href="http://koubei.21-sun.com/list/">机器大全</a> &gt;&gt; <a href="/list/<%=id%>.htm"><%=factoryname%><%=name%><%=catalogname%></a> &gt;&gt; <%=factoryname%><%=name%><%=catalogname%>产品对比</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10 np_fix"> 
  <!--left-->
  <div class="w210 l n_pp_left np_left nkb_detleft">
    <div class="w208  l leftPart02 mb10 np_addpcat border02">
      <div class="stitle np_fix">
        <h3 class="l"><%=factoryname%><%=catalogname%></h3>
        <span class="r"><a href="/<%=cataNum%>-<%=factoryid %>-0.htm" target="_blank" title="更多<%=factoryname%><%=catalogname%>口碑">更多&gt;&gt;</a></span> </div>
      <ul class="list003">
	    <jsp:include page="/include/koubei/compare_left_products.jsp" flush="true">
			<jsp:param name="catalog" value="<%=cataNum%>"></jsp:param>
			<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
		</jsp:include>
      </ul>
    </div>
    <div class="mb10 nkb_zyyw border02 l w208">
      <div class="nkb_zyyw_title">
        <h2 class="l"><%=factoryname%>主营业务</h2>
        <span class="r"><a href="/0-<%=factoryid %>-0.htm" target="_blank" title="更多<%=factoryname%>口碑">更多&gt;&gt;</a></span> </div>
      <ul class="nkb_zyyw_list np_fix">
        <%
       		if(allcatalogsList!=null && allcatalogsList.size()>0){
       			for(Map m:allcatalogsList){
       				String num = CommonString.getFormatPara(m.get("num"));
       				String cataname = CommonString.getFormatPara(m.get("name"));
       				List<Map> subcatalogList = dbHelper.getMapList("select top 1 id from pro_products where is_show=1 and factoryid = '"+factoryid+"' and catalognum like '"+num+"%'");
       				if(subcatalogList!=null && subcatalogList.size()>0){
       	%> 
        	<li><a target="_blank"  href="http://koubei.21-sun.com/<%=num %>-<%=factoryid %>-0.htm" title="<%=factoryname %><%=cataname %>口碑"><%=cataname %></a></li>
         <%}}}%>
      </ul>
    </div>
    <div class="w208 border02 l leftPart02 mb10 pp_hotph">
      <h2><%=catalogname%>品牌排行 </h2>
      <ul class="list003" id="brandSubLeftId">
        <jsp:include page="/include/koubei/compare_left_brands_rank.jsp" flush="true">
			<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
			<jsp:param name="catalog" value="<%=catalognum %>"></jsp:param>
		</jsp:include>
      </ul>
    </div>
    <div class="mb10 nkb_zyyw border02 l w208 nkb_proxf">
      <div class="nkb_zyyw_title">
        <h2><%=CommonString.getFormatPara(catalogMap.get(topNum)) %>产品细分</h2>
      </div>
      <ul class="nkb_zyyw_list np_fix">
	        <jsp:include page="/include/koubei/compare_left_catelog.jsp" flush="true">
				<jsp:param name="catalog" value="<%=catalognum %>"></jsp:param>
			</jsp:include>
      </ul>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r n_pp_right">
  	<div class="com_topimg">
    	<div class="com_ch_title"><%=factoryname%><%=cataName%>　对比平台</div>
        <div class="np_fix comimg_val">
        	<div class="l comimg_left">
            	<p class="comimg"><img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=img2%>" width="310" height="230" alt="<%=factoryname%><%=name%><%=catalogname%>" title="<%=factoryname%><%=name%><%=catalogname%>"/></p>
                <div class="com_pname"><%=factoryname%><%=name%></div>
                <div class="com_pcat"><%=catalogname%></div>
            </div>
            <div class="r comimg_right comimg">
            	<p class="comimg" id="comPro"> <img src="../images/new_pro/com_nopic.jpg" width="310" height="230" alt=""/></p>
                <div class="com_sele_brand">
				    <select id="chooseBrand" style="width:95px;">
					  <option value="0">请选择品牌</option>
				      <jsp:include page="/include/koubei/select_brand.jsp" flush="true">
			            <jsp:param name="catalog" value="<%=cataNum %>"></jsp:param>
		              </jsp:include>
					</select>
                </div>
                <div class="com_sele_cat">
                	<select id="choosePro" style="width:95px;">
                    	<option value="0">请选择型号</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="com_dbbtn">
        	<a href="javascript:;" class="com_star" onclick="compareTop();">开始对比</a>
            <a href="javascript:;" class="com_clear" onclick="clearTop();">清空对比</a>
        </div>
    </div>
    <div class="com_topimg">
    	<div class="com_ch_title">同品牌<%=cataName%>对比</div>
        <div class="fix com_sbrand">
        	<div class="l combrand_left">
            	<ul class="comsbrand_list comsb_left np_fix">
                	<li>
                    	<p class="com_brand_img"><a target="_blank" href="/list/<%=id%>.htm"><img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=img2%>" alt="<%=factoryname%><%=name%><%=catalogname%>"/></a></p>
                        <p class="com_brand_name"><a target="_blank" href="/list/<%=id%>.htm"><%=factoryname%><%=name%></a></p>
                        <p class="com_brand_cat"><%=catalogname%></p>
                        <p class="com_brand_btn"><a href="javascript:;"></a></p>
                        <p class="comb_vs_bg"></p>
                    </li>
					
                </ul>
            </div>
            <div class="r combrand_right">
            	<ul class="comsbrand_list comsb_right np_fix">
					<jsp:include page="/include/koubei/compare_same_pro.jsp" flush="true">
			            <jsp:param name="catalog" value="<%=cataNum %>"></jsp:param>
						<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
			            <jsp:param name="proId" value="<%=id %>"></jsp:param>
		            </jsp:include>	          
                </ul>
                <div class="com_dbbtn">
                    <a href="javascript:;" class="com_star" onclick="compareSameBrand();">开始对比</a>
                    <a href="javascript:;" class="com_clear" onclick="clearSame();" >清空对比</a>
                </div>
            </div>
        </div>
    </div>
    <div class="com_topimg">
    	<div class="com_ch_title">与热门<%=cataName%>对比</div>
        <div class="fix com_sbrand">
        	<div class="l combrand_left">
            	<ul class="comsbrand_list comsb_left np_fix">					
					<li>
                    	<p class="com_brand_img"><a target="_blank" href="/list/<%=id%>.htm"><img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=img2%>" alt="<%=factoryname%><%=name%><%=catalogname%>"/></a></p>
                        <p class="com_brand_name"><a target="_blank" href="/list/<%=id%>.htm"><%=factoryname%><%=name%></a></p>
                        <p class="com_brand_cat"><%=catalogname%></p>
                        <p class="com_brand_btn"><a href="javascript:;"></a></p>
                        <p class="comb_vs_bg"></p>
                    </li>
                </ul>
            </div>
            <div class="r combrand_right">
            	<ul class="comsbrand_list comsb_right np_fix">
					<jsp:include page="/include/koubei/compare_dif_pro.jsp" flush="true">
			            <jsp:param name="catalog" value="<%=cataNum %>"></jsp:param>
						<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
			            <jsp:param name="proId" value="<%=id %>"></jsp:param>
		            </jsp:include>
                </ul>
                <div class="com_dbbtn ">
                    <a href="javascript:;" class="com_star" onclick="compareDifBrand();">开始对比</a>
                    <a href="javascript:;" class="com_clear" onclick="clearDif();">清空对比</a>
                </div>
            </div>
        </div>
    </div>
  </div>
  
  <input type="hidden" name="topProId" id="topProId" value="0"/>
  <input type="hidden" name="sameProId" id="sameProId" value="0"/>
  <input type="hidden" name="difProId" id="difProId" value="0"/>

  <!--right end--> 
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--end of foot--> 
<!--最底下-->
<div class="spec_bottom">
  <div class="contain980">
    <div class="np_fix spec_bottom_btn">
      <div class="hot_pro"> <a href="#">热门产品</a>
        <div class="spec_bot_tcc">
          <div class="contain980 tcc_nr">
            <div class="tcctitle np_fix"><span>热门产品</span></div>
            <ul class="np_fix">
					<jsp:include page="/include/koubei/hot_catalog.jsp" flush="true">
			            <jsp:param name="factoryName" value="<%=factoryname %>"></jsp:param>
						<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
		            </jsp:include>
            </ul>
          </div>
        </div>
      </div>
      <div class="hot_pp"> <a href="#">热门品牌</a>
        <div class="spec_bot_tcc specbot_tcc_2">
          <div class="contain980 tcc_nr" >
            <div class="tcctitle np_fix"><span>热门品牌</span></div>
            <ul class="np_fix">
					<jsp:include page="/include/koubei/hot_brand.jsp" flush="true">
			            <jsp:param name="catalog" value="<%=cataNum %>"></jsp:param>
		            </jsp:include>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--最底下结束--> 
<script type="text/javascript" src="/scripts/sort.js"></script> 
<script type="text/javascript">
	$('.hot_pro').hover(function(){
		$('.spec_bottom').addClass('spec_bottom_on');
		$(this).find('.spec_bot_tcc').show();
		},function(){
			$('.spec_bottom').removeClass('spec_bottom_on');
			$(this).find('.spec_bot_tcc').hide();
			});
	 $('.hot_pp').hover(function(){
		$('.spec_bottom').addClass('spec_bottom_on');
		$(this).addClass('btn_two_on');
		$(this).prev('.hot_pro').addClass('btn_one_on');
		$(this).find('.spec_bot_tcc').show();
		},function(){
			$('.spec_bottom').removeClass('spec_bottom_on');
			$(this).removeClass('btn_two_on');
			$(this).prev('.hot_pro').removeClass('btn_one_on');
			$(this).find('.spec_bot_tcc').hide();
			});
</script>
<script type="text/javascript">
	$('.comsb_right li').click(function(){
		$(this).addClass('add_com').siblings().removeClass('add_com');
	});
	$('.combrand_right .com_dbbtn .com_clear').click(function(){
		$(this).parent().prev().find('.add_com').removeClass('add_com');
		});
</script>
<script>
   //选择品牌后加载该品牌下的产品   
   jQuery(function(){
		jQuery("#chooseBrand").change(function(){
		    var brandId=this.value;
			jQuery.post("/tools/ajax.jsp",{'brandId':brandId,'cataNum':<%=cataNum%>,'flag':'getProByBrand'},function(data){
						   $('#choosePro').append(data);
			});
		});
	});
	//选择完产品后加载该产品的一些相关信息
	jQuery(function(){
		jQuery("#choosePro").change(function(){
		     var proId=this.value;
			 document.getElementById("topProId").value= proId;
			 jQuery.post("/tools/ajax.jsp",{'proId':proId,'flag':'getProInfo'},function(data){
				document.getElementById("comPro").innerHTML = (jQuery.trim(data));
			 });
		});
	});
    //顶部对比
	function compareTop(){
	   var id=document.getElementById("topProId").value;
	   if(id==0){
	      alert("请选择对比产品！");
	   }else{
          window.open("/compare-<%=id%>-"+id+".shtm");   	   
	   }
	}
	//同品牌产品对比
	function compareSameBrand(){
	   var id=document.getElementById("sameProId").value;
	   if(id==0){
	    alert("请选择对比产品！");
	   }else{
	        window.open("/compare-<%=id%>-"+id+".shtm");   	   
	   }
	}
	//不同品牌产品对比
	function compareDifBrand(){
	   var id=document.getElementById("difProId").value;
	   if(document.getElementById("difProId").value==0){
	   	    alert("请选择对比产品！");
	   }else{
		   window.open("/compare-<%=id%>-"+id+".shtm");
       }
	}
	//设置选择对比产品Id
	function chooseDifId(id){
	  document.getElementById("difProId").value=id;
	}
	function chooseSameId(id){
      document.getElementById("sameProId").value=id;
	}
	//清空所选对比
	function clearSame(){
	    document.getElementById("sameProId").value='0';
		$(this).parent().prev().find('.add_com').removeClass('add_com');
	}
	function clearDif(){
		document.getElementById("difProId").value=0;
		$(this).parent().prev().find('.add_com').removeClass('add_com');
	}
	
	function clearTop(){
	document.getElementById("chooseBrand").selectedIndex=0;
    document.getElementById("choosePro").selectedIndex=0;
	document.getElementById("topProId").value=0;
    jQuery("#comPro").html("<img src='../images/new_pro/com_nopic.jpg' width='310' height='230' alt=''/>");


	}
</script>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
#ads02 { position:fixed; right:0px; top:80px; z-index:99999; width:42px; height:350px;}
* html #ads02 {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,0)||0)-(parseInt(this.currentStyle.marginRight,0)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<!--对联广告-->
<div id="ads02" class="ads_hover">
<a href="http://product.21-sun.com/activity/koubei/index.jsp" target="blank" style="display:block;"><img src="http://product.21-sun.com/images/kb_dl20140702.jpg" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>
<!--对联广告结束-->
</body>
</html>