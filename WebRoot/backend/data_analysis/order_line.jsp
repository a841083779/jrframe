<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.sql.Connection"%>

<%!
   public static int getMonth(Date start, Date end) {
        if (start.after(end)) {
            Date t = start;
            start = end;
            end = t;
        }
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTime(start);
        Calendar endCalendar = Calendar.getInstance();
        endCalendar.setTime(end);
        Calendar temp = Calendar.getInstance();
        temp.setTime(end);
        temp.add(Calendar.DATE, 1);

        int year = endCalendar.get(Calendar.YEAR)
                - startCalendar.get(Calendar.YEAR);
        int month = endCalendar.get(Calendar.MONTH)
                - startCalendar.get(Calendar.MONTH);

        if ((startCalendar.get(Calendar.DATE) == 1)
                && (temp.get(Calendar.DATE) == 1)) {
            return year * 12 + month + 1;
        } else if ((startCalendar.get(Calendar.DATE) != 1)
                && (temp.get(Calendar.DATE) == 1)) {
            return year * 12 + month;
        } else if ((startCalendar.get(Calendar.DATE) == 1)
                && (temp.get(Calendar.DATE) != 1)) {
            return year * 12 + month;
        } else {
            return (year * 12 + month - 1) < 0 ? 0 : (year * 12 + month);
        }
    }
