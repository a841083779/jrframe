﻿<%@ page language="java" import="com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
   String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	Map brandMap = (Map) application.getAttribute("brandMap");
	if(catalog.indexOf("10500315")!=-1){
		Common.do301(response,"/products/prolist.jsp?catalog=105003") ;
	}
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	if (!"".equals(factory)) {
		factoryid = factory;
	}
	DBHelper dbHelper = DBHelper.getInstance();
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	Map seoTitleKeywordMap = (HashMap)application.getAttribute("seoTitleKeywordMap") ;
	String seoTitle = null ;
	seoTitle = CommonString.getFormatPara(seoTitleKeywordMap.get(catalog)) ;
	String province = "";
	String ip  = request.getHeader("x-forwarded-for");
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("X-Real-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	try{
		Object [] pArr = WEBServiceUtil.executeDynamic("Area","getMyProvinceAndCity",new Object [] {
			ip
		});
		String objStr = (String)pArr[0];
		JSONObject obj = new JSONObject(objStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
		}
	}catch(Exception e){
		
	}
	%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
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
		List<Map> catalogList = (List) application.getAttribute("catalogList");
		Map catalogMap = (Map) application.getAttribute("catalogMap");
		Map brandUsernMap = (HashMap) application.getAttribute("brandUsernMap"); // id 和 品牌代号对应
		if (null == brandUsernMap) {
			brandUsernMap = new HashMap();
		}
		StringBuffer whereStr = new StringBuffer(" and is_show=1");
		if (!"".equals(catalog)) {
			whereStr.append(" and catalognum like '%" + catalog + "%'");
		}
		if (!"".equals(factoryid)) {
			whereStr.append(" and factoryid=" + factoryid);
		}
		if (!keyword.equals("")) {
			// whereStr.append(" and (name like '%"+keyword+"%' or factoryname like '%"+keyword+"%' or catalogname like '%"+keyword+"%')");
			whereStr.append(" and  factoryname+name+catalogname like '%" + keyword + "%'");
		}
		//拆分吨位
		String[] parttonandmeters = null;
		String firsttonandmeter = "";
		String sectonandmeter = "";
		if (!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)) {
			parttonandmeters = tonandmeter.split("_");
			firsttonandmeter = parttonandmeters[1];
			sectonandmeter = parttonandmeters[2];
			if ("0".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter < " + firsttonandmeter);
			} else if ("1".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter >" + firsttonandmeter);
			} else if ("01".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter =" + firsttonandmeter);
			} else {
				whereStr.append(" and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
			}
		}
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(10); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
		if("".equals(order)){
			// pageBean.setOrderBy(" order_no asc") ;
		}
		if(!"".equals(factoryid) && "".equals(order)){
			pageBean.setOrderBy(" order_no desc,tonandmeter desc") ;
		}
		if ("1".equals(order)) {
		// 	pageBean.setOrderBy(" id desc "); // 默认排序
		}
		if ("0".equals(order)) {
			pageBean.setOrderBy(" view_count desc"); // 点击量排序
		}
		String url = CommonString.getFormatPara(request.getQueryString());
		if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
		}
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum ");
		pageBean.setTableName("pro_products");
		pageBean.setIsShowSql(true) ;
		String showTile = keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog))+"_"+keyword+showtonandmeter
		+("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog));
		if(!"_".equals(showTile)){
	    	showTile+="价格表" ;
	    }else{
	    	showTile = "工程机械产品大全" ;
	    }
		if(!"".equals(seoTitle)){
			showTile = ("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+seoTitle ;
		}
	%><head>
		<title><%=showTile%>_中国工程机械商贸网</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>,<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>价格,<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>价格表,<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>图片,<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>型号,<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>参数" />
		<meta name="description" content="【<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>价格,<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>图片,<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>型号】就上中国工程机械商贸网。提供最新最全的<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>信息，帮助您全面了解<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>。" />
		<meta name="author" content="design by www.21-sun.com" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="/style/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
		<script type="text/javascript" src="/scripts/scripts.js"></script>
		<!-- jbox -->
		<script type="text/javascript"
			src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
		<script type="text/javascript"
			src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
		<link type="text/css" rel="stylesheet"
			href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
		<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
	</head>
	<body>
		<!--top-->
		<jsp:include page="/include/top.jsp" flush="true">
			<jsp:param name="keyword" value="<%=keyword%>"></jsp:param>
			<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
			<jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
		</jsp:include>
		<!--面包屑-->
		<div class="contain980 mb10">
			<h3 class="breadCrumbs">
				您现在所在的位置：
				<a href="/">工程机械产品中心</a> &gt;&gt;
				<a href="/products/">产品大全</a>
				<%=("".equals(catalog) || "".equals(CommonString.getFormatPara(catalogMap.get(catalog)))) ? "" : " &gt;&gt; <a href='?catalog="
					+ (catalog.length() > 6 ? catalog.substring(0, 6) : catalog)
					+ "'>"
					+ (catalog.length() > 6 ? CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 6))) : CommonString.getFormatPara(catalogMap
							.get(catalog))) + "</a>"%>
				<%="".equals(factoryid) ? "" : " &gt;&gt; <a href='/brand/"
					+ ("".equals(factoryid) ? "" : CommonString.getFormatPara(brandUsernMap.get(factoryid))) + "/'>"
					+ ("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))) + "</a>"%>
				<%="".equals(catalog) ? "" : " &gt;&gt; " + ("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))
					+ ("".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)))%>
				<%="".equals(keyword) ? "" : " &gt;&gt; " + keyword%></h3>
		</div>
		<!--面包屑结束-->
		<!--main-->
		<div class="contain980 mb10">
			<!--left-->
			<div class="w210 l">
				<!--热门品牌-->
				<div id="leftId">
				</div>
				<!--热门品牌结束-->
				<!--同类品牌排行-->
				<div class="w208 border02 l leftPart02 mb10">
					<h2><%=keyword%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>品牌排行
					</h2>
					<ul class="list003" id="brandSubLeftId">
					</ul>
				</div>
				<!--同类品牌排行结束-->
				<!--同类热卖排行-->
				<div class="w208 border02 l leftPart02 mb10">
					<h2><%=keyword%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>关注排行
					</h2>
					<ul class="list03" id="proSubLeftId">
					</ul>
				</div>
				<!--同类热卖排行结束-->
			</div> 
			<!--left end-->
			<!--right-->
			<div class="w757 r mb10">
				<cache:cache cron="* * */1 * *">
					<%
						List<Map> searchProducts = pageBean.getDatas(); // 根据条件查出的产品
					%>
					<form name="theform" id="theform">
						<div class="w755 border03 l Condition mb10">
							<div class="ConditionTop">
								<div class="l">
									<%
										if (!"".equals(catalog) || !"".equals(factoryid)) {
									%>
									<span class="reset" onclick="sosuo();">重置</span>
									<%
										}
									%>
									<%
										if (!"".equals(catalog) && !"".equals(catalog)) {
									%>
									<span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em>
										<a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("","<%=factoryid%>","","","<%=order%>")'></a> </span>
									<%
										}
									%>
									<%
										if (!"".equals(factoryid) && !"".equals(factoryid)) {
									%>
									<span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em>
										<a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","","","","<%=order%>")'></a> </span>
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
								<h3 class="r"><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></h3>
							</div>
							<ul class="ConditionBottom">
								<script type="text/javascript">
	  jQuery(document).ready(function() {
		  jQuery(".pbtn").click(function(){
			  jQuery(this).next("div").slideToggle(0)
			  .siblings(".plmore:visible").slideUp(0);
			  jQuery(this).toggleClass("pbon");
			  jQuery(this).siblings(".pbon").removeClass("pbon");
		  });	
	  });
	  </script>
								<li class="cblist">
									<dt>
										类别
									</dt>
									<input type="hidden" name="factory" id="factory_id" />
									<input type="hidden" name="catalog" id="catalognum" />
									<dd>
										<a onclick="sosuo('','<%=factoryid%>','');"
											href="javascript:void(0);" <%if("".equals(catalog)){%>
											class='select' <%} %>>不限</a>
										<a onclick="sosuo('101001','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("101001".equals(catalog)){%>
											class='select' <%} %>>挖掘机</a>
										<a onclick="sosuo('101002','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("101002".equals(catalog)){%>
											class='select' <%} %>>装载机</a>
										<a onclick="sosuo('102','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("102".equals(catalog)){%>
											class='select' <%} %>>起重机械</a>
										<a onclick="sosuo('101003','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("101003".equals(catalog)){%>
											class='select' <%} %>>推土机</a>
										<a onclick="sosuo('103','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("103".equals(catalog)){%>
											class='select' <%} %>>混凝土</a>
										<a onclick="sosuo('106001','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("106001".equals(catalog)){%>
											class='select' <%} %>>压路机</a>
										<a onclick="sosuo('101005','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("101005".equals(catalog)){%>
											class='select' <%} %>>平地机</a>
										<a onclick="sosuo('105003','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("105003".equals(catalog)){%>
											class='select' <%} %>>旋挖钻</a>
										<a onclick="sosuo('113001','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("113001".equals(catalog)){%>
											class='select' <%} %>>破碎锤</a>
										<a onclick="sosuo('104001','<%=factoryid%>','')"
											href="javascript:void(0)" <%if("104001".equals(catalog)){%>
											class='select' <%} %>>摊铺机</a>
										<div id="changethis" class="pbtn"></div>
										<div class="plmore" style="padding-left: 0px; width: 100%;">
											<iframe id="catalog_iframe"
												src="/include/products/catalog.jsp?catalog='<%=catalog%>'&factoy_id='<%=factoryid%>'&tonandmeter='<%=tonandmeter%>'&order='<%=order%>'"
												frameborder="0" scrolling="no" width="100%" height="670"
												allowtransparency="true"></iframe>
										</div>
									</dd>
								</li>
								<li class="cblist">
									<dt>
										品牌
									</dt>
									<dd>
										<%
											if (!"".equals(catalog)) {
										%>
										<a onclick="sosuo('<%=catalog%>','','<%=tonandmeter%>');"
											href="javascript:void(0)" <%if("".equals(factoryid)){%>
											class="select" <%} %>>不限</a>
										<%
											List<Map> recommend_brands = dbHelper
															.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog
																	+ "' order by order_no desc");
													if (null != recommend_brands && recommend_brands.size() > 0) {
														int i = 0;
														for (Map oneMap : recommend_brands) {
															i++;
															if (i == 11) {
																break;
															}
										%>
										<!-- 挖掘机 -->
										<a
											onclick="sosuo('<%=catalog%>','<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>','<%=tonandmeter%>')"
											href="javascript:;"
											<%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factoryid)){%>
											class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
										<%
											}
													}
												} else {
										%>
										<a class="select" href="javascript:void(0)"
											onclick="sosuo('101001','','');">不限</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','133','')">三一</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','182','')">小松</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','192','')">斗山</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','184','')">日立</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','183','')">神钢</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','175','')">沃尔沃</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','174','')">卡特彼勒</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','146','')">玉柴重工</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','136','')">柳工</a>
										<!-- 挖掘机 -->
										<a href="javascript:;" onclick="sosuo('101001','194','')">现代京城</a>
										<%
											}
										%>
										<div id="changethis" class="pbtn"></div>
										<div class="plmore" style="padding-left: 0px; width: 100%;">
											<iframe id="brand_iframe"
												src="/include/products/brand.jsp?catalog='<%=catalog%>'&factory_id='<%=factoryid%>'&tonandmeter='<%=tonandmeter%>'&order='<%=order%>'"
												frameborder="0" scrolling="no" width="100%" height="460"
												allowtransparency="true"></iframe>
										</div>
									</dd>
								</li>
								<li class="cblist" id="grab" style="display: none;">
									<dt>
										吨位
									</dt>
									<dd>
										<input type="hidden" name="tonandmeter" id="tonandmeter" />
										<a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_1_13')"
											<%if("grab_1_13".equals(tonandmeter)){%> class="select" <%}%>>小挖(1T～13T)</a>&nbsp;
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_14_30')"
											<%if("grab_14_30".equals(tonandmeter)){%> class="select"
											<%}%>>中挖(14T～30T)</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_30_1')"
											<%if("grab_30_1".equals(tonandmeter)){%> class="select" <%}%>>大挖(30T以上)</a>
									</dd>
								</li>
								<li class="cblist" style="display: none;" id="loader">
									<dt>
										吨位
									</dt>
									<dd>
										<a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_1_3')"
											<%if("loader_1_3".equals(tonandmeter)){%> class="select"
											<%}%>>3T以下</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_01')"
											<%if("loader_3_01".equals(tonandmeter)){%> class="select"
											<%}%>>3T</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_5')"
											<%if("loader_3_5".equals(tonandmeter)){%> class="select"
											<%}%>>3T～5T</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_5_1')"
											<%if("loader_5_1".equals(tonandmeter)){%> class="select"
											<%}%>>5T以上</a>
									</dd>
								</li>
								<li class="cblist" style="display: none;" id="crane">
									<dt>
										吨位
									</dt>
									<dd>
										<a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_1_16')"
											<%if("crane_1_16".equals(tonandmeter)){%> class="select"
											<%}%>>16T以下</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_20_70')"
											<%if("crane_20_70".equals(tonandmeter)){%> class="select"
											<%}%>>20T～70T</a>
										<a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_70_1')"
											<%if("crane_70_1".equals(tonandmeter)){%> class="select"
											<%}%>> 70T以上</a>
									</dd>
								</li>
                                
                              <li style="display:block;" class="cblist agent">
									<dt>山东<br />代理</dt>
									<dd><a href="#">淄博永德</a> <a href="#">青岛裕博晟</a> <a href="#">永立建机</a> <a href="#">山东永安建机</a> <a href="#">山东易元明通</a> <a href="#">烟台天宏厦工</a></dd>
								</li>
                                
								<script type="text/javascript">
            if('<%=catalog%>'.indexOf("101001")!=-1){
              jQuery("#grab").attr("style","display:;") ;
            }
               if('<%=catalog%>'.indexOf("101002")!=-1){
              jQuery("#loader").attr("style","display:;") ;
            }
               if('<%=catalog%>'.indexOf("102")!=-1){
              jQuery("#crane").attr("style","display:;") ;
            }
          </script>
          
         							 <li class="cblist" id="grab">
									<dt>
										山东
									</dt>
									<dd>
										
									</dd>
									</li>
							</ul>
						</div>
						<input type="hidden" name="order" id="order" />
						<input type="hidden" name="keyword" id="key_word" />
					</form>
					<div class="w755 l border03 listTop">
						<div class="l" id="showorder">
							<strong>排序</strong>
							<a href="javascript:;"
								onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','<%=tonandmeter%>','',1,'<%=keyword%>');"
								class="select">默认</a>
							<a href="javascript:;"
								onclick="javascript:sosuo('<%=catalog%>','<%=factoryid%>','<%=tonandmeter%>','',0,'<%=keyword%>');">热度</a>
						</div>
						<div class="r">
							<span><b><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>
							</b>&nbsp;&nbsp;共</span><b><%=pageBean.getTotal()%></b><span>款机型&nbsp;|</span>
							<!--  <a href="javascript:void(0);" class="pre noPre"></a> <b>1/11</b> <a href="#" class="next"></a> -->
							<%=pageBean.getUpPageBar()%>
						</div>
					</div>
					<div class="plist">
						<ul id="showproducts">
						<jsp:include page="/include/products/pro_rec.jsp">
						 	<jsp:param value="<%=catalog %>" name="catalognum"/>
						 	<jsp:param value="<%=factoryid %>" name="factoryid"/> 
						 	<jsp:param value="<%=offset %>" name="offset"/> 
						</jsp:include>
								<!-- 付费会员选取产品 -->
								<%
								String commentsProducts = " select top 3 id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum from pro_products where catalognum like '%"+catalog+"%'" ;
								%>
								<!-- *************3个产品结束****************** -->
							<%
								if (searchProducts != null && searchProducts.size() > 0) {
										for (Map oneMap : searchProducts) {
							%>
							<li>
								<a href="/proDetail/<%=oneMap.get("file_name")%>"
									target="_blank"> <img
										src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"
										onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"
										width="130" height="90" class="plimg"
										alt="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
										+ (String) oneMap.get("catalogname"))%>"
										title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
										+ (String) oneMap.get("catalogname"))%>" />
								</a>
								<div class="w618 r">
									<h2>
										<a href="/proDetail/<%=oneMap.get("file_name")%>"
											target="_blank"><%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
										+ (String) oneMap.get("catalogname"))%></a>
									</h2>
									<span class="info"> <a
										href="?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneMap.get("catalognum")).length() >= 6 ? CommonString
								.getFormatPara(oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))%>"><%=CommonString.getFormatPara((String) oneMap.get("factoryname"))
								+ CommonString.getFormatPara(catalogMap.get((((String) oneMap.get("catalognum")).length() >= 6) ? CommonString.getFormatPara(
										oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))))%></a>
										<em>|</em> <a
										href="/inquiry/?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneMap.get("catalognum"))%>"
										target='_blank'>订单</a> <em>|</em> <a
										href="/photo/list.jsp?factoryid=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalogid=<%=CommonString.getFormatPara(catalog)%>"
										target="_balnk">图片</a> <a href="javascript:;"
										onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')"
										class="plbtn">询价</a> </span>
									<div class="plInfo"><%=CommonString.substringByte(CommonHtml.filterHTML((String)oneMap.get("introduce")), 180) + (CommonHtml.filterHTML((String)oneMap.get("introduce")).equals("")?"":"...")%><b><a
											href="/proDetail/<%=oneMap.get("file_name")%>"
											target="_blank">[查看详情]</a> </b>
									</div>
								</div>
							</li>
							<%
								}
									} else {
							%>
							<p style="padding: 10px 15px;">
								暂无符合条件的产品
							</p>
							<%
								}
							%>
						</ul>
					</div>
					<div class="w755 l">
						<div id="pagination" class="page">
							<tags:page pageBean="<%=pageBean%>" />
						</div>
					</div>
					<!--right end-->
					<div class="clear"></div>
						</cache:cache>
			</div>
			<!--main end-->
			<!--最新订单-->
			<div class="contain980 mb10">
				<div class="title04">
					<h2><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>最新订单
					</h2>
					<span><a
						href="/inquiry/?<%="".equals(factoryid) ? "" : "factory=" + factoryid + "&"%><%="".equals(catalog) ? "" : "catalog=" + catalog%>"
						target="_blank">更多&gt;&gt;</a> </span>
				</div>
				<div class="list04">
					<div id="MarqueeDiv"
						style="width: 978px; height: auto; overflow: hidden;">
						<ul>
							<jsp:include page="/include/products/order_sub_foot.jsp"
								flush="true">
								<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
								<jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
							</jsp:include>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<!--最新订单结束-->
			<!--foot-->
			<script type="text/javascript">
		//jQuery("#factoryid_search option:eq(0)").html("<%="".equals(factoryid) ? "请选择品牌" : CommonString.getFormatPara(brandMap.get(factoryid))%>") ;
		//jQuery("#catalog_search option:eq(0)").html("<%="".equals(catalog) ? "请选择机型" : CommonString.getFormatPara(catalogMap.get(catalog))%>")
