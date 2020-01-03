<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String pro_id = CommonString.getFormatPara(request.getParameter("id")) ;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String type = CommonString.getFormatPara(request.getParameter("type"));
	String zhanhui = CommonString.getFormatPara(request.getParameter("zhanhui"));
	
	 Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
	
	Map<String,String> main_pics = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	if(!"".equals(pro_id)){
		//mainPhoto = dbHelper.getMap("select id,title,sort_num,image,view_count,keywords,brand_keywords,catalognum,factoryid from pro_photo_group where is_show=1 and id="+pro_id);
		main_pics = dbHelper.getMap(" select *  from pro_photo_group where is_show=1 and id = '"+pro_id+"' order by pub_date") ;
	}
	if(null==main_pics){
		//main_pics = new HashMap();
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		Common.doForward(request,response,"/404.htm");
	}
	String factoryname = "" ;
	String catalogname = "" ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map brandMap2 = (HashMap)application.getAttribute("brandMap2") ;
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map catalogMap2 = (HashMap)application.getAttribute("catalogMap2") ;
	//factoryname = (String)brandMap.get(factoryid) ;
	//标签
	String showCatalogName="";
	String title = CommonString.getFormatPara(main_pics.get("title"));
	String keywords = CommonString.getFormatPara(main_pics.get("keywords"));
	String brand_keywords = CommonString.getFormatPara(main_pics.get("brand_keywords"));
	String sort_num = CommonString.getFormatPara(main_pics.get("sort_num"));
	String list_img = CommonString.getFormatPara(main_pics.get("image"));
	String catalognum = CommonString.getFormatPara(main_pics.get("catalognum"));
	String factorys = CommonString.getFormatPara(main_pics.get("factoryid"));
	if(type.equals("")&&!sort_num.equals("")){
		type = CommonString.getFormatPara(sort_num.split(",")[0]);
	}
	System.out.println("title:"+title);
	System.out.println("type:"+type);
	System.out.println("sort_num:"+sort_num);
	//更多趣味图片
	List<Map> other_pics = dbHelper.getMapList(" select * from pro_photo_group where is_show=1 and sort_num like '%"+type+"%' order by pub_date") ;  // 子表图片
	if(null==other_pics){
		other_pics = new ArrayList() ;
	}
	
	Map<String,String> pro_pics = null ;
	if(!"".equals(brand_keywords)){
	pro_pics = dbHelper.getMap(" select * from pro_products where is_show=1 and factoryname like'%"+brand_keywords+"%' and catalogname like '%"+keywords+"%'") ;
	}
	//感兴趣
	//String factoryid = CommonString.getFormatPara(pro_pics.get("factoryid"));
	//String catalog_more = CommonString.getFormatPara(pro_pics.get("catalog"));
	
			
	if(keywords!=null){
		String c = CommonString.getFormatPara(keywords.split("-")[0]);
		if(!c.equals("")){
			catalog = CommonString.getFormatPara(catalogMap2.get(c));
			if(catalog.length()>6){catalog=catalog.substring(0,6);}
			catalogname=(String)catalogMap.get(catalog) ;
		}
	}
	if(brand_keywords!=null){
		String b = CommonString.getFormatPara(brand_keywords.split("-")[0]);
		if(!b.equals("")){
			factoryid = CommonString.getFormatPara(brandMap2.get(b));
			factoryname=(String)brandMap.get(factoryid) ;
		}
	}
	
	
	
	String sortName = "";
	String url="";
	if(type.equals("107001")){
		sortName = "行业图片";
		url="nlist";
	}else if(type.equals("107003")){
		sortName = "施工图片";
		url="other";
	}else if(type.equals("107004")){
		sortName = "维修图片";
		url="other";
	}else if(type.equals("107005")){
		sortName = "展会图片";
	}else if(type.equals("107006")){
		sortName = "趣味图片";
		url="other";
	}else if(type.equals("107007")){
		sortName = "更多图片";
		url="other";
	}
	
	List<Map> sub_pics = dbHelper.getMapList(" select id,title,image  from pro_photo where is_show=1 and group_id = '"+pro_id+"' order by pub_date") ;  // 子表图片
	if(null==sub_pics){
		sub_pics = new ArrayList() ;
	}
	
		
	
	//推荐图集
	String wheres="";
	if(!factoryid.equals("")&&!catalognum.equals("")){
	wheres+=" and catalognum like'"+catalognum+"' ";
	}else{
	wheres+=" and keywords like'"+keywords+"' ";
	}
	List<Map> tui_pics = dbHelper.getMapList(" select id,title,keywords,brand_keywords,catalognum,factoryid  from pro_photo_group where is_show=1 and sort_num like '%"+type+"%' "+wheres+"  order by pub_date") ;  
	if(null==tui_pics){
		tui_pics = new ArrayList() ;
	}
	
	// 右侧同品牌、同类别下的产品相关图片
	List<Map> right_pics = dbHelper.getMapList(" select top 8 id,title,image  from pro_photo_group where is_show=1 and sort_num like '%"+type+"%' order by newid() ") ;
	String titled="";String keywordsd="";String descriptiond="";
		String factory1=CommonString.getFormatPara(catalogMap.get(catalog));
		String catalog1=CommonString.getFormatPara(brandMap.get(factory));
		 if(type.equals("107003")){
		titled="【施工图片】"+title+"_施工图片 – 铁臂图库";
        keywordsd=""+title+",现场施工图片,施工图片大全";;
        descriptiond="铁臂图库为您提供最新"+title+"的施工图片,想了解"+title+"的图片请到铁臂图库来.买工程机械产品就上铁臂商城.";
		}else if(type.equals("107004")){
		titled="【维修图片】"+title+"_维修图片 – 铁臂图库";
        keywordsd=""+title+",维修图片, 铁臂图库";
        descriptiond="铁臂图库为您提供最新"+title+"的维修图片,想了解"+title+"的图片请到铁臂图库来.买工程机械产品就上铁臂商城.";
		}else if(type.equals("107006")){
		titled="【趣味图片】"+title+"_趣味图片 – 铁臂图库";
        keywordsd=""+title+",趣味图片,趣味图库大全";
        descriptiond="铁臂图库为您提供最新"+title+"的趣味图片欣赏,想了解更多"+title+"的图片请到铁臂图库来.买工程机械产品就上铁臂商城.";
		}else if(type.equals("107001")){
		titled="【行业图片】"+title+"_行业图片 – 铁臂图库";
        keywordsd=""+title+",行业图片,行业图片大全";
        descriptiond="铁臂图库为您提供最新"+title+"的行业图片,想了解"+title+"的行业图片请到铁臂图库来.买工程机械产品就上铁臂商城.";
		}else if(type.equals("107005")){
		titled="【展会图片】"+title+"_展会图片 – 铁臂图库";
        keywordsd=""+title+",展会图片,展会图片大全";
        descriptiond="铁臂图库为您提供最新"+title+"的照片欣赏,想了解"+title+"的展会照片现场实景图请到铁臂图库来.买工程机械产品就上铁臂商城.";
		}
		
		String zhanhuiName="";
		if(zhanhui.equals("107005001")){
		zhanhuiName="北京展BICES";
		}else if(zhanhui.equals("107005002")){
		zhanhuiName="上海宝马展";
		}else if(zhanhui.equals("107005003")){
		zhanhuiName="法国国际工程机械展";
		}
		
		String maibao="";
		if(type.equals("107003")){
		maibao="&gt;&gt;<a href=\"/other_0_0_107003_0.htm\">"+catalog1+"施工图片</a>&gt;&gt;"+title+"";
		}else if(type.equals("107004")){
       maibao="&gt;&gt;<a href=\"/other_0_0_107004_0.htm\">"+catalog1+"维修图片</a>&gt;&gt;"+title+"";
		}else if(type.equals("107006")){
       maibao="&gt;&gt;<a href=\"/other_0_0_107005_0.htm\">"+catalog1+"趣味图片</a>&gt;&gt;"+title+"";
		}else if(type.equals("107001")){
      maibao="&gt;&gt;<a href=\"/nlist_0_0_107001_0.htm\">"+catalog1+"行业图片</a>&gt;&gt;"+title+"";
		}else if(type.equals("107005")){
       maibao="&gt;&gt;<a href=\"/zhanhui_0_0_0_107005_0.htm\">"+catalog1+"展会图片</a>&gt;&gt;"+title+"";
		}else{
		maibao="&gt;&gt;工程机械产品图片";
		}
