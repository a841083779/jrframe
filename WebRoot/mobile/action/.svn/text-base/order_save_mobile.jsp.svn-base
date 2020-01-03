<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%><%
	response.setContentType("text/html; charset=UTF-8");
	
	List<Integer> idList = new ArrayList<Integer>(0);
	Integer zhu_jian = 0;
	DBHelper dbHelper = DBHelper.getInstance();
	String product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))) ;  // 产品
	String zd_name = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_name"))) ;  // 提交订单者
	String telephone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))) ;  // 提交订单者电话
	if(zd_name.equals("") || telephone.equals("")){
		out.println("-1"); //请留下您的姓名及联系电话
		return;
	}
	// 新增预购买时间
	String buy_time = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_buy_time"))) ;
	// 个人或公司
	String ifgroup = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_ifgroup"))) ;  
	// 公司名字
	String company = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_company"))) ;
	String oneuuid = "" ;
	StringBuffer sql = new StringBuffer();
	List values = new ArrayList(0);
	List into_values = new ArrayList(0);
	Connection connection = null;
	int rs = 0;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		
		Object file_name_obj = dbHelper.getOne("select file_name from pro_products where id=" + product_id, connection);
		String referer = "http://product.21-sun.com/proDetail/" + file_name_obj.toString();
		
		//验证手机是否加入黑名单
		Map isB = dbHelper.getMap(" select tel from pro_product_form_blacklist where tel = '"+telephone+"' ");
		if(isB != null || zd_name.equals("on") || telephone.indexOf("'") >= 0 ){
			out.println("-2"); //因该号码多次恶意询价已被加入黑名单，如有误，请联系客服0535-6792733!
			return ;
		}
		
		if(zd_name.matches("[0-9]+")){			
			out.println("-3"); //姓名请填写中英文不要填写纯数字，如有误，请联系客服0535-6792733!
			return ;			
		}
		
		// 获得表名
		String tableName = Common.securityFilter(CommonString.getFormatPara(request.getParameter("tableName")));
		String idStr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_id")));
		
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
					if(!name.endsWith("flag") && !name.endsWith("import_pro_catalognum")){
						into_values.add(value) ;
					}
				}
			}
			sqlback.setLength(sqlback.length() - 1);
			sql.setLength(0);
			StringBuffer into_sql = new StringBuffer("") ;
			sql.append(" update " + tableName + " set " + sqlback.toString() + " where id = ? ");
			values.add(idStr);
			zhu_jian = CommonString.getFormatInt(idStr);
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
			oneuuid = CommonString.getUUID() ;
			values.add(oneuuid);
			values.add("front_mobile");
			values.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
			values.add(Common.getIp(request,1));
			values.add(referer);
			sqlback.setLength(sqlback.length() - 1);
			sqlback.append(",uuid");
			sqlback.append(",add_user");
			sqlback.append(",add_date");
			sqlback.append(",add_ip");
			sqlback.append(",referer");
			sqlback.append(")");
			sqlques.setLength(sqlques.length() - 1);
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
				//System.out.println("---代理商订单111") ;
				Common.doPostHttpAsync(Common.getDomain(request)+"/action/ajax.jsp",dai_li_order);
				/*代理商订单部分*/
			}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	
	out.println(rs);
%>