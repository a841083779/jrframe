<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%><%
 	DBHelper dbHelper = DBHelper.getInstance() ;
	String cat = CommonString.getFormatPara(request.getParameter("cat"));
	Map proParamMap = (Map) application.getAttribute("proParamMap");
	
    Connection connection = null;
	String whereStr="";
	List<Map> list =null;
	if("sanjiao".equals(cat)){
		whereStr+=" and catalogname ='三角式破碎锤' ";
	}
	if("zhijiao".equals(cat)){
		whereStr+=" and catalogname ='直角式破碎锤' ";
	}
	if("jingyin".equals(cat)){
		whereStr+=" and catalogname ='静音式破碎锤' ";
	}
	if("fensuiqian".equals(cat)){
		whereStr+=" and catalogname ='单缸单轴液压粉碎钳' ";
	}
	if("dangangjian".equals(cat)){
		whereStr+=" and catalogname ='单缸单轴液压剪' ";
	}
	if("shuanggangjian".equals(cat)){
		whereStr+=" and catalogname ='双缸双轴多功能液压剪' ";
	}
	if("miniqian".equals(cat)){
		whereStr+=" and catalogname ='迷你液压钳' ";
	}
	try{
		connection = dbHelper.getConnection();
		
		list =dbHelper.getMapList(" select top 6 id,catalogname,name,file_name,zoomlion_hot_pic from pro_products where factoryid=18936 and is_show=1 "+whereStr+" order by view_count desc,id desc ");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>正迪旗舰店</title>
		<script src="js/module/jquery-3.4.1.min.js" type="text/javascript" charset="utf-8"></script>
		<link href="http://product.21-sun.com/style/shop.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/style.css" />
	</head>

	<body>
		<!--header-->
		  <%@include file="/brandshop/include/top.jsp"%>
		<!--header end-->
		<div class="top_nav">
			<div class="wrap">
				<div class="nav_area fix">
					<a href="/brandshop/zhengdi/" target="_blank" class="logo l"></a>
					<a href="/brandshop/zhengdi/list.jsp?cat=sanjiao" target="_blank" class="nav_item l">三角式破碎锤</a>
					<a href="/brandshop/zhengdi/list.jsp?cat=zhijiao" target="_blank" class="nav_item l">直角式破碎锤</a>
					<a href="/brandshop/zhengdi/list.jsp?cat=jingyin" target="_blank" class="nav_item l">静音式破碎锤</a>
					<a href="/brandshop/zhengdi/list.jsp?cat=fensuiqian" target="_blank" class="nav_item l">单缸单轴液压粉碎钳</a>
					<a href="/brandshop/zhengdi/list.jsp?cat=dangangjian" target="_blank" class="nav_item l">单缸单轴液压剪</a>
					<a href="/brandshop/zhengdi/list.jsp?cat=shuanggangjian" target="_blank" class="nav_item l">双缸双轴多功能液压剪</a>
					<a href="/brandshop/zhengdi/list.jsp?cat=miniqian" target="_blank" class="nav_item l">迷你液压钳</a>
				</div>
			</div>
		</div>
		<div class="list_banner">
			<img src="img/pro_list_baner.jpg" />
		</div>

		<div class="zd_item cat_condition">
			<div class="wrap">
				<div class="main fix">
					<div class="con_left l">
						<a href="javascript:void(0);"  class="con_item all <%if("".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">全部系列</p>
						</a>
					</div>
					<div class="con_right fix r">
						<a href="javascript:void(0);" data-id="sanjiao" class="con_item l <%if("sanjiao".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">三角式破碎锤</p>
						</a>
						<a href="javascript:void(0);" data-id="zhijiao" class="con_item l <%if("zhijiao".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">直角式破碎锤</p>
						</a>
						<a href="javascript:void(0);" data-id="jingyin" class="con_item l <%if("jingyin".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">静音式破碎锤</p>
						</a>
						<a href="javascript:void(0);" data-id="fensuiqian" class="con_item l <%if("fensuiqian".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">单缸单轴液压粉碎钳</p>
						</a>
						<a href="javascript:void(0);" data-id="dangangjian" class="con_item l <%if("dangangjian".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">单缸单轴液压剪</p>
						</a>
						<a href="javascript:void(0);" data-id="shuanggangjian" class="con_item l <%if("shuanggangjian".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">双缸双轴多功能液压剪</p>
						</a>
						<a href="javascript:void(0);" data-id="miniqian" class="con_item l <%if("miniqian".equals(cat)){out.print("on");}%> fix">
							<div class="con_block l"></div>
							<p class="con_des l">迷你液压钳</p>
						</a>
						
					</div>
				</div>
			</div>
		</div>
		<div class="zd_item pro_list">
			<div class="wrap">
				<div class="main fix"  id="list">
				<%
				if(list!=null && list.size()>0){
				for(Map m:list){
					String id =CommonString.getFormatPara(m.get("id"));
					String paramStr="";
					if(proParamMap!=null){
                        List <Map> paramList=(List<Map>)(proParamMap.get(id));	
						int num=0;						
						if(paramList != null && paramList.size() > 0) {
					        for (Map mmm : paramList) {
								num++;
								if(num==1){
									paramStr+="<p class='item_p1'>"+CommonString.getFormatPara(mmm.get("param_name"))+"："+CommonString.getFormatPara(mmm.get("param_value"))+"</p>";
								}
								if(num==2){
									paramStr+="<p class='item_p2'>"+CommonString.getFormatPara(mmm.get("param_name"))+"："+CommonString.getFormatPara(mmm.get("param_value"))+"</p>";
								}
							
						}}
					}	
				%>
					<div class="list_item l">
						<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" class="item_link">
							<p class="item_cat"><%=CommonString.getFormatPara(m.get("catalogname"))%></p>
							<p class="item_type"><%=CommonString.getFormatPara(m.get("name"))%></p>
							<%=paramStr%>
							<div class="item_icon">
								<img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("zoomlion_hot_pic"))%>" onerror="this.src='/uploadfiles/no_big.gif'"/>
							</div>
						</a>
					</div>
				<%}}%>	
				</div>
			</div>
		</div>

		<!--<div class="page_count fix">
			<div class="wrap">
				<div class="page_number l">
					<a class="num" href="javascript:void(0);">1</a>
					<span class="num current"> 2 </span>
					<a class="num" href="javascript:void(0);">3</a>
					<a class="num" href="javascript:void(0);">4</a>
					<a class="num" href="javascript:void(0);">5</a>
					<span class="sl ellipsis">...</span>
					<a class="num" href="javascript:void(0);">13</a>
					<a class="num" href="javascript:void(0);">14</a>
				</div>
				<div class="page_arr r">
					<a class="prev_page goprev" href="#">上一页</a>
					<a class="next_page gonext" href="#">下一页</a>
				</div>
			</div>
		</div>-->
		<!--footer-->
		<div class="footer">
			<div class="foot_top fix">
				<div class="wrap fix">
					<a href="http://www.21-sun.com" class="item l">中国工程机械商贸网旗下网站：</a>
					<a href="http://part.21-sun.com/" class="item l">中国工程机械配件网</a>
					<a href="http://job.21-sun.com/" class="item l">中国工程机械人才网</a>
					<a href="http://rent.21-sun.com/" class="item l">中国工程机械租赁网</a>
					<a href="http://used.21-sun.com/" class="item l">中国工程机械二手网</a>
					<a href="http://www.21part.com/" class="item l">配件商城</a>
					<a href="http://peitao.21-sun.com/" class="item l">配套网</a>
					<a href="http://www.cmbol.com/" class="item l">工程机械外贸网</a>
					<a href="http://product.21-sun.com/" class="item l">铁臂商城</a>
				</div>
			</div>
			<div class="foot_bot">
				<div class="wrap fix">
					<div class="bot_left l">
						<div class="links fix">
							<a href="http://www.21-sun.com/service/guanggao/index.htm" class="link_item l">广告服务|</a>
							<a href="http://aboutus.21-sun.com/contact/" class="link_item l">联系方式|</a>
							<a href="http://www.jerei.com/" class="link_item l">关于我们|</a>
							<a href="http://www.jerei.com/news/index-list-0.htm" class="link_item l">本网动态|</a>
							<a href="http://www.jerei.com/contact/legal.jsp" class="link_item l">法律声明|</a>
							<a href="http://aboutus.21-sun.com/map.htm" class="link_item l">网站导航|</a>
							<a href="http://aboutus.21-sun.com/contact/" class="link_item l">联系客服</a>
						</div>
						<p class="">中国工程机械商贸网 Copyright © 2000-2019</p>
					</div>
					<div class="bot_right r fix">
						<div class="qr_item l fix">
							<div class="qr_img l">
								<img src="img/qr_mobile.png" />
							</div>
							<div class="qr_des r">
								<p>铁臂商城手机版</p>
								<p>随时随地询价</p>
							</div>
						</div>
						<div class="qr_item l fix">
							<div class="qr_img l">
								<img src="img/qr_public.png" />
							</div>
							<div class="qr_des r">
								<p>关注铁臂商城</p>
								<p>抢先查询新品信息</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</body>
	
	<script src="js/pro_list.js" type="text/javascript" charset="utf-8"></script>
	
</html>