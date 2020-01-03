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
}else if(p.equals("month")){
calendar.add(Calendar.DATE, -30);    //得到前一天   
}else{
calendar.add(Calendar.DATE, -1);    //得到前一天   	
}
String yesday = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()) +" 16:00:00";
DBHelper dbHelper = DBHelper.getInstance() ;

String sql1="select count(distinct(mobile_phone)) as sum from pro_product_form where ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and  province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and    add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0  ";
String sql2="select count(distinct(mobile_phone)) as sum from pro_product_form where  ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or   catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs in('103004','103005','103006','103007','103003','103002') and province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql3="select count(distinct(mobile_phone)) as sum from pro_product_form where  ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or   catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs in('103002','103003') and  province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";  	

String sql_a_1="select count(distinct(mobile_phone)) as sum from pro_product_form where   ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or   catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103002' and province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_a_2="select count(distinct(mobile_phone)) as sum from pro_product_form where  ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or   catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103003' and province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_a_3="select count(distinct(mobile_phone)) as sum from pro_product_form where  ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and    call_rs ='103004' and province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_a_4="select count(distinct(mobile_phone)) as sum from pro_product_form where  ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or   catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and    call_rs ='103005' and province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_a_5="select count(distinct(mobile_phone)) as sum from pro_product_form where  ( (catanum like '%105003%'  and factoryid in(209,133,134,142) )  or   catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103006' and province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_a_6="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103007' and province in('北京','天津','上海','广西','河北','江西', '西藏','内蒙古','福建','广东','新疆')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";



String sql5="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北' )  and add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0  ";
String sql6="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs in('103004','103005','103006','103007','103003','103002') and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and  add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql7="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs in('103002','103003') and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";  	

String sql_b_1="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103002' and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_b_2="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103003' and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_b_3="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103004' and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_b_4="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103005' and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_b_5="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103006' and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_b_6="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103007' and province in('安徽','贵州','山东','云南','青海','浙江','海南','山东','山西','湖北')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";


 


String sql13="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and     add_date>='"+yesday+"' and add_date<='"+today+"'  and  is_deleted=0  ";
String sql14="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs in('103004','103005','103006','103007','103003','103002') and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql15="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs in('103002','103003') and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";  	

String sql_d_1="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and    call_rs ='103002' and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_d_2="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103003' and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_d_3="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103004' and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_d_4="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103005' and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_d_5="select count(distinct(mobile_phone)) as sum from pro_product_form where   ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103006' and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";
String sql_d_6="select count(distinct(mobile_phone)) as sum from pro_product_form where  ((catanum like '%105003%'  and factoryid in(209,133,134,142) )  or  catanum like '%101003%' or  (catanum like '%106001%' and catanum!='106001020' and catanum!='106001021'  ) or  catanum like '%101005002%' or  catanum like '%104001%' or  catanum like '%104005%' or (catanum in('101001001','101001004') and factoryid in(174,182,184,183,175,133,192,194,455,139,209,141,136,137,135,189,185) ) or (catanum like '%101002007%' and factoryid in(137,136,139,135,138,141,209,133,148,144,16683,172) ) ) and   call_rs ='103007' and province in('甘肃','陕西','湖南','江苏','河南','重庆','四川','宁夏','吉林','辽宁','黑龙江')  and   add_date>='"+yesday+"' and add_date<='"+today+"' and is_deleted=0  ";

Map map1 = dbHelper.getMap(sql1);
if(map1==null){map1=new HashMap();}
Map map2 = dbHelper.getMap(sql2);
if(map2==null){map2=new HashMap();}
Map map3 = dbHelper.getMap(sql3);
if(map3==null){map3=new HashMap();}

