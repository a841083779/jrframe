<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*,com.jerehnet.wxpay.*"%>
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%@page import="com.jerehnet.wxpay.WXPayConstants.SignType" %>
<%@page import="com.jerehnet.alipay.util.*" %>

<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();

	String rs = "fail";
	String callback = CommonString.getFilterStr(request.getParameter("callback"));
	
	try{
		connection = dbHelper.getConnection(); 	

		//生成订单
		if("createOrder".equals(flag)){
			String createTime = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			String out_trade_no=System.currentTimeMillis()+RandomUtils.generateString(15);
			String name = CommonString.getFormatPara(request.getParameter("name")) ;
			String tel = CommonString.getFormatPara(request.getParameter("tel")) ;
			String source = CommonString.getFormatPara(request.getParameter("source")) ;
			String headUrl = CommonString.getFormatPara(request.getParameter("headUrl")) ;
			String nickName = CommonString.getFormatPara(request.getParameter("nickName")) ;
			String openId = CommonString.getFormatPara(request.getParameter("openId")) ;
			String price = CommonString.getFormatPara(request.getParameter("price")) ;
			String productId = CommonString.getFormatPara(request.getParameter("productId")) ;
			String productName = CommonString.getFormatPara(request.getParameter("productName")) ;
			
			int result=dbHelper.execute("insert into activity_sany_pay (add_date,source,head_url,nick_name,name,tel,price,product_id,product_name,order_no,order_state,open_id) "+
				" values('"+createTime+"','"+source+"','"+headUrl+"','"+nickName+"','"+name+"','"+tel+"',"+price+","+productId+",'"+productName+"','"+out_trade_no+"',0,'"+openId+"')",connection) ;  
				if(result==1){
					rs=out_trade_no;
				}else{
					rs="fail";
				}
			
		}
		if("updateOrder".equals(flag)){
			String out_trade_no=System.currentTimeMillis()+RandomUtils.generateString(15);
			String openId = CommonString.getFormatPara(request.getParameter("openId")) ;
			String productId = CommonString.getFormatPara(request.getParameter("productId")) ;
			
			int result=dbHelper.execute(" update activity_sany_pay set order_no2='"+out_trade_no+"' where order_state=1 and open_id='"+openId+"' and product_id=  "+productId,connection);
			if(result>0){
				rs=out_trade_no;
			}else{
				rs="fail";
			}
		}
		if("rankList".equals(flag)){
			String html="";String tel_deal="";String product_name="";int num=0;
			List<Map> list=dbHelper.getMapList(" select product_name,tel from activity_sany_pay where order_state=1  ",connection);
			if(list!=null&&list.size()>0){
				for(Map m:list){
					product_name=CommonString.getFormatPara(m.get("product_name"));
					tel_deal=CommonString.getFormatPara(m.get("tel")).substring(0,3)+"****"+CommonString.getFormatPara(m.get("tel")).substring(7,11);
						html +="<p>恭喜 "+tel_deal+"  成功预定三一重工"+product_name+" 1台！</p>";
				}
				if(list.size() > 2){
				  for(Map m:list){
					  if(num<2){
						  num++;
						  html +="<p>恭喜 "+tel_deal+"  成功预定三一重工"+product_name+" 1台！</p>";
					  }
				  }
			  }
			}
			rs=html;
			
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>