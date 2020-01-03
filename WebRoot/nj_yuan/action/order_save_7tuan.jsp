<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.codehaus.xfire.client.Client,com.jerehnet.util.common.Env,java.net.URL"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%
	response.setContentType("text/html; charset=UTF-8");
	String randValue = Common.securityFilter(CommonString.getFormatPara(request.getParameter("rand"))).toLowerCase() ;
	String rand = Common.securityFilter(CommonString.getFormatPara(session.getAttribute("rand"))).toLowerCase() ;
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer"))) ;
	String source = Common.securityFilter(CommonString.getFormatPara(request.getParameter("source"))) ;
	String if_tag = Common.securityFilter(CommonString.getFormatPara(request.getParameter("if_tag"))) ;
	

	
	
	String zd_message=CommonString.getFormatPara(request.getParameter("zd_message"));
	if(zd_message.contains("www")||zd_message.contains("http")){
			out.println("<script>alert('您的留言内容存在敏感词汇，请重新输入!');history.back();</script>") ;
		   return ;
	}
	List<Integer> idList = new ArrayList<Integer>(0);
	Integer zhu_jian = 0;
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	String product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))) ;  // 产品
	String zd_name = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_name"))) ;  // 提交订单者
	String telephone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))) ;  // 提交订单者电话
	if((zd_name.equals("") || telephone.equals(""))&& url.indexOf("showinqueryresult.jsp")==-1 && url.indexOf("/agent") == -1){
		out.println("<script>alert('请输入姓名和联系电话!');history.back();</script>") ;
		return;
	}
	String zd_contact_address = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_contact_address"))) ;
	String contact_addr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("contact_addr"))) ;
	String uuids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("uuids"))) ;
	String province = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_province"))) ;
	String city = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_city"))) ;
	// 新增预购买时间
	String buy_time = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_buy_time"))) ;
	// 个人或公司
	String ifgroup = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_ifgroup"))) ;  
	// 公司名字
	String company = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_company"))) ;
	String oneuuid = "" ;
	String[] orderuuid = null ;
	if(!"".equals(uuids) && uuids.length()>0){
		orderuuid = uuids.split(",") ;
	}
	String email_productid = "" ;// 发送邮件用的产品订单id
	String ontact_address="";
	String provinces=province;
	String citys=city;
	StringBuffer sql = new StringBuffer();
	StringBuffer sql1 = new StringBuffer();
	List values = new ArrayList(0);
	List into_values = new ArrayList(0) ;
	Connection connection = null;
	int rs = 0;
	Map postMap = new HashMap();
	postMap.putAll(request.getParameterMap());
	if(null!=adminInfo){
		postMap.put("uuid",adminInfo.get("uuid"));
	}
	
	//获取省市
	if(citys.equals("")&&provinces.equals("")){
	String urlString = "http://life.tenpay.com/cgi-bin/mobile/MobileQueryAttribution.cgi?chgmobile="+telephone;
	String responses = "";
	HttpURLConnection conn = null;
	try{
		URL _url = new URL(urlString);
		conn = (HttpURLConnection) _url.openConnection();
		conn.connect();
		InputStream is = conn.getInputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is,
				"gb2312"));
		String line = "";
		StringBuffer resultBuffer = new StringBuffer();
		while ((line = br.readLine()) != null) {
			resultBuffer.append(line);
		}
		br.close();
		is.close();
		responses = resultBuffer.toString();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(null!=conn){
			conn.disconnect();
		}
	}
        if(responses.indexOf("city")!=-1&&responses.indexOf("province")!=-1){
        	responses.replaceAll("<city>", "@").replace("</city>", "@");
        	responses.replaceAll("<province>", "#").replace("</province>", "#");
             city = responses.substring(responses.indexOf("<city>"),responses.lastIndexOf("</city>")).replace("<city>", "").trim();
             province = responses.substring(responses.indexOf("<province>"),responses.lastIndexOf("</province>")).replace("<province>", "").trim();
			 ontact_address=province+city;
        }
	}
	
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		//验证手机是否加入黑名单
		Map isB = dbHelper.getMap(" select tel from pro_product_form_blacklist where tel = '"+telephone+"' ");
		if(isB != null || zd_name.equals("on") || telephone.indexOf("'") >= 0 ){
			out.println("<script>alert('因该号码多次恶意询价已被加入黑名单，如有误，请联系客服0535-6792733!');window.close();</script>") ;
			return ;
		}
		
		if(zd_name.matches("[0-9]+")){			
			out.println("<script>alert('姓名请填写中英文不要填写纯数字，如有误，请联系客服0535-6792733!');window.close();</script>") ;
			return ;			
		}
		// 获得表名
		String tableName = Common.securityFilter(CommonString.getFormatPara(request.getParameter("tableName")));
		String idStr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_id")));
		String ids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("del_id")));
			Enumeration params = request.getParameterNames();
			String name = "";
			String value = "";
			StringBuffer sqlback = new StringBuffer("(");
			StringBuffer sqlques = new StringBuffer("(");
				email_productid = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))) ;  // 获得该产品的id
				while (params.hasMoreElements()) {
				name = (String) params.nextElement();
					if (name.startsWith("zd_") && !name.endsWith("_txt_val")) {
						value = request.getParameter(name);
						if (name.equals("zd_id")) {
							if(Env.getInstance().getProperty("dbtype").equals("mssql")){
								continue;
							}
							if(Env.getInstance().getProperty("dbtype").equals("mysql")){
								value = "0";
							}
						}
						sqlback.append(name.substring(name.indexOf("zd_") + 3));
						sqlback.append(",");
						sqlques.append("?,");
						if (null == value) {
							value = "";
						}
						values.add(value);
					}
				}
				oneuuid = CommonString.getUUID() ;
				values.add(oneuuid);
				if(null!=adminInfo){
					values.add(adminInfo.get("usern"));
				}else{
					values.add("front");
				}
				values.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
				values.add(Common.getIp(request,1));
				if(citys.equals("")&&provinces.equals("")){
				values.add(province);
				values.add(city);
				values.add(province+city);
				}
				sqlback.setLength(sqlback.length() - 1);
				sqlback.append(",uuid");
				sqlback.append(",add_user");
				sqlback.append(",add_date");
				sqlback.append(",add_ip");
				if(citys.equals("")&&provinces.equals("")){
				sqlback.append(",province");
				sqlback.append(",city");
				sqlback.append(",contact_address");
				}
				sqlback.append(")");
				sqlques.setLength(sqlques.length() - 1);
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				if(citys.equals("")&&provinces.equals("")){
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				}
				sqlques.append(")");
				sql.setLength(0);
				sql1.setLength(0);
				
				sql.append(" insert into pro_product_form " + sqlback.toString()+ " values " + sqlques.toString());
				Integer keyId = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection) ; 
				
				sql1.append(" insert into pro_product_form_leiqm " + sqlback.toString()+ " values " + sqlques.toString());
				
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title></title>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript">
	 // 询价成功，把用户名和电话放入 cookie 中
	 SetCookie("order_name",'<%=zd_name %>') ;
	 SetCookie("order_phone",'<%=telephone %>') ;
 
</script>
</head>
<body>
<div style="height:128px; width:500px; margin:200px auto; border:1px solid #EDD28B; background-color:#FFFDEE;">
    <%
		if(rs>0){
	%>
	<div style="float:left; padding-left:30px;">
		<img src="/images/Check.png" />
	</div>
	<div style="float:left; padding-left:20px; width:322px; font:bold 20px/128px 微软雅黑; color:#FF6600;">
		您的询价信息已成功提交！
	</div>
	<div style="clear:both;"></div>
	<%}else{%>
	<div style="float:left; padding-left:20px; width:322px; font:bold 20px/128px 微软雅黑; color:#FF6600;">
		信息提交失败,请重新提交！
	</div>
	<div style="clear:both;"></div>
	<%}%>
	
</div>
</body>
</html>
