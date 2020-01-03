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
		pro_List = dbHelper.getMapList(" select * from pro_product_form where add_date>='"+yesday+"' and add_date<='"+today+"' "+flag_400) ;
	}
	if("1".equals(if_tag))
	{
		// 获取选择的条件
		String orderby = "" ;
		StringBuffer whereStr = new StringBuffer(" 1=1 ") ;
		String name = CommonString.getFormatPara(request.getParameter("name")) ; // 订单人
		String start_date = CommonString.getFormatPara(request.getParameter("start_date")) ; // 开始时间
		String end_date = CommonString.getFormatPara(request.getParameter("end_date")) ;  //
		String factoryname = CommonString.getFormatPara(request.getParameter("factoryname")) ;
		String catanum = CommonString.getFormatPara(request.getParameter("catanum")) ;
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
		String product_name = CommonString.getFormatPara(request.getParameter("product_name")) ;
		String contact_address = CommonString.getFormatPara(request.getParameter("contact_address")) ;
		String state = CommonString.getFormatPara(request.getParameter("state")) ;
		String start_form_id  = CommonString.getFormatPara(request.getParameter("start_form_id")) ;
		String end_form_id = CommonString.getFormatPara(request.getParameter("end_form_id")) ;
		String orderbywhat = CommonString.getFormatPara(request.getParameter("orderbywhat")) ;
		String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;  // 所属分类
		
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
			whereStr.append(" and factoryid='"+factoryid+"'") ;
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
		String flag_400 = CommonString.getFormatPara(request.getParameter("flag_400"));
		if(!"".equals(flag_400)){
			whereStr.append(" and call_rs = '103002' ");
		}
		//system.out.println(whereStr+"--") ;
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
	String titlename="产品中心订单";
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-disposition","attachment; filename="+URLEncoder.encode(titlename, "UTF-8")+".xls");
%>
  <table width="100%" border="1" cellpadding="4" cellspacing="1" bgcolor="#000000" class="table_border_bg">
    <tr >
      <td height="20" align="center" nowrap bgcolor="#0000FF" class="title1"><strong class="list_border_bg STYLE1">ID</strong></td>
      <td colspan="2" nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>所在地区</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>所属厂家</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>所属分类</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>订购产品</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><strong class="list_border_bg STYLE1">订单人</strong></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>手机号码</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>预计购买时间</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>购买性质</strong></span></td>
      <!-- <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>固定电话</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>联系邮箱</strong></span></td> -->
      <td nowrap bgcolor="#0000FF" class="title1" colspan="4"><span class="STYLE1"><strong>留言内容</strong></span></td>
      <td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>订购时间</strong></span></td>
    </tr>
    <%
	Iterator iter = pro_List.iterator() ;
	while(iter.hasNext()){
		Map one_pro = (HashMap)iter.next() ;
%>
    <tr class="table_border_cell_bg" onMouseMove="mouseMove(this);" onMouseOut="mouseOut(this);">
      <td height="22" align="center" bgcolor="#FFFFFF" title=""><%=CommonString.getFormatPara(one_pro.get("id"))%></td>
      <td align="left" bgcolor="#FFFFFF" title="">[<%=CommonString.getFormatPara(one_pro.get("province"))%>]省</td>
      <td align="left" bgcolor="#FFFFFF" title="">[<%=CommonString.getFormatPara(one_pro.get("city"))%>]市</td>
      <td align="left" bgcolor="#FFFFFF" title=""><a href="/goto.jsp?flag=1&id=<%=CommonString.getFormatPara(one_pro.get("factoryid"))%>" target="_blank"><%=CommonString.getFormatPara(one_pro.get("factoryname"))%></a></td>
      <td height="22" align="left" bgcolor="#FFFFFF" title=""><%=CommonString.getFormatPara(one_pro.get("cataname"))%></td>
      <td align="left" bgcolor="#FFFFFF" title=""><a href="/webadmin/goto.jsp?flag=1&id=<%=CommonString.getFormatPara(one_pro.get("product_id"))%>" target="_blank"><%=CommonString.getFormatPara(one_pro.get("product_name"))%></a></td>
      <td height="22" align="left" bgcolor="#FFFFFF" title=""><%=CommonString.getFormatPara(one_pro.get("name"))%></td>
      <td align="left" bgcolor="#FFFFFF" title=""><%=CommonString.getFormatPara(one_pro.get("mobile_phone"))%></td>
        <td height="22" align="left" bgcolor="#FFFFFF" title="">[<%=CommonString.getFormatPara(((HashMap)application.getAttribute("enumMap")).get(CommonString.getFormatPara(one_pro.get("buy_time"))))%>]</td>
        <td height="22" align="left" bgcolor="#FFFFFF" title="">[<%=(CommonString.getFormatPara(one_pro.get("company")).equals("公司名字")||CommonString.getFormatPara(one_pro.get("company")).equals(""))?"个人":CommonString.getFormatPara(one_pro.get("company"))%>]</td>
      <td height="22" colspan="4"  bgcolor="#FFFFFF" title=""><%=CommonString.getFormatPara(one_pro.get("message"))%></td>
      <td height="22" align="left" bgcolor="#FFFFFF" title="">[<%=CommonString.getFormatPara(one_pro.get("add_date"))%>]</td>
    </tr>
    <%}%>
  </table>

</body>
</html>
