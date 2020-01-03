<%@ page language="java" import="org.json.*,java.net.*,java.sql.Connection,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* * */2 * *">
<%
    String id = CommonString.getFormatPara(request.getParameter("id")) ;  // 新闻 id 
	String keyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
    String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	String factory = CommonString.getFormatPara(request.getParameter("factoryid"));
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
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
	Integer nowPage = 1; 
    PageBean pageBean = new PageBean(); // 分页程序
	if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
	}
    if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
    }
	
	if(catalognum.equals("0")){catalognum="";}
	if(factory.equals("0")){factory="";}
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
	List<Map> weixiuList =null;
	Map oneNews = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection conn_21sun = null;
	String 	sel_sql="select * from article_other where id="+id;
	try{
	    conn_21sun = dbHelper.getConnection("web21market");
		String content_show="";
		String keywords_show="";
		String title_show="";
		String title="";
		String content="";
		String pub_date="";
	    if(!"".equals(id)){
		oneNews = (Map)WEBDBHelper.getMap(sel_sql,"Web21sunDBHelper");
		title=CommonString.getFormatPara(oneNews.get("title"));
	    content = CommonString.getFormatPara(oneNews.get("content"));
        content = content.replaceAll("\\.\\./\\.\\./","/");
        content = content.replaceAll("/UserFiles/Image/","http://news.21-sun.com/UserFiles/Image/");
        content = content.replaceAll("/tech/uploadfiles/","http://www.21-sun.com/tech/uploadfiles/");
		pub_date=CommonDate.getFormatDate("yyyy-MM-dd",oneNews.get("pub_date")) ;
	    content_show = CommonHtml.filterHTML(CommonString.getFormatPara(oneNews.get("content"))).length()>80?CommonHtml.filterHTML(CommonString.getFormatPara(oneNews.get("content"))).substring(0,80):CommonHtml.filterHTML(CommonString.getFormatPara(oneNews.get("content")));
		keywords_show=title+","+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalognum))+"维修,铁臂维修";
		title_show=title+"_"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalognum))+"维修 - 铁臂维修";       
	   }else{
		//维修列表
	    String whereStr=" and is_show=1 and title  like '%维修%' ";
	   	if(!"".equals(keyword)){
		    whereStr+=" and title like '%"+keyword+"%'";
		}
		if(!"".equals(catalog)){
		     whereStr+=" and title like '%"+CommonString.getFormatPara(catalogMap.get(catalog))+"%'";
		}
		pageBean.setParams(url);
       pageBean.setPageSize(15); // 每页显示条数
       pageBean.setCondition(whereStr);
	   pageBean.setNowPage(nowPage);
	   pageBean.setFields("id,title,pub_date");
	   pageBean.setTableName("sell_buy_market");


		weixiuList = pageBean.getDatas(conn_21sun);
		
	    //title_show="【图文】"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修_"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修保养_"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修大全 - 铁臂维修";
	    //keywords_show=keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修,"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修保养,"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修大全";
	    //content_show="铁臂维修为您提供"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修方法，"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修保养知识，快速解决"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修问题，买"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"就上铁臂商城。";
		
	    title_show="【图文】"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修大全 - 铁臂维修";
	    keywords_show=keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修大全";
	    content_show="铁臂维修为您快速解决"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"维修问题，买"+keyword+CommonString.getFormatPara(catalogMap.get(catalog))+"就上铁臂商城。";
		}

      String fullName=CommonString.getFormatPara(catalogMap.get(catalog))+keyword;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<title><%=title_show %></title>
