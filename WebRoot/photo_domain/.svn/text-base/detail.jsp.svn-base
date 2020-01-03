<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String pro_id = CommonString.getFormatPara(request.getParameter("id")) ;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	Map<String,String> main_pics = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	if(!"".equals(pro_id)){
		main_pics = dbHelper.getMap(" select id,img2,add_date,factoryname,catalogname,name,catalognum,file_name,factoryid  from pro_products where id = '"+pro_id+"'") ;
	}else{
		 main_pics = dbHelper.getMap(" select id,img2,add_date,factoryname,catalogname,name,catalognum,file_name,factoryid  from pro_products where factoryid = '"+factoryid+"' and catalognum = "+catalog+"" ) ;
	}
	if(null==main_pics){
		main_pics = new HashMap();
	}
	String factoryname = "" ;
	String catalogname = "" ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	factoryname = (String)brandMap.get(factoryid) ;
	if("".equals(factoryname) || null == factoryname){
		factoryname = CommonString.getFormatPara(main_pics.get("factoryname")) ;
	}
	catalogname = (String)catalogMap.get(catalog) ;
	if(null == catalogname || "".equals(catalogname)){
		catalogname = CommonString.getFormatPara(main_pics.get("catalogname")) ;
	}
	if(null==factoryid || "".equals(factoryid) ||"null".equals(factoryid)){
		factoryid = CommonString.getFormatPara(String.valueOf(main_pics.get("factoryid"))) ;
	}
	if(null == catalog || "".equals(catalog)){
		catalog = CommonString.getFormatPara(main_pics.get("catalognum")) ;		
	}
	
	String parentcatalogname = CommonString.getFormatPara(catalogMap.get(catalog.length()>6?catalog.substring(0,6):catalog));
	
	List<Map> sub_pics = dbHelper.getMapList(" select  name,img_name from pro_product_pic where product_id='"+pro_id+"'") ;  // 子表图片
	if(null==sub_pics){
		sub_pics = new ArrayList() ;
	}
	// 同类别、不同品牌产品相关图片
	List<Map> relate_pics = dbHelper.getMapList(" select top 6 id,img2,catalogname,name,factoryname from pro_products where catalognum = '"+catalog+"' and factoryid != '"+(("null".equals(factoryid))?"":factoryid)+"' and img2 is not null and img2 != '' order by newid() ") ;
	
	// 右侧同品牌、同类别下的产品相关图片
	List<Map> right_pics = dbHelper.getMapList(" select top 8 id,img2,catalogname,name,factoryname from pro_products where catalognum = '"+catalog+"' and factoryid = '"+(("null".equals(factoryid))?"":factoryid)+"' and img2 is not null and img2 != '' and id != '"+pro_id+"' order by newid() ") ;
	
	//最新订单
	List<Map> orderList = dbHelper.getMapList("select top 10 id,province,city,name,factoryname,cataname,product_name from pro_product_form where is_deleted=0 and product_name is not null and product_name!='' and product_id=" + pro_id + " order by id desc");
	if(orderList==null || orderList.size()<=0){
		orderList = dbHelper.getMapList("select top 10 id,province,city,name,factoryname,cataname,product_name from pro_product_form where is_deleted=0 and product_name is not null and product_name!='' and factoryid=" + factoryid + " order by id desc");
	}
	
	//最新维修资讯
	//List<Map> newsList = dbHelper.getMapList("select top 10 title,link_other,html_filename from article where is_pub=1 and title like '%维修%' and title like '%" + (catalog.length()>3 ? CommonString.getFormatPara(catalogMap.get(catalog.substring(0,2))) : CommonString.getFormatPara(catalogMap.get(catalog))) + "%' order by id desc");
	//TDK
	String words= factoryname+CommonString.getFormatPara(main_pics.get("name"))+(catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【多图】<%=words%>图片_<%=words%>图片大全 - 铁臂图库</title>
<meta name="keywords" content="<%=words%>图片,<%=words%>图片大全,<%=words%>,铁臂图库" />
<meta name="description" content="铁臂图库提供最新<%=words%>图片，帮助您全面了解<%=words%>，买<%=words%>就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top_photo_news.jsp" flush="true">
<jsp:param value="107002" name="type"/>
</jsp:include>
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="http://photo.21-sun.com/">铁臂图库</a> &gt;&gt; <a href="/list.jsp?factoryid=<%=factoryid%>"><%=factoryname%></a> &gt;&gt; <a href="/list.jsp?catalogid=<%=(catalog.length()>6?catalog.substring(0,6):catalog)%>"><%=parentcatalogname%></a> &gt;&gt; <a href="/list.jsp?factoryid=<%=factoryid%>&catalogid=<%=(catalog.length()>6?catalog.substring(0,6):catalog)%>"><%=factoryname+parentcatalogname %></a> &gt;&gt; <%=factoryname+CommonString.getFormatPara(main_pics.get("name")) +parentcatalogname %>图片</h3>
</div>
<!--面包屑结束-->
<!--main-->
<div class="contain980">
  <script type="text/javascript" src="/scripts/upscroll.js"></script>
  <script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery(".pdil").Scroll({line:1,speed:500,up:"pdilup",down:"pdildown"});
    });
    </script>
  <link type="text/css" rel="stylesheet" href="/photo_domain/style/jquery.ad-gallery.css"/>
  <script type="text/javascript" src="/photo_domain/scripts/jquery.ad-gallery.js"></script>
  <script type="text/javascript">
	jQuery(function() {
	var galleries = jQuery('.ad-gallery').adGallery();
	});
	</script>
  <div class="photoShow">
    <div class="photoLeft">
      <h1 class="photoName" style="font-size:14px"><a title="<%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>图片" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(main_pics.get("file_name")).replace(".shtm","") %>_pic.shtm" target="_blank"><%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>图片</a></h1>
      <div class="checkdetail"><b><a title="查看<%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>详细参数" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(main_pics.get("file_name")).replace(".shtm","") %>_parameter.shtm" target="_blank">查看详细参数&gt;&gt;</a></b><a href="javascript:;"  onclick="showinquery(<%=CommonString.getFormatPara(String.valueOf(main_pics.get("id"))) %>)"><img src="/images/pd_btn_x.gif" alt="免费询价" /></a></div>
      <div class="pdbigImg_new">
        <div id="gallery" class="ad-gallery">
          <div class="ad-image-wrapper"></div>
		    <div class="bdsharebuttonbox bdshare-button-style0-16" style="width: 160px;" data-bd-bind="1405573184802">
    <a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
          <div class="ad-controls"> </div>
          <div class="ad-nav">
            <div class="ad-thumbs">
              <ul class="ad-thumb-list">
			  <%
			  String detail_images="";
			  detail_images=CommonString.getFormatPara(main_pics.get("img2"));
			   if(detail_images.indexOf("uploadfiles")<0){
        			     	detail_images = "http://product.21-sun.com/uploadfiles/"+detail_images;
        		}else{
				detail_images = "http://product.21-sun.com/"+detail_images;
				}
			  %>
                <li> <a href="<%=detail_images %>" title="<%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>"><img src="<%=detail_images %>" class="image0"  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>" /></a></li>
                <%
               		if(null !=sub_pics && sub_pics.size()>0){
						int i = 0;
            	   		for(Map onesubMap:sub_pics){
						String detail_img=CommonString.getFormatPara(onesubMap.get("img_name"));
						if(detail_img.indexOf("resource.21-sun")>0){
				        detail_img = detail_img;
						}else if(detail_img.indexOf("uploadfiles")<0){
        			    detail_img = "http://product.21-sun.com/uploadfiles/"+detail_img;
				        }else{
						 detail_img = "http://product.21-sun.com/"+detail_img;
						}
						i++;
            	 %>
                <li> <a href="<%=detail_img %>" title="<%=CommonString.getFormatPara(main_pics.get("factoryname"))%><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %><%=CommonString.getFormatPara(onesubMap.get("name")) %>"> <img src="<%=detail_img%>" class="image<%=i%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(main_pics.get("factoryname"))%><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>"/> </a> </li>
                <%
            	  		}
				   }
				%>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="nph_nextpre np_fix">
        <div class="l nph_prev" id="prev">
          <!--上一图集-->
          <jsp:include page="/include/photo/pre_pic.jsp" flush="true">
          <jsp:param name="id" value="<%=pro_id%>"></jsp:param>
          <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
          </jsp:include>
        </div>
        <div class="r nph_next" id="next">
          <!--下一图集-->
          <jsp:include page="/include/photo/next_pic.jsp" flush="true">
          <jsp:param name="id" value="<%=pro_id%>"></jsp:param>
          <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
          </jsp:include>
        </div>
      </div>
    </div>
    <div class="photoRight">
      <span style="border-bottom-color: rgb(244, 244, 244);border-bottom-style: solid;border-bottom-width: 1px;color: rgb(67, 67, 67);display: block;font-family: Arial;font-size: 14px;font-weight: normal;height: 25px;margin-bottom: 0px;margin-left: 0px;margin-right: 0px;margin-top: 0px;padding-bottom: 0px;text-align: center;padding-right: 0px;padding-top: 10px;width: 214px">更多产品图片</span>
      <div class="pdImgList">
        <div class="pdimgBtn_up"><img src="/images/picbtn_up.gif" width="130" height="25" id="pdildown"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  /></div>
        <div class="pdil">
          <ul>
            <%
               if(null !=right_pics && right_pics.size()>0){
            	   for(Map onesubMap:right_pics){
            		   %>
            <li><a href="/detail_for_<%=CommonString.getFormatPara(onesubMap.get("id")) %>.htm" title="<%=CommonString.getFormatPara(onesubMap.get("factoryname"))%><%=CommonString.getFormatPara(onesubMap.get("name")) %><%=CommonString.getFormatPara(onesubMap.get("catalogname")) %>图片"> <img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(onesubMap.get("img2")) %>" width="124" height="91"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(onesubMap.get("factoryname"))%><%=CommonString.getFormatPara(onesubMap.get("name")) %><%=CommonString.getFormatPara(onesubMap.get("catalogname")) %>图片" />
              <h4><%=CommonString.getFormatPara(onesubMap.get("factoryname"))%><%=CommonString.getFormatPara(onesubMap.get("name")) %><%=CommonString.getFormatPara(onesubMap.get("catalogname")) %>图片</h4>
              </a></li>
            <%
            	   }
               }
              %>
          </ul>
        </div>
        <div class="pdimgBtn_down"><img src="/images/picbtn_down.gif" width="130" height="25" id="pdilup" /></div>
      </div>
     <!-- <div class="photoSearch">
        <form id="form3" name="form3" method="get" action="list.jsp">
          <div class="psi">
            <input type="text" name="keywords" id="keywords" maxlength="20" />
          </div>
          <div class="psb">
            <input type="submit" value="&nbsp;" />
          </div>
        </form>
      </div>-->
    </div>
  </div>
  <div class="clear"></div>
