<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%><%

	response.setContentType("text/html; charset=UTF-8");
	String randValue = Common.securityFilter(CommonString.getFormatPara(request.getParameter("rand"))).toLowerCase() ;
	String rand = Common.securityFilter(CommonString.getFormatPara(session.getAttribute("rand"))).toLowerCase() ;
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer"))) ;
	String source = Common.securityFilter(CommonString.getFormatPara(request.getParameter("source"))) ;
	String if_tag = Common.securityFilter(CommonString.getFormatPara(request.getParameter("if_tag"))) ;
	String telephone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))) ;  // 提交订单者电话
    String catalognum = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_catanum"))) ;
    String zd_product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id")));  	
    if(telephone.equals("180")||telephone.equals("075588888888")||telephone.indexOf("8888888")>=0){return;}
	boolean telephoneResult=(telephone.replace("-","")).matches("[0-9]+");
    if (telephoneResult != true) {return;}
    String the_ip=CommonString.getFormatPara(request.getHeader("Cdn-Src-Ip"));
	if(the_ip.equals("")&&!Common.getIp(request,1).equals("")){
		the_ip=Common.getIp(request,1);
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
	if((zd_name.equals("") || telephone.equals(""))&& url.indexOf("showinqueryresult.jsp")==-1 && url.indexOf("/agent") == -1){
		out.println("<script>alert('请输入姓名和联系电话!');history.back();</script>") ;
		return;
	}
	String zd_contact_address = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_contact_address"))) ;
	String contact_addr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("contact_addr"))) ;
	String uuids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("uuids"))) ;
	String province = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_province"))) ;
	String city = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_city"))) ;
	String buy_type = Common.securityFilter(CommonString.getFormatPara(request.getParameter("buy_type"))) ;  // 付款方式
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
				values.add(the_ip);
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
				postMap.put("keyId",keyId);
				if(null!=keyId&&keyId>0){
					rs = 1;
 
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
			 
						}
					}
				}
			}
			//寻单次数+1
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
<script src="http://script.v.jerei.com/recv.js" type="text/javascript"></script>
<script type="text/javascript">
		 SetCookie("order_name",'<%=zd_name%>') ;
		 SetCookie("order_phone",'<%=telephone%>') ;
	 	 setTimeout(function(){
		    var zd_catalognum='<%=catalognum%>';
			var zd_product_id='<%=zd_product_id%>';
            window.location.href = "/nj/include/products/showinqueryresult_s.jsp?productid=<%=product_id%>&name="+encodeURIComponent('<%=zd_name%>')+"&telephone=<%=telephone%>&zd_contact_address=<%=URLEncoder.encode(zd_contact_address,"utf-8")%>&province=<%=URLEncoder.encode(province,"utf-8")%>&city=<%=URLEncoder.encode(city,"utf-8")%>&buy_time=<%=buy_time%>&ifgroup=<%=ifgroup%>&company=<%=company%>&keyId=<%=zhu_jian %>&heshi=<%=Common.securityFilter(CommonString.getFormatPara(request.getParameter("heshi"))) %>&source=<%=source %>&rand=<%=rand%>" ; 		 		
	 	 },1000) ;
</script>
<%

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