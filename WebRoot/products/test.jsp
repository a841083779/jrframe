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
    String sql1="select count(id) as sum from pro_product_form where product_id in(23915,21525,21959,21514,20163,20164,9546,325,574,588,4561,590) and   catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0 and factoryid=174 and add_user ='baidu'";
	String sql2="select count(id) as sum from pro_product_form where product_id in(23915,21525,21959,21514,20163,20164,9546,325,574,588,4561,590) and  catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and (((add_user! ='baidu' or add_user  is null  or  add_user=''  ) and is_first=1  ) or ( add_user   like '%mobile%' and (push_order!= 1 or  push_order is null  )  ) )";
	String sql3="select count(id) as sum from pro_product_form where product_id in(23915,21525,21959,21514,20163,20164,9546,325,574,588,4561,590) and  catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and  (((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )    or (add_user   like '%mobile%' and push_order=1)  )" ;
	String sql4="select count(id) as sum from pro_product_form where product_id in(23915,21525,21959,21514,20163,20164,9546,325,574,588,4561,590) and  catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=1 and factoryid=174" ;
	Map map1 = dbHelper.getMap(sql1);
    Map map2 = dbHelper.getMap(sql2);
	Map map3 = dbHelper.getMap(sql3);
	Map map4 = dbHelper.getMap(sql4);
	
	String sql5="select count(id) as sum from pro_product_form where product_id in(29171,29172,29173,29176,29178,29444,25480,23906,25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378)   and   add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0 and factoryid=174 and add_user ='baidu'";
	String sql6="select count(id) as sum from pro_product_form where product_id in(29171,29172,29173,29176,29178,29444,25480,23906,25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378)   and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and (((add_user! ='baidu' or add_user  is null  or  add_user=''  ) and is_first=1  ) or ( add_user   like '%mobile%' and (push_order!= 1 or  push_order is null  )  ) )";
	String sql7="select count(id) as sum from pro_product_form where product_id in(29171,29172,29173,29176,29178,29444,25480,23906,25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378)   and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and  (((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )    or (add_user   like '%mobile%' and push_order=1)  )" ;
	String sql8="select count(id) as sum from pro_product_form where product_id in(29171,29172,29173,29176,29178,29444,25480,23906,25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378)   and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=1 and factoryid=174" ;
	Map map5 = dbHelper.getMap(sql5);
    Map map6 = dbHelper.getMap(sql6);
	Map map7 = dbHelper.getMap(sql7);
	Map map8 = dbHelper.getMap(sql8);
	
	
	String sql9="select count(id) as sum from pro_product_form where product_id not in(25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378,21525,21959,21514,20163,20164,9546,325,574,588,4561,590,30221,30220,30219) and  catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0 and factoryid=174 and add_user ='baidu'";
	String sql10="select count(id) as sum from pro_product_form where product_id not in(25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378,21525,21959,21514,20163,20164,9546,325,574,588,4561,590,30221,30220,30219) and catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and (((add_user! ='baidu' or add_user  is null  or  add_user=''  ) and is_first=1  ) or ( add_user   like '%mobile%' and (push_order!= 1 or  push_order is null  )  ) )";
	String sql11="select count(id) as sum from pro_product_form where product_id not in(25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378,21525,21959,21514,20163,20164,9546,325,574,588,4561,590,30221,30220,30219) and catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and  (((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )    or (add_user   like '%mobile%' and push_order=1)  )" ;
	String sql12="select count(id) as sum from pro_product_form where product_id not in(25477,23911,23910,23909,23908,23907,19946,11366,9555,9554,9553,9552,9551,9550,9548,9547,3525,3503,522,445,407,403,400,390,378,21525,21959,21514,20163,20164,9546,325,574,588,4561,590,30221,30220,30219) and catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=1 and factoryid=174" ;
	Map map9 = dbHelper.getMap(sql9);
    Map map10 = dbHelper.getMap(sql10);
	Map map11 = dbHelper.getMap(sql11);
	Map map12 = dbHelper.getMap(sql12);
	
	
	
    String sql13="select count(id) as sum from pro_product_form where product_id  in (30221,30220,30219) and  catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0 and factoryid=174 and add_user ='baidu'";
	String sql14="select count(id) as sum from pro_product_form where product_id  in (30221,30220,30219) and catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and (((add_user! ='baidu' or add_user  is null  or  add_user=''  ) and is_first=1  ) or ( add_user   like '%mobile%' and (push_order!= 1 or  push_order is null  )  ) )";
	String sql15="select count(id) as sum from pro_product_form where product_id  in (30221,30220,30219) and catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0 and factoryid=174 and  (((is_first  is null  or  is_first=''  or  is_first='0' or  is_first=0 ) and  (add_user! ='baidu' or add_user  is null  or  add_user=''  )  and add_user not like '%mobile%'  )    or (add_user   like '%mobile%' and push_order=1)  )" ;
	String sql16="select count(id) as sum from pro_product_form where product_id  in (30221,30220,30219) and catanum='101001001' and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=1 and factoryid=174" ;
	Map map13 = dbHelper.getMap(sql13);
    Map map14 = dbHelper.getMap(sql14);
	Map map15 = dbHelper.getMap(sql15);
	Map map16 = dbHelper.getMap(sql16);
	
	
%>
<strong>BCP</strong><br>
竞价：<%=CommonString.getFormatInt(map1.get("sum"))%><br>
主动：<%=CommonString.getFormatInt(map2.get("sum"))%><br>
引导：<%=CommonString.getFormatInt(map3.get("sum"))%><br>
无效：<%=CommonString.getFormatInt(map4.get("sum"))%><br><br><br>

<strong>GCI</strong><br>
竞价：<%=CommonString.getFormatInt(map5.get("sum"))%><br>
主动：<%=CommonString.getFormatInt(map6.get("sum"))%><br>
引导：<%=CommonString.getFormatInt(map7.get("sum"))%><br>
无效：<%=CommonString.getFormatInt(map8.get("sum"))%><br><br><br>


<strong>NGH</strong><br>
竞价：<%=CommonString.getFormatInt(map13.get("sum"))%><br>
主动：<%=CommonString.getFormatInt(map14.get("sum"))%><br>
引导：<%=CommonString.getFormatInt(map15.get("sum"))%><br>
无效：<%=CommonString.getFormatInt(map16.get("sum"))%><br><br><br>

<strong>其他</strong><br>
竞价：<%=CommonString.getFormatInt(map9.get("sum"))%><br>
主动：<%=CommonString.getFormatInt(map10.get("sum"))%><br>
引导：<%=CommonString.getFormatInt(map11.get("sum"))%><br>
无效：<%=CommonString.getFormatInt(map12.get("sum"))%><br><br><br>