</div>
<div class="otherPhoto c">
 <div class="contain980 liked">
      <strong class="n">您可能感兴趣的：</strong>
      <div class="text">
        <a href="/list.jsp?factory=<%=factoryid%>"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>产品图片</a><em class="w">|</em><a href="/other_<%=factoryid%>_0_107003_0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>施工图片</a><em class="w">|</em><a href="/zhanhui_107005002_<%=factoryid%>_0_107005_0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>宝马展</a><em class="w">|</em><a href="/zhanhui_107005001_<%=factoryid%>_0_107005_0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>北京展</a><em class="w">|</em><a href="/other_<%=factoryid%>_0_107006_0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>趣味图片</a><em class="w">|</em><a href="/nlist_<%=factoryid%>_0_107001_0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>行业图片</a><em class="w">|</em><a href="/other_<%=factoryid%>_0_107004_0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>维修图片</a>
      </div>
    </div>
<cache:cache  cron="* */7 * * *">
  <%
	if(!catalog.equals("")){
		List<Map> brandList = dbHelper.getMapList("select  id,name from pro_agent_factory where is_show=1 and flag=1 and id in (select distinct factoryid from pro_products where catalognum like '"+catalog+"%' ) order by view_count desc");
		if(brandList!=null && brandList.size()>0){
%>
  <!--更多品牌图片-->
  <div class="contain980">
    <div class="allCatalog">
      <div class="mt">
        <h3>更多<%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>图片</h3>
      </div>
      <ul class="list">
        <%
			for(Map brand : brandList){
				String brandId = CommonString.getFormatPara(brand.get("id"));
				String brandName = CommonString.getFormatPara(brand.get("name"));
   %>
        <li><a title="<%=brandName %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>图片" href="/list.jsp?catalog=<%=catalog.length()>6?catalog.substring(0,6):catalog %>&factory=<%=brandId %>"><%=brandName %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>图片</a></li>
        <%
			}
   %>
        <div class="clear"></div>
      </ul>
    </div>
  </div>
  <!--更多品牌图片结束-->
  <%
		}
	}
