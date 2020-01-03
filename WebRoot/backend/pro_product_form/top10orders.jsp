<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//1 省份 2品牌  前10位订单
String if_tag = CommonString.getFormatPara(request.getParameter("if_tag")) ;  // 获得标识
DBHelper dbHelper = DBHelper.getInstance() ;
List<Map> top10orders  = new ArrayList() ;

SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  Calendar cal = Calendar.getInstance();
  GregorianCalendar gcLast = (GregorianCalendar) Calendar.getInstance();
  Calendar calendar = Calendar.getInstance();
  calendar.setTime(new Date());

  calendar.add(Calendar.MONTH, -1);
  Date theDate = calendar.getTime();
  gcLast.setTime(theDate);
  gcLast.set(Calendar.DAY_OF_MONTH, 1);
  String day_first_prevM = df.format(gcLast.getTime());
  StringBuffer str = new StringBuffer().append(day_first_prevM).append(" 00:00:00");
  day_first_prevM = str.toString();
  calendar.add(cal.MONTH, 1);
  calendar.set(cal.DATE, 1);
  calendar.add(cal.DATE, -1);
  String day_end_prevM = df.format(calendar.getTime());
  StringBuffer endStr = new StringBuffer().append(day_end_prevM).append(" 23:59:59");
  day_end_prevM = endStr.toString();
  DecimalFormat dformat = new DecimalFormat("0.00");//这里是设定小数位数
  int count = 0;
if("1".equals(if_tag))
{
	  count =(Integer)dbHelper.getMap("   select sum(total) total from ( select top 10 count(*) total,province if_tag from pro_product_form where province is not null and add_date>='"+day_first_prevM+"' and add_date<='"+day_end_prevM+"' group by province  order by total desc ) a ").get("total") ;
	  top10orders = dbHelper.getMapList("  select top 10 count(*) total,province if_tag from pro_product_form where province is not null and add_date>='"+day_first_prevM+"' and add_date<='"+day_end_prevM+"' group by province  order by total desc  ") ;
	  Iterator iter = top10orders.iterator() ;
	  while(iter.hasNext())
	  {
		  Map oneMap = (HashMap)iter.next() ;
	  }
}
if("2".equals(if_tag))
{
	 count = (Integer)dbHelper.getMap("   select sum(total) total from ( select top 10 count(*) total,factoryname if_tag from pro_product_form where factoryname is not null and add_date>='"+day_first_prevM+"' and add_date<='"+day_end_prevM+"' group by factoryname  order by total desc  ) a ").get("total") ;
	 top10orders = dbHelper.getMapList("   select top 10 count(*) total,factoryname if_tag from pro_product_form where factoryname is not null and add_date>='"+day_first_prevM+"' and add_date<='"+day_end_prevM+"' group by factoryname  order by total desc  ") ;
	  Iterator iter = top10orders.iterator() ;
	  while(iter.hasNext())
	  {
		  Map oneMap = (HashMap)iter.next() ;
	  }
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>前10位订单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  <body>
  <table width="500" cellspacing="0" cellpadding="3" border="1" bgcolor="#CCCCCC" align="center" class="word" bordercolordark="#000000" bordercolorlight="#FFFFFF">
  <tbody><tr bgcolor="#0066CC">
  <td width="65" align="center"><strong><font color="#FFFFFF">排名</font></strong></td>
    <td width="120" align="center"><strong><font color="#FFFFFF">数量</font></strong></td>
    <td bgcolor="#0066CC" align="center"><strong><font color="#FFFFFF"><%="1".equals(if_tag)?"省份":"品牌" %></font></strong></td>
    <td bgcolor="#0066CC" align="center"><strong><font color="#FFFFFF">占有率（%）</font></strong></td>
  </tr>
  <%
     if(null!=top10orders)
     {
    	 Iterator iter = top10orders.iterator() ;
    	 int k=1 ;
    	 while(iter.hasNext())
    	 {
    		 Map oneMap = (HashMap) iter.next() ;
    	 %>
		 <tr><td bgcolor="#FFFFFF" align="center"><b><%=k %></b></td>
		<td bgcolor="#FFFFFF" align="center"><%=oneMap.get("total") %></td>
		<td bgcolor="#FFFFFF" align="center"><%=oneMap.get("if_tag") %></td>
		<td bgcolor="#FFFFFF" align="center"><%=dformat.format(((Integer)oneMap.get("total")/(float)count)*100)+"%"%></td></tr>
<%
		k++ ;
    	 }
     }
  %>
</tbody></table>
<script type="text/javascript">
  function doSub(){
    return true ;
  }
</script>
  </body>
</html>
