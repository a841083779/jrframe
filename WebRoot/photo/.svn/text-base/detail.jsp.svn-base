<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>图片】-<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>价格表|<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>报价 - 中国工程机械商贸网</title>
<meta name="keywords" content="<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>图片,<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>,最新<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>价格表" />
<meta name="description" content="<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>图片，<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>最新高清图片，找<%=factoryname %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) %>图片就来中国工程机械商贸网。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/scripts.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/photo/">产品图库</a> &gt;&gt; <a href="/photo/list.jsp?factoryid=<%=factoryid%>"><%=factoryname%></a> &gt;&gt; <a href="/photo/list.jsp?factoryid=<%=factoryid%>&catalogid=<%=(catalog.length()>6?catalog.substring(0,6):catalog)%>"><%=factoryname+parentcatalogname %>图片</a> &gt;&gt; <a href="/photo/list.jsp?factoryid=<%=factoryid%>&catalogid=<%=catalog%>"><%=factoryname+catalogname %>图片</a></h3>
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
  <link type="text/css" rel="stylesheet" href="style/jquery.ad-gallery.css"/>
  <script type="text/javascript" src="scripts/jquery.ad-gallery.js"></script> 
  <script type="text/javascript">
	jQuery(function() {
	var galleries = jQuery('.ad-gallery').adGallery();
	});
	</script>
  <div class="photoShow">
    <style type="text/css">
	  .photoLeft { height:615px;}
	  .photoRight { height:613px;}
	  .photoRight h2 { font-size:14px; font-weight:bold; padding:10px 0px 0px 15px; height:25px; border-bottom:#f4f4f4 1px solid;}
	  .checkdetail { width:225px; padding-top:15px;}
	  .checkdetail b { line-height:29px; float:left; width:auto;}
	  .checkdetail b a { float:none;}
	  .checkdetail a { float:right;}
	  .otherList { margin-bottom:15px;}
	  .otherPhoto { height:auto; padding-bottom:20px;}
	  .otherPhoto .w755 { width:978px;}
	  .otherPhoto .list07 { width:968px;}
	  .otherPhoto .list07 li { width:182px;}
	  .photoShow .pdbigImg_new { width:705px; height:530px; margin-left:18px; _display:inline; padding:3px; margin-top:15px; float:left; border:#C9C9C9 1px solid; background-color:#fff;}
	  .otherPhoto .w755 .title { height:30px; line-height:30px; background-color:#f4f4f4;}
	  .otherPhoto .w755 .title h2 { width:auto; float:left; background:none;}
	  .otherPhoto .title span.more { width:auto; float:right; padding-right:10px; font-family:宋体;}
	  .psi input { height:20px; line-height:20px;}
	  .pdil { height:465px;}
	  .pdil ul li { background:none; height:121px; margin-bottom:2px; text-align:center;}
	  .pdil ul li a { width:100%; padding:0px; height:auto; cursor:pointer;}
	  .pdil ul li a img { padding:2px; border:#ccc 1px solid; margin:0 auto;}
	  .pdil ul li a h4 { font-size:12px; font-weight:normal; width:100%; height:20px; line-height:20px; text-align:center; white-space:nowrap; text-overflow:ellipsis; overflow:hidden;}
	  .photoShow .pdImgList { width:160px; padding-right:30px;}
	  .pdimgBtn_up, .pdimgBtn_down { text-align:center;}
	  .photoName { padding-top:15px;}
	  </style>
    <div class="photoLeft">
      <h3 class="photoName" style="font-size:14px"><a href="/proDetail/<%=CommonString.getFormatPara(main_pics.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %></a><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>图片</h3>
      <div class="checkdetail"><b><a href="/proDetail/<%=CommonString.getFormatPara(main_pics.get("file_name")) %>" target="_blank">查看详细参数&gt;&gt;</a></b><a href="javascript:;"  onclick="showinquery(<%=CommonString.getFormatPara(String.valueOf(main_pics.get("id"))) %>)"><img src="/images/pd_btn_x.gif" alt="免费询价" /></a></div>
      <div class="pdbigImg_new">
        <div id="gallery" class="ad-gallery">
          <div class="ad-image-wrapper"></div>
          <div class="ad-controls"> </div>
          <div class="ad-nav">
            <div class="ad-thumbs">
              <ul class="ad-thumb-list">
                <li> <a href="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(main_pics.get("img2")) %>" title="<%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(main_pics.get("img2")) %>" class="image0"  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(main_pics.get("factoryname")) %><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>" /></a></li>
                <%
               		if(null !=sub_pics && sub_pics.size()>0){
						int i = 0;
            	   		for(Map onesubMap:sub_pics){
							i++;
            	 %>
                <li> <a href="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(onesubMap.get("img_name")) %>" title="<%=CommonString.getFormatPara(main_pics.get("factoryname"))%><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %><%=CommonString.getFormatPara(onesubMap.get("name")) %>"> <img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(onesubMap.get("img_name")) %>" class="image<%=i%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(main_pics.get("factoryname"))%><%=CommonString.getFormatPara(main_pics.get("name")) %><%=CommonString.getFormatPara(main_pics.get("catalogname")) %>"/> 
                </a> </li>
                <%
            	  		}
				   }
				%>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="photoRight">
      <h2>浏览此图的人还浏览过</h2>
      <div class="pdImgList">
        <div class="pdimgBtn_up"><img src="../images/picbtn_up.gif" width="130" height="25" id="pdildown"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  /></div>
        <div class="pdil">
          <ul>
            <%
               if(null !=right_pics && right_pics.size()>0){
            	   for(Map onesubMap:right_pics){
            		   %>
            <li><a href="/photo/detail_for_<%=CommonString.getFormatPara(onesubMap.get("id")) %>.htm" title="<%=CommonString.getFormatPara(onesubMap.get("factoryname"))%><%=CommonString.getFormatPara(onesubMap.get("name")) %><%=CommonString.getFormatPara(onesubMap.get("catalogname")) %>"> <img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(onesubMap.get("img2")) %>" width="124" height="91"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(onesubMap.get("factoryname"))%><%=CommonString.getFormatPara(onesubMap.get("name")) %><%=CommonString.getFormatPara(onesubMap.get("catalogname")) %>" />
              <h4><%=CommonString.getFormatPara(onesubMap.get("factoryname"))%><%=CommonString.getFormatPara(onesubMap.get("name")) %><%=CommonString.getFormatPara(onesubMap.get("catalogname")) %></h4>
            </a></li>
            <%
            	   }
               }
              %>
          </ul>
        </div>
        <div class="pdimgBtn_down"><img src="../images/picbtn_down.gif" width="130" height="25" id="pdilup" /></div>
      </div>
      <div class="photoSearch">
        <form id="form3" name="form3" method="get" action="list.jsp">
          <div class="psi">
            <input type="text" name="keywords" id="keywords" maxlength="20" />
          </div>
          <div class="psb">
            <input type="submit" value="&nbsp;" />
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<div class="otherPhoto c">
  <div class="contain980">
    <div class="title">
      <h3>其他相关图片</h3>
      <span class="more"><a target="_blank" href="/photo/list.jsp?catalog=<%=catalog%>">更多&gt;&gt;</a></span>
    </div>
    <div class="otherList">
      <ul>
        <%
          if(null != relate_pics && relate_pics.size()>0){
        	  for(Map oneMap:relate_pics){
        		  %>
        <li>
          <div><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm"> <img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>图片" width="120" height="90" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></div>
          <h3><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
        </li>
        <%
        	  }
          }
        %>
      </ul>
    </div>
    <div class="w755 border02 l leftPart02">
      <div class="title">
        <h2><%=CommonString.getFormatPara(main_pics.get("factoryname"))%>主营业务</h2>
        <span class="more"><a target="_blank" href="/brand/<%=brandUsernMap.get(factoryid)%>/">更多&gt;&gt;</a></span>
      </div>
      <ul class="list07">
        <jsp:include page="/include/prodetail/pro_sub_left_foot.jsp" flush="true">
        <jsp:param name="factoryid" value='<%=main_pics.get("factoryid")%>'></jsp:param>
        <jsp:param name="factoryname" value='<%=main_pics.get("factoryname")%>'></jsp:param>
        </jsp:include>
      </ul>
    </div>
    <div class="clear"></div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot--> 
<script type="text/javascript" src="/scripts/sort.js"></script> 
<script type="text/javascript">
 function showinquery(pid){
    	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+pid, {
	    title: "在线询价单",
	    width: 720,
	    height: 450,
	     iframeScrolling : 'no',
	    buttons: { '关闭': false }
	    });
	    jQuery(".jbox-button-panel").attr("style","display:none;") ;
    }
</script>
</body>
</html>