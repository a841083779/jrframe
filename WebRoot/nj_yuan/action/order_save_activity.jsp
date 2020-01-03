<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%
	response.setContentType("text/html; charset=UTF-8");
	String randValue = Common.securityFilter(CommonString.getFormatPara(request.getParameter("rand"))).toLowerCase() ;
	String rand = Common.securityFilter(CommonString.getFormatPara(session.getAttribute("rand"))).toLowerCase() ;
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer"))) ;
	String source = Common.securityFilter(CommonString.getFormatPara(request.getParameter("source"))) ;
	String if_tag = Common.securityFilter(CommonString.getFormatPara(request.getParameter("if_tag"))) ;
	

	//获取询价的session信息
	int inquriyCount=0;
	if( session.getAttribute(Common.getIp(request,1))!=null){
	inquriyCount=(Integer) session.getAttribute(Common.getIp(request,1)) ;
	}

	
	List<Integer> idList = new ArrayList<Integer>(0);
	Integer zhu_jian = 0;
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	String product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))) ;  // 产品
	String zd_name = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_name"))) ;  // 提交订单者
	String zd_contact_tel = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_contact_tel"))) ;  // 提交订单者电话
	if((zd_name.equals("") || zd_contact_tel.equals(""))&& url.indexOf("showinqueryresult.jsp")==-1 && url.indexOf("/agent") == -1){
		out.println("<script>alert('请输入姓名和联系电话!');history.back();</script>") ;
		return;
	}
	String zd_contact_address = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_contact_address"))) ;
	String contact_addr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("contact_addr"))) ;
	String uuids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("uuids"))) ;
	String province = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_province"))) ;
	String city = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_city"))) ;
	
	String zd_factoryid = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_factoryid"))) ;
	String zd_catanum = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_catanum"))) ;
	String zd_product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))) ;
	System.out.println("zd_factoryid"+zd_factoryid);
	System.out.println("zd_catanum"+zd_catanum);
	System.out.println("zd_product_id"+zd_product_id);
	
	String ssql="select factoryid,factoryname,catalognum,catalogname,id,name from pro_products where id="+zd_product_id;
	List<Map<String,Object>> list = null ; 
    list = dbHelper.getMapList(ssql) ;
	
	String zd_factoryname=CommonString.getFormatPara(list.get(0).get("factoryname"));
	String zd_cataname=CommonString.getFormatPara(list.get(0).get("catalogname"));
	String zd_product_name=CommonString.getFormatPara(list.get(0).get("name"));
	

	String oneuuid = "" ;
	String[] orderuuid = null ;
	if(!"".equals(uuids) && uuids.length()>0){
		orderuuid = uuids.split(",") ;
	}
	String email_productid = "" ;// 发送邮件用的产品订单id
	//公用表前缀
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	
	StringBuffer sql = new StringBuffer();
	List values = new ArrayList(0);
	List into_values = new ArrayList(0) ;
	Connection connection = null;
	int rs = 0;
	Map postMap = new HashMap();
	postMap.putAll(request.getParameterMap());
	if(null!=adminInfo){
		postMap.put("uuid",adminInfo.get("uuid"));
	}
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		//验证手机是否加入黑名单
		Map isB = dbHelper.getMap(" select tel from pro_product_form_blacklist where tel = '"+zd_contact_tel+"' ");
		if(isB != null || zd_name.equals("on") || zd_contact_tel.indexOf("'") >= 0 ){
			out.println("<script>alert('因该号码多次恶意询价已被加入黑名单，如有误，请联系客服0535-6792733!');history.back();</script>") ;
			return ;
		}	
		if(zd_name.matches("[0-9]+")){			
			out.println("<script>alert('姓名请填写中英文不要填写纯数字，如有误，请联系客服0535-6792733!');history.back();</script>") ;
			return ;			
		}
				
		// 获得表名
		String tableName = Common.securityFilter(CommonString.getFormatPara(request.getParameter("tableName")));
		String idStr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_id")));
		String ids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("del_id")));
		if (null != ids && ids.length() > 0) {// 删除
			if(null!=adminInfo){
				postMap.put("logFlag","101003");
				postMap.put("usern",adminInfo.get("usern"));
			}
			sql.append("delete from " + tableName + " where uuid in (" + ids
					+ ") ");
			rs = dbHelper.execute(sql.toString(),connection);
		} else if("".equals(if_tag) || !"fourorders".equals(if_tag)){// 增加或修改
			Enumeration params = request.getParameterNames();
			StringBuffer sqlback = new StringBuffer("(");
			StringBuffer sqlques = new StringBuffer("(");
			String name = "";
			String value = "";
			if (null != idStr && !"".equals(idStr)) {// 修改
				sqlback = new StringBuffer();
				while (params.hasMoreElements()) {
					name = (String) params.nextElement();
					if (name.equals("zd_id")) {
						continue;
					}
					if (name.startsWith("zd_") && !name.endsWith("_txt_val")) {
						value = Common.securityFilter(CommonString.getFormatPara(request
								.getParameter(name)));
						sqlback.append(name.substring(name.indexOf("zd_") + 3)
								+ "=?,");
						if (null == value) {
							value = "";
						}
						values.add(value);
						if(!name.endsWith("flag") && !name.endsWith("import_pro_catalognum"))
						{
							into_values.add(value) ;
						}
					}
				}
				sqlback.setLength(sqlback.length() - 1);
				sql.setLength(0);
				StringBuffer into_sql = new StringBuffer("") ;
				sql.append(" update " + tableName + " set "
						+ sqlback.toString() + " where id = ? ");
				values.add(idStr);
				zhu_jian = CommonString.getFormatInt(idStr);
				if(null!=adminInfo){
					postMap.put("keyId",idStr);
					postMap.put("logFlag","101002");
					postMap.put("usern",adminInfo.get("usern"));
					//记录修改日志
					Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/log.jsp",postMap);
				}
				rs = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection);  // 更新导入的产品
			} else {// 增加
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
				
				values.add(zd_factoryname);
				values.add(zd_cataname);
				values.add(zd_product_name);
				
				
				sqlback.setLength(sqlback.length() - 1);
				sqlback.append(",uuid");
				sqlback.append(",add_user");
				sqlback.append(",add_date");
				sqlback.append(",add_ip");
				
				sqlback.append(",factoryname");
				sqlback.append(",cataname");
				sqlback.append(",product_name");
				
				
				sqlback.append(")");
				sqlques.setLength(sqlques.length() - 1);
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				
				sqlques.append(")");
				sql.setLength(0);
				sql.append(" insert into " + tableName + sqlback.toString()+ " values " + sqlques.toString());
				Integer keyId = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection) ; // 
				zhu_jian = keyId;
				DwrPushOrderInfo dwrPushOrderInfo = new DwrPushOrderInfo() ;
				dwrPushOrderInfo.setOrderInfo(String.valueOf(keyId),request) ;
				//寻单次数+1
				if(null!=keyId&&keyId>0){
                   //inqueryMap = session.getAttribute("inqueryMap");
				   session.setAttribute(Common.getIp(request,1),inquriyCount+1);
                }
				
				postMap.put("keyId",keyId);
				if(null!=keyId&&keyId>0){
				
				}
			}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	
	if((rs>0 &&"".equals(if_tag) || !"fourorders".equals(if_tag))&& url.indexOf("/agent/")==-1&&!product_id.equals("")){
		%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	// 询价成功，把用户名和电话放入 cookie 中
		 
                 SetCookie("order_name",'<%=zd_name%>') ;
		 SetCookie("order_phone",'<%=zd_contact_tel%>') ;
	 	 jQuery.post("/tools/email/order_email.jsp?productids=<%=email_productid%>&uuids=<%=oneuuid%>") ;
	 	 setTimeout(function(){
	 	 	//window.location.href = "/include/products/showinqueryresult.jsp?productid=<%=product_id%>&name="+encodeURIComponent('<%=zd_name%>')+"&telephone=<%=zd_contact_tel%>&zd_contact_address=<%=URLEncoder.encode(zd_contact_address,"utf-8")%>&province=<%=URLEncoder.encode(province,"utf-8")%>&city=<%=URLEncoder.encode(city,"utf-8")%>&keyId=<%=zhu_jian %>&heshi=<%=Common.securityFilter(CommonString.getFormatPara(request.getParameter("heshi"))) %>&source=<%=source %>&rand=<%=rand%>" ;
	 	     window.location.href="/activity/yuehuituan";
                      alert("报名成功！");
                     //jQuery.jBox.tip("报名成功！") ;
	 	 },1000) ;
</script>
<%
      
 //邮件推送提醒
      String cc="daifq@21-sun.com,sunyb@21-sun.com";
      String msg=province+city+"的"+zd_name+"（电话："+ zd_contact_tel  +"）,对"+ zd_factoryname+zd_cataname+zd_product_name  +"感兴趣，报名参加了铁臂约惠团的活动。";
      //WEBEmail.sendMail("douxp@21-sun.com",cc,"铁臂约惠团报名信息",msg);
      //cc="zengfc@21-sun.com,songlf@21-sun.com";
      WEBEmail.sendMail("douxp@21-sun.com",cc,"铁臂约惠团报名信息",msg);


//如果是手机给短息提醒
      if(zd_contact_tel.indexOf("-")==-1){
	  		try {
			 	Map root = new HashMap() ;
				root.put("phone",zd_contact_tel) ;
				root.put("content","您在铁臂商城的询价单已提交，厂家或代理商稍后会和您及时联系，祝您购机愉快！") ;
				root.put("source","195002");
				//String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			} catch (Exception e) {
			
			}
	  }

	}else{
		if(null!=idList&&idList.size()>0){
			String rsStr = "";
			for(Integer id : idList){
				rsStr += id+",";
			}
			rsStr = rsStr.substring(0,rsStr.length()-1);
			out.print(rsStr);
		}
	}
%>