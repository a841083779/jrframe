<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
  	String proId = CommonString.getFormatPara(request.getParameter("id"));
    String otherProId = CommonString.getFormatPara(request.getParameter("otherProId"));
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	if(proId.equals("")){proId="0";}  	if(otherProId.equals("")){otherProId="0";}
    Map proMap = dbHelper.getMap("select id,name,factoryid,factoryname,catalognum,catalogname,img2,file_name,tonandmeter,view_count from pro_products where id="+proId);
    Map otherProMap = dbHelper.getMap("select id,name,factoryid,factoryname,catalognum,catalogname,img2,file_name,tonandmeter,view_count from pro_products where id="+otherProId);
    String id="";  String name="";  String factoryid="";  String factoryname="";  String catalognum="";  String catalogname="";  String img2=""; String file_name="";  String tonandmeter=""; String viewcount="";  String catanum="";
    String otherid="";  String othername="";  String otherfactoryid="";  String otherfactoryname="";  String othercatalognum="";  String othercatalogname="";  String otherimg2=""; String otherfile_name="";  String othertonandmeter="";  String otherviewcount=""; String othercatanum="";
   if(proMap!=null&&otherProMap!=null){
	    id = CommonString.getFormatPara(proMap.get("id"));
		name = CommonString.getFormatPara(proMap.get("name"));
		factoryid = CommonString.getFormatPara(proMap.get("factoryid"));
		factoryname = CommonString.getFormatPara(proMap.get("factoryname"));
		catalognum = CommonString.getFormatPara(proMap.get("catalognum"));
		catalogname = CommonString.getFormatPara(proMap.get("catalogname"));
		img2 = CommonString.getFormatPara(proMap.get("img2"));
		file_name=CommonString.getFormatPara(proMap.get("file_name"));
		tonandmeter=CommonString.getFormatPara(proMap.get("tonandmeter"));
		viewcount=CommonString.getFormatPara(proMap.get("view_count"));
		if(catalognum.length()>6){catanum=catalognum.substring(0,6);}else{catanum=catalognum;}
		
		otherid = CommonString.getFormatPara(otherProMap.get("id"));
		othername = CommonString.getFormatPara(otherProMap.get("name"));
		otherfactoryid = CommonString.getFormatPara(otherProMap.get("factoryid"));
		otherfactoryname = CommonString.getFormatPara(otherProMap.get("factoryname"));
		othercatalognum = CommonString.getFormatPara(otherProMap.get("catalognum"));
		othercatalogname = CommonString.getFormatPara(otherProMap.get("catalogname"));
		otherimg2 = CommonString.getFormatPara(otherProMap.get("img2"));
		otherfile_name=CommonString.getFormatPara(otherProMap.get("file_name"));
		othertonandmeter=CommonString.getFormatPara(otherProMap.get("tonandmeter"));
		otherviewcount=CommonString.getFormatPara(otherProMap.get("view_count"));
		if(othercatalognum.length()>6){othercatanum=othercatalognum.substring(0,6);}else{othercatanum=othercatalognum;}


	}else{
		Common.do302(response,"http://koubei.21-sun.com/");
	    return;
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=factoryname+name+catalogname%>和<%=otherfactoryname+othername+othercatalogname%>哪个好 - 铁臂口碑</title>
<meta name="keywords" content="<%=factoryname+name+catalogname%>和<%=otherfactoryname+othername+othercatalogname%>哪个好" />
<meta name="description" content="铁臂口碑为您提供<%=factoryname+name+catalogname%>和<%=otherfactoryname+othername+othercatalogname%>口碑对比，包括<%=factoryname+name+catalogname%>和<%=otherfactoryname+othername+othercatalogname%>详情对比、点评对比、关注度对比等方面让您全面了解<%=factoryname+name+catalogname%>和<%=otherfactoryname+othername+othercatalogname%>的区别，买挖掘机，就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/plugin/chat/FusionChartsV3/FusionCharts.js"></script>
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
  <h3 class="breadCrumbs"><a href="/">铁臂口碑</a> &gt;&gt; <a href="http://koubei.21-sun.com/list/">机器大全</a> &gt;&gt; <%=factoryname+name+catalogname%>和<%=otherfactoryname+othername+othercatalogname%>哪个好</h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10 np_fix">
  <div class="cd_box">
    <div class="cd_title fix">
      <div class="l cd_pro_left"><strong><%=factoryname+name+catalogname%></strong>
        <select id="mainPro">
          <option value="0">更换产品</option>
		   <jsp:include page="/include/koubei/change_brand.jsp" flush="true">
			    <jsp:param name="catalog" value="<%=catanum %>"></jsp:param>
				<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
		   </jsp:include>
        </select>
      </div>
      <div class="l cd_pro_right"><strong><%=otherfactoryname+othername+othercatalogname%></strong>
        <select id="subPro">
          <option value="0">更换产品</option>
		  <jsp:include page="/include/koubei/change_brand.jsp" flush="true">
			    <jsp:param name="catalog" value="<%=othercatanum %>"></jsp:param>
				<jsp:param name="factoryid" value="<%=otherfactoryid %>"></jsp:param>
		   </jsp:include>
        </select>
      </div>
    </div>
    <div class="cd_pro_img fix">
      <div class="l cd_one_pro">
        <p class="cdimg"><img width="287"  height="217" src="http://product.21-sun.com/uploadfiles/<%=img2%>" alt="<%=factoryname+name+catalogname%>" title="<%=factoryname+name+catalogname%>" /></p>
        <p class="cdname"><%=factoryname+name%></p>
        <p class="cdcat"><%=catalogname%></p>
      </div>
      <div class="r cd_one_pro">
        <p class="cdimg"><img width="287"  height="217" src="http://product.21-sun.com/uploadfiles/<%=otherimg2%>" alt="<%=otherfactoryname+othername+othercatalogname%>" title="<%=otherfactoryname+othername+othercatalogname%>"/></p>
        <p class="cdname"><%=otherfactoryname+othername%></p>
        <p class="cdcat"><%=othercatalogname%></p>
      </div>
    </div>
  </div>
  <div class="cd_box">
    <div class="cd_title fix"> 综合对比 </div>
    <div class="cd_zhcs_nr">
      <table cellpadding="0" cellspacing="0" border="0" width="101%">
        <tr class="tab_proname">
          <td colspan="2" align="center"><%=factoryname+name+catalogname%></td>
          <td colspan="2" align="center"><%=otherfactoryname+othername+othercatalogname%></td>
        </tr>
        <tr>
          <td width="15%" align="center" class="cd_f5bg">品牌</td>
          <td width="34%" align="center" class="cd_ffbg"><%=factoryname%></td>
          <td width="35%" align="center" class="cd_ffbg"><%=otherfactoryname%></td>
          <td width="15%" align="center" class="cd_f5bg">品牌</td>
        </tr>
		<%
		if((catalognum.indexOf("101001")!=-1&&othercatalognum.indexOf("101001")!=-1)||(catalognum.indexOf("101002")!=-1&&othercatalognum.indexOf("101002")!=-1)){
		if(catalognum.indexOf("101001")!=-1){
		%>
		<tr>
          <td align="center" class="cd_f5bg">行走</td>
          <td align="center" class="cd_ffbg"><%=catalogname.equals("挖掘机")?"履带式挖掘机":catalogname%></td>
          <td align="center" class="cd_ffbg"><%=othercatalogname.equals("挖掘机")?"履带式挖掘机":othercatalogname%></td>
          <td align="center" class="cd_f5bg">行走</td>
        </tr>
		<%}else if(catalognum.indexOf("101002")!=-1){%>
		<tr>
          <td align="center" class="cd_f5bg">行走</td>
          <td align="center" class="cd_ffbg"><%=catalogname.equals("装载机")?"履带式装载机":catalogname%></td>
          <td align="center" class="cd_ffbg"><%=othercatalogname.equals("装载机")?"履带式装载机":othercatalogname%></td>
          <td align="center" class="cd_f5bg">行走</td>
        </tr>
		<%}}%>
        <tr>
          <td align="center" class="cd_f5bg">吨位</td>
          <td align="center" class="cd_ffbg"><%=tonandmeter.equals("")?"暂无":tonandmeter+"吨"%></td>
          <td align="center" class="cd_ffbg"><%=othertonandmeter.equals("")?"暂无":othertonandmeter+"吨"%></td>
          <td align="center" class="cd_f5bg">吨位</td>
        </tr>
        <tr>
          <td align="center" class="cd_f5bg">关注度</td>
          <td align="center" class="cd_ffbg">共有<%=viewcount.equals("")?"0":viewcount%>人关注</td>
          <td align="center" class="cd_ffbg">共有<%=otherviewcount.equals("")?"0":otherviewcount%>人关注</td>
          <td align="center" class="cd_f5bg">关注度</td>
        </tr>
        <tr>
          <td align="center" class="cd_f5bg">网友平均评分</td>
          <td align="center" class="cd_ffbg" id="proScore"></td>
          <td align="center" class="cd_ffbg" id="otherProScore"></td>
          <td align="center" class="cd_f5bg">网友平均评分</td>
        </tr>
        <tr>
          <td align="center" class="cd_f5bg">价格</td>
          <td align="center" class="cd_ffbg" id="proJg"></td>
          <td align="center" class="cd_ffbg" id="otherProJg"></td>
          <td align="center" class="cd_f5bg">价格</td>
        </tr>
        <tr>
          <td align="center" class="cd_f5bg">质量</td>
          <td align="center" class="cd_ffbg" id="proZl"></td>
          <td align="center" class="cd_ffbg" id="otherProZl"></td>
          <td align="center" class="cd_f5bg">质量</td>
        </tr>
        <tr>
          <td align="center" class="cd_f5bg">性能</td>
          <td align="center" class="cd_ffbg" id="proXn"></td>
          <td align="center" class="cd_ffbg" id="otherProXn"></td>
          <td align="center" class="cd_f5bg">性能</td>
        </tr>
        <tr>
          <td align="center" class="cd_f5bg">售后</td>
          <td align="center" class="cd_ffbg cd_ffbg_last" id="proSh"></td>
          <td align="center" class="cd_ffbg cd_ffbg_last" id="otherProSh"></td>
          <td align="center" class="cd_f5bg">售后</td>
        </tr>
        <tr class="cd_quprice">
          <td colspan="2" align="center"><span class="xj_btn"><a href="javascript:;" onclick="showinquery('<%=id%>','')"><img src="../images/pd_btn.gif" /></a></span> <span class="view_cs"><a target="_blank" href="http://product.21-sun.com/proDetail/<%=file_name.replace(".shtm","")%>_parameter.shtm">查看详细参数</a></span></td>
          <td colspan="2" align="center"><span class="xj_btn"><a href="javascript:;" onclick="showinquery('<%=otherid%>','')"><img src="../images/pd_btn.gif" /></a></span> <span class="view_cs"><a target="_blank" href="http://product.21-sun.com/proDetail/<%=otherfile_name.replace(".shtm","")%>_parameter.shtm">查看详细参数</a></span></td>
        </tr>
      </table>
    </div>
  </div>
  <div class="cd_box">
    <div class="cd_title fix"> 关注度对比 </div>
    <div class="cd_zhcs_nr">
      <table cellpadding="0" cellspacing="0" border="0" width="101%">
        <tr class="tab_proname">
          <td width="49%" align="center"><%=factoryname+name+catalogname%>关注度指数 </td>
          <td width="50%" align="center"><%=otherfactoryname+othername+othercatalogname%>关注度指数 </td>
        </tr>
        <tr class="tab_view_zst">
          <td colspan="2" align="center" valign="middle">最近12个月产品阅读量走势图</td>
        </tr>
		<tr class="cd_nor_border">
           <td><div style="height:300px;width:470px;padding-left:10px;" id="view1"></div></td>
           <td><div style="height:300px;width:470px;padding-left:10px;" id="view2"></div></td>
		</tr>
      </table>
    </div>
  </div>
  <div class="cd_box cd_box_nomag">
    <div class="cd_title fix"> 点评对比 </div>
    <div class="cd_zhcs_nr">
      <table cellpadding="0" cellspacing="0" border="0" width="101%">
        <tr class="tab_proname">
          <td width="49%" align="center"><%=factoryname+name+catalogname%> &emsp; <span class="view_detail_dp"><a target="_blank" href="/list/<%=id%>.htm">查看详细点评</a></span></td>
          <td width="50%" align="center"><%=otherfactoryname+othername+othercatalogname%> &emsp; <span class="view_detail_dp"><a target="_blank" href="/list/<%=otherid%>.htm">查看详细点评</a></span></td>
        </tr>
        <tr class="cd_nor_border">
          <td><div class="cd_dianping">
              <div class="cd_dp_title">网友平均评分<span class="cd_org" id="proScore2">  </span>分 <span class="dp_time" style="display:none">点评时间：2014-04-30</span></div>
              <div class="cd_user_t">网友评分</div>
              <div class="cd_dp_star">
                <ul class="np_fix">
                  <li> <span class="dcdp_twz">价格：</span>
                    <div class="dcdp_star"  id="proJg2"></div>
                    <span class="dcdp_score" id="jgscore">分</span> </li>
                  <li> <span class="dcdp_twz">性能：</span>
                    <div class="dcdp_star" id="proXn2"></div>
                    <span class="dcdp_score" id="xnscore">分</span> </li>
                  <li> <span class="dcdp_twz" >质量：</span>
                    <div class="dcdp_star" id="proZl2"></div>
                    <span class="dcdp_score" id="zlscore">分</span> </li>
                  <li> <span class="dcdp_twz">售后：</span>
                    <div class="dcdp_star" id="proSh2"></div>
                    <span class="dcdp_score" id="shscore">分</span> </li>
                </ul>
              </div>
              <div class="dcdp_gnl"><a title="<%=factoryname%>" target="_blank" href="/0-<%=factoryid%>-0.htm"><%=factoryname%></a> <span>|</span> <a target="_blank" href="/<%=catalognum.length()>6?catalognum.substring(0,6):catalognum%>-<%=factoryid%>-0.htm" title="<%=factoryname%><%=catalogname%>"><%=factoryname%><%=catalogname%></a> <span>|</span> <a target="_blank" href="http://koubei.21-sun.com/comment-<%=catalognum.length()>6?catalognum.substring(0,6):catalognum%>-<%=factoryid%>-0-0-0.htm" title="更多<%=factoryname%><%=catalogname%>口碑">更多<%=factoryname%><%=catalogname%>口碑</a> <span>|</span> <a href="javascript:;" onclick="showinquery('<%=id%>','')">询最低价</a></div>
            </div></td>
          <td><div class="cd_dianping">
              <div class="cd_dp_title">网友平均评分<span class="cd_org" id="otherProScore2">  </span>分 <span class="dp_time" style="display:none">点评时间：2014-04-30</span></div>
              <div class="cd_user_t">网友评分</div>
              <div class="cd_dp_star">
                <ul class="np_fix">
                  <li> <span class="dcdp_twz" >价格：</span>
                    <div class="dcdp_star" id="otherProJg2"></div>
                    <span class="dcdp_score" id="jgscore2">分</span> </li>
                  <li> <span class="dcdp_twz">性能：</span>
                    <div class="dcdp_star" id="otherProXn2"></div>
                    <span class="dcdp_score" id="xnscore2">分</span> </li>
                  <li> <span class="dcdp_twz" >质量：</span>
                    <div class="dcdp_star" id="otherProZl2"></div>
                    <span class="dcdp_score" id="zlscore2">分</span> </li>
                  <li> <span class="dcdp_twz">售后：</span>
                    <div class="dcdp_star" id="otherProSh2"></div>
                    <span class="dcdp_score" id="shscore2">分</span> </li>
                </ul>
              </div>
              <div class="dcdp_gnl"><a title="<%=otherfactoryname%>" target="_blank" href="/0-<%=otherfactoryid%>-0.htm"><%=otherfactoryname%></a> <span>|</span> <a target="_blank" href="/<%=othercatalognum.length()>6?othercatalognum.substring(0,6):othercatalognum%>-<%=otherfactoryid%>-0.htm" title="<%=otherfactoryname%><%=othercatalogname%>"><%=otherfactoryname%><%=othercatalogname%></a> <span>|</span> <a target="_blank" href="/comment-<%=othercatalognum.length()>6?othercatalognum.substring(0,6):othercatalognum%>-<%=otherfactoryid%>-0-0-0.htm" title="更多<%=otherfactoryname%><%=othercatalogname%>口碑">更多<%=otherfactoryname%><%=othercatalogname%>口碑</a> <span>|</span> <a href="javascript:;" onclick="showinquery('<%=otherid%>','')">询最低价</a></div>
            </div></td>
        </tr>
      </table>
    </div>
  </div>
  <div class="cd_box">
    <div class="cd_title fix">
        <span class="cdt_radio">口碑对比</span>

    </div>
    <div class="cd_zhcs_nr">
      <table cellpadding="0" cellspacing="0" border="0" width="101%">
        <tr class="cd_nor_border">
          <td width="49%">
          <div class="cddp_user_list">
              <ul class="np_fix">
			  <jsp:include page="/include/koubei/compare_koubei_list.jsp" flush="true">
			      <jsp:param name="id" value="<%=proId %>"></jsp:param>
		      </jsp:include>   	
              </ul>
            </div>
          </td>
          <td width="50%">
          <div class="cddp_user_list">
              <ul class="np_fix">
                <jsp:include page="/include/koubei/compare_koubei_list.jsp" flush="true">
			      <jsp:param name="id" value="<%=otherProId %>"></jsp:param>
		        </jsp:include> 
              </ul>
            </div>
          </td>
        </tr>
        <tr class="cd_nor_border">
          <td>
          <div class="dc_user_page">
              <div id="pagination" class="page">
                <div style="display:none"  class="paging page" id="pagination"><a class="pre noPre" title="上一页" href="javascript:;"></a> <span class="current"><b>&nbsp;1&nbsp;</b></span><a class="num" href="/0-0-0-0-10.htm">&nbsp;2&nbsp;</a><a class="num" href="/0-0-0-0-20.htm">&nbsp;3&nbsp;</a><a class="num" href="/0-0-0-0-30.htm">&nbsp;4&nbsp;</a><a class="num" href="/0-0-0-0-40.htm">&nbsp;5&nbsp;</a><a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a><a class="num" href="/0-0-0-0-1490.htm">&nbsp;150&nbsp;</a><a class="num" href="/0-0-0-0-1500.htm">&nbsp;151&nbsp;</a><a href="/0-0-0-0-10.htm" class="next"></a></div>
                <div class="paging page" id="pagination"><a title="更多<%=factoryname+name+catalogname%>口碑"  target="_blank" href="/list/<%=id%>.htm" class="num">更多</a></div>
              </div>
            </div>
          </td>
          <td>
          <div class="dc_user_page">
              <div id="pagination" class="page">
			    <div style="display:none" class="paging page" id="pagination"><a class="pre noPre" title="上一页" href="javascript:;"></a> <span class="current"><b>&nbsp;1&nbsp;</b></span><a class="num" href="/0-0-0-0-10.htm">&nbsp;2&nbsp;</a><a class="num" href="/0-0-0-0-20.htm">&nbsp;3&nbsp;</a><a class="num" href="/0-0-0-0-30.htm">&nbsp;4&nbsp;</a><a class="num" href="/0-0-0-0-40.htm">&nbsp;5&nbsp;</a><a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a><a class="num" href="/0-0-0-0-1490.htm">&nbsp;150&nbsp;</a><a class="num" href="/0-0-0-0-1500.htm">&nbsp;151&nbsp;</a><a href="/0-0-0-0-10.htm" class="next"></a></div>
                <div class="paging page" id="pagination"><a title="更多<%=otherfactoryname+othername+othercatalogname%>口碑" target="_blank"  href="/list/<%=otherid%>.htm" class="num">更多</a></div>
              </div>
            </div>
          </td>
        </tr>
      </table>
    </div>
  </div>

</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
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
					<jsp:include page="/include/koubei/hot_catalog_detail.jsp" flush="true">
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
			            <jsp:param name="catalog" value="<%=catanum %>"></jsp:param>
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
       //获取主产品得分和星星 
		function getAllComment(){
	    var id=<%=id%>;
		jQuery.getJSON("/action/ajax.jsp?flag=get_all_comment&callback=?&pid="+id,function(data){
			var s1 = (parseInt(data.score1,10)/20);
			var s2 = (parseInt(data.score2,10)/20);
			var s3 = (parseInt(data.score3,10)/20);
			var s4 = (parseInt(data.score4,10)/20);
			var sall = ((s1*5)+(s2*5)+(s3*5)+(s4*5));
			jQuery("#proScore").html(sall);
			jQuery("#proScore2").html(sall);
            jQuery("#jgscore").html(data.score1);
		    jQuery("#zlscore").html(data.score2);
		    jQuery("#xnscore").html(data.score3);
		    jQuery("#shscore").html(data.score4);
			jQuery("#proJg").raty({
				half : true ,
			    readOnly : true,
				score : s1
			});
			jQuery("#proZl").raty({
				half : true ,
				readOnly : true,
				score : s2
			});
			jQuery("#proXn").raty({
				half : true ,
				readOnly : true,
				score : s3
			});
			jQuery("#proSh").raty({
				half : true ,
				readOnly : true,
				score : s4
			});
			
			jQuery("#proJg2").raty({
				half : true ,
			    readOnly : true,
				score : s1
			});
			jQuery("#proZl2").raty({
				half : true ,
				readOnly : true,
				score : s2
			});
			jQuery("#proXn2").raty({
				half : true ,
				readOnly : true,
				score : s3
			});
			jQuery("#proSh2").raty({
				half : true ,
				readOnly : true,
				score : s4
			});
		
		});
	}
	getAllComment();
	
		function getAllCommentOther(){
		var id=<%=otherid%>;
		jQuery.getJSON("/action/ajax.jsp?flag=get_all_comment&callback=?&pid="+id,function(data){
			var s1 = (parseInt(data.score1,10)/20);
			var s2 = (parseInt(data.score2,10)/20);
			var s3 = (parseInt(data.score3,10)/20);
			var s4 = (parseInt(data.score4,10)/20);
			var sall = ((s1*5)+(s2*5)+(s3*5)+(s4*5));
			jQuery("#otherProScore").html(sall);
			jQuery("#otherProScore2").html(sall);
            jQuery("#jgscore2").html(data.score1);
		    jQuery("#zlscore2").html(data.score2);
		    jQuery("#xnscore2").html(data.score3);
		    jQuery("#shscore2").html(data.score4);
			jQuery("#otherProJg").raty({
				half : true ,
			    readOnly : true,
				score : s1
			});
			jQuery("#otherProZl").raty({
				half : true ,
				readOnly : true,
				score : s2
			});
			jQuery("#otherProXn").raty({
				half : true ,
				readOnly : true,
				score : s3
			});
			jQuery("#otherProSh").raty({
				half : true ,
				readOnly : true,
				score : s4
			});
			
			jQuery("#otherProJg2").raty({
				half : true ,
			    readOnly : true,
				score : s1
			});
			jQuery("#otherProZl2").raty({
				half : true ,
				readOnly : true,
				score : s2
			});
			jQuery("#otherProXn2").raty({
				half : true ,
				readOnly : true,
				score : s3
			});
			jQuery("#otherProSh2").raty({
				half : true ,
				readOnly : true,
				score : s4
			});
		
		});
	}
	getAllCommentOther();
	
    //更换产品时url跳转
	   jQuery(function(){
		jQuery("#mainPro").change(function(){
		    var id=this.value;
			if(id!=0){
                 window.location.href="/compare-"+id+"-<%=otherid%>.shtm"; 
			}
		});
	});
	
	   jQuery(function(){
		jQuery("#subPro").change(function(){
		    var id=this.value;
			if(id!=0){
                window.location.href="/compare-<%=id%>-"+id+".shtm"; 
			}
		});
	});
	
	//报表
	jQuery(function(){
	
	
	function getChart1(){
	
	   var id=<%=id%>;
		jQuery.ajax({
		url:"/tools/funsion_charts_action_agent.jsp?proid=<%=id%>&enumNo=106015&flag=order_count&d=<%=CommonDate.getToday("yyyyMMddHHmmss") %>",
		type:"post",
	    dataType: "html",
		data:{"proid":id,"flag":"order_count","d":<%=CommonDate.getToday("yyyyMMddHHmmss") %>},
		success:function(data){
		var chart1 = new FusionCharts("/plugin/chat/FusionChartsV3/Charts/Line.swf", "ChartId1", "100%", "100%", "0", "0");
		//chart1.setDataURL(tongji_gailan_page);
		chart1.setDataXML(data);
		chart1.render("view1");	
		}
	   })
	  
	}
	getChart1();
	
	function getChart2(){
	   var id=<%=otherid%>;
		jQuery.ajax({
		url:"/tools/funsion_charts_action_agent.jsp?proid=<%=otherid%>&enumNo=106015&flag=order_count&d=<%=CommonDate.getToday("yyyyMMddHHmmss") %>",
		type:"post",
	    dataType: "html",
		data:{"proid":id,"flag":"order_count","d":<%=CommonDate.getToday("yyyyMMddHHmmss") %>},
		success:function(data){
		var chart2 = new FusionCharts("/plugin/chat/FusionChartsV3/Charts/Line.swf", "ChartId1", "100%", "100%", "0", "0");
		//chart1.setDataURL(tongji_gailan_page);
		chart2.setDataXML(data);
		chart2.render("view2");	
		}
	   })
	}
	getChart2();
	
	

		

	});
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