<meta name="keywords" content="<%=keywords_show %>" />
<meta name="description" content="<%=content_show %>" />
</head>
<body>
<jsp:include page="/weixiu/top.jsp" flush="true" />
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="http://weixiu.21-sun.com/">铁臂维修</a>
  <%="".equals(keyword)?"":" &gt;&gt; "+keyword+"维修大全"%>
  <%="".equals(catalog)?"":" &gt;&gt; "+CommonString.getFormatPara(catalogMap.get(catalog))+"维修大全"%>
  
   <%=!"".equals(factory)?" &gt;&gt; <a href='/0-0-"+factory+".htm'>"+CommonString.getFormatPara(brandMap.get(factory)):""+"</a>"%>
   <%=!"".equals(catalognum)?" &gt;&gt; <a href='/"+catalognum+"-0-0.htm'>"+CommonString.getFormatPara(catalogMap.get(catalognum)):""+"</a>"%>
   <%=!"".equals(factory)&&!"".equals(catalognum)?" &gt;&gt; <a href='/weixiu/"+catalognum+"-0-"+factory+".htm'>"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalognum)):""+"</a>"%>
   <%=!"".equals(factory)||!"".equals(catalognum)?" &gt;&gt; "+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalognum))+"维修":""%>
   <%if(!"".equals(id)){%>&gt;&gt; <%=title%><%}%>  
  </h3>