%><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=titled%></title>
<meta name="renderer" content="webkit">
<meta name="keywords" content="<%=keywordsd%>" />
<meta name="description" content="<%=descriptiond%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/new_style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</head>
<body class="photobg">
<!--top--> 
<a class="shop_topbg"></a>
<jsp:include page="/include/top_photo_news.jsp" flush="true">
<jsp:param value="<%=type%>" name="type"/>
</jsp:include>
<!--main-->
<div class="pho_newderail"> 
  <!--面包屑-->
  <div class="contain980 mb10">
  	<h3 class="breadCrumbs"><a href="/">铁臂图库</a> <%=maibao%></h3>
</div>
  <!--面包屑结束-->
 <div class="contain980">
  <script type="text/javascript" src="/scripts/upscroll.js"></script>
  <script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery(".pdil").Scroll({line:1,speed:500,up:"pdilup",down:"pdildown"});
    });
    </script>
  <link type="text/css" rel="stylesheet" href="/photo_domain/style/jquery.ad-gallery.css">
  <script type="text/javascript" src="/photo_domain/scripts/jquery.ad-gallery.js"></script>
  <script type="text/javascript">
	jQuery(function() {
		var galleries = jQuery('.ad-gallery').adGallery();
	});
	</script>
  <div class="photoShow">
    <div class="photoLeft" style="height:695px;">
      <h1 class="photoName" style="font-size:14px;"><%=CommonString.getFormatPara(main_pics.get("title")) %></h1>
      <a href="javascript:void(0);" class="uploadBtn" onclick="<% if(username.equals("")){ %>login();<%}else{%>showupload();<%}%>">上传图片</a>
       <div class="pdbigImg_new">
        <div id="gallery" class="ad-gallery">
          <div class="ad-image-wrapper"></div>
		    <div class="bdsharebuttonbox bdshare-button-style0-16" style="width: 160px;" data-bd-bind="1405497473672">
    <a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
          <div class="ad-controls"> </div>
          <div class="ad-nav">
            <div class="ad-thumbs">
			
              <ul class="ad-thumb-list">
                <%
               		if(null !=sub_pics && sub_pics.size()>0){
						int i = 0;
            	   		for(Map onesubMap:sub_pics){
						  String image=CommonString.getFormatPara(onesubMap.get("image"));
						  if(image.equals("")){
						  image=list_img;
						  }
						  if(image.indexOf("resource")<0){
						   if(image.indexOf("uploadfiles")<0){
        			     	image = "http://product.21-sun.com/uploadfiles/"+image;
        			        }
						  }
				  
							i++;
            	 %>
				
                <li> <a href="<%=image %>" title="<%=factoryname%><%=CommonString.getFormatPara(onesubMap.get("title")) %><%=catalogname %><%=CommonString.getFormatPara(onesubMap.get("title")) %>">
				<img src="<%=image %>" class="image<%=i%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname%><%=CommonString.getFormatPara(onesubMap.get("title")) %><%=catalogname %>"/> </a> </li> 
                <%
            	  		}
				   }else{
				   String image="";
				   image=list_img;
				   if(image.indexOf("resource")<0){
						   if(image.indexOf("uploadfiles")<0){
        			     	image = "http://product.21-sun.com/uploadfiles/"+image;
        			        }
						  }
				%>
				 <li> <a href="<%=image %>" title="<%=factoryname%><%=title %><%=catalogname %><%=title %>">
				<img src="<%=image %>" class="image<%=0%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname%><%=title %><%=catalogname %>"/> </a> </li>
				<%}%>
              </ul>
			  
            </div>
          </div>
        </div>
      </div>
      
 
	
      <div class="nph_nextpre np_fix">
        <div class="l nph_prev" id="prev">
          <!--上一图集-->
          <jsp:include page="/include/photo/newspre_pic.jsp" flush="true">
          <jsp:param name="id" value="<%=pro_id%>"></jsp:param>
		   <jsp:param name="type" value="<%=type%>"></jsp:param>
          </jsp:include>
        </div>
        <div class="r nph_next" id="next">
          <!--下一图集-->
          <jsp:include page="/include/photo/newsnext_pic.jsp" flush="true">
          <jsp:param name="id" value="<%=pro_id%>"></jsp:param>
		   <jsp:param name="type" value="<%=type%>"></jsp:param>
          </jsp:include>
        </div>
      </div>
    </div>
    <div class="photoRight">
      <span style="border-bottom-color: rgb(244, 244, 244);border-bottom-style: solid;border-bottom-width: 1px;color: rgb(67, 67, 67);display: block;font-family: Arial;font-size: 14px;font-weight: normal;height: 25px;margin-bottom: 0px;margin-left: 0px;margin-right: 0px;margin-top: 0px;padding-bottom: 0px;padding-left: 35px;padding-right: 0px;padding-top: 10px;width: auto;text-align: center;">最新<%=sortName%></span>
      <div class="pdImgList">
        <div class="pdimgBtn_up"><img src="/images/picbtn_up.gif" width="130" height="25" id="pdildown" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" style="cursor: pointer;"></div>
        <div class="pdil">
          <ul>
             <%
               if(null !=right_pics && right_pics.size()>0){
            	   for(Map onesubMap:right_pics){
				   String images=CommonString.getFormatPara(onesubMap.get("image"));
				   if(images.indexOf("resource")<0){
						   if(images.indexOf("uploadfiles")<0){
        			     	images = "http://product.21-sun.com/uploadfiles/"+images;
        			        }
						  }
            		   %>
            <li><a href="/ndetail_for_<%=CommonString.getFormatPara(onesubMap.get("id")) %>.htm" title="<%=CommonString.getFormatPara(onesubMap.get("title")) %>"> 
			<img src="<%=images%>" width="124" height="91"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(onesubMap.get("title")) %>" />
              <h4><%=CommonString.getFormatPara(onesubMap.get("title")) %></h4>
              </a></li>
            <%
            	   }
               }
              %>
          </ul>
        </div>
        <div class="pdimgBtn_down"><img src="/images/picbtn_down.gif" width="130" height="25" id="pdilup" style="cursor: pointer;"></div>
      </div>

    </div>
  </div>
  <div class="clear"></div>
