<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache"%>
<%
String p = CommonString.getFormatPara(request.getParameter("p"));
Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
String today = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime())+" 16:00:00" ;
if(p.equals("x")){
calendar.add(Calendar.DATE, -2);    //得到前一天    
}else if(p.equals("d")){
calendar.add(Calendar.DATE, -3);    //得到前一天   
}else if(p.equals("qm")){
calendar.add(Calendar.DATE, -4);    //得到前一天   
}else if(p.equals("gq")){
calendar.add(Calendar.DATE, -8);    //得到前一天   
}else{
calendar.add(Calendar.DATE, -1);    //得到前一天   	
}
String yesday = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()) +" 16:00:00";
	DBHelper dbHelper = DBHelper.getInstance() ;
    String sql1="select count(id) as sum from pro_product_form where  (catanum='101001001'  or product_id in (29171,29172,29173,29176,29178,29444)) and   add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0 and factoryid=174 and add_user ='baidu'";
	String sql2="select count(id) as sum from pro_product_form where  (catanum='101001001'  or product_id in (29171,29172,29173,29176,29178,29444))and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and (((add_user! ='baidu' or add_user  is null  or  add_user=''  ) and is_first=1  ) or ( add_user   like '%mobile%' and (push_order!= 1 or  push_order is null  )  ) )";
	String sql3="select count(id) as sum from pro_product_form where  (catanum='101001001'  or product_id in (29171,29172,29173,29176,29178,29444)) and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and  (((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )    or (add_user   like '%mobile%' and push_order=1)  )" ;
	String sql4="select count(id) as sum from pro_product_form where  (catanum='101001001'  or product_id in (29171,29172,29173,29176,29178,29444)) and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174" ;
	Map map1 = dbHelper.getMap(sql1);
    Map map2 = dbHelper.getMap(sql2);
	Map map3 = dbHelper.getMap(sql3);
	Map map4 = dbHelper.getMap(sql4);
%>
竞价：<%=CommonString.getFormatInt(map1.get("sum"))%><br>
主动：<%=CommonString.getFormatInt(map2.get("sum"))%><br>
引导：<%=CommonString.getFormatInt(map3.get("sum"))%><br>
总数：<%=CommonString.getFormatInt(map4.get("sum"))%><br>


