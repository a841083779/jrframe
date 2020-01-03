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
	String zd_message=CommonString.getFormatPara(request.getParameter("zd_message"));

	List<Integer> idList = new ArrayList<Integer>(0);
	Integer zhu_jian = 0;
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	DBHelper dbHelper = DBHelper.getInstance();
	String product_id = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_product_id"))) ;  // 产品
	String zd_name = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_name"))) ;  // 提交订单者
	String telephone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))) ;  // 提交订单者电话

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

	StringBuffer sql = new StringBuffer();
	List values = new ArrayList(0);
	List into_values = new ArrayList(0) ;
	Connection connection = null;
	int rs = 0;

	try{
	    
		System.out.println("1234");
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
				if(null != fourids && fourids.length>0  ){
		 
					for(int i=0;i<fourids.length;i++){
				 
						tempproduct =dbHelper.getMap(" select name,catalog_num,catalog_name,brand_id,brand_name  from pro_machine_products where id="+fourids[i]) ;
						if(null != tempproduct && tempproduct.size()>0){
							String m="我对"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("brand_name")))+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("name")))+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("catalog_name")))+"感兴趣，想要咨询，请您给我回复，谢谢。" ;
							insertsql = " insert into pro_machine_products_inquiry(add_date,add_ip,add_user,name,mobile_phone,province,city,product_id,product_name,factoryid,factoryname,catanum,cataname,message,uuid ) values('"+today+"','"+ip+"','front','"+username+"','"+tel+"','"+zd_province+"','"+zd_city+"','"+fourids[i]+"','"+CommonString.getFormatPara(tempproduct.get("name"))+"','"+CommonString.getFormatPara(tempproduct.get("brand_id"))+"','"+CommonString.getFormatPara(tempproduct.get("brand_name"))+"','"+CommonString.getFormatPara(tempproduct.get("catalog_num"))+"','"+CommonString.getFormatPara(tempproduct.get("catalog_name"))+"','"+m+"','"+CommonString.getUUID()+"') " ;
							rs = dbHelper.executeUpdate(insertsql);
	
							

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

	if((rs>0 &&"".equals(if_tag) || !"fourorders".equals(if_tag))&& url.indexOf("/agent/")==-1&&!product_id.equals("")){
		%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript">
	      // 询价成功，把用户名和电话放入 cookie 中
		 SetCookie("order_name",'<%=zd_name%>') ;
		 SetCookie("order_phone",'<%=telephone%>') ;

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