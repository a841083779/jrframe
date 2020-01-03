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
	if(factoryid.equals("671")){
	     factoryName ="方圆";
		}else{
		factoryName = CommonString.getFormatPara(brandMap.get(factoryid));
		}
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
	//String url = CommonString.getFormatPara(request.getQueryString()) ;
	
	String faa=""; faa=factory; if(faa.equals("")){faa="0";}
	String caa=""; caa=catalog; if(caa.equals("")){caa="0";}
	String orderNo="";
	if(order.indexOf("001")!=-1){orderNo="001";}
	else if(order.indexOf("002")!=-1){orderNo="002";}
	else{orderNo="001";}
	String url="nlist_"+faa+"_"+caa+"_"+type+"_"+orderNo;
	
	String parentcatalogname = CommonString.getFormatPara(catalogMap.get(catalog.length()>6?catalog.substring(0,6):catalog));
    pageBean.setParams(url) ;
    pageBean.setFields(" id,image,title") ;
    pageBean.setTableName("pro_photo_group") ;
	
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String titled="";String keywordsd="";String descriptiond="";
		String factory1=CommonString.getFormatPara(catalogMap.get(catalog));
		String catalog1=CommonString.getFormatPara(brandMap.get(factory));
       if(factory.equals("")){
		titled="【行业图片】工程机械行业图片_工程机械行业动态图片 – 铁臂图库";
        keywordsd="工程机械行业图片,工程机械行业动态图片,铁臂图库";
        descriptiond="铁臂图库为您提供大量高清工程机械行业图片，帮助您通过行业动态图片了解更多工程机械行业动态，买工程机械产品就上铁臂商城。";
        }else if(!factory.equals("")){
		titled="【行业图片】"+catalog1+"行业图片_"+catalog1+"行业动态图片 - 铁臂图库";
        keywordsd=""+catalog1+"行业图片,"+catalog1+"行业动态图片,铁臂图库";
        descriptiond="铁臂图库为您提供大量高清"+catalog1+"行业图片,帮助您通过行业动态图片了解更多"+catalog1+"行业动态,买工程机械产品就上铁臂商城。";
		}
		
		String maibao="";
		if(factory.equals("")){          
		maibao="&gt;&gt; 行业图片";
		}else 	if(!factory.equals("")){
		maibao="&gt;&gt; <a href=\"/nlist_0_0_"+type+"_0.htm\">行业图片</a> &gt;&gt; <a href=\"/nlist_"+factory+"_0_"+type+"_0.htm\">"+catalog1+"</a> &gt;&gt; "+catalog1+"行业图片";
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
      <div class="w980 border03 l Condition mb10">
        <div class="ConditionTop">
            <div class="l">
            <%
										if (!"".equals(catalog) || !"".equals(factoryid)) {
									%>
            <a href="/nlist_0_0_<%=type%>_0.htm"><span class="reset" >重置</span></a>
            <%
										}
									%>
            <%
										if (!"".equals(catalog) && !"".equals(catalog)) {
									%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="/nlist_<%=factoryid.equals("")?"0":""+factoryid+""%>_0_<%=type%>_0.htm" title="取消" class="delete"
										></a> </span>
            <%
										}
									%>
            <%
										if (!"".equals(factoryid) && !"".equals(factoryid)) {
									%>
            <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="/nlist_0_<%=catalog.equals("")?"0":""+catalog+""%>_<%=type%>_0.htm" title="取消" class="delete"
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
            <h1 class="r" style="font-size:14px;"><%="".equals(wordsSelect) ? "" :""%><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>行业图片大全</h1>
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
           
          <li class="cblist disp">
            <dt> 国内品牌 </dt>
			 <div class="pbtn" ></div>
            <dd class="sel02_1">
			 <a href="/nlist_0_0_107001_0.htm"  <%if("".equals(factory)){%> class='select' <%}%>>不限</a> 
			   <a href="/nlist_671_0_107001_0.htm" target="_top" <%if("671".equals(factory)){%> class='select' <%}%>>方圆集团</a> 
			   <a href="/nlist_141_0_107001_0.htm" target="_top" <%if("141".equals(factory)){%> class='select' <%}%>>福田雷沃</a>
			    <a href="/nlist_136_0_107001_0.htm" target="_top" <%if("136".equals(factory)){%> class='select' <%}%>>柳工</a>
				 <a href="/nlist_135_0_107001_0.htm" target="_top" <%if("135".equals(factory)){%> class='select' <%}%>>龙工</a> 
				 <a href="/nlist_133_0_107001_0.htm" <%if("133".equals(factory)){%> class='select' <%}%>>三一</a> 
				  <a href="/nlist_137_0_107001_0.htm" target="_top" <%if("137".equals(factory)){%> class='select' <%}%>>山东临工</a>
				  <a href="/nlist_209_0_107001_0.htm" target="_top" <%if("209".equals(factory)){%> class='select' <%}%>>徐工</a>
             
          <%
		 for(int i = 0;list != null && i < list.size();i++){
						Map m = list.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
              <a <%if(id.equals(factory)){%> class='select' <%} %> href="/nlist_<%=id%>_0_107001_0.htm"><%=factoryname%></a> 
             
			 <%}%>
            </dd>
			
          </li>
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
             <a href="/nlist_0_0_107001_0.htm"  <%if("".equals(factory)){%> class='select' <%}%>>不限</a> 
               <a href="/nlist_192_0_107001_0.htm" <%if("192".equals(factory)){%> class='select' <%}%>>斗山</a> 
				  <a href="/nlist_175_0_107001_0.htm" target="_top" <%if("175".equals(factory)){%> class='select' <%}%>>沃尔沃</a>
				  <a href="/nlist_182_0_107001_0.htm" <%if("182".equals(factory)){%> class='select' <%}%>>小松</a> 
				 <a href="/nlist_184_0_107001_0.htm" target="_top" <%if("184".equals(factory)){%> class='select' <%}%>>日立</a> 
			   <a href="/nlist_174_0_107001_0.htm" target="_top" <%if("174".equals(factory)){%> class='select' <%}%>>卡特彼勒</a> 
			   <a href="/nlist_1718_0_107001_0.htm" target="_top" <%if("1718".equals(factory)){%> class='select' <%}%>>雷萨重机</a>
          <%
		 for(int i = 0;list2 != null && i < list2.size();i++){
						Map m = list2.get(i);
					    String factoryname=(String)CommonString.getFormatPara(m.get("name"));
						String id = CommonString.getFormatPara(m.get("id"));
		 %>
             <a <%if(id.equals(factory)){%> class='select' <%} %> href="/nlist_<%=id%>_0_107001_0.htm"><%=factoryname%></a> 
             
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
		 
        </ul>
      </div>
      <input type="hidden" name="order" id="order" />
      <input type="hidden" name="keyword" id="key_word" />
    </form>
    <div class="new_cates">
      <ul class="fix">
        <li><a href="/nlist_0_0_<%=type%>_001.htm"  <%if("001".equals(order)){%>class="selected"<%}%>>最新图片</a></li>
        <li><a href="/nlist_0_0_<%=type%>_002.htm" <%if("002".equals(order)){%>class="selected"<%}%>>热门图片</a></li>
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
						if(image.indexOf("uploadfiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}}
					
					
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_photo where group_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"));
				  if(x==0){
				  x=1;
				  }
				%>
          <li>
            <div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" title="<%=title %>"><img src="<%=image %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"  alt="<%=title %>"/></a></div>
            <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" title="<%=title %>"><%=title %></a></div>
			<%
			Map sub_photoCount = dbHelper.getMap(" select count(id) as count  from pro_photo where is_show=1 and group_id = '"+id+"'") ;
			%>
            <div class="num">共<%=x%>张图片</div>
          </li>
         <%
                i++;}}	
                %>
                	</ul>
					
        		</div>
        		</div>
				
   
   <div class="w755 l">
	      <div id="pagination" class="page">
	        	<tags:page_photo pageBean="<%=pageBean %>"/>
	      	</div>   
    </div>


  </div>
</div>
<div class="clear"></div>

<!--main--> 
<!--foot-->
<jsp:include page="../include/foot_photo.jsp"/>
<!--foot end-->
</body>
<script type="text/javascript">

function showmore(){
var m = $("#morebrand");  
m.css("height","auto"); 
//var mm = $("#morebrandhelp");  
//mm.css("height","auto"); 
 $("#showmore").hide(); 
}



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
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>

