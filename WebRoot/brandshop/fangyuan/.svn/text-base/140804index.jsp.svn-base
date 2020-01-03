<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%
  Map oneMap = null ;
  DBHelper dbHelper = DBHelper.getInstance() ;
  //混凝土搅拌设备
  String sql_hn = "select top 2 id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1 and catalognum like'103002%' AND (id=5764 OR id=11588) order by view_count desc" ;
  List<Map> productsListHn = null ;
  productsListHn = dbHelper.getMapList(sql_hn) ;
  
  //塔式起重机
  String sql_ts = "select top 2 id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1 and catalognum like'102002%' order by view_count desc" ;
  List<Map> productsListTs = null ;
  productsListTs = dbHelper.getMapList(sql_ts) ;
  
   //施工升降机
 String sql_sg= "select top 2 id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1  and  catalognum  like'102011%' order by view_count desc" ;
  List<Map> productsListSg = null ;
  productsListSg = dbHelper.getMapList(sql_sg) ;
  
  //稳定土拌和站
 String sql_wd= "select top 2 id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1 and  catalognum  like'104006%' order by view_count desc" ;
 List<Map> productsListWd = null ;
  productsListWd = dbHelper.getMapList(sql_wd) ;
  
    //混泥土搅拌运输车
    String sql_ys= "select top 2 id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1 and catalognum LIKE'103019%' order by view_count desc" ;
 List<Map> productListYs = null ;
  productListYs = dbHelper.getMapList(sql_ys) ;
    //输送泵
    String sql_sq= "select top 2 id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1 and catalognum LIKE '103020%' order by view_count desc" ;
 List<Map> productList_sq = null ;
  productList_sq = dbHelper.getMapList(sql_sq) ;
  //其他工程机械
    String sql_qt= "select top 2 id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname from pro_products where factoryid=671 and is_show=1 and catalognum LIKE '105%'  order by view_count desc" ;
 List<Map> productListQt = null ;
  productListQt = dbHelper.getMapList(sql_qt) ;
	//公司信息
	String  company="select introduce from pro_agent_factory where id=671";
   List<Map> companyInfo = null ;
   companyInfo = dbHelper.getMapList(company) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>方圆旗舰店-中国工程机械商贸网</title>
<meta name="keywords" content="方圆集团,方圆集团品牌专区" />
<meta name="description" content="铁臂商城为您提供方圆集团产品，方圆集团报价，方圆集团图片等全面的方圆集团信息，帮助您全面了解方圆集团。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/fangyuan.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
</head>
<body class="fy_body">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end-->
<!--main-->
<div class="fy_top">
	<div class="contain980 fix">
    	<h2 class="fy_logo"><a href="/brandshop/fangyuan/" title="方圆集团"><img src="images/fy_logo.gif" alt="方圆集团"/></a></h2>
        <ul class="fy_nav fix">
        	<li class="cur"><a href="/brandshop/fangyuan/" >首页</a></li>
            <li><a href="/brandshop/fangyuan/list.jsp?catalog=103002" title="混凝土搅拌设备">混凝土搅拌设备</a></li>
            <li><a href="/brandshop/fangyuan/list.jsp?catalog=102002" title="塔式起重机">塔式起重机</a></li>
            <li><a href="/brandshop/fangyuan/list.jsp?catalog=102011" title="塔式起重机">施工升降机</a></li>
            <li><a href="/brandshop/fangyuan/list.jsp?catalog=104006" title="稳定土拌和站">稳定土拌和站</a></li>
            <li><a href="/brandshop/fangyuan/list.jsp?catalog=103019" title="混凝土搅拌运输车">混凝土搅拌运输车</a></li>
            <li><a href="/brandshop/fangyuan/list.jsp?catalog=103020" title="输送泵">输送泵</a></li>
            <li><a href="/brandshop/fangyuan/list.jsp?catalog=105"  title="桩工机械">桩工机械</a></li>
        </ul>
    </div>
</div>
<!--banner-->
<div class="fy_banner">
	<div class="bd">
    	<ul>
        	<li style="background-image:url(images/banner_01.jpg);"></li>
            <li style="background-image:url(images/banner_02.jpg);"></li>
        </ul>
    </div>
    <div class="hd"></div>
