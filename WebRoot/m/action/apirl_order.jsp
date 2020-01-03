<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%
	response.setContentType("text/html; charset=UTF-8");
    String orderIds = Common.securityFilter(CommonString.getFormatPara(request.getParameter("orderIds"))) ;
    String orderContact = Common.securityFilter(CommonString.getFormatPara(request.getParameter("orderContact"))) ;
	String message="需要预定的产品如下<br>";
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);	
           // 一次提交n个产品订单
			String proids = Common.securityFilter(CommonString.getFormatPara(request.getParameter("pro_ids"))) ;  // n个产品的id
			if(proids.equals("")){proids=orderIds;}
			proids=proids.substring(0,proids.length()-1);
			String[] fourids = null ;
			Map tempproduct = null ;
			String insertsql = "" ;
			String ip = Common.getIp(request,1) ;
			String tempId="";
			if(!"".equals(proids) && proids.length()>0){    
				fourids = proids.split(",") ;
				if(null != fourids && fourids.length>0&&fourids.length<=5 ){
				   
					for(int i=0;i<fourids.length;i++){
					if(fourids[i].equals("1")){tempId="20440";} if(fourids[i].equals("2")){tempId="20163";} if(fourids[i].equals("3")){tempId="20735";}
					if(fourids[i].equals("4")){tempId="10105";} if(fourids[i].equals("5")){tempId="15377";} if(fourids[i].equals("6")){tempId="20260";}
					if(fourids[i].equals("7")){tempId="7208";} if(fourids[i].equals("8")){tempId="5225";} if(fourids[i].equals("9")){tempId="7643";}
					if(fourids[i].equals("10")){tempId="10112";} if(fourids[i].equals("11")){tempId="20190";} if(fourids[i].equals("12")){tempId="12188";}
					if(fourids[i].equals("13")){tempId="883";} if(fourids[i].equals("14")){tempId="800";} if(fourids[i].equals("15")){tempId="10097";}
					if(fourids[i].equals("16")){tempId="853";} if(fourids[i].equals("17")){tempId="822";} if(fourids[i].equals("18")){tempId="4611";}
					if(fourids[i].equals("19")){tempId="3215";} if(fourids[i].equals("20")){tempId="787";} if(fourids[i].equals("21")){tempId="7170";}
					if(fourids[i].equals("22")){tempId="3799";} if(fourids[i].equals("23")){tempId="21057";} if(fourids[i].equals("24")){tempId="8866";}
					if(fourids[i].equals("25")){tempId="6912";} if(fourids[i].equals("26")){tempId="15785";} if(fourids[i].equals("27")){tempId="21133";}
					if(fourids[i].equals("28")){tempId="7886";} if(fourids[i].equals("30")){tempId="7889";} if(fourids[i].equals("31")){tempId="8302";}
					if(fourids[i].equals("32")){tempId="8105";} if(fourids[i].equals("33")){tempId="21101";} if(fourids[i].equals("34")){tempId="19859";}	
						tempproduct =dbHelper.getMap(" select * from pro_products where id="+tempId) ;
						if(null != tempproduct && tempproduct.size()>0){
                             message+="ID为"+tempId+"的产品，"+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("factoryname")))+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("name")))+Common.securityFilter(CommonString.getFormatPara(tempproduct.get("catalogname")))+"</br>";						
						}
					}
				}
			}
         if(null != fourids && fourids.length>0&&fourids.length<=5 ){
		 WEBEmail.sendMail("zengfc@21-sun.com,mujie@21-sun.com,yuxj@21-sun.com",null,"优买团4月预售订单",message+"联系方式:"+orderContact);
		 }else{
			 WEBEmail.sendMail("zengfc@21-sun.com",null,"优买团4月预售订单",message+"联系方式:"+orderContact);
		 }
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}

		%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript">
history.back();
</script>
<%

%>