Map map_a_1 = dbHelper.getMap(sql_a_1);
if(map_a_1==null){map_a_1=new HashMap();}
Map map_a_2 = dbHelper.getMap(sql_a_2);
if(map_a_2==null){map_a_2=new HashMap();}
Map map_a_3 = dbHelper.getMap(sql_a_3);
if(map_a_3==null){map_a_3=new HashMap();}
Map map_a_4 = dbHelper.getMap(sql_a_4);
if(map_a_4==null){map_a_4=new HashMap();}
Map map_a_5 = dbHelper.getMap(sql_a_5);
if(map_a_5==null){map_a_5=new HashMap();}
Map map_a_6 = dbHelper.getMap(sql_a_6);
if(map_a_6==null){map_a_6=new HashMap();}

Map map5 = dbHelper.getMap(sql5);
if(map5==null){map5=new HashMap();}
Map map6 = dbHelper.getMap(sql6);
if(map6==null){map6=new HashMap();}
Map map7 = dbHelper.getMap(sql7);
if(map7==null){map7=new HashMap();}

Map map_b_1 = dbHelper.getMap(sql_b_1);
if(map_b_1==null){map_b_1=new HashMap();}
Map map_b_2 = dbHelper.getMap(sql_b_2);
if(map_b_2==null){map_b_2=new HashMap();}
Map map_b_3 = dbHelper.getMap(sql_b_3);
if(map_b_3==null){map_b_3=new HashMap();}
Map map_b_4 = dbHelper.getMap(sql_b_4);
if(map_b_4==null){map_b_4=new HashMap();}
Map map_b_5 = dbHelper.getMap(sql_b_5);
if(map_b_5==null){map_b_5=new HashMap();}
Map map_b_6 = dbHelper.getMap(sql_b_6);
if(map_b_6==null){map_b_6=new HashMap();}
 
 
 
 

 
  
 
 
Map map13 = dbHelper.getMap(sql13);
if(map13==null){map13=new HashMap();}
Map map14 = dbHelper.getMap(sql14);
if(map14==null){map14=new HashMap();}
Map map15 = dbHelper.getMap(sql15);
if(map15==null){map15=new HashMap();}

Map map_d_1 = dbHelper.getMap(sql_d_1);
if(map_d_1==null){map_d_1=new HashMap();}
Map map_d_2 = dbHelper.getMap(sql_d_2);
if(map_d_2==null){map_d_2=new HashMap();}
Map map_d_3 = dbHelper.getMap(sql_d_3);
if(map_d_3==null){map_d_3=new HashMap();}
Map map_d_4 = dbHelper.getMap(sql_d_4);
if(map_d_4==null){map_d_4=new HashMap();}
Map map_d_5 = dbHelper.getMap(sql_d_5);
if(map_d_5==null){map_d_5=new HashMap();}
Map map_d_6 = dbHelper.getMap(sql_d_6);
if(map_d_6==null){map_d_6=new HashMap();}

%>
 <style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 1px;font-size:16px;text-align:center}
	td{height:20px;width:105px}
	</style>
<table>
<tr>
<td>负责人</td>
<td >订单量</td>
<td style="width:400px">回访量（成功/无效/拒访/占线/关机/无人接听）</td>
<td>未回访量</td>
<td>回访比例</td>
<td>成功</td>
<td>失败</td>
<td>转化率</td>
</tr>



 
 
<tr>
<td>王啸</td>
<td><%=CommonString.getFormatInt(map13.get("sum"))%></td>
<td><%=CommonString.getFormatInt(map14.get("sum"))%>（<%=CommonString.getFormatInt(map_d_1.get("sum"))%>/<%=CommonString.getFormatInt(map_d_2.get("sum"))%>/<%=CommonString.getFormatInt(map_d_3.get("sum"))%>/<%=CommonString.getFormatInt(map_d_4.get("sum"))%>/<%=CommonString.getFormatInt(map_d_5.get("sum"))%>/<%=CommonString.getFormatInt(map_d_6.get("sum"))%>）</td>
<td><%=CommonString.getFormatInt(map13.get("sum"))-CommonString.getFormatInt(map14.get("sum"))%></td>
<%if(CommonString.getFormatInt(map13.get("sum"))!=0){%>
<td><%=(CommonString.getFormatInt(map14.get("sum"))*100)/CommonString.getFormatInt(map13.get("sum"))%>%</td>
<%}else{%>
<td>0%</td>
<%}%>
<td><%=CommonString.getFormatInt(map15.get("sum"))%></td>
<td><%=CommonString.getFormatInt(map13.get("sum"))-CommonString.getFormatInt(map15.get("sum"))%></td>
<%if(CommonString.getFormatInt(map13.get("sum"))!=0){%>
<td><%=(CommonString.getFormatInt(map15.get("sum"))*100)/CommonString.getFormatInt(map13.get("sum"))%>%</td>
<%}else{%>
<td>0%</td>
<%}%>
</tr>