</div>
<!--banner end-->
<div class="fymain_bg">
	<div class="contain980 fix">
    	<div class="fy_mval mval_left bg_p1">
        	<ul class="fix fypro_list">
				  <% 
                  String fullName=null;
                  String imgSrc=null;
				  String catalogName=null;
				  String name=null;
				  String file_name=null;
				   String     id =null;
                  if(null!=productsListHn && productsListHn.size()>0){
                    for(int i=0;i<productsListHn.size();i++){
					
                      oneMap = (HashMap)productsListHn.get(i);		
					  catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));					  
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>"/></a></div>
                    <div class="fy_name">
					<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
						
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
               </ul>
            <div class="ftpro_sum">
            	<a href="/brandshop/fangyuan/list.jsp?catalog=103002" title="混凝土搅拌设备">
                	<div class="fy_t1">混凝土搅拌设备</div>
                    <div class="fy_t2">更多、更快、更好、更省</div>
					
				<div class="fy_more" style="cursor:pointer;" >查看更多</div>			
               </a>
            </div>
        </div>
        <div class="fy_mval mval_right bg_p2">
        	<ul class="fix fypro_list">
			<%
            	if(null!=productsListTs && productsListTs.size()>0){
                    for(int i=0;i<productsListTs.size();i++){
                      oneMap = (HashMap)productsListTs.get(i);					
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>"/></a></div>
                    <div class="fy_name">
						<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
               
            </ul>
            <div class="ftpro_sum">
            	 <a href="/brandshop/fangyuan/list.jsp?catalog=102002" title="塔式起重机">
                	<div class="fy_t1">塔式起重机</div>
                    <div class="fy_t2">经久耐用，行业首选</div>
                 <div style="cursor:pointer;" class="fy_more">查看更多</div>
                </a>
            </div>
        </div>
        <div class="fy_mval mval_left bg_p3">
        	<ul class="fix fypro_list">
            	<%
            	if(null!=productsListSg && productsListSg.size()>0){
                    for(int i=0;i<productsListSg.size();i++){
                      oneMap = (HashMap)productsListSg.get(i);					
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>"/></a></div>
                    <div class="fy_name">
						<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
            </ul>
            <div class="ftpro_sum">
            	<a href="/brandshop/fangyuan/list.jsp?catalog=102011" title="施工升降机">
                	<div class="fy_t1">施工升降机</div>
                    <div class="fy_t2">更安全、更高效</div>
               	<div class="fy_more" style="cursor:pointer;" >查看更多</div>		
                </a>
            </div>
        </div>
        <div class="fy_mval mval_right bg_p4">
        	<ul class="fix fypro_list">
            		<%
            	if(null!=productsListWd && productsListWd.size()>0){
                    for(int i=0;i<productsListWd.size();i++){
                      oneMap = (HashMap)productsListWd.get(i);					
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>"/></a></div>
                    <div class="fy_name">
						<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
            </ul>
            <div class="ftpro_sum">
            	<a href="/brandshop/fangyuan/list.jsp?catalog=104006" title="稳定土拌和站">
                	<div class="fy_t1">稳定土拌和站</div>
                    <div class="fy_t2">知其道，善为之</div>
                 	<div class="fy_more" style="cursor:pointer;" >查看更多</div>		
                </a>
            </div>
        </div>
        <div class="fy_mval mval_left bg_p5">
        	<ul class="fix fypro_list">
            		<%
            	if(null!=productListYs && productListYs.size()>0){
                    for(int i=0;i<productListYs.size();i++){
                      oneMap = (HashMap)productListYs.get(i);					
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>"/></a></div>
                    <div class="fy_name">
						<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
            </ul>
            <div class="ftpro_sum">
            	<a href="/brandshop/fangyuan/list.jsp?catalog=103019" title="混凝土搅拌运输车">
                	<div class="fy_t1">混凝土搅拌运输车</div>
                    <div class="fy_t2">稳定可靠，环保节能</div>
                	<div class="fy_more" style="cursor:pointer;" >查看更多</div>		
                </a>
            </div>
        </div>
        <div class="fy_mval mval_right bg_p6">
        	<ul class="fix fypro_list">
            		<%
            	if(null!=productList_sq && productList_sq.size()>0){
                    for(int i=0;i<productList_sq.size();i++){
                      oneMap = (HashMap)productList_sq.get(i);					
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>"/></a></div>
                    <div class="fy_name">
					<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
            </ul>
            <div class="ftpro_sum">
            	<a href="/brandshop/fangyuan/list.jsp?catalog=103020" title="输送泵">
                	<div class="fy_t1">输送泵</div>
                    <div class="fy_t2">稳定可靠，环保节能</div>
                	<div class="fy_more" style="cursor:pointer;" >查看更多</div>		
                </a>
            </div>
        </div>
        <div class="fy_mval mval_left bg_p7">
        	<ul class="fix fypro_list">
            		<%
            	if(null!=productListQt && productListQt.size()>0){
                    for(int i=0;i<productListQt.size();i++){
                      oneMap = (HashMap)productListQt.get(i);					
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
            	<li>
                	<div class="fy_img"><a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank"><img title="<%=fullName+catalogName%>"src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>"/></a></div>
                    <div class="fy_name">
						<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
                    	<p style="cursor:pointer;"><%=fullName%></p></a>						
                    	<p style="cursor:pointer;"><%=catalogName%></a></p>	
					</a>
                    </div>
                    <div class="fy_dg fix"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','135')" title="立即订购" class="ipro_xj">立即订购</a></div>
                </li>
				<%}}%>
            </ul>
            <div class="ftpro_sum">
            	<a href="/brandshop/fangyuan/list.jsp?catalog=105" title="桩工机械">
                	<div class="fy_t1">桩工机械</div>
                    <div class="fy_t2">一机多用，可悬挂不同动力装<br/>置，满足多种施工工法</div>
                 	<div class="fy_more" style="cursor:pointer;" >查看更多</div>		
                </a>
            </div>
        </div>
        <div class="fy_about">
        	<div class="fy_channel_t"><a href="#">公司介绍</a></div>
            <div class="fy_about_n">
             <p><img src="images/temp_about.jpg" alt=""/></p>
             <br/>
             <p>
　　方圆集团始建于1970年，四十余年专注于为建设施工企业打造最适用的产品与服务，着力提供工程施工建设全面的解决方案，拓展领域，稳健发展，构筑起以开发生产建设工程机械为主、跨地区、跨行业的大型企业集团。<br/>
　　四十年来，方圆集团恪守“以人为本，科技兴企，产业报国，奉献社会”的经营理念，依靠科技创新，优化产品结构。目前生产的建设工程机械产品有JZC、JS系列混凝土搅拌机、PLD系列混凝土配料机、HBT系列混凝土泵、HZS系列混凝土搅拌站、TC系列塔式起重机、ＳC系列施工升降机、WBZ系列稳定土拌和站、JZL系列电动履带式桩机、FY系列混凝土搅拌输送车、臂架式混凝土泵车等三十大系列、一百八十多个品种。<br/>
　　四十年来，方圆集团实施品牌战略，不断加大重要装备、专业设备投入，先后引进高精细等离子切割机、激光切割机、板材矫平机、钢材预处理线、四轴联动镗铣加工中心、龙门加工中心、机器人自动焊接生产线等专业生产加工设备，保障各类产品的高品质、高可靠性、高精密性。产品连年被中国质协评为“用户满意产品”；八大系列的产品被评为“山东名牌产品”；“方圆”商标被评为“山东省著名商标”；HZS120D型混凝土搅拌站等产品连续荣登“中国工程机械年度TOP50榜”。 <br/>
　　四十年来，方圆集团致力于与用户构建战略伙伴关系，以用户需求为导向，开辟市场空间，拓展经营领域，产品遍布全国，并畅销海外。为京广高速铁路、青藏铁路、武广客运专线、哈大高速公路、长江三峡工程、葛洲坝水利枢纽工程、苏通大桥、首都机场、北京西客站、南京奥体中心、海阳核电等国内外重点工程及国防工程建设提供了优质服务，创造出良好的经济效益和社会效益。<br/>
　　四十年来，方圆集团诚信经营，担当使命，铸就辉煌。1995年在行业首家通过ISO9001、ISO9002国际质量体系认证，2004年通过质量、环境、安全三体系整合认证。集团先后被评为“全国建设机械行业优秀质量管理企业”、“全国建设机械行业用户满意先进企业”、“实施卓越绩效模式先进企业”、“中国机械行业100强企业”、“中国工程机械行业50强企业”、“全国重合同守信用企业”、“山东省高新技术企业”、“山东省文明诚信百佳企业”、“山东省最佳企业公民”、“山东省优等信誉企业”等荣誉称号。集团董事局主席高秀先后被授予“山东省优秀共产党员”、“山东省优秀人大代表”、“山东省机械工业功勋企业家”、“全国机械行业优秀企业家”、“全国劳动模范”等荣誉称号。<br/>
　　方圆人想在您前头做在您心中，方圆集团与您携手共赴美好未来！”。 
             </p>
            </div>
        </div>
        <div class="fy_about">
        	<div class="fy_channel_t"><a href="#">联系方式</a></div>
            <div class="fy_about_n fy_contact">
             	<div><img src="images/conlogo.gif"/></div>
                <div class="fy_contact_nr">
                	<p>电话：0535-3298256 </p>
                    <p>手机：18853551903
 </p>
<p>传真：0535-3298279 </p>
<p>地址：山东省海阳市方圆工业园 </p>
<p>邮编：265100 </p>
<p>电子信箱：<a href="mailto:xdsun@china-fangyuan.com" target="_blank">xdsun@china-fangyuan.com</a></p>
<p>服务热线：0535-3298256 </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!--main end-->
<!--foot-->
<div class="john_foot">
  <jsp:include page="/include/foot.jsp"/>
</div>
<!--foot end--> 
<script type="text/javascript">
$(".fy_banner").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true,autoPage:true,interTime:4000});
jQuery(".myMore").click(function(){
	showinquery(jQuery(this).attr("value"),'')
	return false ;
}) ;
</script>
</body>
</html>