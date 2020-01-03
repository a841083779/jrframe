<%@ page language="java" import="java.util.*,java.sql.Connection,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>

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
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
 	StringBuffer xml = new StringBuffer("");
 	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String ts = CommonString.getFormatPara(request.getParameter("ts")); // 开始时间
	String te = CommonString.getFormatPara(request.getParameter("te")); // 结束时间
	if("".equals(te)){
		te = CommonDate.getToday("yyyy-MM-dd") ;
	}
	
	String fontSize = "12";
	String labelStep = "4";
 
	List<Map> dataList = null ;
	try {
		connection = dbHelper.getConnection() ;
		
		
		    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			String year = CommonString.getFormatPara(request.getParameter("year")) ;
			String month = CommonString.getFormatPara(request.getParameter("month")) ;
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
            String catalog=CommonString.getFormatPara(request.getParameter("catalog")) ; 
			catalog=catalognum;
            String factory=CommonString.getFormatPara(request.getParameter("factory")) ; 
			factory=factoryid;
            String area=CommonString.getFormatPara(request.getParameter("area")) ; 
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
 	        String start_add_date=CommonString.getFormatPara(request.getParameter("start_add_date"));	
	        String end_add_date=CommonString.getFormatPara(request.getParameter("end_add_date"));	
          
			String query = "";
			String whereStr = " where is_deleted=0" ;
			
			if(!"".equals(catalog)){
				whereStr += " and catanum like '"+catalog+"%'" ;
			}	
			if(!"".equals(area)){
				whereStr += " and province like '%"+area+"%'" ;
			}
			if(!"".equals(factory)){
				whereStr += " and factoryid = "+factory ;
			}
			
			
		    if(!"".equals(start_add_date)){
				whereStr += " and add_date >= '"+start_add_date +" 00:00:00'";
			}
			
			
			if(!"".equals(end_add_date)){
				whereStr += " and add_date <= '"+end_add_date +" 23:59:59'";
			}
			
			
			List<Map> orderCountList = null;
			Map order_countMap = null ;
			
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
				
				xml.append("<chart caption='订单走势统计' canvasPadding='10' lineThickness='3' lineColor='1D8BD1' anchorBorderColor='1D8BD1' bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='1'  >") ;
				for(int i=months; i>0; i--){
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.MONTH, -i);
					String yyyyMM = CommonDate.getFormatDate("yyyy-MM", cal.getTime());
					//yyyyMM=end_add_date;
					String yyyy = yyyyMM.split("-")[0];
					String yy = yyyy.substring(2);
					String MM = yyyyMM.split("-")[1];
					xml.append("<set label='" + yyyy+"/"+MM + "' value='" + CommonString.getFormatInt(order_countMap.get(yyyyMM))+"' link='JavaScript:getChoseData(\"" + yyyy + "\", \"" + MM + "\");' />");
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
				
				xml.append("<chart caption='订单走势统计' canvasPadding='10' lineThickness='3' lineColor='1D8BD1' anchorBorderColor='1D8BD1' bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='1'  >") ;
				for(int i=12; i>0; i--){
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.MONTH, -i);
					String yyyyMM = CommonDate.getFormatDate("yyyy-MM", cal.getTime());
					String yyyy = yyyyMM.split("-")[0];
					String yy = yyyy.substring(2);
					String MM = yyyyMM.split("-")[1];
					xml.append("<set label='" + yyyy+"/"+MM+ "' value='" + CommonString.getFormatInt(order_countMap.get(yyyyMM))+"' link='JavaScript:getChoseData(\"" + yyyy + "\", \"" + MM + "\");' />");
				}
			}else if(!year.equals("") && month.equals("")){ //取此年的订单，按月统计
				query = "select substring(convert(varchar,add_date,23),0,8) as order_date,count(id) as order_count from pro_product_form";
				query += whereStr;
				query += " and datepart(yyyy,add_date)=" + year + " group by substring(convert(varchar,add_date,23),0,8)";
				
				orderCountList = dbHelper.getMapList(query);
				order_countMap = CommonCollection.listToMap(orderCountList, "order_date", "order_count");
				if(order_countMap == null){
					order_countMap = new HashMap();
				}
				
				xml.append("<chart caption='" + year + "订单走势统计' canvasPadding='10' lineThickness='3' lineColor='1D8BD1' anchorBorderColor='1D8BD1' bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='1'  >") ;
				for(int i=1; i<=12; i++){
					String MM = String.valueOf(i);
					if(MM.length()<2){
						MM = "0" + MM;
					}
					String yyyyMM = year + "-" + MM;
					xml.append("<set label='" + MM + "月' value='" + CommonString.getFormatInt(order_countMap.get(yyyyMM))+"' link='JavaScript:getChoseData(\"" + year + "\", \"" + MM + "\");' />");
					//xml.append("<set label='" + MM + "月' value='" + CommonString.getFormatInt(order_countMap.get(yyyyMM))+"' />");
				}
			}else if(!year.equals("") && !month.equals("")){ //取此年月的订单，按日统计
				query = "select convert(varchar,add_date,23) as order_date,count(id) as order_count from pro_product_form";
				query += whereStr;
				query += " and datepart(yyyy,add_date)=" + year + " and datepart(MM,add_date)=" + month + " group by convert(varchar,add_date,23)";
				
				orderCountList = dbHelper.getMapList(query);
				order_countMap = CommonCollection.listToMap(orderCountList, "order_date", "order_count");
				if(order_countMap == null){
					order_countMap = new HashMap();
				}
				
				xml.append("<chart caption='" + year + "" + month + "订单走势统计" + "' canvasPadding='10' labelStep='3' lineThickness='3' lineColor='1D8BD1' anchorBorderColor='1D8BD1' bgColor='FFFFFF' formatNumberScale='0' baseFont='微软雅黑' baseFontSize='12' showValues='1'  >") ;
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
			}
			xml.append("</chart>") ;

 
	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		DBHelper.freeConnection(connection);
	}
	out.print(xml.toString());
%>

