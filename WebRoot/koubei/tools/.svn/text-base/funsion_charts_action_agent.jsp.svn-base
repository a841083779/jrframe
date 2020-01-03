<%@ page language="java" import="java.util.*,java.sql.Connection,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jereh.member.manage.*" pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%

	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setContentType("text/xml;");
	StringBuffer xml = new StringBuffer();
	//xml.append("<?xml version='1.0' encoding='gbk'?>");
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String getflag = CommonString.getFormatPara(request.getParameter("getflag"));
	String enumNo = CommonString.getFormatPara(request.getParameter("enumNo"));
	String ts = CommonString.getFormatPara(request.getParameter("ts")); // 开始时间
	String te = CommonString.getFormatPara(request.getParameter("te")); // 结束时间
	if("".equals(te)){
		te = CommonDate.getToday("yyyy-MM-dd") ;
	}
	
	String fontSize = "12";
	String labelStep = "4";
	if ("tm".equals(getflag) || "lt".equals(getflag)) {
		labelStep = "7";
	}
	if ("es".equals(getflag)) { // 7 天
		labelStep = "2";
	}
	try {
		connection = dbHelper.getConnection();
	
		
		
		
		
		
		if("order_count".equals(flag)){
			String proid =  CommonString.getFormatPara(request.getParameter("proid")) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
			
	
	
			
			String query = "";
			String whereStr = " where product_id=" + proid;
			
			if(!"".equals(catalognum)){
				whereStr += " and catanum like '"+catalognum+"%'" ;
			}

			List<Map> orderCountList = null;
			Map order_countMap = null ;
			
			if(year.equals("") && month.equals("")){ //同时为空，默认为最近1年的阅读量
				query = "select substring(convert(varchar,add_date,23),0,8) as order_date,count(id) as order_count from pro_product_form";
				query += whereStr;
				query += " and add_date>dateadd(year, -1, convert(varchar, getdate(), 23)) group by substring(convert(varchar,add_date,23),0,8)";
				
				orderCountList = dbHelper.getMapList(query);
				order_countMap = CommonCollection.listToMap(orderCountList, "order_date", "order_count");
				if(order_countMap == null){
					order_countMap = new HashMap();
				}
				
				xml.append("<chart caption='最近12个月阅读量走势统计' canvasPadding='10' lineThickness='3' lineColor='1D8BD1' anchorBorderColor='1D8BD1' bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='1'  >") ;
				for(int i=12; i>0; i--){
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.MONTH, -i);
					String yyyyMM = CommonDate.getFormatDate("yyyy-MM", cal.getTime());
					String yyyy = yyyyMM.split("-")[0];
					String yy = yyyy.substring(2);
					String MM = yyyyMM.split("-")[1];
					String temp01=Integer.toString((CommonString.getFormatInt(order_countMap.get(yyyyMM)))+50);
					//xml.append("<set label='" + MM+"/"+yy + "' value='" + CommonString.getFormatInt(order_countMap.get(yyyyMM))+"' link='JavaScript:getChoseData(\"" + yyyy + "\", \"" + MM + "\");' />");
					xml.append("<set label='" + MM+"/"+yy + "' value='" + temp01+"'  />");

				}
			}else if(!year.equals("") && month.equals("")){ //取此年的阅读量，按月统计
				query = "select substring(convert(varchar,add_date,23),0,8) as order_date,count(id) as order_count from pro_product_form";
				query += whereStr;
				query += " and datepart(yyyy,add_date)=" + year + " group by substring(convert(varchar,add_date,23),0,8)";
				
				orderCountList = dbHelper.getMapList(query);
				order_countMap = CommonCollection.listToMap(orderCountList, "order_date", "order_count");
				if(order_countMap == null){
					order_countMap = new HashMap();
				}
				
				xml.append("<chart caption='" + year + "年阅读量走势统计' canvasPadding='10' lineThickness='3' lineColor='1D8BD1' anchorBorderColor='1D8BD1' bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='1'  >") ;
				for(int i=1; i<=12; i++){
					String MM = String.valueOf(i);
					if(MM.length()<2){
						MM = "0" + MM;
					}
					String yyyyMM = year + "-" + MM;
					String temp02=Integer.toString((CommonString.getFormatInt(order_countMap.get(yyyyMM)))+50);

					//xml.append("<set label='" + MM + "月' value='" + CommonString.getFormatInt(order_countMap.get(yyyyMM))+"' link='JavaScript:getChoseData(\"" + year + "\", \"" + MM + "\");' />");
					xml.append("<set label='" + MM + "月' value='" +temp02+"' />");
				}
			}else if(!year.equals("") && !month.equals("")){ //取此年月的阅读量，按日统计
				query = "select convert(varchar,add_date,23) as order_date,count(id) as order_count from pro_product_form";
				query += whereStr;
				query += " and datepart(yyyy,add_date)=" + year + " and datepart(MM,add_date)=" + month + " group by convert(varchar,add_date,23)";
				
				orderCountList = dbHelper.getMapList(query);
				order_countMap = CommonCollection.listToMap(orderCountList, "order_date", "order_count");
				if(order_countMap == null){
					order_countMap = new HashMap();
				}
				
				xml.append("<chart caption='" + year + "年" + month + "月阅读量走势统计" + "' canvasPadding='10' labelStep='3' lineThickness='3' lineColor='1D8BD1' anchorBorderColor='1D8BD1' bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='1'  >") ;
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM");
				cal.setTime(simpleDate.parse(year + "-" + month));
				int days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				for(int i=1 ;i<=days ;i++){
					String dd = String.valueOf(i);
					if(dd.length()<2){
						dd = "0" + dd;
					}
					String MMdd = month + "-" + dd;
					String yyyyMMdd = year + "-" + month + "-" + dd;
					xml.append("<set label='"+i+"日' value='"+CommonString.getFormatInt(order_countMap.get(yyyyMMdd))+"' />") ;
				}
			}
			xml.append("</chart>") ;
			
		}
		

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		DBHelper.freeConnection(connection);
	}
	out.print(xml.toString());

%>




