<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.InetAddress"%><%
	response.setContentType("text/html; charset=UTF-8");
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	String pro_id = CommonString.getFormatPara(request.getParameter("pro_id")) ;
	String if_tag = CommonString.getFormatPara(request.getParameter("if_tag")) ;
	//公用表前缀
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	//后置事件
	String eventAfter = CommonString.getFormatPara(request.getParameter("eventAfter"));
	//前置事件
	String eventBefore = CommonString.getFormatPara(request.getParameter("eventBefore"));
	//如果有前置事件
	if(!"".equals(eventBefore)){
		Common.doPostHttpAsync(Common.getDomain(request)+"/admin/action/before.jsp",request.getParameterMap());
	}
	StringBuffer sql = new StringBuffer();
	List values = new ArrayList(0);
	List into_values = new ArrayList(0) ;
	//验证码
	String rand = CommonString.getFormatPara(request.getParameter("rand"));
	if (null != rand && !"".equals(rand)) {
		String randStr = (String) session.getAttribute("rand");
		if (!rand.equals(randStr)) {
			out.print(2);
			return;
		}
	}
	Connection connection = null;
	int rs = 0;
	Map postMap = new HashMap();
	postMap.putAll(request.getParameterMap());
	if(null!=factoryInfo){
		postMap.put("uuid",factoryInfo.get("uuid"));
	}
	try{
		connection = dbHelper.getConnection();
		// 获得表名
		String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
		String idStr = CommonString.getFormatPara(request.getParameter("zd_id"));
		String ids = CommonString.getFormatPara(request.getParameter("del_id"));
		if (null != ids && ids.length() > 0) {// 删除
			
		} else {// 增加或修改
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
				if(!"".equals(pro_id) && !"undefined".equals(pro_id))  // 如果是导入产品中心
				{
					////system.out.println(pro_id) ;
					into_sql.append(" update pro_products set factoryname=?,introduce=?,paras=?,tonandmeter=?,uuid=?,name=?,catalogname=?,view_count=?,img2=?,factoryid=?"+
						 " where id = ? ");
					into_values.add(pro_id) ;
					rs = dbHelper.executeUpdate(into_sql.toString(), into_values.toArray(),connection);  // 更新导入的产品
				}else  if("1".equals(if_tag))// 插入产品中心一个新的产品
				{
					StringBuffer pro_values = new StringBuffer("'") ;
					into_values.remove(pro_id) ;
					Iterator iter = into_values.iterator() ;
					while(iter.hasNext())
					{
						pro_values.append((String)iter.next()+"','")  ;
					}
				     rs = dbHelper.execute(" insert into pro_products(factoryname,introduce,paras,tonandmeter,uuid,name,catalogname,view_count,img2,factoryid) values("+pro_values.toString().substring(0,pro_values.toString().length()-2)+")") ;
				}
				sql.append(" update " + tableName + " set "
						+ sqlback.toString() + " where id = ? ");
				values.add(idStr);
				if(null!=factoryInfo){
					postMap.put("keyId",idStr);
					postMap.put("logFlag","101002");
					postMap.put("usern",factoryInfo.get("usern"));
					//记录修改日志
					//Common.doPostHttpAsync(Common.getDomain(request)+"/admin/action/log.jsp",postMap);
				}
				rs = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection);  // 更新导入的产品
			} else {// 增加
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
				values.add(CommonString.getUUID());
				if(null!=factoryInfo){
					values.add(factoryInfo.get("usern"));
				}else{
					values.add("front");
				}
				values.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
				// values.add(Common.getIp(request,1)); 
				 values.add(request.getRemoteAddr()); 
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
				sql.append(" insert into " + tableName + sqlback.toString()
						+ " values " + sqlques.toString());
				Integer keyId = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection);

				postMap.put("keyId",keyId);
				if(null!=keyId&&keyId>0){
					rs = 1;
				}
				if(null!=factoryInfo){
					postMap.put("logFlag","101001");
					postMap.put("usern",factoryInfo.get("usern"));
					//记录增加日志
					//Common.doPostHttpAsync(Common.getDomain(request)+"/admin/action/log.jsp",postMap);
				}
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	//如果有后置事件
	if(!"".equals(eventAfter)){
		Common.doPostHttpAsync(Common.getDomain(request)+"/admin/action/after.jsp",postMap);
	}
	out.print(rs); 
%>