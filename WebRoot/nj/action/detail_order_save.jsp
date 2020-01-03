<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%
	response.setContentType("text/html; charset=UTF-8");
	String randValue = CommonString.getFormatPara(request.getParameter("rand")).toLowerCase() ;
	//String rand = CommonString.getFormatPara(session.getAttribute("rand")).toLowerCase() ;
	String if_tag = CommonString.getFormatPara(request.getParameter("if_tag")) ;
	String telephone = CommonString.getFormatPara(request.getParameter("zd_mobile_phone")) ;  // 提交订单者电话
    if(telephone.equals("180")||telephone.equals("075588888888")||telephone.indexOf("8888888")>=0){return;}
	boolean telephoneResult=(telephone.replace("-","")).matches("[0-9]+");
    if (telephoneResult != true) {return;}
	//获取询价的session信息
	int inquriyCount=0;
	if( session.getAttribute(Common.getIp(request,1))!=null){
	inquriyCount=(Integer) session.getAttribute(Common.getIp(request,1)) ;
	}
	String zd_message=CommonString.getFormatPara(request.getParameter("zd_message"));
	if(zd_message.contains("www")||zd_message.contains("http")){
			out.println("<script>alert('您的留言内容存在敏感词汇，请重新输入!');history.back();</script>") ;
		   return ;
	}
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	String product_id = CommonString.getFormatPara(request.getParameter("zd_product_id")) ;  // 产品

	String zd_name = CommonString.getFormatPara(request.getParameter("zd_name")) ;  // 提交订单者
	if(zd_name.equals("") || telephone.equals("")){
		out.println("<script>alert('请输入姓名和联系电话!');history.back();</script>") ;
		return;
	}
	String uuids = CommonString.getFormatPara(request.getParameter("uuids")) ;
	//String ip=request.getHeader("Cdn-Src-Ip");
	//if((ip.equals("")||ip==null)){
	//	if(!Common.getIp(request,1).equals("")&&Common.getIp(request,1)!=null){
	//	  ip=Common.getIp(request,1);
	//	}
	//}
	String province = CommonString.getFormatPara(request.getParameter("zd_province")) ;
	String city = CommonString.getFormatPara(request.getParameter("zd_city")) ;
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
		
		if(zd_name.matches("[0-9]+")){			
			out.println("<script>alert('姓名请填写中英文不要填写纯数字，如有误，请联系客服0535-6792733!');history.back();</script>") ;
			return ;			
		}
		
		
		// 获得表名
		String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
		String idStr = CommonString.getFormatPara(request.getParameter("zd_id"));
		String ids = CommonString.getFormatPara(request.getParameter("del_id"));
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
						value = CommonString.getFormatPara(request
								.getParameter(name));
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
				if(null!=adminInfo){
					postMap.put("keyId",idStr);
					postMap.put("logFlag","101002");
					postMap.put("usern",adminInfo.get("usern"));
					//记录修改日志
					Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/log.jsp",postMap);
				}
				rs = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection);  // 更新导入的产品
			} else {// 增加
				email_productid = CommonString.getFormatPara(request.getParameter("zd_product_id")) ;  // 获得该产品的id
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
				Integer keyId = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection) ;
				postMap.put("keyId",keyId);
				//寻单次数+1
				if(null!=keyId&&keyId>0){
                   //inqueryMap = session.getAttribute("inqueryMap");
				   session.setAttribute(Common.getIp(request,1),inquriyCount+1);
                }
				dbHelper.execute(" update pro_machine_products set inquiry_count = isnull(inquiry_count,0)+1 where id = ? ",new Object [] {email_productid},connection);
				
			}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}

   

	 
 
%>