<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
 Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}

	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factory")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	if(factoryid.equals("0")){factoryid="";}  	if(catalog.equals("0")){catalog="";}
     if(factory.equals("0")){factory="";} 
	
	DBHelper dbHelper = DBHelper.getInstance();
	String type = CommonString.getFormatPara(request.getParameter("type"));
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String keywords = CommonString.getFormatPara(request.getParameter("keywords")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	ArrayList<Map> allSubCataList = new ArrayList<Map>();
	for(Map subCata : catalogList){
		if(CommonString.getFormatPara(subCata.get("num")).length() == 6){
			allSubCataList.add(subCata);
		}
	}
		if(type.equals("0")){type="";} 
		
		if(order.equals("0")){
		    order="001";
		}else{
		
		
		}
	    offset=order.replace("001","").replace("002","");
		if(offset.equals("")){offset="0";}

	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String showtonandmeter = "";
	if ("grab_1_13".equals(tonandmeter)) {
		showtonandmeter = "小挖(1T~13T)";
	} else if ("grab_14_30".equals(tonandmeter)) {
		showtonandmeter = "中挖(14T~30T)";
	} else if ("grab_30_1".equals(tonandmeter)) {
		showtonandmeter = "大挖(30T以上)";
	} else if ("loader_1_3".equals(tonandmeter)) {
		showtonandmeter = "3T以下";
	} else if ("loader_3_01".equals(tonandmeter)) {
		showtonandmeter = "3T";
	} else if ("loader_3_5".equals(tonandmeter)) {
		showtonandmeter = "3T~5T";
	} else if ("crane_1_16".equals(tonandmeter)) {
		showtonandmeter = "16T以下";
	} else if ("crane_20_70".equals(tonandmeter)) {
		showtonandmeter = "20T~70T";
	} else if ("crane_70_1".equals(tonandmeter)) {
		showtonandmeter = "70T以上";
	} else {
		showtonandmeter = "";
	}
	
	String words="工程机械";
	String wordsSelect=(!"".equals(factoryid)&&!"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"):"")+(!"".equals(factoryid)&&"".equals(catalog)?CommonString.getFormatPara(brandMap.get(factoryid)):"")+showtonandmeter+(catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))));
	if(!wordsSelect.equals("")){words=wordsSelect;}
	
	//
	String factoryName = "";
	String catalogName = "";
	if(factoryid!=null && !factoryid.equals("")){
		factoryName = CommonString.getFormatPara(brandMap.get(factoryid));
	}
	if(catalog!=null && !catalog.equals("")){
		catalogName = CommonString.getFormatPara(catalogMap.get(catalog));
	}
	
	StringBuffer whereStr = new StringBuffer(" and image is not null and is_show=1  ") ;
	if(!"".equals(type)){
		whereStr.append(" and sort_num like '%"+type+"%'") ;
	}
	if(!"".equals(catalogName)){
		whereStr.append(" and (keywords like '%"+catalogName+"%' or catalognum='"+catalog+"')") ;
	}
	if(!"".equals(factoryName)){
		whereStr.append(" and (brand_keywords like '%"+factoryName+"%' or factoryid='"+factoryid+"')") ;
	}
	
	
	String sortName = "";
	if(type.equals("107001")){
		sortName = "行业图片";
	}else if(type.equals("107003")){
		sortName = "施工图片";
	}else if(type.equals("107004")){
		sortName = "维修图片";
	}else if(type.equals("107005")){
		sortName = "展会图片";
	}else if(type.equals("107006")){
		sortName = "趣味图片";
	}else if(type.equals("107007")){
		sortName = "更多图片";
	}
	
	//拆分吨位
	String[] parttonandmeters = null;
	String firsttonandmeter = "";
	String sectonandmeter = "";
	
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(16) ; // 每页显示条数
	if(order.equals("001")){
		pageBean.setOrderBy(" view_count desc ");
	}else if(order.equals("002")){
		pageBean.setOrderBy(" is_hot desc ");
	}else{
		pageBean.setOrderBy(" pub_date desc ");
	}
	pageBean.setCondition(whereStr.toString()) ;

	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
		nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;   
	
	String faa=""; faa=factory; if(faa.equals("")){faa="0";}
	String caa=""; caa=catalog; if(caa.equals("")){caa="0";}
	String orderNo="";
	if(order.indexOf("001")!=-1){orderNo="001";}
	else if(order.indexOf("002")!=-1){orderNo="002";}
	else{orderNo="001";}
	String url="other_"+faa+"_"+caa+"_"+type+"_"+orderNo;
	String parentcatalogname = CommonString.getFormatPara(catalogMap.get(catalog.length()>6?catalog.substring(0,6):catalog));
    pageBean.setParams(url) ;
    pageBean.setFields(" id,image,title") ;
    pageBean.setTableName("pro_photo_group") ;
	
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		
		String leibie = "";
	if(type.equals("107001")){
		leibie = "行业";
	}else if(type.equals("107003")){
		leibie = "施工";
	}else if(type.equals("107004")){
		leibie = "维修";
	}else if(type.equals("107005")){
		leibie = "展会";
	}else if(type.equals("107006")){
		leibie = "趣味";
	}else if(type.equals("107007")){
		leibie = "更多";
	}
	    
		String titled="";String keywordsd="";String descriptiond="";
		String factory1=CommonString.getFormatPara(catalogMap.get(catalog));
		String catalog1=CommonString.getFormatPara(brandMap.get(factory));
		if(type.equals("107003")&&catalog1.equals("")&&factory1.equals("")){
		titled="【"+leibie+"图片】工程机械现场施工图片_工程机械施工图片大全 – 铁臂图库";
        keywordsd="工程机械现场施工图片,工程机械施工图片大全,铁臂图库";
        descriptiond="铁臂图库施工图片大全为您提供大量的工程机械现场施工图片,让您通过浏览施工图片全面了解工程机械施工案例。买工程机械产品,就上铁臂商城。";
        }else if(type.equals("107004")&&catalog1.equals("")&&factory1.equals("")){
		titled="【"+leibie+"图片】工程机械维修图片_工程机械维修养护图片 – 铁臂图库";
        keywordsd="工程机械维修图片,工程机械维修养护图片,铁臂图库";
        descriptiond="铁臂图库为您提供专业的工程机械维修图片,让您在浏览维修图片的过程中更全面的了解工程机械维修养护。买工程机械产品,就上铁臂商城。";
        }else if(type.equals("107006")&&catalog1.equals("")&&factory1.equals("")){
		titled="【"+leibie+"图片】趣味图片_工程机械趣味图片大全 – 铁臂图库";
        keywordsd="工程机械趣味图片,工程机械趣味图片大全,铁臂图库";
        descriptiond=" 铁臂图库为您提供工程机械趣味图片,让您在看工程机械趣味图片的同时缓解生活的压力,买工程机械产品,就上铁臂商城。";
        }else if(type.equals("107003")){
		titled="【施工图片】"+catalog1+""+factory1+"现场施工图片_"+catalog1+""+factory1+"施工图片大全 - 铁臂图库";
        keywordsd=""+catalog1+""+factory1+"现场施工图片,"+catalog1+""+factory1+"施工图片大全,铁臂图库";
        descriptiond="铁臂图库施工图片大全为您提供大量的"+catalog1+""+factory1+"施工图片,您通过浏览施工图片全面了解"+catalog1+""+factory1+"施工案例,买工程机械产品,就上铁臂商城。";
		}else if(type.equals("107004")){
		titled="【"+leibie+"图片】"+catalog1+""+factory1+"维修图片_"+catalog1+""+factory1+"维修养护图片 - 铁臂图库";
        keywordsd=""+catalog1+""+factory1+"维修图片,"+catalog1+""+factory1+"维修养护图片,铁臂图库";
        descriptiond="铁臂图库为您提供专业的的"+catalog1+""+factory1+"维修图片,让您在浏览"+catalog1+""+factory1+"维修图片的过程中更全面的了解"+catalog1+""+factory1+"维修养护。买工程机械产品,就上铁臂商城。";
		}else if(type.equals("107006")){
		titled="【"+leibie+"图片】"+catalog1+""+factory1+"趣味图片_"+catalog1+""+factory1+"趣味图片大全 - 铁臂图库";
        keywordsd=""+catalog1+""+factory1+"趣味图片,"+catalog1+""+factory1+"趣味图片大全,铁臂图库";
        descriptiond="铁臂商城图库提供最新最全的"+catalog1+""+factory1+"趣味图片,同时还有真实用户分享更多趣味图片,让您在看"+catalog1+""+factory1+"趣味图库的同时缓解生活的压力,买"+catalog1+""+factory1+"产品,就上铁臂商城。";
		}
	 
		String maibao="";
		if(factory.equals("")&&catalog.equals("")){         
		maibao="&gt;&gt; <a href=\"/other_0_0_"+type+"_0.htm\">"+sortName+"</a>";
		}else 	if(!factory.equals("")&&catalog.equals("")){
		maibao=" &gt;&gt; <a href=\"/other_0_0_"+type+"_0.htm\">"+sortName+"</a> &gt;&gt; <a href=\"/other_"+factory+"_0_"+type+"_0.htm\">"+catalog1+"</a> &gt;&gt;"+catalog1+""+sortName+"";
		}else 	if(factory.equals("")&&!catalog.equals("")){
		maibao=" &gt;&gt; <a href=\"/other_0_0_"+type+"_0.htm\">"+sortName+"</a> &gt;&gt; <a href=\" /other_0_"+catalog+"_"+type+"_0.htm\">"+factory1+"</a> &gt;&gt;"+factory1+""+sortName+"";
		}else if(!factory.equals("")&&!catalog.equals("")){
		maibao=" &gt;&gt; <a href=\"/other_0_0_"+type+"_0.htm\">"+sortName+"</a> &gt;&gt; <a href=\"  /other_"+factory+"_0_"+type+"_0.htm\">"+catalog1+"</a> &gt;&gt;   <a href=\" /other_0_"+catalog+"_"+type+"_0.htm\">"+factory1+"</a> &gt;&gt; <a href=\"/other_"+factory+"_"+catalog+"_"+type+"_0.htm\">"+catalog1+""+factory1+"</a> &gt;&gt; "+catalog1+""+factory1+""+sortName+"";
		}
			//国内品牌
		List<Map> list = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_photo_group.factoryid) from pro_photo_group  where is_show=1 and sort_num like '%"+type+"%') and is_inner=1 order by view_count desc",connection) ;
		
			//国外品牌
		List<Map> list2 = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_photo_group.factoryid) from pro_photo_group  where is_show=1 and sort_num like '%"+type+"%')and is_inner=0 order by view_count desc",connection) ;
		
		
