<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%><%
	response.setContentType("text/html; charset=UTF-8");
	String randValue = CommonString.getFormatPara(request.getParameter("rand")).toLowerCase() ;

	
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer")));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String zd_name = CommonString.getFormatPara(request.getParameter("zd_name"));
	String zd_mobile_phone = CommonString.getFormatPara(request.getParameter("zd_mobile_phone"));
	if(zd_name.equals("") || zd_mobile_phone.equals("")){
		out.println("<script>alert('请输入姓名和联系电话!');history.back();</script>") ;
		return;
	}
	String zd_factoryid = CommonString.getFormatPara(request.getParameter("zd_factoryid"));
	String zd_factoryname = CommonString.getFormatPara(request.getParameter("zd_factoryname"));
	String zd_province = CommonString.getFormatPara(request.getParameter("zd_province"));
	String zd_city = CommonString.getFormatPara(request.getParameter("zd_city"));
	String zd_contact_address = CommonString.getFormatPara(request.getParameter("zd_contact_address"));
	String zd_ifgroup = CommonString.getFormatPara(request.getParameter("zd_ifgroup"));
	String zd_is_first = CommonString.getFormatPara(request.getParameter("zd_is_first"));
	String zd_product_ids = CommonString.getFormatPara(request.getParameter("zd_product_ids"));
	String zd_message = CommonString.getFormatPara(request.getParameter("zd_message"));
	String zd_product_name = "";
	String zd_catanum = "";
	String zd_cataname = "";
	
	int rs = 0;
	Integer zhu_jian = 0;
	String uuid = "";
	String email_productid = "";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	
	try{
		connection = dbHelper.getConnection();
		
		//验证手机是否加入黑名单
		Map isB = dbHelper.getMap(" select tel from pro_product_form_blacklist where tel = '"+zd_mobile_phone+"' ");
		if(isB != null || zd_name.equals("on") || zd_mobile_phone.indexOf("'") >= 0 ){
			out.println("phone") ;
			return ;
		}
		
		if(zd_name.matches("[0-9]+")){			
			out.println("name") ;
			return ;			
		}
		
		String[] productIds = zd_product_ids.split(",");
		for(String pid : productIds){
			email_productid = pid;
			uuid = UUID.randomUUID().toString();
			
			String query = "select name,catalognum,catalogname from pro_products where id=" + pid;
			Map pMap = dbHelper.getMap(query);
			if(pMap != null){
				zd_product_name = CommonString.getFormatPara(pMap.get("name"));
				zd_catanum = CommonString.getFormatPara(pMap.get("catalognum"));
				zd_cataname = CommonString.getFormatPara(pMap.get("catalogname"));
			}
			
			String pInsert = "insert into pro_product_form (uuid,add_ip,add_user,add_date,name,mobile_phone,factoryid,factoryname,province,city,contact_address,ifgroup,is_first,message,product_id,product_name,catanum,cataname) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			Object[] paras = { uuid, Common.getIp(request), "front", CommonDate.getToday("yyyy-MM-dd HH:mm:ss"), zd_name, zd_mobile_phone, zd_factoryid, zd_factoryname, zd_province, zd_city, zd_contact_address, zd_ifgroup, zd_is_first, zd_message, pid, zd_product_name, zd_catanum, zd_cataname };
			dbHelper.execute(pInsert, paras, connection);
		}
		
		rs = 1;
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	
	if(rs>0 ){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title></title>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript">
	 // 询价成功，把用户名和电话放入 cookie 中
	 SetCookie("order_name",'<%=zd_name %>') ;
	 SetCookie("order_phone",'<%=zd_mobile_phone %>') ;
 	 jQuery.post("/tools/email/order_email.jsp?productids=<%=email_productid%>&uuids=<%=uuid%>") ;
 	 
</script>
</head>
<body>
<div style="height:128px; width:500px; margin:20px auto; border:1px solid #EDD28B; background-color:#FFFDEE;">
	<div style="float:left; padding-left:30px;">
		<img src="/images/Check.png" />
	</div>
	<div style="float:left; padding-left:20px; width:322px; font:bold 20px/128px 微软雅黑; color:#FF6600;">
		您的询价信息已成功提交！
	</div>
	<div style="clear:both;"></div>
	
	<script type="text/javascript">
		setTimeout(function(){
	 	 	switch("<%=zd_factoryid %>"){
	 	 		case "174":
	 	 			window.location.href = "/products/prolist.jsp?factory=174&catalog=101001";
	 	 		break;
	 	 		case "138":
	 	 			window.location.href = "/products/prolist.jsp?factory=138&catalog=101002";
	 	 		break;
	 	 	}
	 	 },1000);
	</script>
</div>
<div style="display:none;">
	<script type="text/javascript">
		var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
		document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
	</script>
</div>
</body>
</html>
<%
	}
%>