<tr>
<td>牟杰</td>
<td><%=CommonString.getFormatInt(map1.get("sum"))%></td>
<td><%=CommonString.getFormatInt(map2.get("sum"))%>（<%=CommonString.getFormatInt(map_a_1.get("sum"))%>/<%=CommonString.getFormatInt(map_a_2.get("sum"))%>/<%=CommonString.getFormatInt(map_a_3.get("sum"))%>/<%=CommonString.getFormatInt(map_a_4.get("sum"))%>/<%=CommonString.getFormatInt(map_a_5.get("sum"))%>/<%=CommonString.getFormatInt(map_a_6.get("sum"))%>）</td>
<td><%=CommonString.getFormatInt(map1.get("sum"))-CommonString.getFormatInt(map2.get("sum"))%></td>
<%if(CommonString.getFormatInt(map1.get("sum"))!=0){%>
<td><%=(CommonString.getFormatInt(map2.get("sum"))*100)/CommonString.getFormatInt(map1.get("sum"))%>%</td>
<%}else{%>
<td>0%</td>
<%}%>
<td><%=CommonString.getFormatInt(map3.get("sum"))%></td>
<td><%=CommonString.getFormatInt(map1.get("sum"))-CommonString.getFormatInt(map3.get("sum"))%></td>
<%if(CommonString.getFormatInt(map1.get("sum"))!=0){%>
<td><%=(CommonString.getFormatInt(map3.get("sum"))*100)/CommonString.getFormatInt(map1.get("sum"))%>%</td>
<%}else{%>
<td>0%</td>
<%}%>
</tr>

<tr>
<td>张嘉迅</td>
<td><%=CommonString.getFormatInt(map5.get("sum"))%></td>
<td><%=CommonString.getFormatInt(map6.get("sum"))%>（<%=CommonString.getFormatInt(map_b_1.get("sum"))%>/<%=CommonString.getFormatInt(map_b_2.get("sum"))%>/<%=CommonString.getFormatInt(map_b_3.get("sum"))%>/<%=CommonString.getFormatInt(map_b_4.get("sum"))%>/<%=CommonString.getFormatInt(map_b_5.get("sum"))%>/<%=CommonString.getFormatInt(map_b_6.get("sum"))%>）</td>
<td><%=CommonString.getFormatInt(map5.get("sum"))-CommonString.getFormatInt(map6.get("sum"))%></td>
<%if(CommonString.getFormatInt(map5.get("sum"))!=0){%>
<td><%=(CommonString.getFormatInt(map6.get("sum"))*100)/CommonString.getFormatInt(map5.get("sum"))%>%</td>
<%}else{%>
<td>0%</td>
<%}%>
<td><%=CommonString.getFormatInt(map7.get("sum"))%></td>
<td><%=CommonString.getFormatInt(map5.get("sum"))-CommonString.getFormatInt(map7.get("sum"))%></td>
<%if(CommonString.getFormatInt(map5.get("sum"))!=0){%>
<td><%=(CommonString.getFormatInt(map7.get("sum"))*100)/CommonString.getFormatInt(map5.get("sum"))%>%</td>
<%}else{%>
<td>0%</td>
<%}%>
</tr>
 




</table>