%>
  </cache:cache>


  <%
		if(orderList!=null && orderList.size()>0){
	%>
  <!--最新订单-->
  <div class="contain980 mt10 mb20" style="background-color:#ffffff;">
    <div class="title04">
      <h2><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(main_pics.get("name")) %><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>最新订单 </h2>
      <span><a title="更多<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>订单" href="http://product.21-sun.com/inquiry/0_0_<%="".equals(factoryid)?"0":factoryid%>_<%="".equals(catalog)?"0":catalog%>_0.shtm"
							target="_blank">更多&gt;&gt;</a> </span> </div>
    <div class="list04">
      <ul>
        <%
			for(Map order : orderList){
	%>
        <li>
          <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_<%=CommonString.getFormatPara(order.get("id"))%>.htm" title="<%=CommonString.getFormatPara(order.get("factoryname"))%><%=CommonString.getFormatPara(order.get("product_name"))%><%=CommonString.getFormatPara(order.get("cataname"))%>询价单"><%=CommonString.getFormatPara(order.get("province"))%><%=CommonString.getFormatPara(order.get("city"))%>的 <%=CommonString.getFormatPara(order.get("name")).length()>=1?CommonString.getFormatPara(order.get("name")).substring(0,1):""%>** 用户询问了<font><%=CommonString.getFormatPara(order.get("factoryname"))%><%=CommonString.getFormatPara(order.get("product_name"))%><%=CommonString.getFormatPara(order.get("cataname"))%></font>的价格</a></div>
          <div class="t3"><%=CommonDate.getFormatDate("MM-dd HH:mm",order.get("add_date"))%></div>
        </li>
        <%
			}
	%>
      </ul>
    </div>
    <div class="clear"></div>
  </div>
  <!--最新订单结束-->
  <%
		}
	%>
  <div class=" contain980 border02 leftPart02 nph_zyyw">
    <h2><%=CommonString.getFormatPara(main_pics.get("factoryname"))%>主营业务</h2>
    <ul class="list07">
      <jsp:include page="/include/prodetail/photo_sub.jsp" flush="true">
      <jsp:param name="factoryid" value='<%=main_pics.get("factoryid")%>'></jsp:param>
      <jsp:param name="factoryname" value='<%=main_pics.get("factoryname")%>'></jsp:param>
      </jsp:include>
    </ul>
  </div>
  <div class="clear"></div>
</div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<jsp:include page="/include/koubei_ad.jsp" flush="false"/>
<!--end of foot-->
<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>

<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">

	
  //获取上一篇
	jQuery.ajax({
		//url:"/action/ajax.jsp",
		//type:"post",
		//data:{"flag":"pretPic","catalog":"<%=CommonString.getFormatPara(main_pics.get("catalognum"))%>","id":"<%=pro_id%>"},
		//success:function(data){
			//jQuery("#prev").html(jQuery.trim(data));	
		//}
	})
	
	 //获取下一篇
	jQuery.ajax({
		//url:"/action/ajax.jsp",
		//type:"post",
		//data:{"flag":"nextPic","catalog":"<%=CommonString.getFormatPara(main_pics.get("catalognum"))%>","id":"<%=pro_id%>"},
		//success:function(data){
			//jQuery("#next").html(jQuery.trim(data));	
		//}
	})
</script>
<div style="display:none">
  <script src="http://s17.cnzz.com/stat.php?id=5752121&web_id=5752121" language="JavaScript"></script>
</div>
</body>
</html>