</div>
<%
	if(factoryname!=null){
%>
<div class="otherPhoto c pho_newdetailff">
<%if(!factoryid.equals("")){%>
 <div class="contain980 liked">
      <strong class="n">您可能感兴趣的：</strong>
      <div class="text">
        <a href="/list.jsp?factory=<%=factoryid%>"  title="<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>产品图片"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>产品图片</a><em class="w">|</em><a href="/other_<%=factoryid%>_0_107003_0.htm"  title="<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>施工图片"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>施工图片</a><em class="w">|</em><a href="/zhanhui_107005002_<%=factoryid%>_0_107005_0.htm"  title="<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>宝马展图片"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>宝马展图片</a><em class="w">|</em><a href="/zhanhui_107005001_<%=factoryid%>_0_107005_0.htm"  title="<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>北京展图片"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>北京展图片</a><em class="w">|</em><a href="/other_<%=factoryid%>_0_107006_0.htm"  title="<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>趣味图片"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>趣味图片</a><em class="w">|</em><a href="/nlist_<%=factoryid%>_0_107001_0.htm"  title="<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>行业图片"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>行业图片</a><em class="w">|</em><a href="/other_<%=factoryid%>_0_107004_0.htm"  title="<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>维修图片"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%>维修图片</a>
      </div>
    </div>
	<%}%>
<!--  <div class=" contain980 border02 leftPart02 nph_zyyw" style="margin:20px auto;">
  	<div class="fix pho_newzyyw">
    	<h2><%=factoryname%>主营业务</h2>
    </div>
     <ul class="list07">
      <jsp:include page="/include/prodetail/photo_sub.jsp" flush="true">
      <jsp:param name="factoryid" value='<%=factoryid %>'></jsp:param>
      <jsp:param name="factoryname" value='<%=factoryname %>'></jsp:param>
      <jsp:param value="nphoto" name="flag"/>
      </jsp:include>
    </ul>
  </div>-->
   <!--更多品牌图片-->

    <!--更多品牌图片结束 --> 
	<% if(!type.equals("107005")&&!type.equals("107001")){%>
  <div class="clear"></div>
  <div class="contain980 photo_d_b">
      <div class="allCatalog">
        <div class="mt fix">
          <h3 >更多<%=keywords%><%=sortName%></h3>
		  <div id="pagination" style="float: right;">
					<div> <a style="cursor:pointer;" id="showmore" onclick="showmore();">加载更多</a></div>
	  </div>
        </div>
		
       <ul class="list" id="morebrand" style="height:100px;overflow: hidden;">
		 <%
               		if(null !=tui_pics && tui_pics.size()>0){
						int i = 0;
            	   		for(Map onesubMap:tui_pics){
						  String keywordd=CommonString.getFormatPara(onesubMap.get("keywords"));
						  String brand_keywordsd=CommonString.getFormatPara(onesubMap.get("brand_keywords"));
						  String catalognumd=CommonString.getFormatPara(onesubMap.get("catalognum"));
						  String factoryidd=CommonString.getFormatPara(onesubMap.get("factoryid"));
						  
						  
						  
				  
							
            	 %>
          <li><a title="<%=brand_keywordsd%><%=keywordd%><%=sortName%>" href="/<%=url%>_<%= "".equals(factoryidd)?"0":factoryidd%>_<%="".equals(catalognumd)?"0":catalognumd%>_<%=type%>_0.htm"><%=brand_keywordsd%><%=keywordd%><%=sortName%></a></li>
         <%}}%>
          <div class="clear_0_<%=type%>_0.htm"></div>
        </ul>

      </div>
    </div>
    <!--更多品牌图片结束  -->
  <div class="clear"></div>
  <%}%>
</div>
<%} %>
</div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--foot end-->
</body>
<script>
function showmore(){
var m = $("#morebrand");  
m.css("height","auto"); 
//var mm = $("#morebrandhelp");  
//mm.css("height","auto"); 
 $("#showmore").hide(); 
}
function showupload(){
    jQuery.jBox("iframe:http://product.21-sun.com/photo_domain/upload.jsp?type=<%=type%>", {
	    title: "图片上传",
	    width: 720,
	    height: 435,
	    iframeScrolling : 'no',
	    buttons: { '关闭': false }
	    });
    }
</script>
</html>