</div>
<div class="contain980 np_fix">
  <!--left-->
  <%if(!"".equals(id)){%>
  <div class="kb_det_left">
    <div class="listleft02">
      <div class="listtitle01"><%=title%></div>
      <div class="listtitle03"><font class="font08">发布时间:<%=pub_date%> &nbsp;&nbsp;&nbsp;&nbsp;来源:<a href="http://weixiu.21-sun.com/">铁臂维修</a></font></div>
      <div class="detail" id="mainDetail"> <%=content%> </div>
      <div class="listfoot01"></div>
      <div class="listfoot02">【<img src="http://www.21-sun.com/tech/images/tb01.gif" width="18" height="11"><a href="javascript:storePage();" class="pl">收藏此页</a>】【<img src="http://www.21-sun.com/tech/images/tb02.gif" width="16" height="10"><a href="javascript:SetFontSize(16)" class="pl">大</a>&nbsp;<a href="javascript:SetFontSize(14)">中</a>&nbsp;<a href="javascript:SetFontSize(12)" class="pl">小</a>】【<img src="http://www.21-sun.com/tech/images/tb03.gif" width="16" height="12"><a href="Javascript:window.print();">打印</a>】【<img src="http://www.21-sun.com/tech/images/tb04.gif" width="12" height="9"><a href="/">返回首页</a>】 </div>
    </div>
  </div>
  <%}else{%>
  <!--维修list-->
  <div class="rp clearfix mb10 nwx_zxlist repairList" style="width:600px;float:left">
    <div class="title">
      <h3><%="".equals(keyword+CommonString.getFormatPara(catalogMap.get(catalog)))?"最新工程机械":keyword+CommonString.getFormatPara(catalogMap.get(catalog))%>维修</h3>
    </div>
    <div class="content ">
      <ul class="list blue">
        <%
        		if(weixiuList!=null && weixiuList.size()>0){
        			for(Map weixiu : weixiuList){
        				String ids = CommonString.getFormatPara(weixiu.get("id"));
        				String title_weixiu = CommonString.getFormatPara(weixiu.get("title"));
        				String pub_dates = CommonDate.getFormatDate("yyyy-MM-dd", weixiu.get("pub_date"));
        	%>
        <li>
          <h3><span class="lb">
		  <a style="color: #ff6600;background: url('');padding-left:0px;" href="<%=catalog.equals("")?"/weixiu/detail.jsp?catalog="+catalog:"/weixiu/detail.jsp?keyword="+fullName%>" title="<%=fullName%>维修">[<%=fullName%>维修]</a>
		  </span><a href="http://market.21-sun.com/viewSellBuy_for_<%=ids %>.htm" target="_blank" title="<%=title_weixiu %>"><%=title_weixiu %></a></h3>
          <span class="time"><%=pub_dates %></span> </li>
        <%}}%>
        <%if((weixiuList==null|| weixiuList.size()<=0)){%>
        <div align="center">暂无相关信息</div>
        <%}%>
      </ul>
    </div>
      <div id="pagination" class="page" style="float:left">
        <tags:page pageBean="<%=pageBean%>" />
      </div>
 </div>
 
  <!--维修list结束-->
  <%}%>
  <!--left end-->
  <!--right-->
  <div class="kb_det_right" >
    <div class="hybk">
      <div class="hybk1">
        <div class="hybkzt">行业百科</div>
      </div>
      <div class="hybkred">按机种:</div>
      <div class="hybk2"> <a href="/101001-0-0.htm" class="link06" title="挖掘机维修">挖掘机</a>　 <a href="/101002-0-0.htm" class="link06" title="装载机维修">装载机</a>　 <a href="/102-0-0.htm" class="link06" title="起重机维修">起重机</a>　 <a href="/101003-0-0.htm" class="link06" title="推土机维修">推土机</a>　 <a href="/106001-0-0.htm" class="link06" title="压路机维修">压路机</a>　 <a href="/101005-0-0.htm" class="link06" title="平地机维修">平地机</a><br>
        <a href="/104001-0-0.htm" class="link06" title="摊铺机维修">摊铺机</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="/105003-0-0.htm" class="link06" title="旋挖钻维修">旋挖钻</a> 　 <a href="/105003-0-0.htm" class="link06" title="泵车维修">泵车</a> 　 <a href="/107-0-0.htm" class="link06" title="叉车维修">叉车</a></div>
      <div class="hybkmore">
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tbody>
            <tr>
              <td><table width="44" height="16" cellspacing="0" cellpadding="0" border="0" align="right"  id="imgmenu1" onclick="showsubmenu(1)" style=" cursor:pointer; background:url(../images/new_pro/hybkxs.gif) no-repeat 0 0;">
                  <tbody>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="submenu1" style=" display:none;">
                  <tbody>
                    <tr>
                      <td align="left" height="20" valign="top"><img src="http://www.21-sun.com/tech/images/hybkxx.jpg" width="346" height="3"></td>
                    </tr>
                    <tr>
                      <td class="bk"><a href="/101001-0-0.htm" class="link06" title="挖掘机维修">挖掘机</a> 　 <a href="/101003-0-0.htm" class="link06" title="推土机维修">推土机</a>　 <a href="/101002-0-0.htm" class="link06" title="装载机维修">装载机</a> 　 <a href="/101005-0-0.htm" class="link06" title="平地机维修">平地机</a> 　 <a href="/101004-0-0.htm" class="link06" title="铲运机维修">铲运机</a> 　 <a href="/101008-0-0.htm" class="link06" title="自卸卡车维修">自卸卡车</a> 　 </td>
                    </tr>
                    <tr>
                      <td height="25"></td>
                    </tr>
                    <tr>
                      <td class="bk"><a href="/102013-0-0.htm" class="link06" title="桥梁式起重机维修">桥梁式起重机</a>　 <a href="/102012-0-0.htm" class="link06" title="伸缩臂叉装机维修">伸缩臂叉装机</a>　 <a href="/102002-0-0.htm" class="link06" title="塔式起重机维修">塔式起重机</a>　 <a href="/102011-0-0.htm" class="link06" title="施工升降机维修">施工升降机</a>　 <a href="/102010-0-0.htm" class="link06" title="高空作业车维修">高空作业车</a>　 <a href="/102007-0-0.htm" class="link06" title="汽车起重机维修">汽车起重机</a>　 <a href="/102008-0-0.htm" class="link06" title="履带式起重机维修">履带式起重机</a>　 <a href="/102006-0-0.htm" class="link06" title="随车起重机维修">随车起重机</a>　 <a href="/102003-0-0.htm" class="link06" title="高空作业平台维修">高空作业平台</a>　 </td>
                    </tr>
                    <tr>
                      <td height="25"></td>
                    </tr>
                    <tr>
                      <td class="bk"><a href="/103008-0-0.htm" class="link06" title="干粉砂浆生产设备维修">干粉砂浆生产设备</a>　 <a href="/103009-0-0.htm" class="link06" title="粉粒物料运输车维修">粉粒物料运输车</a>　 <a href="/103005-0-0.htm" class="link06" title="混凝土布料设备维修">混凝土布料设备</a>　 <a href="/103006-0-0.htm" class="link06" title="混凝土搅拌运输车维修">混凝土搅拌运输车</a>　 <a href="/103015-0-0.htm" class="link06" title="其它混凝土设备维修">其它混凝土设备</a>　 <a href="/103012-0-0.htm" class="link06" title="干混砂浆生产线维修">干混砂浆生产线</a>　 <a href="/103011-0-0.htm" class="link06" title="沥青砂浆车维修">沥青砂浆车</a>　 <a href="/103014-0-0.htm" class="link06" title="干混砂浆背罐车维修">干混砂浆背罐车</a>　 <a href="/103002-0-0.htm" class="link06" title="混凝土搅拌设备维修">混凝土搅拌设备</a>　 <a href="/103001-0-0.htm" class="link06" title="混凝土泵车维修">混凝土泵车</a>　 <a href="/103010-0-0.htm" class="link06" title="喷湿机维修">喷湿机</a>　 </td>
                    </tr>
                    <tr>
                      <td height="25"><a href="/104006-0-0.htm" class="link06" title="稳定土拌合机维修">稳定土拌合机</a>　 <a href="/104005-0-0.htm" class="link06" title="铣刨机维修">铣刨机</a>　 <a href="/104008-0-0.htm" class="link06" title="稳定土厂拌设备维修">稳定土厂拌设备</a>　 <a href="/104007-0-0.htm" class="link06" title="沥青混合料搅拌设备维修">沥青混合料搅拌设备</a>　 <a href="/104009-0-0.htm" class="link06" title="沥青搅拌站维修">沥青搅拌站</a>　 <a href="/104004-0-0.htm" class="link06" title="其它路面机械维修">其它路面机械</a>　 <a href="/104001-0-0.htm" class="link06" title="摊铺机维修">摊铺机</a>　 <a href="/104002-0-0.htm" class="link06" title="养护机械维修">养护机械</a>　 </td>
                    </tr>
                    <tr>
                      <td height="25"></td>
                    </tr>
                    <tr>
                      <td class="bk"><a href="/105017-0-0.htm" class="link06" title="强夯机维修">强夯机</a>　 <a href="/105018-0-0.htm" class="link06" title="长螺旋钻孔机维修">长螺旋钻孔机</a>　 <a href="/105009-0-0.htm" class="link06" title="液压静力压桩机维修">液压静力压桩机</a>　 <a href="/105019-0-0.htm" class="link06" title="多功能钻机维修">多功能钻机</a>　 <a href="/105007-0-0.htm" class="link06" title="连续墙抓斗维修">连续墙抓斗</a>　 <a href="/105028-0-0.htm" class="link06" title="截桩机/破桩机维修">截桩机/破桩机</a>　 <a href="/105011-0-0.htm" class="link06" title="打桩机维修">打桩机</a>　 <a href="/105016-0-0.htm" class="link06" title="连续墙钻机维修">连续墙钻机</a>　 <a href="/105015-0-0.htm" class="link06" title="打桩锤维修">打桩锤</a>　 <a href="/105027-0-0.htm" class="link06" title="其它桩工机械维修">其它桩工机械</a>　 <a href="/105026-0-0.htm" class="link06" title="多轴钻孔机维修">多轴钻孔机</a>　 <a href="/105013-0-0.htm" class="link06" title="液压步履式桩架维修">液压步履式桩架</a>　 <a href="/105003-0-0.htm" class="link06" title="旋挖钻机维修">旋挖钻机</a>　 <a href="/105004-0-0.htm" class="link06" title="潜孔钻机维修">潜孔钻机</a>　 <a href="/105005-0-0.htm" class="link06" title="水平定向钻维修">水平定向钻</a>　</td>
                    </tr>
                    <tr>
                      <td height="25"></td>
                    </tr>
                    <tr>
                      <td height="25"><a href="/106004-0-0.htm" class="link06" title="夯实机维修">夯实机</a>　 <a href="/106003-0-0.htm" class="link06" title="压实机维修">压实机</a>　 <a href="/106001-0-0.htm" class="link06" title="压路机维修">压路机</a>　 <a href="/107010-0-0.htm" class="link06" title="专用叉车维修">专用叉车</a>　 <a href="/107001-0-0.htm" class="link06" title="内燃叉车维修">内燃叉车</a>　 <a href="/107003-0-0.htm" class="link06" title="电动叉车维修">电动叉车</a>　 <a href="/107005-0-0.htm" class="link06" title="仓储叉车维修">仓储叉车</a>　 <a href="/109004-0-0.htm" class="link06" title="维修提梁机">提梁机</a>　 <a href="/109005-0-0.htm" class="link06" title="检测车维修">检测车</a>　 <a href="/109002-0-0.htm" class="link06" title="运梁车维修">运梁车</a>　 <a href="/109006-0-0.htm" class="link06" title="砂浆车维修">砂浆车</a>　 <a href="/109001-0-0.htm" class="link06" title="架桥机维修">架桥机</a>　 </td>
                    </tr>
                    <tr>
                      <td class="bk"><a href="/110010-0-0.htm" class="link06" title="凿岩钻维修">凿岩钻</a>　 <a href="/110008-0-0.htm" class="link06" title="凿岩台车维修">凿岩台车</a>　 <a href="/110009-0-0.htm" class="link06" title="破碎机维修">破碎机</a>　 <a href="/110011-0-0.htm" class="link06" title="凿岩机和钻机维修">凿岩机和钻机</a>　 <a href="/110012-0-0.htm" class="link06" title="筛分机维修">筛分机</a>　 <a href="/110013-0-0.htm" class="link06" title="装载及搬运设备维修">装载及搬运设备</a>　 <a href="/110014-0-0.htm" class="link06" title="连续采煤机和隧道掘进机维修">连续采煤机和隧道掘进机</a>　 <a href="/110005-0-0.htm" class="link06" title="采煤机维修">采煤机</a>　 <a href="/110015-0-0.htm" class="link06" title="输送和辅助设备维修">输送和辅助设备</a>　 <a href="/110002-0-0.htm" class="link06" title="矿用掘进机维修">矿用掘进机</a>　 <a href="/110016-0-0.htm" class="link06" title="全液压凿岩钻机维修">全液压凿岩钻机</a>　 <a href="/110017-0-0.htm" class="link06" title="隧道轨道设备维修">隧道轨道设备</a>　 <a href="/110001-0-0.htm" class="link06" title="盾构掘进机维修">盾构掘进机</a>　 </td>
                    </tr>
                    <tr>
                      <td height="25"></td>
                    </tr>
                    <tr>
                      <td class="bk"><a href="/111003-0-0.htm" class="link06" title="吊具维修">吊具</a>　 <a href="/111001-0-0.htm" class="link06" title="正面吊维修">正面吊</a>　 <a href="/111002-0-0.htm" class="link06" title="堆高机维修">堆高机</a>　 <a href="/111007-0-0.htm" class="link06" title="推耙机维修">推耙机</a>　 <a href="/111006-0-0.htm" class="link06" title="场桥维修">场桥</a>　 <a href="/113002-0-0.htm" class="link06" title="液压剪维修">液压剪</a>　 <a href="/113001-0-0.htm" class="link06" title="维修破碎锤">破碎锤</a> 　 <a href="/118004-0-0.htm" class="link06" title="维修牵引车">牵引车</a>　 <a href="/118002-0-0.htm" class="link06" title="专用车辆维修">专用车辆</a>　 <a href="/118003-0-0.htm" class="link06" title="消防车维修">消防车</a> 　 <a href="/119001-0-0.htm" class="link06" title="煤炭机械维修">煤炭机械</a> 　 </td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="hybkxt"><img src="../images/new_pro/hybkht.jpg" width="365" height="18"></div>
      <div class="hybkred2">热门搜索:</div>
      <div class="hybk22" style="line-height: 22px;"> <a href="/weixiu/detail.jsp?keyword=大臂" class="link06" title="大小臂">大小臂</a>　 <a href="/weixiu/detail.jsp?keyword=四轮一带" class="link06" title="四轮一带">四轮一带</a> 　 <a href="/weixiu/detail.jsp?keyword=控制器" class="link06" title="控制器">控制器</a> 　 <a href="/weixiu/detail.jsp?keyword=压油" class="link06" title="压油">压油</a> 　 <a href="/weixiu/detail.jsp?keyword=破碎器" class="link06" title="破碎器">破碎器</a> 　 <a href="/weixiu/detail.jsp?keyword=法兰" class="link06" title="法兰">法兰</a> 　 <a href="/weixiu/detail.jsp?keyword=传感器" class="link06" title="传感器">传感器</a>　 <a href="/weixiu/detail.jsp?keyword=发动机" class="link06" title="发动机">发动机</a>　 <a href="/weixiu/detail.jsp?keyword=破碎锤" class="link06" title="破碎锤">破碎锤</a>　 <a href="/weixiu/detail.jsp?keyword=液压系统" class="link06" title="液压系统">液压系统</a> 　 <a href="/weixiu/detail.jsp?keyword=变速箱" class="link06" title="变速箱">变速箱</a> 　 <a href="/weixiu/detail.jsp?keyword=滤清器" class="link06" title="滤清器">滤清器</a> 　 <a href="/weixiu/detail.jsp?keyword=液压油缸" class="link06" title="液压油缸">液压油缸</a> <a href="/weixiu/detail.jsp?keyword=液压油路" class="link06" title="液压油路">液压油路</a> 　 <a href="/weixiu/detail.jsp?keyword=液压剪" class="link06" title="液压剪">液压剪</a> 　 <a href="/weixiu/detail.jsp?keyword=马达" class="link06" title="马达">马达</a> 　 <a href="/weixiu/detail.jsp?keyword=履带架" class="link06" title="履带架">履带架</a> 　 <a href="/weixiu/detail.jsp?keyword=驾驶室" class="link06" title="驾驶室">驾驶室</a> <a href="/weixiu/detail.jsp?keyword=油缸" class="link06" title="油缸">油缸</a>　 <a href="/weixiu/detail.jsp?keyword=挖斗" class="link06" title="挖斗">挖斗</a>　 <a href="/weixiu/detail.jsp?keyword=转台" class="link06" title="转台">转台</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="/weixiu/detail.jsp?keyword=操纵系统" class="link06" title="操纵系统">操纵系统</a> 　 <a href="/weixiu/detail.jsp?keyword=泵" class="link06" title="泵">泵</a> 　 <a href="/weixiu/detail.jsp?keyword=吊壳" class="link06" title="吊壳">吊壳</a> 　 <a href="/weixiu/detail.jsp?keyword=小型阀块" class="link06" title="小型阀块">小型阀块</a> 　 <a href="/weixiu/detail.jsp?keyword=抓斗" class="link06" title="抓斗">抓斗</a>　 </div>
    </div>
  </div>
  <!--right end-->
