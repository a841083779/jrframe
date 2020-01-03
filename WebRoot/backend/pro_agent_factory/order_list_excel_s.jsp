<%@page contentType="text/html;charset=utf-8" %>
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

        Calendar calendar = Calendar.getInstance();//此时打印它获取的是系统当前时间
        String today = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime())+" 16:00:00" ;
        calendar.add(Calendar.DATE, -1);    //得到前一天    
        String yesday = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()) +" 16:00:00";
	    // 获取选择的条件
		String orderby = " order by id desc" ;
		StringBuffer whereStr = new StringBuffer(" 1=1") ;
		String factoryId = CommonString.getFormatPara(request.getParameter("factoryId")) ; // 订单人
		String start_date = CommonString.getFormatPara(request.getParameter("cooperate_start_date")) ; // 开始时间
		String end_date = CommonString.getFormatPara(request.getParameter("cooperate_end_date")) ;  //
		String is_push = CommonString.getFormatPara(request.getParameter("is_push")); //是否为推送
		
		//其他
		String start_date_s = CommonString.getFormatPara(request.getParameter("start_date")) ; 
		String end_date_s = CommonString.getFormatPara(request.getParameter("end_date")) ;  
		String call_rs = CommonString.getFormatPara(request.getParameter("call_rs")) ; 
		String name = CommonString.getFormatPara(request.getParameter("name")) ;  
		String contact_address = CommonString.getFormatPara(request.getParameter("contact_address")) ;  
		String is_deal = CommonString.getFormatPara(request.getParameter("is_deal")) ;  
		String is_star = CommonString.getFormatPara(request.getParameter("is_star")) ;  
		String brand_series = CommonString.getFormatPara(request.getParameter("brand_series")) ;  
		String pro_condition = CommonString.getFormatPara(request.getParameter("pro_condition")) ;  
		String mobile_phone = CommonString.getFormatPara(request.getParameter("mobile_phone")) ;
		String cooperate = CommonString.getFormatPara(request.getParameter("cooperate")) ;  
		
		if(!"".equals(start_date_s))
		{
			whereStr.append(" and add_date>='"+start_date_s+" 00:00:00'") ;
		}
		if(!"".equals(end_date_s))
		{
			whereStr.append(" and add_date<='"+end_date_s+" 23:59:59'") ;
		}
        if(!"".equals(call_rs)) 
		{
			whereStr.append("  and call_rs_task2='"+call_rs+"' ") ;
		} 
		if(!"".equals(name)) 
		{
			whereStr.append("  and name like '%"+name+"%' ") ;
		}
		if(!"".equals(contact_address)) 
		{
			whereStr.append("  and contact_address like '%"+contact_address+"%' ") ;
		} 		
		if(!"".equals(is_deal)) 
		{
			whereStr.append("  and is_deal= "+is_deal) ;
		} 
		if(!"".equals(is_star)) 
		{
			whereStr.append("  and is_star= "+is_star) ;
		} 
		
		
        if(!"".equals(brand_series)) 
		{
			whereStr.append("  and brand_series='"+brand_series+"' ") ;
		} 
		if(!"".equals(pro_condition)) 
		{
			whereStr.append("  and pro_condition='"+pro_condition+"' ") ;
		} 
		if(!"".equals(mobile_phone)) 
		{
			whereStr.append("  and mobile_phone   like '%"+mobile_phone+"%' ") ;
		} 		
		
		
	    if(!"".equals(factoryId)) 
		{
			whereStr.append("  and is_deleted=0 ") ;
		} 
		if(!"".equals(factoryId)) 
		{
			whereStr.append(" and  factoryid= "+factoryId+"") ;
		}
		
		if(cooperate.equals("1")){
		if(!"".equals(start_date))
		{
			whereStr.append(" and add_date>='"+start_date+" 00:00:00'") ;
		}
		if(!"".equals(end_date))
		{
			whereStr.append(" and add_date<='"+end_date+" 23:59:59'") ;
		}
		}
		
		if(cooperate.equals("0")){
	
			whereStr.append(" and  (add_date<'"+start_date+" 00:00:00'  or  add_date>'"+end_date+" 23:59:59'  )") ;
	
	
	
	
		}
		
		 if(!"".equals(is_push)&&!"-1".equals(is_push)) 
		{
			whereStr.append(" and push_order = "+is_push+"") ;
		}
		pro_List = dbHelper.getMapList(" select id,province,city,name,mobile_phone,factoryname,product_name,cataname,buy_time,add_date,call_rs_task2,deal_factoryname,is_deal,brand_series,pro_condition,deal_proid,follow_content,special_remark,call_result1  from pro_product_form where "+whereStr.toString()+orderby+"") ;
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
	ws.setColumnView(10,20);
	ws.setColumnView(11,20);
	ws.setColumnView(12,20);
	ws.setColumnView(13,20);
	ws.setColumnView(14,20);
	ws.setColumnView(15,20);
	ws.setColumnView(16,20);
	ws.setColumnView(17,20);
	ws.setColumnView(18,20);
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
	label = new Label(10,0,"外呼情况");
	ws.addCell(label);
	label = new Label(11,0,"成交品牌");
	ws.addCell(label);
    label = new Label(12,0,"是否成交");
	ws.addCell(label);
	label = new Label(13,0,"品牌分类");
	ws.addCell(label);
	label = new Label(14,0,"新旧程度");
	ws.addCell(label);
	label = new Label(15,0,"成交型号");
	ws.addCell(label);
	label = new Label(16,0,"用户跟踪记录");
	ws.addCell(label);
	label = new Label(17,0,"回访记录");
	ws.addCell(label);
	label = new Label(18,0,"备注信息");
	ws.addCell(label);
	String titlename="产品中心推送订单";
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
			//第二次外呼
			String temp="";
			if(CommonString.getFormatPara(oneMap.get("call_rs_task2")).equals("106001")){temp="未外呼";}
			else if(CommonString.getFormatPara(oneMap.get("call_rs_task2")).equals("106002")){temp="已购机";}
			else if(CommonString.getFormatPara(oneMap.get("call_rs_task2")).equals("106003")){temp="联系中";}
			else if(CommonString.getFormatPara(oneMap.get("call_rs_task2")).equals("106004")){temp="不需要了";}
			else if(CommonString.getFormatPara(oneMap.get("call_rs_task2")).equals("106005")){temp="无效号码";}
			else if(CommonString.getFormatPara(oneMap.get("call_rs_task2")).equals("106006")){temp="无人接听";}
			else{temp="未外呼";}
			label = new Label(10,(i+1),temp) ;
			ws.addCell(label);
			//成交品牌
			if(temp.equals("已购机")){
			label = new Label(11,(i+1),CommonString.getFormatPara(oneMap.get("deal_factoryname"))) ;
			ws.addCell(label);
			}else{
			label = new Label(11,(i+1),"无") ;
			ws.addCell(label);
			}
			//是否成交
			temp="";
			if(CommonString.getFormatPara(oneMap.get("is_deal")).equals("1")){temp="是";}else{temp="否";}
			label = new Label(12,(i+1),temp) ;
			ws.addCell(label);
			//品牌分类
			temp="";
			if(CommonString.getFormatPara(oneMap.get("brand_series")).equals("108001")){temp="国产系";}
			if(CommonString.getFormatPara(oneMap.get("brand_series")).equals("108002")){temp="欧美系";}
			if(CommonString.getFormatPara(oneMap.get("brand_series")).equals("108003")){temp="日韩系";}
			if(CommonString.getFormatPara(oneMap.get("brand_series")).equals("108004")){temp="不确定";}
			label = new Label(13,(i+1),temp) ;
			ws.addCell(label);
			//新旧程度
			temp="";
			if(CommonString.getFormatPara(oneMap.get("pro_condition")).equals("109001")){temp="新机";}
			if(CommonString.getFormatPara(oneMap.get("pro_condition")).equals("109002")){temp="二手";}
			if(CommonString.getFormatPara(oneMap.get("pro_condition")).equals("109003")){temp="不确定";}
			label = new Label(14,(i+1),temp) ;
			ws.addCell(label);
			temp="";
			Map map=dbHelper.getMap(" select name from pro_products  where id=?",new Object[]{CommonString.getFormatPara(oneMap.get("deal_proid"))}) ;
			if(map!=null){temp=CommonString.getFormatPara(map.get("name"));}
			label = new Label(15,(i+1),temp) ;
			ws.addCell(label);
			//用户跟踪记录
			label = new Label(16,(i+1),CommonString.getFormatPara(oneMap.get("follow_content"))) ;
			ws.addCell(label);
			//回访记录
			label = new Label(17,(i+1),CommonString.getFormatPara(oneMap.get("special_remark"))) ;
			ws.addCell(label);
			label = new Label(18,(i+1),CommonString.getFormatPara(oneMap.get("call_result1"))) ;
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