%>
<%
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
    String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
    String area = CommonString.getFormatPara(request.getParameter("area")) ;
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String nowPage = CommonString.getFormatPara(request.getParameter("nowPage"));
				String year = CommonString.getFormatPara(request.getParameter("year")) ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
	int nowpage = Integer.parseInt(nowPage.equals("")?"1":nowPage) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	PageBean pageBean = new  PageBean() ;
	Connection conn = null ;
	Connection connection = null;
 
	Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
    String today = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime())+"" ;
	calendar.add(Calendar.DATE, -1);  
	String yesday = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()) +"";

	String ts = CommonString.getFormatPara(request.getParameter("ts")); // 开始时间
	String te = CommonString.getFormatPara(request.getParameter("te")); // 结束时间
	String start_add_date=CommonString.getFormatPara(request.getParameter("start_add_date"));	
	String end_add_date=CommonString.getFormatPara(request.getParameter("end_add_date"));	
	if(ts.equals("undefined")||"".equals(ts)){
		ts = yesday ;   // 默认今天 
	}
	if(te.equals("undefined")||"".equals(te)){
		te = today ;   // 默认今天 
	}
	String whereStr = " where is_deleted=0" ;
 			if(!"".equals(catalognum)){
				whereStr += " and catanum like '"+catalognum+"%'" ;
			}	

			if(!"".equals(factoryid)){
				whereStr += " and factoryid = "+factoryid ;
			}
			
            if(area.equals("1")){area="安徽";}
			else if(area.equals("2")){area="北京";}
			else if(area.equals("3")){area="重庆";}
			else if(area.equals("4")){area="福建";}
			else if(area.equals("5")){area="甘肃";}
			else if(area.equals("6")){area="广东";}
			else if(area.equals("7")){area="广西";}
			else if(area.equals("8")){area="贵州";}
			else if(area.equals("9")){area="海南";}
			else if(area.equals("10")){area="河北";}
			else if(area.equals("11")){area="黑龙江";}
			else if(area.equals("12")){area="河南";}
			else if(area.equals("13")){area="湖北";}
			else if(area.equals("14")){area="湖南";}
			else if(area.equals("15")){area="内蒙古";}
			else if(area.equals("16")){area="江苏";}
			else if(area.equals("17")){area="江西";}
			else if(area.equals("18")){area="吉林";}
			else if(area.equals("19")){area="辽宁";}
			else if(area.equals("20")){area="宁夏";}
			else if(area.equals("21")){area="青海";}
			else if(area.equals("22")){area="山西";}
			else if(area.equals("23")){area="山东";}
			else if(area.equals("24")){area="上海";}
			else if(area.equals("25")){area="四川";}
			else if(area.equals("26")){area="天津";}
			else if(area.equals("27")){area="西藏";}
			else if(area.equals("28")){area="新疆";}
			else if(area.equals("29")){area="云南";}
			else if(area.equals("30")){area="浙江";}
			else if(area.equals("31")){area="陕西";}
 			if(!"".equals(area)){
				whereStr += " and province like '%"+area+"%'" ;
			}
					    if(!"".equals(start_add_date)){
				whereStr += " and add_date >= '"+start_add_date +" 00:00:00'";
			}
			
			
			if(!"".equals(end_add_date)){
				whereStr += " and add_date <= '"+end_add_date +" 23:59:59'";
			}
			List<Map> orderCountList = null;
			Map order_countMap = null ;
 String query = "";
	//获得当前url
	//判断当前url是否有参数
   String url = CommonString.getFormatPara(request.getQueryString());
   
   int wjj=0; int zzj=0; int qzj=0; int ylj=0; int hnt=0;  int qt=0;
   Map wjjMap=null;   Map zzjMap=null;  Map qzjMap=null;  Map yljMap=null;  Map hntMap=null;  Map qtMap=null;
	try{

		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList =dbHelper.getMapList("select num,name from pro_catalog where is_show=1 and  parentid=0  order by order_no asc ");
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
	.l-grid-body-table tr td{height:25px;}.tableList01{border:1px solid #D9D9D9;border-collapse:collapse;}.tableList01 th,.tableList01 td{border:1px solid #D9D9D9;}.tableList01 th{background-color:#F3F3F3;font-weight:bold;height:12px;line-height:12px;padding:10px 0;text-align:center;}.tableList01 th img{vertical-align:-2px;}.tableList01 td{color:#949494;*line-height:60%;line-height:40%;padding:10px 0;text-align:center;}.tableList01 td.bt{text-align:left;}.tableList01 td.zt{color:#2E7FDC;}.tableList01 td.zt font{color:#D12610;}.tableList01 td.bt em.d{font-family:宋体;}.tableList01 td.blue a{display:inline-block;white-space:nowrap;}.tableList tr.hover td{background-color:#F9F9F9;}.orderSelect{background-color:#F8F8F8;clear:both;margin-bottom:10px;}.orderSelect td{padding:5px 18px;}.orderSelect .select01{border:1px solid #B5B6B3;padding:3px;}.orderSelect .input03{border:1px solid #B5B6B3;height:22px;line-height:22px;padding-left:5px;width:120px;}.orderSelect span.n{display:inline-block;float:left;height:24px;line-height:24px;padding-left:5px;}.orderSelect .btn01{background:url("/images/btns.gif") no-repeat scroll 0 -248px transparent;border:medium none;cursor:pointer;height:27px;vertical-align:-2px;width:66px;}a.btn_search,a.btn_reset{background:url("/images/btns.gif") no-repeat scroll 0 0 transparent;cursor:pointer;display:inline-block;height:25px;margin-right:5px;width:auto;}a.btn_search span,a.btn_reset span{background:url("/images/btns.gif") no-repeat scroll 0 0 transparent;display:inline-block;height:25px;line-height:25px;padding:0 12px 0 30px;width:auto;}a.btn_search{background-position:left -248px;color:#FFFFFF !important;}a.btn_search span{background-position:right -248px;}a.btn_reset{background-position:left -325px;color:#333333 !important;}a.btn_reset span{background-position:right -325px;}.menuLinks{display:inline-block;padding-left:10px;white-space:nowrap;width:290px;}.menuLinks em{color:#BAB8B8;margin:0 13px;}a:link,a:visited{color:#444444;text-decoration:none;}
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

              
			  
			  <input type="text"   onfocus="WdatePicker({maxDate:'<%=CommonDate.getToday("yyyy-MM-dd") %>'})" style="*vertical-align: -5px;" class="input03 Wdate" id="start_add_date" name="start_add_date"/>
            ~
            <input type="text"   onfocus="WdatePicker({maxDate:'<%=CommonDate.getToday("yyyy-MM-dd") %>'})" style="*vertical-align: -5px;" class="input03 Wdate" id="end_add_date" name="end_add_date"/>
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
        		<div class="menuLinks" style="float:left;">类<span class="span2">&nbsp;</span>型:
        		<select class="jr_select" id="catalognum" name="catalognum">
        		<option value="">--请选择--</option>
					  	  <%	for(Map m : catalogList){%>
					         <option <%if(CommonString.getFormatPara(m.get("num")).equals(catalognum)){%>selected="selected"<%}%> value="<%=CommonString.getFormatPara(m.get("num"))%>"><%=CommonString.getFormatPara(m.get("name"))%></option>
					  <%}%>		
        		</select>
        		</div>
        <div class="menuLinks">所在地区:
        <select class="jr_select" id="area" name="area">
         <option value="">--请选择--</option>
                      <option value="1" <%if(area.equals("1")){%>selected="selected"<%}%> >安徽</option>
                      <option value="2" <%if(area.equals("2")){%>selected="selected"<%}%> >北京</option>
                      <option value="3" <%if(area.equals("3")){%>selected="selected"<%}%>>重庆</option>
                      <option value="4" <%if(area.equals("4")){%>selected="selected"<%}%>>福建</option>
                      <option value="5" <%if(area.equals("5")){%>selected="selected"<%}%>>甘肃</option>
                      <option value="6" <%if(area.equals("6")){%>selected="selected"<%}%>>广东</option>
                      <option value="7" <%if(area.equals("7")){%>selected="selected"<%}%>>广西</option>
                      <option value="8" <%if(area.equals("8")){%>selected="selected"<%}%>>贵州</option>
                      <option value="9" <%if(area.equals("9")){%>selected="selected"<%}%>>海南</option>
                      <option value="10" <%if(area.equals("10")){%>selected="selected"<%}%>>河北</option>
                      <option value="11" <%if(area.equals("11")){%>selected="selected"<%}%>>黑龙江</option>
                      <option value="12" <%if(area.equals("12")){%>selected="selected"<%}%>>河南</option>
                      <option value="13" <%if(area.equals("13")){%>selected="selected"<%}%>>湖北</option>
                      <option value="14" <%if(area.equals("14")){%>selected="selected"<%}%>>湖南</option>
                      <option value="15" <%if(area.equals("15")){%>selected="selected"<%}%>>内蒙古</option>
                      <option value="16" <%if(area.equals("16")){%>selected="selected"<%}%>>江苏</option>
                      <option value="17" <%if(area.equals("17")){%>selected="selected"<%}%>>江西</option>
                      <option value="18" <%if(area.equals("18")){%>selected="selected"<%}%>>吉林</option>
                      <option value="19" <%if(area.equals("19")){%>selected="selected"<%}%>>辽宁</option>
                      <option value="20" <%if(area.equals("20")){%>selected="selected"<%}%>>宁夏</option>
                      <option value="21" <%if(area.equals("21")){%>selected="selected"<%}%>>青海</option>
                      <option value="22" <%if(area.equals("22")){%>selected="selected"<%}%>>山西</option>
                      <option value="23" <%if(area.equals("23")){%>selected="selected"<%}%>>山东</option>
                      <option value="24" <%if(area.equals("24")){%>selected="selected"<%}%>>上海</option>
                      <option value="25" <%if(area.equals("25")){%>selected="selected"<%}%>>四川</option>
                      <option value="26" <%if(area.equals("26")){%>selected="selected"<%}%>>天津</option>
                      <option value="27" <%if(area.equals("27")){%>selected="selected"<%}%>>西藏</option>
                      <option value="28" <%if(area.equals("28")){%>selected="selected"<%}%>>新疆</option>
                      <option value="29" <%if(area.equals("29")){%>selected="selected"<%}%>>云南</option>
                      <option value="30" <%if(area.equals("30")){%>selected="selected"<%}%>>浙江</option>
                      <option value="31" <%if(area.equals("31")){%>selected="selected"<%}%>>陕西</option>
        		</select>
        		</div>
			</td>
        </tr>
      </tbody></table>
      </form>
  	<div style="clear: left;"></div>
	<!--
	<div style="float:left;width:100%;height:30px;text-align:center;padding:3px;background-color:#ccc;line-height:30px;font-size:15px; font-family:微软雅黑; color:#434343;font-weight:bold;">
	  <b id="ts_date"><%=ts%></b>~<b id="te_date"><%=te%></b> 
	</div>
	-->
	<div style="width:70% ;height:400px;float:right;margin-top:1px;" name="brand_order" id="brand_order">
	</div>
	<div style="width:30% ;float:left;margin-top:1px;height:100%;">
	<div style="height:75%;">
	<table width="100%;height:100%;" cellspacing="0" cellpadding="0" border="0" class="tableList tableList01">
          <tbody><tr class="">
          	<th width="30%">时间</th>
          	<th width="30%">数量</th>
         </tr>

		 
		 
		 <%
		 
		 if(!start_add_date.equals("") && !end_add_date.equals("")){
				
				int months=1;
				query = "select substring(convert(varchar,add_date,23),0,8) as order_date,count(id) as order_count from pro_product_form";
				query += whereStr;
				query += " and add_date>dateadd(year, -1, convert(varchar, "+start_add_date+", 23)) group by substring(convert(varchar,add_date,23),0,8)";
				
				
				orderCountList = dbHelper.getMapList(query);
				order_countMap = CommonCollection.listToMap(orderCountList, "order_date", "order_count");
				if(order_countMap == null){
					order_countMap = new HashMap();
				}
				
              SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
		      Date c1 = df.parse(start_add_date);
			  Date c2 = df.parse(end_add_date);
		      months =getMonth(c1,c2)-1;
				
 				for(int i=months; i>0; i--){
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.MONTH, -i);
					String yyyyMM = CommonDate.getFormatDate("yyyy-MM", cal.getTime());
					//yyyyMM=end_add_date;
					String yyyy = yyyyMM.split("-")[0];
					String yy = yyyy.substring(2);
					String MM = yyyyMM.split("-")[1];
					
					%>
		  <tr class="">
          	<td><span style="color:#D22C17;"><%=yyyy+"/"+MM%></span></td>
          	<td style="text-align: center;color: #000;"><%=CommonString.getFormatInt(order_countMap.get(yyyyMM))%></td>
         </tr>         			 

					<%
 				}
				
				
			}else{

			if(year.equals("") && month.equals("")){ //同时为空，默认为最近1年的订单
				query = "select substring(convert(varchar,add_date,23),0,8) as order_date,count(id) as order_count from pro_product_form";
				query += whereStr;
				query += " and add_date>dateadd(year, -1, convert(varchar, getdate(), 23)) group by substring(convert(varchar,add_date,23),0,8)";

				orderCountList = dbHelper.getMapList(query);
				order_countMap = CommonCollection.listToMap(orderCountList, "order_date", "order_count");
				if(order_countMap == null){
					order_countMap = new HashMap();
				}
				
 				for(int i=12; i>0; i--){
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.MONTH, -i);
					String yyyyMM = CommonDate.getFormatDate("yyyy-MM", cal.getTime());
					String yyyy = yyyyMM.split("-")[0];
					String yy = yyyy.substring(2);
					String MM = yyyyMM.split("-")[1];
										%>
		  <tr class="">
          	<td><span style="color:#D22C17;"><%=yyyy+"/"+MM%></span></td>
          	<td style="text-align: center;color: #000;"><%=CommonString.getFormatInt(order_countMap.get(yyyyMM))%></td>
         </tr>         			 

					<%
 				}
			} 
			}
		 
		 %>
		 

		 
      </tbody></table> 
	</div>

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
	
	var brand_order = '/backend/action/chart.jsp?start_add_date=<%=start_add_date%>&end_add_date=<%=end_add_date%>&factoryid=<%=factoryid%>&catalognum=<%=catalognum%>&area=<%=area%>';
	$.ajax({
		type:"get",
		url:brand_order,
		data:{},
		success:function(result){
			var xmlData = $.trim(result);
			var chart = new FusionCharts({
				swfUrl: '/plugin/chat/FusionChartsV3/Charts/Line.swf',
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
	jQuery("#area option").each(function(){
			jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
		}) ;
	jQuery("#catalognum option").each(function(){
	      if(jQuery(this).val()=='<%=catalognum%>'){
	      	jQuery(this).attr("selected","selected") ;
	      	return  ;
	      }
	}) ;
		jQuery("#area option").each(function(){
	      if(jQuery(this).val()=='<%=area%>'){
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
	var flag = jQuery("#t_flag").val() ;
	var ts = jQuery("#start_add_date").val() ;
	var te = jQuery("#end_add_date").val() ;
	var catalognum = jQuery("#catalognum").val() ;
	var area = jQuery("#area").val() ;
	var factoryid = jQuery("#factoryid").val() ;
	window.location.href="?flag="+flag+"&start_add_date="+ts+"&end_add_date="+te+"&catalognum="+catalognum+"&area="+area+"&factoryid="+factoryid ;
}
jQuery("#catalognum").change(function(){
	var flag = jQuery("#t_flag").val() ;
	var ts = jQuery("#start_add_date").val() ;
	var te = jQuery("#end_add_date").val() ;
	var catalognum = jQuery("#catalognum").val() ;
	var area = jQuery("#area").val() ;
	var factoryid = jQuery("#factoryid").val() ;
	window.location.href="?flag="+flag+"&start_add_date="+ts+"&end_add_date="+te+"&catalognum="+catalognum+"&area="+area+"&factoryid="+factoryid ;
}) ;
jQuery("#area").change(function(){
	var flag = jQuery("#t_flag").val() ;
	var ts = jQuery("#start_add_date").val() ;
	var te = jQuery("#end_add_date").val() ;
	var catalognum = jQuery("#catalognum").val() ;
	var area = jQuery("#area").val() ;
	var factoryid = jQuery("#factoryid").val() ;
	window.location.href="?flag="+flag+"&start_add_date="+ts+"&end_add_date="+te+"&catalognum="+catalognum+"&area="+area+"&factoryid="+factoryid ;
}) ;
jQuery("#factoryid").change(function(){
	var flag = jQuery("#t_flag").val() ;
	var ts = jQuery("#start_add_date").val() ;
	var te = jQuery("#end_add_date").val() ;
	var catalognum = jQuery("#catalognum").val() ;
	var area = jQuery("#area").val() ;
	var factoryid = jQuery("#factoryid").val() ;
	window.location.href="?flag="+flag+"&start_add_date="+ts+"&end_add_date="+te+"&catalognum="+catalognum+"&area="+area+"&factoryid="+factoryid ;
}) ;
</script>
<%
	} catch(Exception e){
		e.printStackTrace() ;
	}finally{
		DBHelper.freeConnection(conn) ;
	}
%>