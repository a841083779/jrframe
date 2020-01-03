<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.net.URLDecoder"%><%
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
    String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
    String province = CommonString.getFormatPara(request.getParameter("province")) ;
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String nowPage = CommonString.getFormatPara(request.getParameter("nowPage"));
	int nowpage = Integer.parseInt(nowPage.equals("")?"1":nowPage) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	PageBean pageBean = new  PageBean() ;
	Connection conn = null ;
	Connection connection = null;
	String ts = CommonString.getFormatPara(request.getParameter("ts")); // 开始时间
	String te = CommonString.getFormatPara(request.getParameter("te")); // 结束时间
	if(ts.equals("undefined")||"".equals(ts)){
		ts = CommonDate.getToday("yyyy-MM-dd") ;   // 默认今天 
	}
	if(te.equals("undefined")||"".equals(te)){
		te = CommonDate.getToday("yyyy-MM-dd") ;   // 默认今天 
	}
	String whereStr = "" ;
	whereStr += " and add_date>='"+ts+" 00:00:00' and add_date<='"+te+" 23:59:59'" ;
	if(!"".equals(catalognum)){
		whereStr += " and catanum like '%"+catalognum+"%'" ;
	}
	if(!"".equals(province)){
		whereStr += " and province like '%"+province+"%'" ;
	}
	if(!"".equals(factoryid)){
		whereStr += " and factoryid ="+factoryid ;
	}
	String tableName = "( select max(id) id ,factoryname,count(id) total from pro_product_form where factoryname is not null and factoryname<>'' "+whereStr+" group by factoryname ) a" ;
	String total_sql = "select sum(total) total from "+tableName ;
	Map totalMap = dbHelper.getMap(total_sql) ;
	if(null==totalMap){
		totalMap = new HashMap() ;
	}
	//获得当前url
	//判断当前url是否有参数
   String url = CommonString.getFormatPara(request.getQueryString());
		if (!"".equals(url)) {
			if (url.indexOf("nowPage") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("nowPage") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
		}
	try{
		pageBean.setTableName(tableName) ;
		pageBean.setPageSize(15) ;
		pageBean.setNowPage(nowPage) ;
		pageBean.setFields(" id,total,factoryname") ;
		pageBean.setOrderBy("total desc") ;
		pageBean.setParams(url.toString()) ;
		List<Map> orderList = pageBean.getDatas() ;
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		List<Map> brandList = (ArrayList)application.getAttribute("brandList") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%=Env.getInstance().getProperty("project_name") %></title>
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
	<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
	<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.l-grid-body-table tr td{height:25px;}.tableList01{border:1px solid #D9D9D9;border-collapse:collapse;}.tableList01 th,.tableList01 td{border:1px solid #D9D9D9;}.tableList01 th{background-color:#F3F3F3;font-weight:bold;height:12px;line-height:12px;padding:10px 0;text-align:center;}.tableList01 th img{vertical-align:-2px;}.tableList01 td{color:#949494;line-height:40%;padding:10px 0;text-align:center;}.tableList01 td.bt{text-align:left;}.tableList01 td.zt{color:#2E7FDC;}.tableList01 td.zt font{color:#D12610;}.tableList01 td.bt em.d{font-family:宋体;}.tableList01 td.blue a{display:inline-block;white-space:nowrap;}.tableList tr.hover td{background-color:#F9F9F9;}.orderSelect{background-color:#F8F8F8;clear:both;margin-bottom:10px;}.orderSelect td{padding:5px 18px;}.orderSelect .select01{border:1px solid #B5B6B3;padding:3px;}.orderSelect .input03{border:1px solid #B5B6B3;height:22px;line-height:22px;padding-left:5px;width:120px;}.orderSelect span.n{display:inline-block;float:left;height:24px;line-height:24px;padding-left:5px;}.orderSelect .btn01{background:url("/images/btns.gif") no-repeat scroll 0 -248px transparent;border:medium none;cursor:pointer;height:27px;vertical-align:-2px;width:66px;}a.btn_search,a.btn_reset{background:url("/images/btns.gif") no-repeat scroll 0 0 transparent;cursor:pointer;display:inline-block;height:25px;margin-right:5px;width:auto;}a.btn_search span,a.btn_reset span{background:url("/images/btns.gif") no-repeat scroll 0 0 transparent;display:inline-block;height:25px;line-height:25px;padding:0 12px 0 30px;width:auto;}a.btn_search{background-position:left -248px;color:#FFFFFF !important;}a.btn_search span{background-position:right -248px;}a.btn_reset{background-position:left -325px;color:#333333 !important;}a.btn_reset span{background-position:right -325px;}.menuLinks{display:inline-block;padding-left:10px;white-space:nowrap;width:290px;}.menuLinks em{color:#BAB8B8;margin:0 13px;}a:link,a:visited{color:#444444;text-decoration:none;}
	.page {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background: url("/images/pagebg.gif") repeat-x scroll center bottom #FFFFFF;
    border-image: none;
    border-width: medium 1px 1px;
    clear: both;
    height: 18px;
    line-height: 18px;
    padding: 7px;
    text-align: right;
}
	</style>
  <script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script></head>
  <script type="text/javascript" src="/plugin/chat/FusionChartsV3/FusionCharts.js"></script>
  <script type="text/javascript" src="/scripts/pinyin.js"></script> 
  <body>
 <form id="theform" name="theform" action="">
 	<input type="hidden" name="t_flag" id="t_flag" value="<%=flag %>"/>
      <table width="100%" cellspacing="0" cellpadding="0" border="0" class="orderSelect">
        <tbody><tr>
          <td>
            <div class="menuLinks">统计时间：
            <a style='<%=(flag.equals("td")||"".equals(flag))?"font-size:12px; font-weight:bold; color:#236ad0;":"" %>' href="?flag=td&ts=<%=CommonDate.getToday("yyyy-MM-dd") %>&te=<%=CommonDate.getToday("yyyy-MM-dd") %>" onclick="getChoseOrderRanking(this,'<%=CommonDate.getToday("yyyy-MM-dd") %>','<%=CommonDate.getToday("yyyy-MM-dd") %>');">今天</a><em>|</em>
            <a style='<%=(flag.equals("ye"))?"font-size:12px; font-weight:bold; color:#236ad0;":"" %>' href="?flag=ye&ts=<%=Tools.getYesterday("",1)%>&te=<%=Tools.getYesterday("",1)%>">昨天</a><em>|</em>
            <a style='<%=(flag.equals("tw"))?"font-size:12px; font-weight:bold; color:#236ad0;":"" %>' href="?flag=tw&ts=<%=Tools.getYesterday("",7)%>&te=<%=Tools.getYesterday("",1)%>">近一周</a><em>|</em>
            <a style='<%=(flag.equals("tm"))?"font-size:12px; font-weight:bold; color:#236ad0;":"" %>' href="?flag=tm&ts=<%=Tools.getYesterday("",31)%>&te=<%=Tools.getYesterday("",1)%>">近一月</a><em>|</em>
            <a style='<%=(flag.equals("tq"))?"font-size:12px; font-weight:bold; color:#236ad0;":"" %>' href="?flag=tq&ts=<%=Tools.getYesterday("",91)%>&te=<%=Tools.getYesterday("",1)%>">近一季度</a><em>|</em>
            <a style='<%=(flag.equals("th"))?"font-size:12px; font-weight:bold; color:#236ad0;":"" %>' href="?flag=th&ts=<%=Tools.getYesterday("",181)%>&te=<%=Tools.getYesterday("",1)%>">近半年</a><em>|</em>
            <a style='<%=(flag.equals("ty"))?"font-size:12px; font-weight:bold; color:#236ad0;":"" %>' href="?flag=ty&ts=<%=Tools.getYesterday("",366)%>&te=<%=Tools.getYesterday("",1)%>">近一年</a><em>|</em>
             <input type="text" value="<%=ts %>" onfocus="WdatePicker({maxDate:'<%=CommonDate.getToday("yyyy-MM-dd") %>'})" style="*vertical-align: -5px;" class="input03 Wdate" id="ts" name="ts"/>
            ~
            <input type="text" value="<%=te %>" onfocus="WdatePicker({maxDate:'<%=CommonDate.getToday("yyyy-MM-dd") %>'})" style="*vertical-align: -5px;" class="input03 Wdate" id="te" name="te"/>
            <a href="javascript:;" onclick="checkInput();" class="btn_search"><span>查询</span></a>
            </div>
          </td>
        </tr>
        <tr>
        	<td>
        	    <div class="menuLinks" style="float:left;">品<span class="span2">&nbsp;</span>牌:
        		<select class="jr_select" id="factoryid" name="factoryid">
        		<option value="">--请选择--</option>
		  		<%if(brandList != null){for(Map m : brandList){%>
                        	<option value="<%=m.get("id")%>"><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
                        <%}}%>	
        		</select>
        		</div>
        		<div class="menuLinks" style="float:left;">机<span class="span2">&nbsp;</span>型:
        		<select class="jr_select" id="catalognum" name="catalognum">
        		<option value="">--请选择--</option>
		  				<%if(catalogList != null){for(Map m : catalogList){%>
                        	<option value="<%=m.get("num")%>"><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
                        <%}}%>  		
        		</select>
        		</div>
        		<div class="menuLinks" style="float:left;">所在地区:
        <select class="jr_select" id="zd_province" name="zd_province">
         <option value="">--请选择--</option>
		 <option value="安徽">安徽</option>
          <option value="北京">北京</option>
          <option value="重庆">重庆</option>
          <option value="福建">福建</option>
          <option value="甘肃">甘肃</option>
          <option value="广东">广东</option>
          <option value="广西">广西</option>
          <option value="贵州">贵州</option>
          <option value="海南">海南</option>
          <option value="河北">河北</option>
          <option value="黑龙江">黑龙江</option>
          <option value="河南">河南</option>
          <option value="湖北">湖北</option>
          <option value="湖南">湖南</option>
          <option value="内蒙古">内蒙古</option>
          <option value="江苏">江苏</option>
          <option value="江西">江西</option>
          <option value="吉林">吉林</option>
          <option value="辽宁">辽宁</option>
          <option value="宁夏">宁夏</option>
          <option value="青海">青海</option>
          <option value="山西">山西</option>
          <option value="山东">山东</option>
          <option value="上海">上海</option>
          <option value="四川">四川</option>
          <option value="天津">天津</option>
          <option value="西藏">西藏</option>
          <option value="新疆">新疆</option>
          <option value="云南">云南</option>
          <option value="浙江">浙江</option>
          <option value="陕西">陕西</option>
          <option value="台湾">台湾</option>
          <option value="香港">香港</option>
          <option value="澳门">澳门</option>
          <option value="海外">海外</option>
        		</select>
        		</div>
			</td>
        </tr>
      </tbody></table>
      </form>
  	<div style="clear: left;"></div>
	<div style="float:left;width:100%;height:30px;text-align:center;padding:3px;background-color:#ccc;line-height:30px;font-size:15px; font-family:微软雅黑; color:#434343;font-weight:bold;">
	  <b id="ts_date"><%=ts%></b>~<b id="te_date"><%=te%></b>询价品牌及数量(总计:<%=CommonString.getFormatPara(totalMap.get("total")) %>)
	</div>
	<div style="width:50% ;height:90%;float:left;margin-top:1px;" name="brand_order" id="brand_order">
	</div>
	<div style="width:50%;height:100%;float:right;margin-top:1px;">
	<div style="height:75%;">
	<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tableList tableList01">
          <tbody><tr class="">
          	<th width="10%">序号</th>
          	<th width="30%">品牌</th>
          	<th width="30%">数量</th>
         </tr>
         <%
         	 if(null!=orderList && orderList.size()>0){
         		 int count = pageBean.getOffset()  ;
         		 Map oneMap = null ;
         		 for(int i=0;i<orderList.size();i++){
         			 oneMap = (HashMap)orderList.get(i) ;
         			 %>
          <tr class="">
          	<td style="text-align:center;">&nbsp;<%=(i+1) +count %></td>
          	<td><span style="color:#D22C17;"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></span></td>
          	<td style="text-align: center;color: #000;"><%=CommonString.getFormatPara(oneMap.get("total")) %></td>
         </tr>         			 
         			 <%
         		 }
         	 }else{
         		 %>
         		<tr><td colspan="3">暂无记录</td></tr>
         		 <%
         	 }
         %>
      </tbody></table> 
	</div>
	<div class="page" style="width:97.5%;float:right;"><%=pageBean.getPageBar() %></div>
	</div>
  </body>
</html>
<script type="text/javascript">
	//增加和编辑的方法
	jQuery(".searchForm input[type=text]").keypress(function(e){
		if(e.keyCode==13){
			doSearch();
		}
	});
	/*列表页条件查询*/
	/*列表页清空查询*/
	function doClearForm(){
		jQuery(".searchForm input:text,select").val('');
		 // alert(jQuery(".searchForm select option:eq(0)").html()) ;
       jQuery("#catanum option:eq(0)").attr("selected",true) ;
       jQuery("#factoryid option:eq(0)").attr("selected",true) ;
	}
		// 回车提交表单
	 document.onkeydown=function(event){ 
        e = event ? event :(window.event ? window.event : null); 
        if(e.keyCode==13){ 
            doSearch();
        } 
        }
var h = jQuery("#brand_order").height();
var w = jQuery("#brand_order").width();
function getBrandRanking(start_date,end_date){
	// 投票统计
	var brand_order = '/backend/action/funsion_charts_action.jsp?flag=brand_order&ts=<%=ts%>&te=<%=te%>&factoryid=<%=factoryid%>&catalognum=<%=catalognum%>&province=<%=province.length()>2?province.substring(0,2):province%>';
	$.ajax({
		type:"get",
		url:brand_order,
		data:{},
		success:function(result){
			var xmlData = $.trim(result);
			var chart = new FusionCharts({
				swfUrl: '/plugin/chat/FusionChartsV3/Charts/Pie3D.swf',
				width: w, 
				height: h-40
		    });
			chart.setDataXML(xmlData);
			chart.render("brand_order");
		}
	});
}
jQuery(function(){
	getBrandRanking();
	jQuery("#today_s").attr("style","font-size:12px; font-weight:bold; color:#236ad0;") ;
	jQuery("#zd_province option").each(function(){
			jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
		}) ;
	jQuery("#catalognum option").each(function(){
	      if(jQuery(this).val()=='<%=catalognum%>'){
	      	jQuery(this).attr("selected","selected") ;
	      	return  ;
	      }
	}) ;
		jQuery("#zd_province option").each(function(){
	      if(jQuery(this).val()=='<%=province%>'){
	      	jQuery(this).attr("selected","selected") ;
	      	return  ;
	      }
	}) ;
	jQuery("#factoryid option").each(function(){
	      if(jQuery(this).val()=='<%=factoryid%>'){
	      	jQuery(this).attr("selected","selected") ;
	      	return  ;
	      }
	}) ;
}) ;
function getChoseOrderRanking(obj,start_date,end_date){
	jQuery(".menuLinks a").removeAttr("style") ;
	jQuery(obj).attr("style","font-size:12px; font-weight:bold; color:#236ad0;") ;
	jQuery("#ts_date").text(start_date) ;
	jQuery("#te_date").text(end_date) ;
	getBrandRanking(start_date,end_date);
}
function checkInput(){
	var ts = jQuery("#ts").val() ;
	var te = jQuery("#te").val() ;
	if(ts>te){
		 jQuery("#te").select() ;
	}else{
	     window.location.href="?flag=tt&ts="+ts+"&te="+te ;
	}
}
jQuery("#catalognum").change(function(){
	var flag = jQuery("#t_flag").val() ;
	var ts = jQuery("#ts").val() ;
	var te = jQuery("#te").val() ;
	var catalognum = jQuery("#catalognum").val() ;
	var province = jQuery("#zd_province").val() ;
	var factoryid = jQuery("#factoryid").val() ;
	window.location.href="?flag="+flag+"&ts="+ts+"&te="+te+"&catalognum="+catalognum+"&province="+province+"&factoryid="+factoryid ;
}) ;
jQuery("#zd_province").change(function(){
	var flag = jQuery("#t_flag").val() ;
	var ts = jQuery("#ts").val() ;
	var te = jQuery("#te").val() ;
	var catalognum = jQuery("#catalognum").val() ;
	var province = jQuery("#zd_province").val() ;
	province = encodeURIComponent(province);
	var factoryid = jQuery("#factoryid").val() ;
	window.location.href="?flag="+flag+"&ts="+ts+"&te="+te+"&catalognum="+catalognum+"&province="+province+"&factoryid="+factoryid ;
}) ;
jQuery("#factoryid").change(function(){
	var flag = jQuery("#t_flag").val() ;
	var ts = jQuery("#ts").val() ;
	var te = jQuery("#te").val() ;
	var catalognum = jQuery("#catalognum").val() ;
	var province = jQuery("#zd_province").val() ;
	var factoryid = jQuery("#factoryid").val() ;
	window.location.href="?flag="+flag+"&ts="+ts+"&te="+te+"&catalognum="+catalognum+"&province="+province+"&factoryid="+factoryid ;
}) ;
</script>
<%
	} catch(Exception e){
		e.printStackTrace() ;
	}finally{
		DBHelper.freeConnection(conn) ;
	}
%>