%>
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
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript">

function showupload(a){
    	jQuery.jBox("iframe:http://product.21-sun.com/photo_domain/upload.jsp?type="+a, {
	    title: "图片上传",
	    width: 720,
	    height: 435,
	    iframeScrolling : 'no',
	    buttons: { '关闭': false }
	    });
    }
</script>
</head>
<body class="photobg">
<!--top--> 
<a class="shop_topbg"></a>
<jsp:include page="/include/top_photo_news.jsp" flush="true">
<jsp:param value="<%=type%>" name="type"/>
</jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂图库</a> <%=maibao%></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="np_fix contain980 pho_main">
  <div class="new_layout">
    <form name="theform" id="theform" action="/list.jsp">
      <div class="w755 border03 l Condition mb10">
	   <div class="ConditionTop">
          <div class="l">
            <%
										if (!"".equals(catalog) || !"".equals(factoryid)) {
									%>
            <a href="/other_0_0_<%=type%>_0.htm"><span class="reset" >重置</span></a>
            <%
										}
									%>
            <%
										if (!"".equals(catalog) && !"".equals(catalog)) {
									%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_0_<%=type%>_0.htm" title="取消" class="delete"
										></a> </span>
            <%
										}
									%>
            <%
										if (!"".equals(factoryid) && !"".equals(factoryid)) {
									%>
            <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="/other_0_<%=catalog.equals("")?"0":""+catalog+""%>_<%=type%>_0.htm" title="取消" class="delete"
										></a> </span>
            <%
										}
									%>
            <%
										if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {
									%>
            <span><em><%=showtonandmeter%></em> <a
										href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","<%=factoryid%>","")'></a> </span>
            <%
										}
									%>
          </div>
           <h1 class="r" style="font-size:14px;"><%="".equals(wordsSelect) ? "" :""%><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%><%=leibie%>图片大全</h1>
        </div>
        <ul class="ConditionBottom">
          <script type="text/javascript">
          jQuery(document).ready(function() {
              jQuery("#changethis").click(function(){
                  jQuery(this).next("div").slideToggle(0)
                  .siblings(".plmore:visible").slideUp(0);
                  jQuery(this).toggleClass("pbon");
                  jQuery(this).siblings(".pbon").removeClass("pbon");
              });	
          });
          </script>
          <li class="cblist">
            <dt> 类别 </dt>
            <input type="hidden" name="factory" id="factory_id" />
            <input type="hidden" name="catalog" id="catalognum" />
            <dd> 
			<a  href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_0_<%=type%>_0.htm" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a>  
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_101001_<%=type.equals("")?"":""+type%>_0.htm" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_101002_<%=type.equals("")?"":""+type%>_0.htm" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_102_<%=type.equals("")?"":""+type%>_0.htm" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_101003_<%=type.equals("")?"":""+type%>_0.htm" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_103_<%=type.equals("")?"":""+type%>_0.htm" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_106001_<%=type.equals("")?"":""+type%>_0.htm" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_101005_<%=type.equals("")?"":""+type%>_0.htm" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_105003_<%=type.equals("")?"":""+type%>_0.htm" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_113001_<%=type.equals("")?"":""+type%>_0.htm" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> 
            <a href="/other_<%=factoryid.equals("")?"0":""+factoryid+""%>_104001_<%=type.equals("")?"":""+type%>_0.htm" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 905px;;">
            <jsp:include page="/include/products/catalog_news_weixiu.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=order%>" name="order"/>
			<jsp:param value="<%=type%>" name="typed"/>
            <jsp:param value="photo" name="flag"/>
            </jsp:include>
              </div>
            </dd>
          </li>
		    
          <%if((list!=null&&list.size()>0)||type.equals("107006")||type.equals("107004")){%>
          <li class="cblist disp">
            <dt> 国内品牌 </dt>
			 <div class="pbtn" ></div>
            <dd class="sel02_1">
             
              <a href="/other_0_0_<%=type.equals("")?"0":type%>_0.htm"  <%if("".equals(factory)){%> class='select' <%}%>>不限</a> 
			  <% if(type.equals("107006")){ %>
			   <a href="/other_141_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("141".equals(factory)){%> class='select' <%}%>>福田雷沃</a>
			   <a href="/other_135_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("135".equals(factory)){%> class='select' <%}%>>龙工</a> 
				   <a href="/other_146_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" <%if("146".equals(factory)){%> class='select' <%}%>>玉柴重工</a> 
			  <%}else if(type.equals("107004")){%>
			    <a href="/other_136_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("136".equals(factory)){%> class='select' <%}%>>柳工</a>
				 <a href="/other_135_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("135".equals(factory)){%> class='select' <%}%>>龙工</a> 
				 <a href="/other_133_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" <%if("133".equals(factory)){%> class='select' <%}%>>三一</a> 
			  
			   <%}%>
          <%
		 for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
              <a <%if(id.equals(factory)){%> class='select' <%} %> href="/other_<%=id%>_<%=catalog.equals("")?"0":catalog%>_<%=type%>_0.htm"><%=factoryname%></a> 
             
			 <%}%>
            </dd>
			
          </li><%}%>
		  <script type="text/javascript">
		  $('.disp').find('.pbtn').click(function(){
			if($(this).hasClass('pbon')){
				$(this).removeClass('pbon');
				$(this).next('.sel02_1').removeClass('sel_more');
				$('.plist_box').stop(1,0).animate({scrollTop:'0'},1);
			}else{
				$(this).addClass('pbon');
				$(this).next('.sel02_1').addClass('sel_more');
			}
		  })
		  </script>
		      
          <li class="cblist disb">
            <dt> 国外品牌 </dt>
			 <div class="pbtn" ></div>
            <dd class="sel02_3">
             
             <a href="/other_0_0_<%=type.equals("")?"0":type%>_0.htm"  <%if("".equals(factory)){%> class='select' <%}%>>不限</a> 
			   <% if(type.equals("107006")){ %>
			    <a href="/other_192_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" <%if("192".equals(factory)){%> class='select' <%}%>>斗山</a> 
				 <a href="/other_179_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("179".equals(factory)){%> class='select' <%}%>>利勃海尔</a>
			  <%}else if(type.equals("107004")){%>
			   <a href="/other_192_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" <%if("192".equals(factory)){%> class='select' <%}%>>斗山</a> 
				  <a href="/other_175_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("175".equals(factory)){%> class='select' <%}%>>沃尔沃</a>
				  <a href="/other_182_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" <%if("182".equals(factory)){%> class='select' <%}%>>小松</a> 
				 <a href="/other_184_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("184".equals(factory)){%> class='select' <%}%>>日立</a> 
			   <a href="/other_185_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("185".equals(factory)){%> class='select' <%}%>>住友</a>
			   <%}else if(type.equals("107003")){%>
			    <a href="/other_455_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("455".equals(factory)){%> class='select' <%}%>>凯斯</a>
				<a href="/other_189_<%=catalog.equals("")?"0":catalog%>_<%=type.equals("")?"0":type%>_0.htm" target="_top" <%if("189".equals(factory)){%> class='select' <%}%>>加藤</a>
			   <%}%>
          <%
		 for(int i = 0;list2 != null && i < list2.size();i++){
						Map m = list2.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
             <a <%if(id.equals(factory)){%> class='select' <%} %> href="/other_<%=id%>_<%=catalog.equals("")?"0":catalog%>_<%=type%>_0.htm"><%=factoryname%></a> 
             
			 <%}%>
            </dd>
			
          </li>
		  <script type="text/javascript">
		    $('.disb').find('.pbtn').click(function(){
			if($(this).hasClass('pbon')){
				$(this).removeClass('pbon');
				$(this).next('.sel02_3').removeClass('sel_more');
				$('.plist_box').stop(1,0).animate({scrollTop:'0'},1);
			}else{
				$(this).addClass('pbon');
				$(this).next('.sel02_3').addClass('sel_more');
			}
		  })
		  </script>
        <!--  <li class="cblist" id="grab" style="display: none;">
            <dt> 吨位 </dt>
            <dd>
              <input type="hidden" name="tonandmeter" id="tonandmeter">
              <a href="javascript:void(0)" onclick="sosuo('','')" class="select">不限</a> <a href="javascript:;" onclick="sosuo('','','grab_1_13')">小挖(1T～13T)</a>&nbsp; <a href="javascript:;" onclick="sosuo('','','grab_14_30')">中挖(14T～30T)</a> <a href="javascript:;" onclick="sosuo('','','grab_30_1')">大挖(30T以上)</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="loader">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)" onclick="sosuo('','')" class="select">不限</a> <a href="javascript:;" onclick="sosuo('','','loader_1_3')">3T以下</a> <a href="javascript:;" onclick="sosuo('','','loader_3_01')">3T</a> <a href="javascript:;" onclick="sosuo('','','loader_3_5')">3T～5T</a> <a href="javascript:;" onclick="sosuo('','','loader_5_1')">5T以上</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="crane">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)" onclick="sosuo('','')" class="select">不限</a> <a href="javascript:;" onclick="sosuo('','','crane_1_16')">16T以下</a> <a href="javascript:;" onclick="sosuo('','','crane_20_70')">20T～70T</a> <a href="javascript:;" onclick="sosuo('','','crane_70_1')"> 70T以上</a> </dd>
          </li>-->
        </ul>
      </div>
      <input type="hidden" name="order" id="order">
      <input type="hidden" name="keyword" id="key_word">
    </form>
    <div class="new_cates">
      <ul class="fix">
        <li><a href="/other_0_0_<%=type%>_001.htm"  <%if("001".equals(order)){%>class="selected"<%}%>>最新图片</a></li>
        <li><a href="/other_0_0_<%=type%>_002.htm" <%if("002".equals(order)){%>class="selected"<%}%>>热门图片</a></li>
      </ul>
      <a href="javascript:void(0);" class="uploadBtn" onclick="<% if(username.equals("")){ %>login();<%}else{%>showupload('<%=type%>');<%}%>">上传图片</a>
    </div>
    <div class="pho_pic_val phopic_list_small">
      <div class="phopic_list">
        <ul class="fix">
		<%
            	List<Map> main_picList = pageBean.getDatas() ;  // 根据条件查出的产品
    			if(null !=main_picList && main_picList.size()>0){
        		    String catalogNo="";
        		    int i = 1;
                	for(Map oneMap:main_picList){
        			   catalogNo=(String)CommonString.getFormatPara(oneMap.get("catalognum"));
        			   if(catalogNo.length()>6){
        			      catalogNo=catalogNo.substring(0,6);
        			   }
        			   parentcatalogname=CommonString.getFormatPara(catalogMap.get(catalogNo));
				        String id = CommonString.getFormatPara(oneMap.get("id"));
	        			String image = CommonString.getFormatPara(oneMap.get("image"));
	        			String title = CommonString.getFormatPara(oneMap.get("title"));
							if(image.indexOf("resource")>0){
							image=image;
							}else{
						
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			   }
					
				  Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_photo where group_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"));
				  if(x==0){
				  x=1;
				  }
				%>
          <li>
            <div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" alt="<%=title %>"/></a></div>
            <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" title="<%=title %>"><%=title %></a></div>
            <div class="num">共<%=x%>张图片</div>
          </li>
         <%
                		if(i!=1&&i!=16&&i!=pageBean.getTotal()&&i%4==0){
                %>
                	</ul>
        		</div>
        		</div>
        		   <div class="pho_pic_val phopic_list_small">
      <div class="phopic_list">
			        	<ul class="fix">
                <%			
                		}
                		i++;
                		}
        	       }else{
				%>
				 <span class="textStyle">暂无信息</span>
				<%}%>
        </ul>
      </div>	
    </div>
    <div class="w755 l">
	      <div id="pagination" class="page">
	        	<tags:page_photo pageBean="<%=pageBean %>"/>
	      	</div>   
    	</div>

		
        

  <%
	if(!catalog.equals("")){
		List<Map> brandList = dbHelper.getMapList("select  id,name from pro_agent_factory where is_show=1 and flag=1 and id in (select distinct factoryid from pro_products where catalognum like '"+catalog+"%' ) order by view_count desc");
		if(brandList!=null && brandList.size()>0){
%>
  <!--更多品牌图片-->
  <%if(!catalog.equals("") || !factory.equals("")){%>
  <div class="contain980 photo_d_b">
      <div class="allCatalog">
       <div class="mt fix">
          <h3 style="float: left;">更多<%=sortName%>  </h3>
		  <div id="pagination" style="float: right;">
					<div> <a style="cursor:pointer;color:#666666;float: right;line-height: 28px;padding-right: 10px;font-family: 宋体;" id="showmore" onclick="showmore();">加载更多</a></div>
	  </div>
		
        </div>
		
       <ul class="list" id="morebrand" style="height:100px;overflow: hidden;">
		
          <li><a title="徐工<%=sortName%>" href="/other_209_0_<%=type%>_0.htm">徐工<%=sortName%></a></li>
          <li><a title="三一<%=sortName%>" href="/other_133_0_<%=type%>_0.htm">三一<%=sortName%></a></li>
          <li><a title="小松<%=sortName%>" href="/other_182_0_<%=type%>_0.htm">小松<%=sortName%></a></li>
          <li><a title="柳工<%=sortName%>" href="/other_136_0_<%=type%>_0.htm">柳工<%=sortName%></a></li>
          <li><a title="中联重科<%=sortName%>" href="/other_134_0_<%=type%>_0.htm">中联重科<%=sortName%></a></li>
          <li><a title="斗山<%=sortName%>" href="/other_192_0_<%=type%>_0.htm">斗山<%=sortName%></a></li>
          <li><a title="卡特<%=sortName%>" href="/other_174_0_<%=type%>_0.htm">卡特<%=sortName%></a></li>
          <li><a title="沃尔沃<%=sortName%>" href="/other_175_0_<%=type%>_0.htm">沃尔沃<%=sortName%></a></li>
          <li><a title="福田雷沃<%=sortName%>" href="/other_141_0_<%=type%>_0.htm">福田雷沃<%=sortName%></a></li>
          <li><a title="日立<%=sortName%>" href="/other_184_0_<%=type%>_0.htm">日立<%=sortName%></a></li>
          <li><a title="龙工<%=sortName%>" href="/other_135_0_<%=type%>_0.htm">龙工<%=sortName%></a></li>
          <li><a title="厦工<%=sortName%>" href="/other_139_0_<%=type%>_0.htm">厦工<%=sortName%></a></li>
          <li><a title="神钢<%=sortName%>" href="/other_183_0_<%=type%>_0.htm">神钢<%=sortName%></a></li>
          <li><a title="利勃海尔<%=sortName%>" href="/other_179_0_<%=type%>_0.htm">利勃海尔<%=sortName%></a></li>
          <li><a title="山河智能<%=sortName%>" href="/other_142_0_<%=type%>_0.htm">山河智能<%=sortName%></a></li>
          <li><a title="山东临工<%=sortName%>" href="/other_137_0_<%=type%>_0.htm">山东临工<%=sortName%></a></li>
          <li><a title="加藤<%=sortName%>" href="/other_189_0_<%=type%>_0.htm">加藤<%=sortName%></a></li>
          <li><a title="山重建机<%=sortName%>" href="/other_152_0_<%=type%>_0.htm">山重建机<%=sortName%></a></li>
          <li><a title="凯斯<%=sortName%>" href="/other_455_0_<%=type%>_0.htm">凯斯<%=sortName%></a></li>
          <li><a title="玉柴<%=sortName%>" href="/other_146_0_<%=type%>_0.htm">玉柴<%=sortName%></a></li>
          <li><a title="特雷克斯<%=sortName%>" href="/other_176_0_<%=type%>_0.htm">特雷克斯<%=sortName%></a></li>
          <li><a title="卡特重工<%=sortName%>" href="/other_178_0_<%=type%>_0.htm">卡特重工<%=sortName%></a></li>
          <li><a title="现代<%=sortName%>" href="/other_194_0_<%=type%>_0.htm">现代<%=sortName%></a></li>
          <li><a title="住友<%=sortName%>" href="/other_185_0_<%=type%>_0.htm">住友<%=sortName%></a></li>
          <li><a title="JCB<%=sortName%>" href="/other_177_0_<%=type%>_0.htm">JCB<%=sortName%></a></li>
          <li><a title="久保田<%=sortName%>" href="/other_187_0_<%=type%>_0.htm">久保田<%=sortName%></a></li>
          <li><a title="徐挖<%=sortName%>" href="/other_150_0_<%=type%>_0.htm">徐挖<%=sortName%></a></li>
          <li><a title="沃得重工<%=sortName%>" href="/other_149_0_<%=type%>_0.htm">沃得重工<%=sortName%></a></li>
          <li><a title="河北宣工<%=sortName%>" href="/other_154_0_<%=type%>_0.htm">河北宣工<%=sortName%></a></li>
          <li><a title="竹内<%=sortName%>" href="/other_188_0_<%=type%>_0.htm">竹内<%=sortName%></a></li>
          <li><a title="常林股份<%=sortName%>" href="/other_148_0_<%=type%>_0.htm">常林股份<%=sortName%></a></li>
          <li><a title="开元智富<%=sortName%>" href="/other_160_0_<%=type%>_0.htm">开元智富<%=sortName%></a></li>
          <li><a title="力士德<%=sortName%>" href="/other_157_0_<%=type%>_0.htm">力士德<%=sortName%></a></li>
          <li><a title="鼎盛重工<%=sortName%>" href="/other_140_0_<%=type%>_0.htm">鼎盛重工<%=sortName%></a></li>
          <li><a title="熔盛机械<%=sortName%>" href="/other_173_0_<%=type%>_0.htm">熔盛机械<%=sortName%></a></li>
          <li><a title="江淮重工<%=sortName%>" href="/other_479_0_<%=type%>_0.htm">江淮重工<%=sortName%></a></li>
          <li><a title="鸿达<%=sortName%>" href="/other_217_0_<%=type%>_0.htm">鸿达<%=sortName%></a></li>
          <li><a title="上海彭浦<%=sortName%>" href="/other_156_0_<%=type%>_0.htm">上海彭浦<%=sortName%></a></li>
          <li><a title="晋工<%=sortName%>" href="/other_172_0_<%=type%>_0.htm">晋工<%=sortName%></a></li>
          <li><a title="山猫<%=sortName%>" href="/other_454_0_<%=type%>_0.htm">山猫<%=sortName%></a></li>
          <li><a title="移山<%=sortName%>" href="/other_161_0_<%=type%>_0.htm">移山<%=sortName%></a></li>
          <li><a title="洋马<%=sortName%>" href="/other_191_0_<%=type%>_0.htm">洋马<%=sortName%></a></li>
          <li><a title="石川岛<%=sortName%>" href="/other_190_0_<%=type%>_0.htm">石川岛<%=sortName%></a></li>
          <li><a title="阿特拉斯<%=sortName%>" href="/other_180_0_<%=type%>_0.htm">阿特拉斯<%=sortName%></a></li>
          <li><a title="格瑞德<%=sortName%>" href="/other_477_0_<%=type%>_0.htm">格瑞德<%=sortName%></a></li>
          <li><a title="华力重工<%=sortName%>" href="/other_206_0_<%=type%>_0.htm">华力重工<%=sortName%></a></li>
          <li><a title="恒特<%=sortName%>" href="/other_170_0_<%=type%>_0.htm">恒特<%=sortName%></a></li>
          <li><a title="抚挖<%=sortName%>" href="/other_164_0_<%=type%>_0.htm">抚挖<%=sortName%></a></li>
          <li><a title="詹阳动力<%=sortName%>" href="/other_195_0_<%=type%>_0.htm">詹阳动力<%=sortName%></a></li>
          <li><a title="烟工<%=sortName%>" href="/other_155_0_<%=type%>_0.htm">烟工<%=sortName%></a></li>
          <li><a title="大信重工<%=sortName%>" href="/other_171_0_<%=type%>_0.htm">大信重工<%=sortName%></a></li>
          <li><a title="南特<%=sortName%>" href="/other_169_0_<%=type%>_0.htm">南特<%=sortName%></a></li>
          <li><a title="普什重机<%=sortName%>" href="/other_486_0_<%=type%>_0.htm">普什重机<%=sortName%></a></li>
          <li><a title="江麓<%=sortName%>" href="/other_487_0_<%=type%>_0.htm">江麓<%=sortName%></a></li>
          <li><a title="徐威重科<%=sortName%>" href="/other_544_0_<%=type%>_0.htm">徐威重科<%=sortName%></a></li>
          <li><a title="愚公机械<%=sortName%>" href="/other_562_0_<%=type%>_0.htm">愚公机械<%=sortName%></a></li>
          <li><a title="勤牛<%=sortName%>" href="/other_582_0_<%=type%>_0.htm">勤牛<%=sortName%></a></li>
          <li><a title="犀牛重工<%=sortName%>" href="/other_623_0_<%=type%>_0.htm">犀牛重工<%=sortName%></a></li>
          <li><a title="森田重机<%=sortName%>" href="/other_626_0_<%=type%>_0.htm">森田重机<%=sortName%></a></li>
          <li><a title="永工<%=sortName%>" href="/other_647_0_<%=type%>_0.htm">永工<%=sortName%></a></li>
          <li><a title="沃尔华<%=sortName%>" href="/other_662_0_<%=type%>_0.htm">沃尔华<%=sortName%></a></li>
          <li><a title="洛阳路通<%=sortName%>" href="/other_673_0_<%=type%>_0.htm">洛阳路通<%=sortName%></a></li>
          <li><a title="军联<%=sortName%>" href="/other_681_0_<%=type%>_0.htm">军联<%=sortName%></a></li>
          <li><a title="福临<%=sortName%>" href="/other_682_0_<%=type%>_0.htm">福临<%=sortName%></a></li>
          <li><a title="新筑股份<%=sortName%>" href="/other_690_0_<%=type%>_0.htm">新筑股份<%=sortName%></a></li>
          <li><a title="宜工<%=sortName%>" href="/other_770_0_<%=type%>_0.htm">宜工<%=sortName%></a></li>
          <li><a title="北车重工<%=sortName%>" href="/other_1093_0_<%=type%>_0.htm">北车重工<%=sortName%></a></li>
          <li><a title="海斗<%=sortName%>" href="/other_1109_0_<%=type%>_0.htm">海斗<%=sortName%></a></li>
          <li><a title="恒天九五<%=sortName%>" href="/other_1147_0_<%=type%>_0.htm">恒天九五<%=sortName%></a></li>
          <li><a title="福工<%=sortName%>" href="/other_1183_0_<%=type%>_0.htm">福工<%=sortName%></a></li>
          <li><a title="奇瑞迪凯重科<%=sortName%>" href="/other_1184_0_<%=type%>_0.htm">奇瑞迪凯重科<%=sortName%></a></li>
          <li><a title="东方红<%=sortName%>" href="/other_1187_0_<%=type%>_0.htm">东方红<%=sortName%></a></li>
          <li><a title="巨超重工<%=sortName%>" href="/other_1193_0_<%=type%>_0.htm">巨超重工<%=sortName%></a></li>
          <li><a title="山挖重工<%=sortName%>" href="/other_1207_0_<%=type%>_0.htm">山挖重工<%=sortName%></a></li>
          <li><a title="南车北京时代<%=sortName%>" href="/other_1209_0_<%=type%>_0.htm">南车北京时代<%=sortName%></a></li>
          <li><a title="中国重汽<%=sortName%>" href="/other_1214_0_<%=type%>_0.htm">中国重汽<%=sortName%></a></li>
          <li><a title="道胜<%=sortName%>" href="/other_1218_0_<%=type%>_0.htm">道胜<%=sortName%></a></li>
          <li><a title="现代建机<%=sortName%>" href="/other_1227_0_<%=type%>_0.htm">现代建机<%=sortName%></a></li>
          <li><a title="久工<%=sortName%>" href="/other_1232_0_<%=type%>_0.htm">久工<%=sortName%></a></li>
          <li><a title="建德机械<%=sortName%>" href="/other_1352_0_<%=type%>_0.htm">建德机械<%=sortName%></a></li>
          <li><a title="国机重工<%=sortName%>" href="/other_1369_0_<%=type%>_0.htm">国机重工<%=sortName%></a></li>
          <li><a title="合矿<%=sortName%>" href="/other_1525_0_<%=type%>_0.htm">合矿<%=sortName%></a></li>
          <li><a title="华伟重工<%=sortName%>" href="/other_1526_0_<%=type%>_0.htm">华伟重工<%=sortName%></a></li>
          <li><a title="劲工<%=sortName%>" href="/other_1586_0_<%=type%>_0.htm">劲工<%=sortName%></a></li>
          <li><a title="新源机械<%=sortName%>" href="/other_1683_0_<%=type%>_0.htm">新源机械<%=sortName%></a></li>
          <li><a title="威盛<%=sortName%>" href="/other_1738_0_<%=type%>_0.htm">威盛<%=sortName%></a></li>
          <li><a title="小橋<%=sortName%>" href="/other_1741_0_<%=type%>_0.htm">小橋<%=sortName%></a></li>
          <li><a title="农友<%=sortName%>" href="/other_1748_0_<%=type%>_0.htm">农友<%=sortName%></a></li>
          <li><a title="忆辉<%=sortName%>" href="/other_1749_0_<%=type%>_0.htm">忆辉<%=sortName%></a></li>
          <li><a title="京城长野<%=sortName%>" href="/other_1759_0_<%=type%>_0.htm">京城长野<%=sortName%></a></li>
          <li><a title="东德重工<%=sortName%>" href="/other_1763_0_<%=type%>_0.htm">东德重工<%=sortName%></a></li>
          <li><a title="富亿机械<%=sortName%>" href="/other_1888_0_<%=type%>_0.htm">富亿机械<%=sortName%></a></li>
          <li><a title="新宇机械<%=sortName%>" href="/other_13098_0_<%=type%>_0.htm">新宇机械<%=sortName%></a></li>
          <li><a title="嘉和重工<%=sortName%>" href="/other_13176_0_<%=type%>_0.htm">嘉和重工<%=sortName%></a></li>
          <li><a title="山东众和<%=sortName%>" href="/other_13209_0_<%=type%>_0.htm">山东众和<%=sortName%></a></li>
          <li><a title="奥泰<%=sortName%>" href="/other_13272_0_<%=type%>_0.htm">奥泰<%=sortName%></a></li>
          <li><a title="宝鼎<%=sortName%>" href="/other_13570_0_<%=type%>_0.htm">宝鼎<%=sortName%></a></li>
          <li><a title="力士<%=sortName%>" href="/other_13683_0_<%=type%>_0.htm">力士<%=sortName%></a></li>
          <li><a title="闽工<%=sortName%>" href="/other_13697_0_<%=type%>_0.htm">闽工<%=sortName%></a></li>
          <li><a title="纳科重工<%=sortName%>" href="/other_13700_0_<%=type%>_0.htm">纳科重工<%=sortName%></a></li>
          <li><a title="上力重工<%=sortName%>" href="/other_13718_0_<%=type%>_0.htm">上力重工<%=sortName%></a></li>
          <li><a title="厦装<%=sortName%>" href="/other_13783_0_<%=type%>_0.htm">厦装<%=sortName%></a></li>
          <li><a title="神娃机械<%=sortName%>" href="/other_14235_0_<%=type%>_0.htm">神娃机械<%=sortName%></a></li>
          <li><a title="约翰迪尔<%=sortName%>" href="/other_14238_0_<%=type%>_0.htm">约翰迪尔<%=sortName%></a></li>
          <li><a title="开普动力<%=sortName%>" href="/other_14247_0_<%=type%>_0.htm">开普动力<%=sortName%></a></li>
          <div class="clear_0_<%=type%>_0.htm"></div>
        </ul>

      </div>
    </div><%}%>
    <!--更多品牌图片结束  -->
  <div class="clear"></div>
  <!--更多品牌图片结束-->
  <%
		}
	}
%>

        
  </div>
</div>
<!--main--> 
<!--foot-->
<jsp:include page="/include/foot_photo.jsp"/>
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
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