</script>
			<jsp:include page="/include/foot.jsp" flush="true" />
			<!--end of foot-->
			<script type="text/javascript" src="/scripts/sort.js"></script>
			<script type="text/javascript">
  	//左侧查询
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"<%=factoryid%>","catalog":"<%=catalog%>","url":"/products/prolist.jsp"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})
	
	//左侧同类产品排行
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"proSubLeft","catalog":"<%=catalog%>","keyword":"<%=keyword%>"},
		success:function(data){
			jQuery("#proSubLeftId").html(jQuery.trim(data));	
		}
	})
	//左侧同类品牌排行
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandSubLeft","catalog":"<%=catalog%>","keyword":"<%=keyword%>"},
		success:function(data){
			jQuery("#brandSubLeftId").html(jQuery.trim(data));	
		}
	})
    //jQuery('html, body').animate({scrollTop: 382}, 0);
    <%
     if("".equals(catalog)) {
    	 %>
    	   jQuery("#brand_iframe").attr("height","1060") ;
    	 <%
     }
    %>
    <%
     if("1".equals(order)){
    	 %>
    	 jQuery("#showorder a:eq(0)").addClass("select") ;
    	 jQuery("#showorder a:eq(1)").removeClass("select") ;
    	 <%
     }else if("0".equals(order)){
    	 %>
    	  jQuery("#showorder a:eq(0)").removeClass("select") ;
    	  jQuery("#showorder a:eq(1)").addClass("select") ;
    	 <%   	 
     }else{
    	 %>
    	 jQuery("#showorder a:eq(0)").addClass("select") ;
   	     jQuery("#showorder a:eq(1)").removeClass("select") ;
   	     <%
     }
    %>
    jQuery.post("/tools/ajax.jsp",{
    	flag : 'customer_product_view_habit',
    	factory : '<%=CommonString.getFormatPara(request.getParameter("factory")) %>',
    	catalog : '<%=CommonString.getFormatPara(request.getParameter("catalog")) %>',
    	tonandmeter : '<%=CommonString.getFormatPara(request.getParameter("tonandmeter")) %>',
    	offset : '<%=CommonString.getFormatPara(request.getParameter("offset")) %>'
    });
</script>
	</body>
</html>