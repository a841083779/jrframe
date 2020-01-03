<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.manage.PoolManager"%>
<%@page import="com.jerehnet.manage.Tools"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.jerehnet.manage.DBType"%>
<%
	String base_e = "0123456789ABCDEF";
	Random random = new Random();
	response.setContentType("text/xml;");
	StringBuffer xml = new StringBuffer();
	xml.append("<?xml version='1.0' encoding='gbk'?>");
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String enumNo = CommonString.getFormatPara(request.getParameter("enumNo"));
	String sql = "";
	List<String> provincesCategory = new ArrayList<String>();
	provincesCategory.add("安徽");
	provincesCategory.add("北京");
	provincesCategory.add("重庆");
	provincesCategory.add("福建");
	provincesCategory.add("甘肃");
	provincesCategory.add("广东");
	provincesCategory.add("广西");
	provincesCategory.add("贵州");
	provincesCategory.add("海南");
	provincesCategory.add("河北");
	provincesCategory.add("黑龙江");
	provincesCategory.add("河南");
	provincesCategory.add("湖北");
	provincesCategory.add("湖南");
	provincesCategory.add("内蒙古");
	provincesCategory.add("江苏");
	provincesCategory.add("江西");
	provincesCategory.add("吉林");
	provincesCategory.add("辽宁");
	provincesCategory.add("宁夏");
	provincesCategory.add("青海");
	provincesCategory.add("山西");
	provincesCategory.add("山东");
	provincesCategory.add("上海");
	provincesCategory.add("四川");
	provincesCategory.add("天津");
	provincesCategory.add("西藏");
	provincesCategory.add("新疆");
	provincesCategory.add("云南");
	provincesCategory.add("浙江");
	provincesCategory.add("陕西");
	provincesCategory.add("台湾");
	provincesCategory.add("香港");
	provincesCategory.add("澳门");
	try {
		connection = PoolManager.getConnection(DBType.getDBTypeByEnum(enumNo));
		if ("news_view_counts".equals(flag)) {
			String year = CommonString.getFormatPara(request.getParameter("year"));
			String month = CommonString.getFormatPara(request.getParameter("month"));
			String hour = CommonString.getFormatPara(request.getParameter("hour"));
			if ("".equals(year)) {
				year = "2013";
			}
			StringBuffer whereStr = new StringBuffer(" where 1=1 ");
			Object[] objs = new Object[3];
			if (!"".equals(year)) {
				whereStr.append(" and year(pub_date)=?");
				objs[0] = year;
			}
			if (!"".equals(month)) {
				whereStr.append(" and month(pub_date)=?");
				objs[1] = month;
			}
			if (!"".equals(hour)) {
				whereStr.append(" and day(pub_date)=?");
				objs[2] = hour;
			}
			String sel_sql = "   select a.*,factory.name from ( select agent_id,sum(view_count) counnts,count(*) total from pro_agent_news group "
					+ whereStr.toString() + "by agent_id) a left join pro_agent_factory factory on a.agent_id = factory.id";
			xml
					.append("<chart caption='2013年新闻浏览量' subCaption='代理商' numdivlines='9' lineThickness='2' showValues='1' formatNumberScale='0' anchorRadius='3' anchorBgAlpha='50' showAlternateVGridColor='1' numVisiblePlot='12' animation='0'>");
			xml.append("<categories>");
			for (int i = 1; "".equals(month) && i <= 12; i++) {
				xml.append("<category label='" + i + "月'/>");
			}
			for (int i = 1; "".equals(hour) && !"".equals(month) && i <= Tools.getMonthDays(year + "" + month); i++) { // 全月
				xml.append("<category label='" + i + "号'/>");
			}
			xml.append("</categories>");
			xml.append("<dataset seriesName='新闻发布量' color='800080' anchorBorderColor='800080'>");
			for (int i = 0; i < 100; i = i + 10) {
				xml.append("<set value='" + i + "'/>");
			}
			xml.append("</dataset>");
			xml.append("<dataset seriesName='新闻阅读量' color='FF8040' anchorBorderColor='FF8040'>");
			for (int i = 0; i < 12; i++) {
				xml.append("<set value='" + i + "'/>");
			}
			xml.append("</dataset>");
			xml.append("</chart>");
		}
		if(flag.equals("tongji_gailan_page")){
			String province = URLDecoder.decode(CommonString.getFormatPara(request.getParameter("province"))) ; // 省份
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(province)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append(province) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			String agentid = CommonString.getFormatPara(request.getParameter("agent_id")) ;
			if("".equals(agentid)){
				agentid = "120" ;
			}
			subcaption.append("统计概览") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='页面浏览量' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select sum(counts) total from pro_agent_statistics " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and type=0 and agent_id="+agentid) ;
			if(!"".equals(province)){
				whereStr.append(" and province like '"+province+"%'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(statistics_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(statistics_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(statistics_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=Tools.getMonthDays(year+""+month);i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(statistics_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,statistics_date)=? and datepart(hh,statistics_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		}
		if("tongji_gailan_news".equals(flag)){
			String province = URLDecoder.decode(CommonString.getFormatPara(request.getParameter("province"))) ; // 省份
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(province)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append(province) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			String agentid = CommonString.getFormatPara(request.getParameter("agent_id")) ;
			if("".equals(agentid)){
				agentid = "120" ;
			}
			subcaption.append("统计概览") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='新闻浏览量' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select sum(counts) total from pro_agent_statistics " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and type=1 and agent_id="+agentid) ;
			if(!"".equals(province)){
				whereStr.append(" and province like '"+province+"%'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(statistics_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(statistics_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(statistics_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=Tools.getMonthDays(year+""+month);i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(statistics_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,statistics_date)=? and datepart(hh,statistics_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		}
		if("tongji_gailan_orders".equals(flag)){
			String province = URLDecoder.decode(CommonString.getFormatPara(request.getParameter("province"))) ; // 省份
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(province)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append(province) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			String agentid = CommonString.getFormatPara(request.getParameter("agent_id")) ;
			if("".equals(agentid)){
				agentid = "120" ;
			}
			subcaption.append("统计概览") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='订单统计' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select sum(counts) total from pro_agent_statistics " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and type=1 and agent_id="+agentid) ;
			if(!"".equals(province)){
				whereStr.append(" and province like '"+province+"%'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(statistics_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(statistics_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(statistics_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=Tools.getMonthDays(year+""+month);i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(statistics_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,statistics_date)=? and datepart(hh,statistics_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		}
		if("tongji_gailan_votes".equals(flag)){
			String province = URLDecoder.decode(CommonString.getFormatPara(request.getParameter("province"))) ; // 省份
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(province)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append(province) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			String agentid = CommonString.getFormatPara(request.getParameter("agent_id")) ;
			if("".equals(agentid)){
				agentid = "120" ;
			}
			subcaption.append("统计概览") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='投票统计' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select sum(counts) total from pro_agent_statistics " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and type=1 and agent_id="+agentid) ;
			if(!"".equals(province)){
				whereStr.append(" and province like '"+province+"%'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(statistics_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(statistics_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(statistics_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=Tools.getMonthDays(year+""+month);i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(statistics_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,statistics_date)=? and datepart(hh,statistics_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		}
		
		if("ding_dan_tong_ji".equals(flag)){
			String province = URLDecoder.decode(CommonString.getFormatPara(request.getParameter("province"))) ; // 省份
			StringBuffer subcaption = new StringBuffer("") ;
			if("".equals(province)){ // 默认为山东
		// 		province = "山东" ;
			}
			subcaption.append(province) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ; // 年份
			if("".equals(year)){
				year = "2013" ;
			}
			subcaption.append(year).append("年") ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			if(!"".equals(month)){
				subcaption.append(month).append("月份") ;
			}
			String hour = CommonString.getFormatPara(request.getParameter(("hour"))) ;
			if(!"".equals(hour)){
				subcaption.append(hour).append("号") ;
			}
			String agentid = CommonString.getFormatPara(request.getParameter("agent_id")) ;
			if("".equals(agentid)){
				agentid = "120" ;
			}
			subcaption.append("统计概览") ;
			// String subcaption = province+year+month+hour+"订单趋势" ;
			xml.append("<chart caption='订单统计' subcaption='"+subcaption.toString()+"' xAxisName=''  yAxisMinValue='10'  showValues='1' formatNumberScale='0' alternateHGridColor='FCB541' alternateHGridAlpha='20' divLineColor='FCB541' divLineAlpha='50' canvasBorderColor='666666' baseFontColor='666666' lineColor='FCB541' baseFont='微软雅黑' baseFontSize='14'>") ;
			String sel_sql = " select sum(counts) total from pro_agent_statistics " ;
			StringBuffer whereStr = new StringBuffer(" where 1=1 and type=0 and agent_id="+agentid) ;
			if(!"".equals(province)){
				whereStr.append(" and province like '"+province+"%'") ;
			}
			if(!"".equals(year)){
				whereStr.append(" and year(statistics_date)="+year) ;
			}
			if(!"".equals(month)){
				whereStr.append(" and month(statistics_date)="+month) ;
			}
			Map oneMap = null ;
			for(int i=1;i<=12&&"".equals(month);i++){ // 全年
				if("".equals(month)){
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and month(statistics_date)=?",new Object[]{i},connection) ;
				}
				xml.append("<set label='"+i+"月' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;"".equals(hour)&&!"".equals(month)&&i<=Tools.getMonthDays(year+""+month);i++){ // 全月
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and day(statistics_date)=?",new Object[]{i},connection) ;
				xml.append("<set label='"+i+"号' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			for(int i=1;!"".equals(hour)&&i<=24;i++){ // 全日
					oneMap = dbHelper.getMap(sel_sql+whereStr.toString()+" and datepart(dd,statistics_date)=? and datepart(hh,statistics_date)=?",new Object[]{hour,i},connection) ;
				xml.append("<set label='"+i+"时' value='"+CommonString.getFormatPara(oneMap.get("total"))+"'/>") ;
			}
			xml.append("</chart>") ;
		
		}
	} catch (Exception e) {
	} finally {
		DBHelper.freeConnection(connection);
	}
	out.print(xml.toString());
%>

