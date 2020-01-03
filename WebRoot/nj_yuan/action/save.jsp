<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>

<%
	response.setContentType("text/html; charset=UTF-8");
	String randValue = Common.securityFilter(CommonString.getFormatPara(request.getParameter("rand"))).toLowerCase() ;
	String rand = Common.securityFilter(CommonString.getFormatPara(session.getAttribute("rand"))).toLowerCase() ;
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer"))) ;
	String source = Common.securityFilter(CommonString.getFormatPara(request.getParameter("source"))) ;
	String if_tag = Common.securityFilter(CommonString.getFormatPara(request.getParameter("if_tag"))) ;
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
	String jr_contact_address = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_contact_address"))) ;
	String contact_addr = Common.securityFilter(CommonString.getFormatPara(request.getParameter("contact_addr"))) ;
	String uuids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("uuids"))) ;
	String province = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_province"))) ;
	String city = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_city"))) ;
	String buy_type = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_buy_type"))) ;  // 付款方式
	// 新增预购买时间
	String buy_time = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_buy_time"))) ;
	// 个人或公司
	String ifgroup = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_ifgroup"))) ;  
	// 公司名字
	String company = Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_company"))) ;
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
		Map isB = dbHelper.getMap(" select tel from pro_product_form_blacklist where tel = '"+telephone+"' ");
		if(isB != null || jr_name.equals("on") || telephone.indexOf("'") >= 0 ){
			out.println("<script>alert('因该号码多次恶意询价已被加入黑名单，如有误，请联系客服0535-6792733!');history.back();</script>") ;
			return ;
		}
		if(jr_name.matches("[0-9]+")){			
			out.println("<script>alert('姓名请填写中英文不要填写纯数字，如有误，请联系客服0535-6792733!');history.back();</script>") ;
			return ;			
		}
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
				System.out.println(sql.toString());
				Integer keyId = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection) ; // 
				zhu_jian = keyId;
				DwrPushOrderInfo dwrPushOrderInfo = new DwrPushOrderInfo() ;
				dwrPushOrderInfo.setOrderInfo(String.valueOf(keyId),request) ;
				//寻单次数+1
				if(null!=keyId&&keyId>0){
				   session.setAttribute(Common.getIp(request,1),inquriyCount+1);
                }
				
				//柳工履带式起重机会把订单直接短信发给柳工那边13605526829
				if(CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("136")&&CommonString.getFormatPara(request.getParameter("jr_catanum")).equals("102008")){
				try {
			 	Map root = new HashMap() ;
				root.put("phone","13605526829") ;
				root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(request.getParameter("jr_name"))+"，"+CommonString.getFormatPara(request.getParameter("jr_mobile_phone"))+"，"+CommonString.getFormatPara(request.getParameter("jr_product_name"))) ;
				root.put("source","195002");
				String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
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
					dai_li_order.put("productId",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_product_id"))));
					dai_li_order.put("factoryid",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_factoryid"))));
					dai_li_order.put("factoryname",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_factoryname"))));
					dai_li_order.put("province",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_province"))));
					dai_li_order.put("city",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_city"))));
					dai_li_order.put("contact_tel",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_mobile_phone"))));
					dai_li_order.put("ifgroup",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_ifgroup"))));
					dai_li_order.put("buy_time",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_buy_time"))));
					dai_li_order.put("message",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_message"))));
					dai_li_order.put("user_name",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_name"))));
					dai_li_order.put("company_name",Common.securityFilter(CommonString.getFormatPara(request.getParameter("jr_company"))));
					/*只有龙工,柳工，千里马几家代理商会自动推送订单*/
if(CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("135")||CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("136")||CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("192")||CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("137")||CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("182")||CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("190")||CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("152")||CommonString.getFormatPara(request.getParameter("jr_factoryid")).equals("134")){
					Common.doPostHttpAsync(Common.getDomain(request)+"/action/ajax.jsp",dai_li_order);
					}
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
	Map map = new HashMap();
	Map newmap= new HashMap();
	map.put("product_id",product_id);
	map.put("productid",product_id);
	map.put("name",jr_name);
    map.put("telephone",telephone);
	map.put("zd_contact_address",jr_contact_address);
	map.put("province",province);
    map.put("city",city);
	map.put("buy_time",buy_time);
	map.put("buy_type",buy_type);
	Common.doPostHttpAsync("http://product.21-sun.com/action/detail_result.jsp",map);
	Common.doPostHttpAsync("http://product.21-sun.com/tools/email/order_email.jsp?productids="+product_id+"&uuids="+oneuuid,newmap);


%>