</div>
<style>
.new_v_foot_list{ width:980px; margin:0 auto; text-align:left; margin-bottom:10px;}
.new_v_foot_list .adnf_list ul li{ float:left;  margin:0 6px 0;white-space:nowrap; padding: 6px 0;}
.new_v_foot_list .adnf_list ul li a{  display:inline-block;}
.new_v_foot_list .adnf_list ul li a:hover{ color:#ff6600}
.new_v_foot_list .adnf_title{ font-size:14px; font-weight:bold; border-bottom:1px solid #ccc; padding:7px 0; margin-bottom:5px; font-family:微软雅黑;}
.nleft_one .list003 { height:210px; overflow:auto;}
</style>
  <%
    String catalogname="";
	String factoryName="";
    if(!"".equals(id)&&!catalognum.equals("")){
    catalogname=CommonString.getFormatPara(catalogMap.get(catalognum));
  %> 
    <!--副导航-->
    <div class="new_v_foot_list">
    <div class="adnf_title">其他品牌<%=catalogname %>维修</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_brand.jsp" flush="true">
     <jsp:param name="catalog" value="<%=catalognum%>"></jsp:param>
     <jsp:param name="catalogName" value="<%=catalogname%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
  </div>
  <!--副导航-->
  <%}else if(!"".equals(id)&&!factory.equals("")){
  factoryName=CommonString.getFormatPara(brandMap.get(factory));
  %>
    <div class="new_v_foot_list">
    <div class="adnf_title"><%=catalogname %>产品维修</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_pro.jsp" flush="true">
     <jsp:param name="factoryid" value="<%=factory%>"></jsp:param>
     <jsp:param name="factoryName" value="<%=factoryName%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
  </div>
  <%}%>
   <!--列表页副导航-->
   <%
    if(!catalog.equals("")){
    catalogname=CommonString.getFormatPara(catalogMap.get(catalog));
  %> 
    <div class="new_v_foot_list">
    <div class="adnf_title">其他品牌<%=catalogname %>维修</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_brand.jsp" flush="true">
     <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
     <jsp:param name="catalogName" value="<%=catalogname%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
  </div>
  <%}%>
  
  <%
     if(!keyword.equals("")){%>
    <div class="new_v_foot_list">
    <div class="adnf_title">更多工程机械维修分类</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_area_index.jsp" flush="true">
     <jsp:param name="area" value="0"></jsp:param>
     <jsp:param name="areaName" value=""></jsp:param>
  </jsp:include>    
      </ul>
    </div>
</div>
<%}%>
 <!--列表页副导航-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<jsp:include page="/include/koubei_ad.jsp" flush="false"/>

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


<script type="text/javascript">
//下拉
$.fn.sele=function() {
	var ev=($(this).data('sele')?$(this).data('sele').act:'mouseenter').split(" ");
	$(this).bind(ev[0],function(){sele_show(this,ev[0])}).bind('mouseleave',function(){sele_hide(this)});
	function sele_show(me,evt){
		$(me).find('.sele_').stop(1,0).show().children('a').click(function(event){
			event.stopPropagation();
			if(!$(this).attr('target')){
				event.preventDefault();
				if($(me).find('.btn').length){
					$(me).find('.btn').attr('href',$(this).attr('href'))
				};
				$(this).parent().hide().parents('.sele').find('span').text($(this).text());
			}
		})
	};
	function sele_hide(me){
		$(me).find('.sele_').stop(1,0).hide()
	};
};
var $sele=$('.sele');
$sele.each(function(i) {$(this).css('z-index',$sele.length-i).sele()});

function SetFontSize(size){
   document.getElementById('mainDetail').style.fontSize=size+'px';
}
function storePage(){
	url = window.location.href; 
	title = "<%=title%>"; 
	window.external.AddFavorite(url,title);
}

</script>
<script>
function showsubmenu(sid)
{
    var whichEl = document.getElementById("submenu" + sid)||null, imgmenu = document.getElementById("imgmenu" + sid)||null;
    if (!whichEl || !imgmenu) return false;    
    whichEl.style.display = whichEl.style.display && true ? "" : "none";
    imgmenu.background = whichEl.style.display && true ? "images/hybkxs.gif" : "images/hybkxx.gif";
    return false;
} 
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(conn_21sun);
	}
%>
</cache:cache>