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
<%@page import="java.io.InputStreamReader"%><%
	response.setContentType("text/html; charset=UTF-8");
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer"))) ;
	String source = Common.securityFilter(CommonString.getFormatPara(request.getParameter("source"))) ;
	//if(!randValue.equals(rand) && url.indexOf("showinqueryresult.jsp")==-1 && url.indexOf("/agent") == -1){  // 验证码不正确
		//out.println("<script>alert('请您输入正确的验证码!');history.back();</script>") ;
		//return ;
	//}
	String zd_message=CommonString.getFormatPara(request.getParameter("zd_message"));
	if(zd_message.contains("www")||zd_message.contains("http")){
			out.println("<script>alert('您的留言内容存在敏感词汇，请重新输入!');history.back();</script>") ;
		   return ;
	}
	List<Integer> idList = new ArrayList<Integer>(0);
	Integer zhu_jian = 0;
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	//String product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))) ;  // 产品
	String product_id = "21443";
	String zd_factoryname="";
	String zd_product_name="";
	String zd_cataname="";
    Map one_proform = dbHelper.getMap("  select  id,factoryname,catalogname,name from pro_products where id="+product_id);
	
	if(one_proform !=null && one_proform.get("id") != null){
	  zd_factoryname=CommonString.getFormatPara(one_proform.get("factoryname"));
	  zd_product_name=CommonString.getFormatPara(one_proform.get("name"));
	  zd_cataname=CommonString.getFormatPara(one_proform.get("catalogname"));
	}
	String if_tag = Common.securityFilter(CommonString.getFormatPara(request.getParameter("if_tag"))) ;
	String zd_name = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_name"))) ;  // 提交订单者
	String telephone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))) ;  // 提交订单者电话
	
	if((zd_name.equals("") || telephone.equals(""))){
		out.println("<script>alert('请输入姓名和联系电话!');history.back();</script>") ;
		return;
	}
	
	
	
	String zd_contact_address = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_contact_address"))) ;
	String contact_addr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("contact_addr"))) ;
	String uuids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("uuids"))) ;
	

	String province = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_province"))) ;
	String city = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_city"))) ;
	String zd_province="";String zd_city="";
	  
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
             zd_city = responses.substring(responses.indexOf("<city>"),responses.lastIndexOf("</city>")).replace("<city>", "").trim();
             zd_province = responses.substring(responses.indexOf("<province>"),responses.lastIndexOf("</province>")).replace("<province>", "").trim();
			 zd_contact_address=province+city;
        }
	
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
	//公用表前缀
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	//后置事件
	String eventAfter = Common.securityFilter(CommonString.getFormatPara(request.getParameter("eventAfter")));
	//前置事件
	String eventBefore = Common.securityFilter(CommonString.getFormatPara(request.getParameter("eventBefore")));
	//如果有前置事件
	if(!"".equals(eventBefore)){
		Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/before.jsp",request.getParameterMap());
	}
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
		Map isB = dbHelper.getMap(" select tel from pro_product_form_blacklist where tel = '"+telephone+"' ");
		if(isB != null || zd_name.equals("on") || telephone.indexOf("'") >= 0 ){
			out.println("<script>alert('因该号码多次恶意询价已被加入黑名单，如有误，请联系客服0535-6792733!');history.back();</script>") ;
			return ;
		}
		
		if(zd_name.matches("[0-9]+")){			
			out.println("<script>alert('姓名请填写中英文不要填写纯数字，如有误，请联系客服0535-6792733!');history.back();</script>") ;
			return ;			
		}
		
		
		// 获得表名
		String tableName = "pro_product_form";
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
					values.add("activity");
				}
				values.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
				values.add(Common.getIp(request,1));
				sqlback.setLength(sqlback.length() - 1);
				sqlback.append(",uuid");
				sqlback.append(",add_user");
				sqlback.append(",add_date");
				sqlback.append(",add_ip");
				sqlback.append(",province");
				sqlback.append(",city");
				sqlback.append(",contact_address");
				sqlback.append(")");
				sqlques.setLength(sqlques.length() - 1);
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",?");
				sqlques.append(",'"+zd_province+"'");
				sqlques.append(",'"+zd_city+"'");
				sqlques.append(",'"+zd_province+zd_city+"'");
				sqlques.append(")");
				sql.setLength(0);
				sql.append(" insert into " + tableName + sqlback.toString()+ " values " + sqlques.toString());
				Integer keyId = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection) ; // 
				zhu_jian = keyId;
				DwrPushOrderInfo dwrPushOrderInfo = new DwrPushOrderInfo() ;
				dwrPushOrderInfo.setOrderInfo(String.valueOf(keyId),request) ;
				
				
				postMap.put("keyId",keyId);
				if(null!=keyId&&keyId>0){
					rs = 1;
					/*代理商订单部分*/ 
					Map dai_li_order = new HashMap();
					dai_li_order.put("flag","product_order_to_agent");
					dai_li_order.put("source_id",keyId);
					dai_li_order.put("productId",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))));
					dai_li_order.put("factoryid",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_factoryid"))));
					dai_li_order.put("factoryname",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_factoryname"))));
					dai_li_order.put("province",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_province"))));
					dai_li_order.put("city",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_city"))));
					dai_li_order.put("contact_tel",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))));
					dai_li_order.put("ifgroup",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_ifgroup"))));
					dai_li_order.put("buy_time",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_buy_time"))));
					dai_li_order.put("message",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_message"))));
					dai_li_order.put("user_name",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_name"))));
					dai_li_order.put("company_name",Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_company"))));
					/*只有龙工,柳工，千里马几家代理商会自动推送订单*/

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
			out.println("<script>alert('询价成功!');history.back();</script>") ;

		%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript">

</script>
<%


	}else{
		if(null!=idList&&idList.size()>0){
			String rsStr = "";
			for(Integer id : idList){
				rsStr += id+",";
			}
			rsStr = rsStr.substring(0,rsStr.length()-1);
			out.println("<script>alert('询价失败!');history.back();</script>") ;
	
		}
	}

%>