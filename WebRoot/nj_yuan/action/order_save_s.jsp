<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%><%
 System.out.println("11111111111111");
	response.setContentType("text/html; charset=UTF-8");
	String randValue = Common.securityFilter(CommonString.getFormatPara(request.getParameter("rand"))).toLowerCase() ;
	String rand = Common.securityFilter(CommonString.getFormatPara(session.getAttribute("rand"))).toLowerCase() ;
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer"))) ;
	String source = Common.securityFilter(CommonString.getFormatPara(request.getParameter("source"))) ;
	String if_tag = Common.securityFilter(CommonString.getFormatPara(request.getParameter("if_tag"))) ;
	String telephone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))) ;  // 提交订单者电话
    String catalognum = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_catanum"))) ; 
    if(telephone.equals("075588888888")){return;}
	//获取询价的session信息
	int inquriyCount=0;
	if( session.getAttribute(Common.getIp(request,1))!=null){
	inquriyCount=(Integer) session.getAttribute(Common.getIp(request,1)) ;
	}
	//Map inqueryMap = session.getAttribute("inqueryMap");
    //if(inqueryMap!=null){sessionCount=CommonString.getFormatInt(memberInfo.get("inqueryCount"));}
	//else{inqueryMap = new HashMap();  inqueryMap.put("inqueryCount",0);  session.setAttribute("inqueryMap", inqueryMap);}

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
	 System.out.println("555555555");

	 System.out.println("66666666666");
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
	 System.out.println("44444444");
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
		 System.out.println("3333");
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
			    System.out.println("22222222222");
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
				sqlback.setLength(sqlback.length() - 1);
				sqlback.append(",uuid");
				sqlback.append(",add_user");
				sqlback.append(",add_date");
				sqlback.append(",add_ip");
				sqlback.append(")");
				sqlques.setLength(sqlques.length() - 1);
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
				
				//柳工履带式起重机会把订单直接短信发给柳工那边13605526829
				if(CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("136")&&CommonString.getFormatPara(request.getParameter("zd_catanum")).equals("102008")){
				try {
			 	Map root = new HashMap() ;
				root.put("phone","13605526829") ;
				root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(request.getParameter("zd_name"))+"，"+CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))+"，"+CommonString.getFormatPara(request.getParameter("zd_product_name"))) ;
				root.put("source","195002");
				//String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			    } catch (Exception e) {
			    }
				}
				
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
if(CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("135")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("136")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("192")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("137")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("182")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("190")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("152")){
					Common.doPostHttpAsync(Common.getDomain(request)+"/action/ajax.jsp",dai_li_order);
					}
					/*代理商订单部分*/
					if(product_id.equals("")){
					%>
                    	<script type="text/javascript"> 
						    parent.jQuery.jBox.tip("询价成功！") ;
    						parent.window.jBox.close();
                        </script>
                    <%
					}
				}
			}
		}else  // 一次提交2个产品订单
		{	
			String zd_province = Common.securityFilter(CommonString.getFormatPara(request.getParameter("province"))) ;
			String zd_city = Common.securityFilter(CommonString.getFormatPara(request.getParameter("city"))) ;
			String proids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("pro_ids"))) ;  // 二个产品的id
			String username = Common.securityFilter(CommonString.getFormatPara(request.getParameter("username"))) ;  // 提交者
			String tel = Common.securityFilter(CommonString.getFormatPara(request.getParameter("telephone"))) ;
			String today = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			String buyTime = Common.securityFilter(CommonString.getFormatPara(request.getParameter("buy_time"))) ;  // 购买两个产品时间
			String ifGroup = Common.securityFilter(CommonString.getFormatPara(request.getParameter("ifgroup"))) ;  // 个人或公司
			String Company = Common.securityFilter(CommonString.getFormatPara(request.getParameter("company"))) ;  // 公司名字
			String buy_type = Common.securityFilter(CommonString.getFormatPara(request.getParameter("buy_type"))) ;  // 付款方式
			int inquiry=0;
			String[] fourids = null ;
			Map tempproduct = null ;
			String insertsql = "" ;
			String ip = Common.getIp(request,1) ;
			if(!"".equals(proids) && proids.length()>0){
				fourids = proids.split(",") ;
				if(null != fourids && fourids.length>0 && null!=orderuuid){
					StringBuffer message =null ;
					for(int i=0;i<fourids.length;i++){
						message = new StringBuffer("您好，我对") ;
						tempproduct =dbHelper.getMap(" select * from pro_products where id="+fourids[i]) ;
						if(null != tempproduct && tempproduct.size()>0){
							message.append(""+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryname")))+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("name")))+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("catalogname")))+"感兴趣，想要咨询，请您给我回复，谢谢。") ;
							insertsql = " insert into pro_product_form(add_date,add_ip,catanum,factoryid,factoryname,cataname,name,contact_address,mobile_phone,product_id,uuid,product_name,message,province,city,buy_time,ifgroup,company,buy_type) values('"+today+"','"+ip+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("catalognum")))+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryid")))+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryname")))+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("catalogname")))+"','"+username+"','"+contact_addr+"','"+tel+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("id")))+"','"+orderuuid[i]+"','"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("name")))+"','"+message+"','"+zd_province+"','"+zd_city+"','"+buyTime+"','"+ifGroup+"','"+Company+"','"+buy_type+"') " ;
							rs = dbHelper.executeUpdate(insertsql);
							
			       			 //柳工履带式起重机会把订单直接短信发给柳工那边13605526829
				            if(CommonString.getFormatPara(tempproduct.get("factoryid")).equals("136")&&CommonString.getFormatPara(tempproduct.get("catalognum")).equals("102008")){
				            try {
			             	Map root = new HashMap() ;
				            root.put("phone","13605526829") ;
				            root.put("content","来自铁臂商城询价单，"+username+"，"+tel+"，"+CommonString.getFormatPara(tempproduct.get("name"))) ;
				            root.put("source","195002");
				            //String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			                }
				            }				
							
							// 发送邮件
							if(rs>0){
							    inquiry=1;
								idList.add(rs);
								/*代理商订单部分*/
								Map dai_li_order = new HashMap();
								dai_li_order.put("flag","product_order_to_agent");
								dai_li_order.put("source_id",rs);
								dai_li_order.put("productId",fourids[i]);
								dai_li_order.put("factoryid",Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryid"))));
								dai_li_order.put("factoryname",Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryname"))));
								dai_li_order.put("province",zd_province);
								dai_li_order.put("city",zd_city);
								dai_li_order.put("contact_tel",tel);
								dai_li_order.put("ifgroup",ifGroup);
								dai_li_order.put("buy_time",buyTime);
								dai_li_order.put("message",message);
								dai_li_order.put("user_name",username);
								dai_li_order.put("company_name",Company);
								/*只有龙工,柳工，千里马几家代理商会自动推送订单*/
if(CommonString.getFormatPara(tempproduct.get("factoryid")).equals("135")||CommonString.getFormatPara(tempproduct.get("factoryid")).equals("136")||CommonString.getFormatPara(tempproduct.get("factoryid")).equals("192")||CommonString.getFormatPara(tempproduct.get("factoryid")).equals("137")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("182")||CommonString.getFormatPara(request.getParameter("zd_factoryid")).equals("190")||CommonString.getFormatPara(tempproduct.get("factoryid")).equals("152")){
								Common.doPostHttpAsync(Common.getDomain(request)+"/action/ajax.jsp",dai_li_order);
								}
								/*代理商订单部分*/
							//	WEBEmail.sendMailByUrl("zhanghonglei.10@163.com","wanggq@21-sun.com",null,"testtttt","test","utf-8") ;
							}
						}
					}
				}
			}
			//寻单次数+1
			if(inquiry==1){session.setAttribute(Common.getIp(request,1),inquriyCount+1);}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	//如果有后置事件
	if(!"".equals(eventAfter)){
		Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/after.jsp",postMap);
	}
	if((rs>0 &&"".equals(if_tag) || !"fourorders".equals(if_tag))&& url.indexOf("/brand/")==-1&& url.indexOf("/agent/")==-1&&!product_id.equals("")){
		%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript">
	// 询价成功，把用户名和电话放入 cookie 中

	   //window.location.href = "/include/products/showinquerynewresult.jsp" ;
		 SetCookie("order_name",'<%=zd_name%>') ;
		 SetCookie("order_phone",'<%=telephone%>') ;
	 	 jQuery.post("/tools/email/order_email.jsp?productids=<%=email_productid%>&uuids=<%=oneuuid%>") ;
	 	 setTimeout(function(){
		 	 	window.location.href = "/include/products/showinqueryresult.jsp?productid=<%=product_id%>&name="+encodeURIComponent('<%=zd_name%>')+"&telephone=<%=telephone%>&zd_contact_address=<%=URLEncoder.encode(zd_contact_address,"utf-8")%>&province=<%=URLEncoder.encode(province,"utf-8")%>&city=<%=URLEncoder.encode(city,"utf-8")%>&buy_time=<%=buy_time%>&ifgroup=<%=ifgroup%>&company=<%=company%>&keyId=<%=zhu_jian %>&heshi=<%=Common.securityFilter(CommonString.getFormatPara(request.getParameter("heshi"))) %>&source=<%=source %>&rand=<%=rand%>" ;

	 	 },1000) ;
</script>
<%
      //如果是手机给短息提醒
      if(telephone.indexOf("-")==-1){
	  		try {
			 	Map root = new HashMap() ;
				root.put("phone",telephone) ;
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