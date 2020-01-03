<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>

<%
	response.setContentType("text/html; charset=UTF-8");
	String randValue = Common.securityFilter(CommonString.getFormatPara(request.getParameter("rand"))).toLowerCase() ;
	String rand = Common.securityFilter(CommonString.getFormatPara(session.getAttribute("rand"))).toLowerCase() ;
	String telephone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_mobile_phone"))) ;  // 提交订单者电话
	if(telephone.equals("")){
		return;
	}
    String catalognum = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_catanum"))) ;
    String jr_product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_product_id")));  	
    if(telephone.equals("180")||telephone.equals("075588888888")||telephone.indexOf("8888888")>=0){return;}
	boolean telephoneResult=(telephone.replace("-","")).matches("[0-9]+");
	//获取询价的session信息
	int inquriyCount=0;
	String jr_message=CommonString.getFormatPara(request.getParameter("jr_message"));
	if(jr_message.contains("www")||jr_message.contains("http")){
		   out.println("<script>alert('您的留言内容存在敏感词汇，请重新输入!');history.back();</script>") ;
		   return ;
	}
	List<Integer> idList = new ArrayList<Integer>(0);
	Integer zhu_jian = 0;
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	String product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_product_id"))) ;  // 产品
	String jr_name = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_name"))) ;  // 提交订单者
	String uuids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("uuids"))) ;
	String province = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_province"))) ;
	String city = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_city"))) ;
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
		
		// 获得表名
		String tableName = Common.securityFilter(CommonString.getFormatPara(request.getParameter("tableName")));
		String idStr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_id")));
		String ids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("del_id")));
        if(1==1){// 增加或修改
			Enumeration params = request.getParameterNames();
			StringBuffer sqlback = new StringBuffer("(");
			StringBuffer sqlques = new StringBuffer("(");
			String name = "";
			String value = "";
               if(1==1) {// 增加
				email_productid = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_product_id"))) ;  // 获得该产品的id
				while (params.hasMoreElements()) {
					name = (String) params.nextElement();
					if (name.startsWith("jr_") && !name.endsWith("_txt_val")) {
						value = request.getParameter(name);
						sqlback.append(name.substring(name.indexOf("jr_") + 3));
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
					values.add("front_right");
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
