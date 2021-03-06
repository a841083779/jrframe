<%@page contentType="text/html;charset=utf-8"
	%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.jerehnet.util.common.CommonApplication"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="java.io.OutputStream"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.Label"%>
<% 
String if_tag = CommonString.getFormatPara(request.getParameter("if_tag")) ;  // 获取标识
List<Map> pro_List = new ArrayList() ;
DBHelper dbHelper = DBHelper.getInstance() ;
java.util.Date utildate=new java.util.Date();
java.sql.Date date=new java.sql.Date(utildate.getTime());
////system.out.println(date);
Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
String today = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime())+" 16:00:00" ;
calendar.add(Calendar.DATE, -1);    //得到前一天    
String yesday = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()) +" 16:00:00";
	if("2".equals(if_tag))  // 一键导出excel
	{
		String flag_400 = CommonString.getFormatPara(request.getParameter("flag_400"));
		if(!"".equals(flag_400)){
			flag_400 = " and call_rs = '103002' ";
		}
		String formUUID = CommonString.getFormatPara(request.getParameter("formUUID"));
		if(!"".equals(formUUID)){
			flag_400 += " and uuid = '"+formUUID+"' ";
		}
		pro_List = dbHelper.getMapList(" select * from pro_product_form where is_deleted=0 and add_date>='"+yesday+"' and add_date<='"+today+"' "+flag_400) ;
	}
	if("1".equals(if_tag))
	{
		// 获取选择的条件
		String orderby = "" ;
		StringBuffer whereStr = new StringBuffer(" is_deleted=0 ") ;
		String name = CommonString.getFormatPara(request.getParameter("name")) ; // 订单人
		String start_date = CommonString.getFormatPara(request.getParameter("start_date")) ; // 开始时间
		String end_date = CommonString.getFormatPara(request.getParameter("end_date")) ;  //
		String factoryname = CommonString.getFormatPara(request.getParameter("factoryname")) ;
		String catanum = CommonString.getFormatPara(request.getParameter("catanum")) ;
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
		String product_name = CommonString.getFormatPara(request.getParameter("product_name")) ;
		String contact_address = CommonString.getFormatPara(request.getParameter("contact_address")) ;
		String state = CommonString.getFormatPara(request.getParameter("state")) ;
		String is_success = CommonString.getFormatPara(request.getParameter("is_success")) ;
		String start_form_id  = CommonString.getFormatPara(request.getParameter("start_form_id")) ;
		String end_form_id = CommonString.getFormatPara(request.getParameter("end_form_id")) ;
		String orderbywhat = CommonString.getFormatPara(request.getParameter("orderbywhat")) ;
		String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;  // 所属分类
		String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;  // 所属分类
		String is_deal = CommonString.getFormatPara(request.getParameter("is_deal")) ;  // 是否成交
		int is_first = CommonString.getFormatInt(request.getParameter("is_first")); //是否主动咨询
		String tel = CommonString.getFormatPara(request.getParameter("tel")) ; // 订单人
		String call_rs1 = CommonString.getFormatPara(request.getParameter("call_rs")) ; // 第一次呼叫
		String call_rs2 = CommonString.getFormatPara(request.getParameter("call_rs2")) ; // 第二次呼叫

		
		if(!"".equals(orderbywhat)){
			orderby = " order by "+orderbywhat +" asc" ;
		}
		if(!"".equals(name)) 
		{
			whereStr.append(" and name like '%"+name+"%'") ;
		}
		if(!"".equals(start_date))
		{
			whereStr.append(" and add_date>='"+start_date+" 00:00:00'") ;
		}
		if(!"".equals(end_date))
		{
			whereStr.append(" and add_date<='"+end_date+" 23:59:59'") ;
		}
		if(!"".equals(factoryname))
		{
			whereStr.append(" and factoryname like'%"+factoryname+"%'") ;
		}
		if(!"".equals(catanum))
		{
			whereStr.append(" and catanum ='"+catanum+"'") ;
		}
		if(!"".equals(factoryid))
		{
			whereStr.append(" and to_brands like '%,"+factoryid+",%'") ;
		}
		if(!"".equals(product_name))
		{
			whereStr.append(" and product_name like'%"+product_name+"%'") ;
		}
		if(!"".equals(contact_address))
		{
			whereStr.append(" and contact_address like '%"+contact_address+"%'") ;
		}
		if(!"".equals(state) && !"-1".equals(state))
		{
			whereStr.append(" and state="+state) ;
		}
		if(!"".equals(start_form_id))
		{
			whereStr.append(" and id>="+start_form_id) ;
		}
		if(!"".equals(end_form_id))
		{
			whereStr.append(" and id<="+end_form_id) ;
		}
		if(!"".equals(catalogname)){
			whereStr.append(" and cataname like '%"+catalogname+"%'") ;
		}
		if(!"".equals(catalognum)){
			whereStr.append(" and catanum like '%"+catalognum+"%'") ;
		}
		String flag_400 = CommonString.getFormatPara(request.getParameter("flag_400"));
		
		if(!"".equals(flag_400)){
			whereStr.append(" and call_rs = '103002' ");
		}
		if(!"".equals(is_deal) && !"-1".equals(is_deal)){
			whereStr.append(" and is_deal='"+is_deal+"'") ;
		}
		if(is_first > -1){
			whereStr.append(" and is_first=" + is_first);
		}
		if(!"".equals(tel)) 
		{
			whereStr.append(" and mobile_phone like '%"+tel+"%'") ;
		}
	    if(!"".equals(call_rs1)) 
		{
			whereStr.append(" and call_rs = '"+call_rs1+"'") ;
		}
		if(!"".equals(call_rs2)) 
		{
			whereStr.append(" and call_rs_task2 = '"+call_rs2+"'") ;
		}
		 if(!"".equals(is_success)&&!"-1".equals(is_success)) 
		{
			whereStr.append(" and is_success = "+is_success+"") ;
		}
		
		pro_List = dbHelper.getMapList(" select * from pro_product_form where "+whereStr.toString()+orderby+"") ;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>

<style type="text/css">
<!--
.STYLE1 {color: #FFFFFF}
-->
</style>
</head>
<body >
<%
 	Map buyTime = CommonApplication.getEnumChildren("102", application);
	WritableWorkbook wwb=null;
	WritableSheet ws=null;
	OutputStream os = response.getOutputStream();
	wwb = Workbook.createWorkbook(os);
	ws=wwb.createSheet("产品订单",0);
	ws.getSettings().setDefaultColumnWidth(15);
	ws.setColumnView(0,10);
	ws.setColumnView(1,15);
	ws.setColumnView(2,15);
	ws.setColumnView(3,15);
	ws.setColumnView(4,15);
	ws.setColumnView(5,10);
	ws.setColumnView(6,20);
	ws.setColumnView(7,15);
	ws.setColumnView(8,10);
	ws.setColumnView(9,20);

	Label label = new Label(0,0,"ID");
	ws.addCell(label);
	label = new Label(1,0,"省份");
	ws.addCell(label);
	label = new Label(2,0,"地区");
	ws.addCell(label);
	label = new Label(3,0,"联系人");
	ws.addCell(label);
	label = new Label(4,0,"电话");
	ws.addCell(label);
	label = new Label(5,0,"所属厂家");
	ws.addCell(label);
	label = new Label(6,0,"询价产品");
	ws.addCell(label);
	label = new Label(7,0,"所属分类");
	ws.addCell(label);
	label = new Label(8,0,"预计购买时间");
	ws.addCell(label);
	label = new Label(9,0,"询价时间");
	ws.addCell(label);

	String titlename="产品中心订单";
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-disposition","attachment; filename="+CommonDate.getToday("yyyyMMdd")+new String((titlename).getBytes("utf-8"),"iso8859-1")+".xls");
	if(null!=pro_List && pro_List.size()>0){
		Map oneMap = null ;
		for(int i=0;i<pro_List.size();i++){
			oneMap = pro_List.get(i) ;
			label = new Label(0,(i+1),CommonString.getFormatPara(oneMap.get("id"))) ;
			ws.addCell(label);
			label = new Label(1,(i+1),CommonString.getFormatPara(oneMap.get("province"))) ;
			ws.addCell(label);
			label = new Label(2,(i+1),CommonString.getFormatPara(oneMap.get("city"))) ;
			ws.addCell(label);
			label = new Label(3,(i+1),CommonString.getFormatPara(oneMap.get("name"))) ;
			ws.addCell(label);
			label = new Label(4,(i+1),CommonString.getFormatPara(oneMap.get("mobile_phone"))) ;
			ws.addCell(label);
			label = new Label(5,(i+1),CommonString.getFormatPara(oneMap.get("factoryname"))) ;
			ws.addCell(label);
			label = new Label(6,(i+1),CommonString.getFormatPara(oneMap.get("product_name"))) ;
			ws.addCell(label);
			label = new Label(7,(i+1), CommonString.getFormatPara(oneMap.get("cataname"))) ;
			ws.addCell(label);
			label = new Label(8,(i+1),CommonString.getFormatPara(buyTime.get(CommonString.getFormatPara(oneMap.get("buy_time")))) ) ;
			ws.addCell(label);
			label = new Label(9,(i+1),CommonString.getFormatPara(oneMap.get("add_date"))) ;
			ws.addCell(label);
		
		}
    }
	wwb.write();
	wwb.close();
	os.close();
	os = null ;
	response.flushBuffer();  
	out.clear();  
	out = pageContext.pushBody();
%>
