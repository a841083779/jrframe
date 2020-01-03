<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.common.*"%>
<%@page import="java.util.*"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="com.jerehnet.mobile.action.*"%>
<%  	
    System.out.println("进入邮件111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
	request.setCharacterEncoding("utf-8");
	String productids = CommonString.getFormatPara(request.getParameter("productids")); // 获得产品id
	String uuids = CommonString.getFormatPara(request.getParameter("uuids")); // 订单表单中的uuid
	String factoryid = "";
	DBHelper dbHelper = DBHelper.getInstance();
	String[] productid = null;
	String[] uuid = null;
	String province = null ;
	String catanum = null ;
    String jr_proname="";
    String jr_uuid="";
					String jr_catalogname= "" ;
			        String jr_factoryname="" ;
			        String jr_proid= "" ;
	//产品信息
	String pro_name="";
	int pro_id=0;
	String jr_message="";
	
	int new_formid=0;

	if (!"".equals(uuids)) {
		uuid = uuids.split(",");
		if (null != uuid && uuid.length == 2) { // 二个产品
		
		System.out.println("两个产品");
		
			for (int i = 0; i < uuid.length; i++) {
				Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid[i] + "'");	
				if (null != one_proform) {
					//  因牟总要求我们做三一、斗山线上活动，3.18日之前邮件停发湖南、
					// 山东所有品牌挖掘机的询价信息，请您协助设置处理，谢谢。
					String city = null;
	                String cata_name = null;
				    province = CommonString.getFormatPara(one_proform.get("province")) ;
					catanum = CommonString.getFormatPara(one_proform.get("catanum")) ;
					city = CommonString.getFormatPara(one_proform.get("city")) ;
					cata_name= CommonString.getFormatPara(one_proform.get("cataname")) ;
					if((province.indexOf("湖南")!=-1 || province.indexOf("山东")!=-1) && catanum.indexOf("101001")!=-1){
						return ;
					}
					factoryid = CommonString.getFormatPara(one_proform.get("factoryid")); // 获得品牌id		
					  jr_catalogname= CommonString.getFormatPara(one_proform.get("cataname")) ;
			          jr_factoryname= CommonString.getFormatPara(one_proform.get("factoryname")) ;
			          jr_proid= CommonString.getFormatPara(one_proform.get("product_id")) ;
			         jr_proname=CommonString.getFormatPara(one_proform.get("product_name")) ;
			          jr_uuid= CommonString.getFormatPara(one_proform.get("uuid")) ;
			        
					//如果是挖掘机的某些品牌就给卡特复制出一条订单
			        if(catanum.indexOf("101001001")>=0){
						if(1==2){
						Map proMap = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
						int tonandmeter=0;
                        if(proMap!=null){
						   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
						}
						Map pushProMap=null;
						if(tonandmeter<=10&&tonandmeter>0){
							if(tonandmeter<=2){
								//pushProMap= new HashMap();
								//pushProMap.put("id","23915");
								//pushProMap.put("name","301.7D CR");
							}else if(tonandmeter<=4){
								//pushProMap= new HashMap();
								//pushProMap.put("id","21525");
								//pushProMap.put("name","303.5E CR");
							}else if(tonandmeter<=6){
								//pushProMap= new HashMap();
								//pushProMap.put("id","4561");
								//pushProMap.put("name","305.5E");
							}else if(tonandmeter<8){
								//pushProMap= new HashMap();
								//pushProMap.put("id","20163");
								//pushProMap.put("name","307E");
							}else{
								//pushProMap= new HashMap();
								//pushProMap.put("id","21514");
								//pushProMap.put("name","308E");
							}
						}else if(tonandmeter>10&&tonandmeter<=30){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (9548,400,9550,445,11366,390,3503) order by newid()");
						}else if(tonandmeter>30){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (3525,19946,9551,522,403,9552,9553,407,9554,9555) order by newid()  " );
						}
						if(pushProMap!=null){
							 pro_id=CommonString.getFormatInt(pushProMap.get("id"));
							 pro_name=CommonString.getFormatPara(pushProMap.get("name"));
							 jr_message="我对卡特彼勒"+pro_name+"感兴趣，请联系我";
						}
			            String sqlCopyString = "insert into pro_product_form(";
			            sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
			            sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,174,'卡特彼勒',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+CommonString.getUUID()+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",uuid,buy_type";
			            sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid[i]+"'";
						if(pushProMap!=null){
			            dbHelper.execute(sqlCopyString);	
						}
						}
			       } 
				   //临工挖掘机某些牌订单推送
				   if("101001001".equals(catanum)){
						//三一133，徐工209，龙工135，厦工139，山推144，山河智能142，斗山192，雷沃141，柳工136，约翰迪尔14238，中联134，山工138，英轩1777
						if(factoryid.equals("133")||factoryid.equals("209")||factoryid.equals("135")||factoryid.equals("139")||factoryid.equals("144")||factoryid.equals("142")||factoryid.equals("192")||factoryid.equals("141")||factoryid.equals("136")||factoryid.equals("14238")||factoryid.equals("134")||factoryid.equals("138")||factoryid.equals("1777")){
							Map proMap = dbHelper.getMap(" select  tonandmeter from pro_products   where  id= "+jr_proid );
							int tonandmeter=0;String procatanum="";
							if(proMap!=null){
							   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
							}
							Map pushProMap=null;
							String whereStr="";
							if(tonandmeter<=3){//微挖
								whereStr+=" and tonandmeter <=3 ";
							}
							if(tonandmeter>4 && tonandmeter<8){//小挖
								whereStr+=" and tonandmeter >4 and tonandmeter<8 ";
							}
							if(tonandmeter>=8 && tonandmeter<15){//中小挖
								whereStr+=" and tonandmeter >=8 and tonandmeter<15 ";
							}
							if(tonandmeter>=15 && tonandmeter<25){//中挖
								whereStr+=" and tonandmeter >=15 and tonandmeter<25 ";
							}
							if(tonandmeter>=25 && tonandmeter<35){//中大挖
								whereStr+=" and tonandmeter >=25 and tonandmeter<35 ";
							}
							if(tonandmeter>=35 ){//大挖
								whereStr+=" and tonandmeter >35 ";
							}
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							//System.out.println("***************"+" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							if(pushProMap!=null){
								pro_id=CommonString.getFormatInt(pushProMap.get("id"));
								pro_name=CommonString.getFormatPara(pushProMap.get("name"));
								jr_message="我对山东临工"+pro_name+"感兴趣，请联系我";
								String tempUid=CommonString.getUUID();
								String sqlCopyString = "insert into pro_product_form(";
								sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
								sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,137,'山东临工',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tempUid+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",'',buy_type";
								sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid[i]+"'";
								int cat_id=dbHelper.execute(sqlCopyString);	
						   }
						}
				   }  
				   //临工装载机某些牌订单推送
				   if(catanum.equals("101002007")){
						//三一133，徐工209，龙工135，厦工139，山推144，山河智能142，斗山192，雷沃141，柳工136，约翰迪尔14238，中联134，山工138，英轩1777
						if(factoryid.equals("133")||factoryid.equals("209")||factoryid.equals("135")||factoryid.equals("139")||factoryid.equals("144")||factoryid.equals("142")||factoryid.equals("192")||factoryid.equals("141")||factoryid.equals("136")||factoryid.equals("14238")||factoryid.equals("134")||factoryid.equals("138")||factoryid.equals("1777")){
							Map proMap = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
							int tonandmeter=0;String procatanum="";
							if(proMap!=null){
							   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
							}
							Map pushProMap=null;
							String whereStr="";
							if(tonandmeter<3){//小装
								whereStr+=" and tonandmeter <3 ";
							}
							if(tonandmeter==3 ){//3T
								whereStr+=" and tonandmeter =3 ";
							}
							if(tonandmeter==5 ){//5T
								whereStr+=" and tonandmeter =5 ";
							}
							if(tonandmeter>5 ){//5T以上
								whereStr+=" and tonandmeter >5 ";
							}
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							//System.out.println("***************"+" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							if(pushProMap!=null){
								pro_id=CommonString.getFormatInt(pushProMap.get("id"));
								pro_name=CommonString.getFormatPara(pushProMap.get("name"));
								jr_message="我对山东临工"+pro_name+"感兴趣，请联系我";
								String tempUid=CommonString.getUUID();
								String sqlCopyString = "insert into pro_product_form(";
								sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
								sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,137,'山东临工',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tempUid+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",'',buy_type";
								sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid[i]+"'";
								int cat_id=dbHelper.execute(sqlCopyString);	
						   }
						}
				   } 
				//如果是徐工的给三一复制一份		  
                    if ("209".equals(factoryid)&&1==2) {
			  	       	Map sanyProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  is_show=1 and  factoryid=133  and catalognum like '%"+catanum+"%' order by view_count desc");
                      	if(sanyProMap!=null){
						int sany_pro_id=CommonString.getFormatInt(sanyProMap.get("id"));
						String sany_pro_name=CommonString.getFormatPara(sanyProMap.get("name"));
						String sany_jr_message="我对三一"+sany_pro_name+"感兴趣，请联系我";
						String sany_tempUid=CommonString.getUUID();
			            String sqlCopyString = "insert into pro_product_form(";
			            sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
			            sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,133,'三一',0,agentname,catanum,cataname,name,email,company,"+sany_pro_id+",'"+sany_pro_name+"',contact_address,contact_tel,'"+sany_jr_message+"',state,province,city,mobile_phone,view_count,'"+sany_tempUid+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",'',buy_type";
			            sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid[i]+"'";
			            dbHelper.execute(sqlCopyString);	

						}  
		            }
 		 //宝鼎订单邮件提醒		  
          if ("13570".equals(factoryid)) {
			  			WEBEmail.sendMailByUrl("156955048@qq.com", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
		  }
			

            //徐工随车订单邮件
            /*
 		    if ("135".equals(factoryid)&&catanum.equals("102006")) {
 		                WEBEmail.sendMailByUrl("lirk@xcmg.com", "", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
 		    }
           */
				  
		    //龙工订单邮件
			if ("135".equals(factoryid)&&1==2) {
		
						
						
						//大装
						if(catanum.indexOf("101002")>=0&&!jr_proid.equals("804")&&!jr_proid.equals("787")&&!jr_proid.equals("4397")&&!jr_proid.equals("7539")&&!jr_proid.equals("7588")&&!jr_proid.equals("15874")&&!jr_proid.equals("15875")&&!jr_proid.equals("21541")&&!jr_proid.equals("21539")&&!jr_proid.equals("15873")&&!jr_proid.equals("15872")){
						
						WEBEmail.sendMailByUrl("scb@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						try {
			                Map root = new HashMap() ;
				            root.put("phone","15960333311") ;
				            root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				            root.put("source","195002");
				            String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			            } catch (Exception e) {}
						
						}
						//叉车
						if(catanum.indexOf("107")>=0){
							
						WEBEmail.sendMailByUrl("salescc@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						try {
			                Map root = new HashMap() ;
				            root.put("phone","13611663580") ;
				            root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				            root.put("source","195002");
				            String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			            } catch (Exception e) {}
						
						}
						//路面机械和小装
						if(catanum.indexOf("106")>=0||jr_proid.equals("804")||jr_proid.equals("787")||jr_proid.equals("4397")||jr_proid.equals("7539")||jr_proid.equals("7588")||jr_proid.equals("15874")||jr_proid.equals("15875")||jr_proid.equals("21541")||jr_proid.equals("21539")||jr_proid.equals("15873")||jr_proid.equals("15872")){
				
						WEBEmail.sendMailByUrl("wxc@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						try {
			                Map root = new HashMap() ;
				            root.put("phone","13512100228") ;
				            root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				            root.put("source","195002");
				            String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			            } catch (Exception e) {}
						
						
						}
						//旋挖钻、推土机
						if(catanum.equals("105003")||catanum.indexOf("101003")>=0){

						WEBEmail.sendMailByUrl("57644948@163.com", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						
						}
						
						
						//挖掘机
						if(catanum.indexOf("101001")>=0){
						WEBEmail.sendMailByUrl("cxj@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						}
			}
			
						
			//信达订单邮件
			if ("1235".equals(factoryid)) {
				    

						WEBEmail.sendMailByUrl("327844026@qq.com", "zengfc@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
			}
			
			//临工订单邮件
			/**if ("137".equals(factoryid)) {
				    String lingongEmail="yuqing.sun@sdlg.com.cn";

						WEBEmail.sendMailByUrl(lingongEmail, "wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
			}**/
			//洋马订单邮件
			if ("191".equals(factoryid)) {
				    String ymEmail="jun_yao@yanmar.com";
						WEBEmail.sendMailByUrl(ymEmail, "qimeng_hu@yanmar.com,wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
			}
			
			//德基订单邮件
			if ("489".equals(factoryid)) {
				    try { 
							Map root1 = new HashMap() ;  
							root1.put("title","德基订单") ;   
							root1.put("content",CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"的"+CommonString.getFormatPara(one_proform.get("name"))+"询价"+CommonString.getFormatPara(one_proform.get("factoryname"))+ CommonString.getFormatPara(one_proform.get("product_name"))+ CommonString.getFormatPara(one_proform.get("catalogname"))+",电话:"+CommonString.getFormatPara(one_proform.get("mobile_phone"))) ;  
							root1.put("to","info@dgmachinery.com,zengfc@21-sun.com");
							Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sendmail.jsp",root1);
					} catch (Exception e) {
					}
			}
			//金土地订单邮件
			if ("16859".equals(factoryid)) {
				    try { 
							Map root1 = new HashMap() ;  
							root1.put("title","金土地订单") ;   
							root1.put("content",CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"的"+CommonString.getFormatPara(one_proform.get("name"))+"询价"+CommonString.getFormatPara(one_proform.get("factoryname"))+ CommonString.getFormatPara(one_proform.get("product_name"))+ CommonString.getFormatPara(one_proform.get("catalogname"))+",电话:"+CommonString.getFormatPara(one_proform.get("mobile_phone"))) ;  
							root1.put("to","452708008@qq.com,zengfc@21-sun.com,wangyn@jerei.com");
							Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sendmail.jsp",root1);
					} catch (Exception e) {
					}
			}
			//柳工订单发送
			if ("136".equals(factoryid)&&!province.equals("江苏")&&!province.equals("云南")&&!province.equals("贵州")) {
				/*
			    if(catanum.indexOf("101001")>=0){
						WEBEmail.sendMailByUrl("zengpy@liugong.com", null, null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
				}else if(catanum.indexOf("101002")>=0){
						WEBEmail.sendMailByUrl("luqy@liugong.com", null, null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
				}else {
						WEBEmail.sendMailByUrl("sales@liugong.com", null, null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
				}*/
			}
			

			
			
					//把来自日立的订单发送给客户
					if ("184".equals(factoryid)&&1==2) {
						
						String phone_to_agent="";
						if(province.indexOf("山东")!=-1||province.indexOf("河北")!=-1||province.indexOf("北京")!=-1||province.indexOf("天津")!=-1){
						WEBEmail.sendMailByUrl("x.wang.zd@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						
						phone_to_agent="13501639342,13601626163,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						
						if(province.indexOf("山西")!=-1){
						WEBEmail.sendMailByUrl("y.xu.dz@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");	
						phone_to_agent="13817806260,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						
						if(province.indexOf("陕西")!=-1){
						WEBEmail.sendMailByUrl("x.shi.zz@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="13761411735,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
				
				
						if(province.indexOf("甘肃")!=-1||province.indexOf("青海")!=-1||province.indexOf("西藏")!=-1){
						WEBEmail.sendMailByUrl("j.wang.pn@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="13636606985,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
				
				
						if(province.indexOf("江苏")!=-1||province.indexOf("上海")!=-1){
						WEBEmail.sendMailByUrl("y.liu.ie@hitachi-kenki.com,x.gu.ib@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="15900908726,13817813937,13601626163,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
				
				
						if(province.indexOf("安徽")!=-1||province.indexOf("湖北")!=-1||province.indexOf("河南")!=-1||province.indexOf("江西")!=-1){
						WEBEmail.sendMailByUrl("y.hou.wm@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="18217781711,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
				
				
						if(province.indexOf("浙江")!=-1 ){
						WEBEmail.sendMailByUrl("j.sun.mo@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="15921435230,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	

						
						if(province.indexOf("福建")!=-1||province.indexOf("新疆")!=-1 ){
						WEBEmail.sendMailByUrl("b.jiang.ig@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="13761970327,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
						
					
						if(province.indexOf("辽宁")!=-1||province.indexOf("吉林")!=-1||province.indexOf("黑龙江")!=-1 ){
						WEBEmail.sendMailByUrl("x.chen.dz@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="15821506125,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
						
						if(province.indexOf("内蒙古")!=-1||CommonString.getFormatPara(one_proform.get("city")).indexOf("银川")!=-1 ){
						WEBEmail.sendMailByUrl("p.wang.zk@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="13817304023,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
				
						
				        if(province.indexOf("重庆")!=-1||CommonString.getFormatPara(one_proform.get("city")).indexOf("成都")!=-1){
						WEBEmail.sendMailByUrl("x.yang.dx@hitachi-kenki.com,s.yu.gl@hitachi-kenki.com,c.zhao.qf@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="13917875217,13816301854,13585827632,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	

						if(province.indexOf("云南")!=-1){
						WEBEmail.sendMailByUrl("x.lu.ja@hitachi-kenki.com,j.shen.rg@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="13918345015,13818965857,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}							
						
						
						if(province.indexOf("广东")!=-1||province.indexOf("海南")!=-1||province.indexOf("广西")!=-1||province.indexOf("湖南")!=-1){
						WEBEmail.sendMailByUrl("y.li.nx@hitachi-kenki.com,l.li.vg@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="13681989075,13761981051,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
						
						
						if(province.indexOf("贵州")!=-1){
						WEBEmail.sendMailByUrl("y.zhang.ki@hitachi-kenki.com,j.shen.rg@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						phone_to_agent="15801775671,13818965857,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
					
					
					} 
					else if ("174".equals(factoryid)) { // 卡特挖掘机订单推送接口
						Map proMaps = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
                        int tonandmeters=0;
                        if(proMaps!=null){
			                tonandmeters=CommonString.getFormatInt(proMaps.get("tonandmeter"));
		                }
				        if(tonandmeters!=0&&tonandmeters<10){
				            //Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat_admin_auto_normal.jsp?uuid=" + uuids, one_proform);
				         }else{
					        Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat_admin.jsp?uuid=" + uuids, one_proform);
				         }
				    } 
					else if ("133".equals(factoryid)) { // 三一订单推送接口
						Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/sany_admin.jsp?uuid=" + uuids, one_proform);
						
					} else if ("138".equals(factoryid)) { // 山工挖掘机订单推送接口
						//Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/shangong_admin.jsp?uuid=" + uuids, one_proform);
					} else if ("209".equals(factoryid)) { // 徐工单独发送邮件
				         Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/xcmg_admin.jsp?uuid=" + uuids, one_proform);
					} else if (!"".equals(factoryid)) {
						Map one_factory = dbHelper.getMap(" select email,id from pro_agent_factory where id ='" + factoryid + "'");
						String emails = CommonString.getFormatPara(one_factory.get("email"));
						String email_id =CommonString.getFormatPara(one_factory.get("id"));

						if (!"".equals(emails) && emails.indexOf(",") != -1 && emails.indexOf("@") != -1&&!email_id.equals("1113")&&!email_id.equals("1112")) {
						
						} else {
							if(!email_id.equals("1113")&&!email_id.equals("1112")){
							WEBEmail.sendMailByUrl(emails, null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
									+ CommonString.getFormatPara(one_proform.get("product_name"))
									+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
									"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						     }
 
						}
					}
		 
							
		//app订单自动推送
		jr_message="我对你的产品感兴趣，请联系我";
		String person_id="0";
		String usern="";
		String agent_id="";
		String areaNum="0000000000";
		Map areaMap = dbHelper.getMap(" select  area_id   from comm_area   where parent_area_id !=129250 and  area_name like '%"+CommonString.getFormatPara(one_proform.get("city"))+"%' " );
        if(areaMap!=null){
		    areaNum=CommonString.getFormatPara(areaMap.get("area_id"));
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("鞍山市")){
			areaNum="120260";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("马鞍山")){
			areaNum="101940";
		}
		//wyn 20190528
		if(CommonString.getFormatPara(one_proform.get("city")).equals("大连")){
			areaNum="123230";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("宿迁")){
			areaNum="112040";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("凯里")){
			areaNum="132680";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("北京")){
			areaNum="105499";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("天津")){
			areaNum="105689";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("重庆")){
			areaNum="105879";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("大同")){
			areaNum="108420";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("思茅")){
			areaNum="137600";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("博乐")){
			areaNum="117780";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("锡林浩特")){
			areaNum="110660";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("上海")){
			areaNum="105290";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("吉林")){
			areaNum="119120";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("衡阳")){
			areaNum="126270";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("抚顺县")){
			areaNum="120340";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("巴州")){
			areaNum="117600";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("克州")){
			areaNum="117550";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("集宁")){
			areaNum="110470";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("海拉尔")){
			areaNum="110260";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("东胜")){
			areaNum="110180";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("临河")){
			areaNum="110390";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("长临河镇")){
			areaNum="102320";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("海口")){
			areaNum="141510";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("潢川县")){
			areaNum="131430";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("眉山")){
			areaNum="140260";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("朝阳县")){
			areaNum="121000";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("江汉")){
			areaNum="124010";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("海淀")){
			areaNum="105500";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("六安")){
			areaNum="102900";
		}
		
		List<Map> agentList =null;
		if(!CommonString.getFormatPara(one_proform.get("factoryid")).equals("")&&!CommonString.getFormatPara(one_proform.get("factoryid")).equals("0")){
			dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+CommonString.getFormatPara(one_proform.get("factoryid"))+"%'  and  city_num like '%"+areaNum+"%'" );
		}
		if(factoryid.equals("182")){//小松
			//agentList=dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and   agent_fac  like '%"+factoryid+"%'  " );
			if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("陕西")>=0){
		         agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=319 " );
		    }else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("河南")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=18351 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("江苏")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=370 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("烟台")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("威海")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("青岛")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=18940 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("日照")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("济宁")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("临沂")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("枣庄")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("菏泽")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("潍坊")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("淄博")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("滨州")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("东营")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("济南")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("泰安")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("德州")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("聊城")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=18945 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("安徽")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=340 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("广东")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=237 " );
			}else{
				 agentList=null;
			}
		}
        //三一的做产品控制
		if(factoryid.equals("133")){
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")!=-1){
			}else{
			agentList=null;	
			}
		}
		//吉尼的做产品控制
		if(factoryid.equals("16855")||factoryid.equals("1524")){
			agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=16855 " );
		}
		//山推挖机的不推送
		if(factoryid.equals("152")){
			agentList = null;
		}
        //英轩写死
		if(factoryid.equals("1777")){
			//英轩暂时停止
			 if(CommonString.getFormatPara(one_proform.get("name")).indexOf("D")>=0||CommonString.getFormatPara(one_proform.get("name")).indexOf("L")>=0||CommonString.getFormatPara(one_proform.get("name")).indexOf("T")>=0||CommonString.getFormatPara(one_proform.get("name")).indexOf("W")>=0){
		         agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=16776 " );
		     }else{
				 agentList=null;
			 }
		}

	    //龙工的做下类别判断
		if(factoryid.equals("135")){
		    //龙工装载机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")!=-1){
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16350  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//龙工推土机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16349 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//龙工挖掘机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16348 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}			
			//龙工旋挖钻
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("105003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16347  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//龙工路面机械
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("106001")!=-1){
				if(province.indexOf("浙江")>=0||province.indexOf("上海")>=0||province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("河北")>=0||province.indexOf("西藏")>=0||province.indexOf("新疆")>=0||province.indexOf("贵州")>=0||province.indexOf("青海")>=0||province.indexOf("甘肃")>=0||province.indexOf("云南")>=0){
					//一部分给装载机
					agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16350  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
				    //agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			    }else{
					//一部分给叉车
					agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
				}
			}
			//龙工叉车
		    if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("106001")!=-1||CommonString.getFormatPara(one_proform.get("catanum")).indexOf("107")!=-1||CommonString.getFormatPara(one_proform.get("catanum")).indexOf("118004")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			agentList=null;
		}
		//雷沃做下判断
		if(factoryid.equals("141")&&1==2){
			//挖掘机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")!=-1){	
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=14245  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//装载机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")!=-1){	
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=14244  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}				
		}
        //山推别的系的不推送	
	    if(factoryid.equals("144")&&CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")==-1){	
		    agentList=null;
		}	
        //柳工推土机的判断
		if(factoryid.equals("136")){
			agentList=null;
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101003")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16658 " );
			}
			//else{
			//	agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id!=16658  and  is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+CommonString.getFormatPara(one_proform.get("factoryid"))+"%'  and  city_num like '%"+areaNum+"%'" );
			//}
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18866 " );
			}
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")>=0||CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101005")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18865 " );
			}
		}
		if(factoryid.equals("209") ){//徐工基础		
			agentList=null;
			if(jr_catalogname.indexOf("钻机")>=0||jr_catalogname.indexOf("连续墙")>=0||jr_catalogname.indexOf("水平定向钻")>=0||jr_catalogname.indexOf("采煤机")>=0||jr_catalogname.indexOf("掘进机")>=0){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16860 " );
			}
		}
		if(factoryid.equals("142") ){//山河智能机型判断		
			agentList=null;
			if(jr_catalogname.indexOf("挖掘机")>=0){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18869 " );
			}
			if(jr_catalogname.indexOf("旋挖钻")>=0){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18863 " );
			}
		}
		//临工 订单宝推送wyn
		if(factoryid.equals("137")){
            agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18845 " );
		    if("102003".equals(CommonString.getFormatPara(one_proform.get("catanum")))){
				agentList=null;
			}
			if(jr_proid.equals("10068")||jr_proid.equals("7182")){
				agentList=null;
			}
		}
		//徐工随车起重机代理商
	    if(factoryid.equals("209")&&CommonString.getFormatPara(one_proform.get("catanum")).equals("102006")){	
		     agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18938 " );
		}
		
		if(null!=agentList&&agentList.size() > 0){
		for(Map mm : agentList){
        usern="";	person_id="0";	   
		agent_id=CommonString.getFormatPara(mm.get("id"));
		List<Map> list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id!=171 and  agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});
		//龙工的做下类别判断
		if(factoryid.equals("135")){
		    //龙工几款装载机
			if(jr_proid.equals("7592")||jr_proid.equals("7609")||jr_proid.equals("7608")||jr_proid.equals("7607")||jr_proid.equals("21539")||jr_proid.equals("21541")||jr_proid.equals("15875")||jr_proid.equals("15874")||jr_proid.equals("15872")||jr_proid.equals("7588")||jr_proid.equals("7539")||jr_proid.equals("4397")||jr_proid.equals("7538")||jr_proid.equals("21540")||jr_proid.equals("7584")||jr_proid.equals("7586")||jr_proid.equals("7585")||jr_proid.equals("7587")||jr_proid.equals("7589")||jr_proid.equals("7590")||jr_proid.equals("768")||jr_proid.equals("763")||jr_proid.equals("766")){
				list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});		
			}else{
				list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id!=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});		
			}
			if(province.indexOf("浙江")>=0||province.indexOf("上海")>=0||province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("河北")>=0||province.indexOf("西藏")>=0||province.indexOf("新疆")>=0||province.indexOf("贵州")>=0||province.indexOf("青海")>=0||province.indexOf("甘肃")>=0||province.indexOf("云南")>=0){
			    if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("106001")!=-1){
					list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});		
				}
			}
			list=null;
		}
		if(null!=list){
				for(Map m : list){			  
				   String nums=CommonString.getFormatPara(m.get("city_num"));
				   if(!nums.equals("")){
				      String  []citys=nums.split(",");
					  if(citys.length>0){
					        for(int ii=0;ii<citys.length;ii++){
					              Map areaInfo = dbHelper.getMap(" select   area_name from comm_area   where area_id = ? ",new Object [] {citys[ii]});
                                     if(areaInfo!=null){
									    if(CommonString.getFormatPara(one_proform.get("city")).equals(CommonString.getFormatPara(areaInfo.get("area_name")))||CommonString.getFormatPara(one_proform.get("city")).indexOf(CommonString.getFormatPara(areaInfo.get("area_name")))>=0|| CommonString.getFormatPara(areaInfo.get("area_name")).indexOf(CommonString.getFormatPara(one_proform.get("city")))>=0){
														    person_id=CommonString.getFormatPara(m.get("id"));
															usern=CommonString.getFormatPara(m.get("usern"));
															break;
										}
									 }								  
                            }
					    }
				    }
				}				
		}
		
		
		
			//雷沃的特殊人群做一些判断
			if(agent_id.equals("16840")){
			if(cata_name.indexOf("装载")>=0&&(province.indexOf("天津")>=0||city.indexOf("廊坊")>=0||city.indexOf("保定")>=0||city.indexOf("沧州")>=0||city.indexOf("石家庄")>=0||city.indexOf("邢台")>=0||city.indexOf("邯郸")>=0||city.indexOf("衡水")>=0)){
				person_id="482";
				usern="ligq";
			}
			if(cata_name.indexOf("挖掘")>=0&&province.indexOf("上海")>=0 ){
				person_id="506";
				usern="cheyj";
			}
			if( (cata_name.indexOf("装载")>=0&&province.indexOf("上海")>=0) || province.indexOf("浙江")>=0 ){
				person_id="499";
				usern="wangfw";
			}
			if((city.indexOf("济宁")>=0||city.indexOf("泰安")>=0||city.indexOf("聊城")>=0||city.indexOf("菏泽")>=0||city.indexOf("莱芜")>=0||city.indexOf("济南")>=0||city.indexOf("德州")>=0)||(city.indexOf("滨州")>=0&&cata_name.indexOf("装载")>=0)){
				person_id="504";
				usern="lily";
			}
			if((city.indexOf("青岛")>=0||city.indexOf("日照")>=0||city.indexOf("潍坊")>=0||city.indexOf("烟台")>=0||city.indexOf("威海")>=0||city.indexOf("临沂")>=0||city.indexOf("东营")>=0||city.indexOf("枣庄")>=0||city.indexOf("淄博")>=0)||(city.indexOf("滨州")>=0&&cata_name.indexOf("挖掘")>=0)){
			    person_id="503";
				usern="zhaonb";
			}
			
			if((province.indexOf("北京")>=0)||(province.indexOf("天津")>=0&&cata_name.indexOf("挖掘")>=0)||(city.indexOf("承德")>=0||city.indexOf("张家口")>=0||city.indexOf("唐山")>=0||city.indexOf("秦皇岛")>=0)||(city.indexOf("廊坊")>=0&&cata_name.indexOf("挖掘")>=0)||(city.indexOf("保定")>=0&&cata_name.indexOf("挖掘")>=0)){
			    person_id="501";
				usern="chengh";
			}
			}
		
			if(factoryid.equals("136")){
				if(catanum.indexOf("101002")>=0){//装载机
					if(province.indexOf("北京")>=0||province.indexOf("天津")>=0||city.indexOf("唐山")>=0){
						person_id="711";
					}
					if(province.indexOf("山西")>=0||(province.indexOf("河北")>=0 && city.indexOf("唐山")<0)){
						person_id="712";
					}
					if(province.indexOf("陕西")>=0||province.indexOf("宁夏")>=0){
						person_id="713";
					}
					if(province.indexOf("山东")>=0||province.indexOf("河南")>=0){
						person_id="724";
					}
					if(province.indexOf("福建")>=0||province.indexOf("江苏")>=0||city.indexOf("温州")>=0||city.indexOf("宁波")>=0||city.indexOf("绍兴")>=0||city.indexOf("舟山")>=0||city.indexOf("丽水")>=0||city.indexOf("台州")>=0){
						person_id="714";
					}
					if(province.indexOf("广东")>=0||province.indexOf("海南")>=0){
						person_id="715";
					}
					if(province.indexOf("云南")>=0||province.indexOf("贵州")>=0){
						person_id="716";
					}
					if(province.indexOf("四川")>=0||province.indexOf("重庆")>=0){
						person_id="717";
					}
					if(province.indexOf("西藏")>=0||province.indexOf("青海")>=0){
						person_id="718";
					}
					if(province.indexOf("广西")>=0||province.indexOf("湖南")>=0){
						person_id="719";
					}
					if(province.indexOf("新疆")>=0||province.indexOf("甘肃")>=0){
						person_id="720";
					}
					if(province.indexOf("内蒙古")>=0){
						person_id="721";
					}
					if(province.indexOf("黑龙江")>=0||province.indexOf("吉林")>=0||province.indexOf("辽宁")>=0||province.indexOf("安徽")>=0){
						person_id="722";
					}
					if(province.indexOf("湖北")>=0||province.indexOf("江西")>=0||province.indexOf("上海")>=0||city.indexOf("金华")>=0||city.indexOf("衢州")>=0||city.indexOf("杭州")>=0||city.indexOf("湖州")>=0||city.indexOf("嘉兴")>=0){
						person_id="723";
					}
				}
				if(catanum.indexOf("101005002")>=0){//平地机
					if(province.indexOf("贵州")>=0||province.indexOf("四川")>=0||province.indexOf("云南")>=0||province.indexOf("西藏")>=0||province.indexOf("重庆")>=0||province.indexOf("陕西")>=0||province.indexOf("甘肃")>=0||province.indexOf("宁夏")>=0||province.indexOf("青海")>=0||province.indexOf("新疆")>=0){
						person_id="727";
					}
					if(province.indexOf("内蒙")>=0||province.indexOf("山西")>=0||province.indexOf("河南")>=0||province.indexOf("河北")>=0){
						person_id="728";
					}
					if(province.indexOf("山东")>=0||province.indexOf("江苏")>=0||province.indexOf("浙江")>=0||province.indexOf("福建")>=0||province.indexOf("安徽")>=0){
						person_id="729";
					}
					if(province.indexOf("江西")>=0||province.indexOf("湖北")>=0||province.indexOf("湖南")>=0||province.indexOf("广西")>=0||province.indexOf("广东")>=0||province.indexOf("海南")>=0){
						person_id="730";
					}
					if(province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("辽宁")>=0||province.indexOf("吉林")>=0||province.indexOf("黑龙江")>=0){
						person_id="731";
					}
				}
				if(catanum.indexOf("101001")>=0){//挖掘机
					if(province.indexOf("河南")>=0){
						person_id="732";
					}
					if(province.indexOf("山东")>=0){
						person_id="733";
					}
					if(city.indexOf("抚顺")>=0||city.indexOf("铁岭")>=0||city.indexOf("朝阳")>=0||city.indexOf("锦州")>=0||city.indexOf("葫芦岛")>=0||city.indexOf("阜新")>=0){
						person_id="734";
					}
					if(city.indexOf("沈阳")>=0||city.indexOf("鞍山")>=0||city.indexOf("丹东")>=0||city.indexOf("辽阳")>=0||city.indexOf("盘锦")>=0||city.indexOf("大连")>=0||city.indexOf("营口")>=0||city.indexOf("本溪")>=0){
						person_id="735";
					}
					if(province.indexOf("吉林")>=0){
						person_id="736";
					}
					if(province.indexOf("黑龙江")>=0){
						person_id="737";
					}
					if(province.indexOf("内蒙古")>=0){
						person_id="738";
					}
					if(province.indexOf("山西")>=0&&city.indexOf("阳泉")<0){
						person_id="739";
					}
					if(city.indexOf("邢台")>=0||city.indexOf("邯郸")>=0){
						person_id="740";
					}
					if(city.indexOf("石家庄")>=0||city.indexOf("保定")>=0||city.indexOf("沧州")>=0||city.indexOf("衡水")>=0||city.indexOf("阳泉")>=0){
						person_id="741";
					}
					if(city.indexOf("唐山")>=0||city.indexOf("秦皇岛")>=0){
						person_id="742";
					}
					if(province.indexOf("北京")>=0||city.indexOf("张家口")>=0||city.indexOf("承德")>=0||city.indexOf("廊坊")>=0){
						person_id="743";
					}
					if(province.indexOf("天津")>=0){
						person_id="744";
					}
					if(province.indexOf("广西")>=0){
						person_id="745";
					}
					if(province.indexOf("湖南")>=0){
						person_id="746";
					}
					if(province.indexOf("广东")>=0&&city.indexOf("湛江")<0&&city.indexOf("茂名")<0&&city.indexOf("阳江")<0){
						person_id="747";
					}
					if(city.indexOf("湛江")>=0||city.indexOf("茂名")>=0||city.indexOf("阳江")>=0){
						person_id="748";
					}
					if(province.indexOf("海南")>=0){
						person_id="749";
					}
					if(province.indexOf("江西")>=0){
						person_id="750";
					}
					if(province.indexOf("上海")>=0||(province.indexOf("江苏")>=0)&&city.indexOf("徐州")<0){
						person_id="751";
					}
					if(province.indexOf("福建")>=0){
						person_id="752";
					}
					if(province.indexOf("湖北")>=0){
						person_id="753";
					}
					if(province.indexOf("浙江")>=0){
						person_id="754";
					}
					if(province.indexOf("安徽")>=0||city.indexOf("徐州")>=0){
						person_id="755";
					}
					if(province.indexOf("甘肃")>=0||province.indexOf("宁夏")>=0||province.indexOf("青海")>=0){
						person_id="756";
					}
					if(province.indexOf("新疆")>=0){
						person_id="757";
					}
					if(province.indexOf("西藏")>=0){
						person_id="758";
					}
					if(province.indexOf("陕西")>=0){
						person_id="759";
					}
					if(province.indexOf("云南")>=0){
						person_id="760";
					}
					if(province.indexOf("贵州")>=0){
						person_id="761";
					}
					if(province.indexOf("四川")>=0&&city.indexOf("达州")<0){
						person_id="762";
					}
					if(province.indexOf("重庆")>=0||city.indexOf("达州")>=0){
						person_id="763";
					}
				}
			}
	if(factoryid.equals("142")){//山河智能刚改的
				if(province.indexOf("江西")>=0){
					person_id="764";
				}
				if(province.indexOf("北京")>=0||(province.indexOf("河北")>=0&&city.indexOf("秦皇岛")<0&&city.indexOf("唐山")<0)){
					person_id="765";
				}
				if(province.indexOf("海南")>=0||city.indexOf("来宾")>=0||city.indexOf("贵港")>=0||city.indexOf("柳州")>=0||city.indexOf("桂林")>=0||city.indexOf("贺州")>=0||city.indexOf("梧州")>=0){
					person_id="766";
				}
				if(province.indexOf("湖北")>=0){
					person_id="767";
				}
				if(city.indexOf("济南")>=0||city.indexOf("泰安")>=0||city.indexOf("济宁")>=0||city.indexOf("枣庄")>=0||city.indexOf("临沂")>=0||city.indexOf("菏泽")>=0||city.indexOf("聊城")>=0||city.indexOf("德州")>=0||city.indexOf("滨州")>=0||city.indexOf("东营")>=0||city.indexOf("淄博")>=0||city.indexOf("莱芜")>=0){
					person_id="768";
				}
				if(province.indexOf("上海")>=0){
					person_id="769";
				}
				if(city.indexOf("南京")>=0||city.indexOf("苏州")>=0||city.indexOf("无锡")>=0||city.indexOf("常州")>=0||city.indexOf("镇江")>=0){
					person_id="770";
				}
				if(city.indexOf("合肥")>=0||city.indexOf("阜阳")>=0||city.indexOf("蚌埠")>=0||city.indexOf("宿州")>=0||city.indexOf("滁州")>=0||city.indexOf("淮南")>=0||city.indexOf("淮北")>=0||city.indexOf("亳州")>=0){
					person_id="771";
				}
				if(city.indexOf("六安")>=0||city.indexOf("巢湖")>=0||city.indexOf("马鞍山")>=0||city.indexOf("安庆")>=0||city.indexOf("池州")>=0||city.indexOf("黄山")>=0||city.indexOf("宣城")>=0||city.indexOf("芜湖")>=0||city.indexOf("铜陵")>=0){
					person_id="773";
				}
				if(city.indexOf("南阳")>=0||city.indexOf("平顶山")>=0||city.indexOf("新乡")>=0||city.indexOf("鹤壁")>=0||city.indexOf("濮阳")>=0||city.indexOf("郑州")>=0){
					person_id="774";
				}
				if(city.indexOf("安阳")>=0||city.indexOf("焦作")>=0||city.indexOf("济源")>=0||city.indexOf("洛阳")>=0||city.indexOf("三门峡")>=0||city.indexOf("信阳")>=0||city.indexOf("驻马店")>=0||city.indexOf("漯河")>=0||city.indexOf("许昌")>=0){
					person_id="775";
				}
				if(province.indexOf("湖南")>=0){
					person_id="776";
				}
				if(city.indexOf("西安")>=0||city.indexOf("汉中")>=0||city.indexOf("安康")>=0||city.indexOf("商洛")>=0||city.indexOf("咸阳")>=0||city.indexOf("宝鸡")>=0){
					person_id="777";
				}
				if(city.indexOf("烟台")>=0||city.indexOf("青岛")>=0||city.indexOf("潍坊")>=0||city.indexOf("威海")>=0||city.indexOf("日照")>=0){
					person_id="778";
				}
				if(city.indexOf("扬州")>=0||city.indexOf("泰州")>=0||city.indexOf("南通")>=0||city.indexOf("盐城")>=0||city.indexOf("淮安")>=0||city.indexOf("宿迁")>=0||city.indexOf("徐州")>=0||city.indexOf("连云港")>=0){
					person_id="779";
				}
				if(city.indexOf("周口")>=0||city.indexOf("商丘")>=0||city.indexOf("开封")>=0){
					person_id="780";
				}
				if(province.indexOf("福建")>=0){
					person_id="781";
				}
				if(province.indexOf("山西")>=0){
					person_id="782";
				}
				if(province.indexOf("黑龙江")>=0||province.indexOf("吉林")>=0||province.indexOf("辽宁")>=0){
					person_id="783";
				}
				if(province.indexOf("甘肃")>=0){
					person_id="784";
				}
				if(city.indexOf("百色")>=0||city.indexOf("南宁")>=0||city.indexOf("北海")>=0||city.indexOf("防城港")>=0||city.indexOf("钦州")>=0||city.indexOf("崇左")>=0||city.indexOf("玉林")>=0||city.indexOf("河池")>=0){
					person_id="785";
				}
				if(province.indexOf("广东")>=0){
					person_id="786";
				}
				//if(city.indexOf("泸州")>=0||city.indexOf("自贡")>=0||city.indexOf("内江")>=0||city.indexOf("宜宾")>=0){
				//	person_id="787";
				//}
				if(city.indexOf("银川")>=0||city.indexOf("固原")>=0||city.indexOf("中卫")>=0){
					person_id="788";
				}
				if(city.indexOf("乌鲁木齐")>=0||city.indexOf("北屯")>=0||city.indexOf("塔城")>=0||city.indexOf("克拉玛依")>=0||city.indexOf("奎屯")>=0||city.indexOf("博乐")>=0||city.indexOf("石河子")>=0||city.indexOf("伊宁")>=0||city.indexOf("哈密")>=0||city.indexOf("库尔勒")>=0||city.indexOf("阿克苏")>=0||city.indexOf("和田")>=0){
					person_id="789";
				}
				if(city.indexOf("喀什")>=0||city.indexOf("克孜勒苏柯尔克自治州")>=0){
					person_id="790";
				}
				if(province.indexOf("重庆")>=0||(province.indexOf("云南")>=0&&city.indexOf("曲靖")<0&&city.indexOf("昭通")<0)||(province.indexOf("贵州")>=0&&city.indexOf("黔西")<0&&city.indexOf("六盘水")<0)){
					person_id="791";
				}
				if(province.indexOf("四川")>=0){
					person_id="792";
				}
				if(province.indexOf("浙江")>=0){
					person_id="793";
				}
				if(city.indexOf("宜昌")>=0||city.indexOf("荆州")>=0||city.indexOf("恩施")>=0){
					person_id="767";
				}
				if(city.indexOf("黔西")>=0||city.indexOf("六盘水")>=0){
					person_id="843";
				}
				if(city.indexOf("曲靖")>=0||city.indexOf("昭通")>=0){
					person_id="844";
				}
				if(city.indexOf("渭南")>=0||city.indexOf("铜川")>=0||city.indexOf("延安")>=0){
					person_id="845";
				}
				
			}
			if(factoryid.equals("182")){//小松
				if(agent_id.equals("319")){//西安安松
					person_id = "692";
				}
				if(agent_id.equals("237")){//广东粤松
					person_id = "876";
				}
				if(agent_id.equals("18940")){//青岛小松烟威青
					if(city.indexOf("烟台")>=0||city.indexOf("青岛")>=0||city.indexOf("威海")>=0){
						person_id="870";
					}
				}
				if(agent_id.equals("18945")){//	山东德润丰
					if(city.indexOf("日照")>=0){
						person_id="872";
					}
					if(city.indexOf("济宁")>=0||city.indexOf("临沂")>=0||city.indexOf("枣庄")>=0||city.indexOf("菏泽")>=0){
						person_id="873";
					}
					if(city.indexOf("潍坊")>=0||city.indexOf("淄博")>=0||city.indexOf("滨州")>=0||city.indexOf("东营")>=0){
						person_id="874";
					}
					if(city.indexOf("济南")>=0||city.indexOf("泰安")>=0||city.indexOf("德州")>=0||city.indexOf("聊城")>=0){
						person_id="875";
					}
				}
				if(agent_id.equals("340")){//安徽小松
					person_id = "871";
				}
				if(agent_id.equals("18351")){//河南凯隆
					if(city.indexOf("郑州")>=0){
						person_id="846";
					}
					if(city.indexOf("南阳")>=0){
						person_id="847";
					}
					if(city.indexOf("信阳")>=0){
						person_id="848";
					}
					if(city.indexOf("周口")>=0||city.indexOf("漯河")>=0){
						person_id="849";
					}
					if(city.indexOf("驻马店")>=0){
						person_id="850";
					}
					if(city.indexOf("洛阳")>=0){
						person_id="851";
					}
					if(city.indexOf("安阳")>=0||city.indexOf("濮阳")>=0||city.indexOf("鹤壁")>=0||city.indexOf("新乡")>=0||city.indexOf("焦作")>=0||city.indexOf("济源")>=0){
						person_id="852";
					}
					if(city.indexOf("许昌")>=0||city.indexOf("平顶山")>=0){
						person_id="853";
					}
					if(city.indexOf("开封")>=0||city.indexOf("商丘")>=0){
						person_id="854";
					}
					if(city.indexOf("三门峡")>=0){
						person_id="855";
					}
				}
				if(agent_id.equals("370")){//江苏宁隆
					if(city.indexOf("南京")>=0){
						person_id="856";
					}
					if(city.indexOf("苏州")>=0){
						person_id="857";
					}
					if(city.indexOf("无锡")>=0){
						person_id="858";
					}
					if(city.indexOf("徐州")>=0){
						person_id="859";
					}
					if(city.indexOf("扬州")>=0||city.indexOf("盐城")>=0||city.indexOf("淮安")>=0){
						person_id="860";
					}
					if(city.indexOf("连云港")>=0||city.indexOf("宿迁")>=0){
						person_id="861";
					}
					if(city.indexOf("常州")>=0||city.indexOf("镇江")>=0){
						person_id="862";
					}
					if(city.indexOf("泰州")>=0||city.indexOf("南通")>=0){
						person_id="863";
					}
				}
			}
			
			if(agent_id.equals("16860")){//徐工基础
				if(jr_catalogname.indexOf("钻机")>=0||jr_catalogname.indexOf("连续墙")>=0||jr_catalogname.indexOf("水平定向钻")>=0||jr_catalogname.indexOf("采煤机")>=0||jr_catalogname.indexOf("掘进机")>=0){
					person_id="809";
				}
			}
		    if ("209".equals(factoryid)&&catanum.equals("102006")) {//徐工起重机
                   person_id="866";
                   usern="xcmgscqzj";
			}
			if(agent_id.equals("14245")&&jr_catalogname.indexOf("装载")>=0){
			}else if(agent_id.equals("14244")&&jr_catalogname.indexOf("挖掘")>=0){
			}else{
				    if(!person_id.equals("0")||agent_id.equals("16776")||factoryid.equals("14238")){	
                        //把订单推给合作的代理商订单中 
                        String sqlString="";
		                //正式表
			            sqlString = "insert into pro_agent_products_form(";
			            sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			            sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factoryid+",'"+jr_factoryname+"',"+agent_id+",agentname,catanum,'"+jr_catalogname+"',"+jr_proid+",'"+jr_proname+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',"+person_id;
			            sqlString += " from pro_product_form WHERE uuid = '"+jr_uuid+"'";
			            new_formid = dbHelper.executeUpdate(sqlString);
			        }
			}
		  
			
			
			 if(!usern.equals("")){
			    System.out.println("============================订单宝推送订单==============================");       
			    //产品中心后台向手机端推送
			    //PushSyncActon push= new PushSyncActon();
				//微信消息推送
				CommonAction commonAction=new CommonAction();
			    int flagno=102001;
			    String orderNo="20150123212321";
			    String machineNo=jr_factoryname+jr_catalogname+jr_proname;
			    //Map proMap = dbHelper.getMap("select img2 from pro_products where id="+CommonString.getFormatPara(orderInfo.get("product_id")));
			    String machineImg="/img/";
			    String createDate=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
			    String linkMan=CommonString.getFormatPara(one_proform.get("name")); 
			    String linkTel= CommonString.getFormatPara(one_proform.get("mobile_phone")) ;
			    String address=CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"));
			    String receiveMan="";
			    int receiveManId=0;
			    int agentId=Integer.parseInt(factoryid);
			    //push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+usern);	
			    if(!linkTel.equals("555-666-0606")){
					commonAction.sendWxMsg(new_formid,"xJx7heYIt8IuqSMLY-wf1eiiozXxP36rP5xw3WycrBc");
				}
				}
			
		       }
		    }
							
							
				}
								List<Map> specialPersonList=null;	 String specialPersonId="";  String specialPersonUsern="";				
        if(factoryid.equals("135")&&(province.indexOf("重庆")!=-1||province.indexOf("四川")!=-1||province.indexOf("贵州")!=-1||province.indexOf("云南")!=-1)){
            			
			
			specialPersonList = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where agent_id = ? ",new Object [] {12993});
			if(null!=specialPersonList){
				for(Map m : specialPersonList){		  
				   String nums=CommonString.getFormatPara(m.get("city_num"));
				   if(!nums.equals("")){
				      String  []citys=nums.split(",");
					  if(citys.length>0){
					        for(int iii=0;iii<citys.length;iii++){
					              Map areaInfo = dbHelper.getMap(" select   area_name from comm_area   where area_id = ? ",new Object [] {citys[iii]});
                                     if(areaInfo!=null){
									    if(CommonString.getFormatPara(one_proform.get("city")).equals(CommonString.getFormatPara(areaInfo.get("area_name")))||CommonString.getFormatPara(one_proform.get("city")).indexOf(CommonString.getFormatPara(areaInfo.get("area_name")))>=0|| CommonString.getFormatPara(areaInfo.get("area_name")).indexOf(CommonString.getFormatPara(one_proform.get("city")))>=0){
														    specialPersonId=CommonString.getFormatPara(m.get("id"));
															specialPersonUsern=CommonString.getFormatPara(m.get("usern"));
															break;
										}
									 }								  
                            }
					  }
				   }
				}
			
        if(!specialPersonId.equals("")&&!specialPersonUsern.equals("")){         
		 
                	String sqlString = "insert into pro_agent_products_form(";
			        sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			        sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',141,factoryname,12993,agentname,catanum,cataname,product_id,product_name,contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',message,company,name,"+1+",id,call_result1,buy_type,'102001',"+specialPersonId;
			        sqlString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			        new_formid = dbHelper.executeUpdate(sqlString);

			//PushSyncActon push= new PushSyncActon();
			//微信消息推送
			CommonAction commonAction=new CommonAction();
			int flagno=102001;
			String orderNo=CommonString.getFormatPara(CommonString.getFormatPara(one_proform.get("id")));
			Map proMap = dbHelper.getMap("select img2,factoryname,catalogname,name from pro_products where id="+CommonString.getFormatPara(one_proform.get("product_id")));
			String machineNo=CommonString.getFormatPara(proMap.get("factoryname"))+CommonString.getFormatPara(proMap.get("catalogname"))+CommonString.getFormatPara(proMap.get("name"));
			String machineImg=CommonString.getFormatPara(proMap.get("img2"));
			String createDate=CommonDate.getFormatDate("yyyy-MM-dd HH:mm",CommonString.getFormatPara(one_proform.get("add_date")));
			String linkMan=CommonString.getFormatPara(one_proform.get("name")); ;
			String linkTel=CommonString.getFormatPara(one_proform.get("contact_tel"));
			String address=CommonString.getFormatPara(one_proform.get("contact_address"));
			String receiveMan="";
			int receiveManId=0;
			int agentId=12993;
			//push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+specialPersonUsern);	
			if(!linkTel.equals("555-666-0606")){
				commonAction.sendWxMsg(new_formid,"xJx7heYIt8IuqSMLY-wf1eiiozXxP36rP5xw3WycrBc");
			}
		}
				
			}
			
			
			
		}
				
				
		}
			

			
			
 							
			        //三一众力订单推送
					System.out.println(factoryid+"--"+catanum+"--"+province);
					if(factoryid.equals("133")&&catanum.indexOf("101001")>=0&&province.indexOf("河北")>=0){	
                        //把订单推给合作的代理商订单中 
                        String sqlStringZl="";
		                //正式表
			            sqlStringZl = "insert into pro_agent_products_form(";
			            sqlStringZl += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			            sqlStringZl += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factoryid+",'"+jr_factoryname+"',16328,agentname,catanum,'"+jr_catalogname+"',"+jr_proid+",'"+jr_proname+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',0";
			            sqlStringZl += " from pro_product_form WHERE uuid = '"+jr_uuid+"'";
			            new_formid = dbHelper.executeUpdate(sqlStringZl);
			        }		
			
			
			
			
			
		} else { // 一个产品
		
		    System.out.println("一个产品");
		
			Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuids + "'");
			factoryid = CommonString.getFormatPara(one_proform.get("factoryid")); // 获得品牌id		
			province = CommonString.getFormatPara(one_proform.get("province")) ;
			String city = CommonString.getFormatPara(one_proform.get("city"));
            String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone"));
			String man= CommonString.getFormatPara(one_proform.get("name"));
			String theProId= CommonString.getFormatPara(one_proform.get("product_id"));
			String cata_name=CommonString.getFormatPara(one_proform.get("cataname"));
			
			System.out.println(city+cata_name);
			//  因牟总要求我们做三一、斗山线上活动，3.18日之前邮件停发湖南、
			// 山东所有品牌挖掘机的询价信息，请您协助设置处理，谢谢。
			/*
		    province = CommonString.getFormatPara(one_proform.get("province")) ;
			catanum = CommonString.getFormatPara(one_proform.get("catanum")) ;
			if((province.indexOf("湖南")!=-1 || province.indexOf("山东")!=-1) && catanum.indexOf("101001")!=-1){
				return ;
		   	}*/
			  jr_catalogname= CommonString.getFormatPara(one_proform.get("cataname")) ;
			  jr_factoryname= CommonString.getFormatPara(one_proform.get("factoryname")) ;
			  jr_proid= CommonString.getFormatPara(one_proform.get("product_id")) ;
			 jr_proname= CommonString.getFormatPara(one_proform.get("product_name")) ;
			  jr_uuid= CommonString.getFormatPara(one_proform.get("uuid")) ;
			catanum = CommonString.getFormatPara(one_proform.get("catanum")) ;
			
			
					//如果是挖掘机的某些品牌就给卡特复制出一条订单
			        if(catanum.indexOf("101001001")>=0){
						if(1==2){
						Map proMap = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
						int tonandmeter=0;
                        if(proMap!=null){
						   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
						}
						Map pushProMap=null;
						if(tonandmeter<=10&&tonandmeter>0){

							if(tonandmeter<=2){
								//pushProMap= new HashMap();
								//pushProMap.put("id","23915");
								//pushProMap.put("name","301.7D CR");
							}else if(tonandmeter<=4){
								//pushProMap= new HashMap();
								//pushProMap.put("id","21525");
								//pushProMap.put("name","303.5E CR");
							}else if(tonandmeter<=6){
								//pushProMap= new HashMap();
								//pushProMap.put("id","4561");
								//pushProMap.put("name","305.5E");
							}else if(tonandmeter<8){
								//pushProMap= new HashMap();
								//pushProMap.put("id","20163");
								//pushProMap.put("name","307E");
							}else{
								//pushProMap= new HashMap();
								//pushProMap.put("id","21514");
								//pushProMap.put("name","308E");
							}
						}else if(tonandmeter>10&&tonandmeter<=30){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (9548,400,9550,445,11366,390,3503) order by newid()");
						}else if(tonandmeter>30){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (3525,19946,9551,522,403,9552,9553,407,9554,9555) order by newid()  " );
						}
						if(pushProMap!=null){
							 pro_id=CommonString.getFormatInt(pushProMap.get("id"));
							 pro_name=CommonString.getFormatPara(pushProMap.get("name"));
							 jr_message="我对卡特彼勒"+pro_name+"感兴趣，请联系我";
						}
			            String sqlCopyString = "insert into pro_product_form(";
			            sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
			            sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,174,'卡特彼勒',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+CommonString.getUUID()+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",uuid,buy_type";
			            sqlCopyString += " from pro_product_form WHERE uuid = '"+uuids+"'";
						if(pushProMap!=null){
			            dbHelper.execute(sqlCopyString);	
						}
						}
			       }
					//临工挖掘机某些牌订单推送
				   if("101001001".equals(catanum)){
						//三一133，徐工209，龙工135，厦工139，山推144，山河智能142，斗山192，雷沃141，柳工136，约翰迪尔14238，中联134，山工138，英轩1777
						if(factoryid.equals("133")||factoryid.equals("209")||factoryid.equals("135")||factoryid.equals("139")||factoryid.equals("144")||factoryid.equals("142")||factoryid.equals("192")||factoryid.equals("141")||factoryid.equals("136")||factoryid.equals("14238")||factoryid.equals("134")||factoryid.equals("138")||factoryid.equals("1777")){
							Map proMap = dbHelper.getMap(" select  tonandmeter from pro_products   where  id= "+jr_proid );
							int tonandmeter=0;String procatanum="";
							if(proMap!=null){
							   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
							}
							Map pushProMap=null;
							String whereStr="";
							if(tonandmeter<=3){//微挖
								whereStr+=" and tonandmeter <=3 ";
							}
							if(tonandmeter>4 && tonandmeter<8){//小挖
								whereStr+=" and tonandmeter >4 and tonandmeter<8 ";
							}
							if(tonandmeter>=8 && tonandmeter<15){//中小挖
								whereStr+=" and tonandmeter >=8 and tonandmeter<15 ";
							}
							if(tonandmeter>=15 && tonandmeter<25){//中挖
								whereStr+=" and tonandmeter >=15 and tonandmeter<25 ";
							}
							if(tonandmeter>=25 && tonandmeter<35){//中大挖
								whereStr+=" and tonandmeter >=25 and tonandmeter<35 ";
							}
							if(tonandmeter>=35 ){//大挖
								whereStr+=" and tonandmeter >35 ";
							}
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							//System.out.println("***************"+" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							if(pushProMap!=null){
								pro_id=CommonString.getFormatInt(pushProMap.get("id"));
								pro_name=CommonString.getFormatPara(pushProMap.get("name"));
								jr_message="我对山东临工"+pro_name+"感兴趣，请联系我";
								String tempUid=CommonString.getUUID();
								String sqlCopyString = "insert into pro_product_form(";
								sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
								sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,137,'山东临工',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tempUid+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",'',buy_type";
								sqlCopyString += " from pro_product_form WHERE uuid = '"+uuids+"'";
								int cat_id=dbHelper.execute(sqlCopyString);	
						   }
						}
				   }  
				   //临工装载机某些牌订单推送
				   if(catanum.equals("101002007")){
						//三一133，徐工209，龙工135，厦工139，山推144，山河智能142，斗山192，雷沃141，柳工136，约翰迪尔14238，中联134，山工138，英轩1777
						if(factoryid.equals("133")||factoryid.equals("209")||factoryid.equals("135")||factoryid.equals("139")||factoryid.equals("144")||factoryid.equals("142")||factoryid.equals("192")||factoryid.equals("141")||factoryid.equals("136")||factoryid.equals("14238")||factoryid.equals("134")||factoryid.equals("138")||factoryid.equals("1777")){
							Map proMap = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
							int tonandmeter=0;String procatanum="";
							if(proMap!=null){
							   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
							}
							Map pushProMap=null;
							String whereStr="";
							if(tonandmeter<3){//小装
								whereStr+=" and tonandmeter <3 ";
							}
							if(tonandmeter==3 ){//3T
								whereStr+=" and tonandmeter =3 ";
							}
							if(tonandmeter==5 ){//5T
								whereStr+=" and tonandmeter =5 ";
							}
							if(tonandmeter>5 ){//5T以上
								whereStr+=" and tonandmeter >5 ";
							}
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							//System.out.println("***************"+" select top 1  id,name   from pro_products   where factoryid=137 and catanum='"+catanum+"' and "+whereStr+" order by newid()");
							if(pushProMap!=null){
								pro_id=CommonString.getFormatInt(pushProMap.get("id"));
								pro_name=CommonString.getFormatPara(pushProMap.get("name"));
								jr_message="我对山东临工"+pro_name+"感兴趣，请联系我";
								String tempUid=CommonString.getUUID();
								String sqlCopyString = "insert into pro_product_form(";
								sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
								sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,137,'山东临工',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tempUid+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",'',buy_type";
								sqlCopyString += " from pro_product_form WHERE uuid = '"+uuids+"'";
								int cat_id=dbHelper.execute(sqlCopyString);	
						   }
						}
				   }
					//如果是徐工的给三一复制一份		  
                    if ("209".equals(factoryid)&&1==2) {
			  	       	Map sanyProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  is_show=1 and  factoryid=133  and catalognum like '%"+catanum+"%' order by view_count desc");
                      	if(sanyProMap!=null){
						int sany_pro_id=CommonString.getFormatInt(sanyProMap.get("id"));
						String sany_pro_name=CommonString.getFormatPara(sanyProMap.get("name"));
						String sany_jr_message="我对三一"+sany_pro_name+"感兴趣，请联系我";
						String sany_tempUid=CommonString.getUUID();
			            String sqlCopyString = "insert into pro_product_form(";
			            sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
			            sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,133,'三一',0,agentname,catanum,cataname,name,email,company,"+sany_pro_id+",'"+sany_pro_name+"',contact_address,contact_tel,'"+sany_jr_message+"',state,province,city,mobile_phone,view_count,'"+sany_tempUid+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",'',buy_type";
			            sqlCopyString += " from pro_product_form WHERE uuid = '"+uuids+"'";
			            dbHelper.execute(sqlCopyString);	

						}  
		            }
			
			
		 //推送雷沃时重庆茗森特殊的再处理一下	
		List<Map> specialPersonList=null;	 String specialPersonId="";  String specialPersonUsern="";				
        if(factoryid.equals("135")&&(province.indexOf("重庆")!=-1||province.indexOf("四川")!=-1||province.indexOf("贵州")!=-1||province.indexOf("云南")!=-1)){
            			
			
			specialPersonList = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where agent_id = ? ",new Object [] {12993});
			if(null!=specialPersonList){
				for(Map m : specialPersonList){		  
				   String nums=CommonString.getFormatPara(m.get("city_num"));
				   if(!nums.equals("")){
				      String  []citys=nums.split(",");
					  if(citys.length>0){
					        for(int iii=0;iii<citys.length;iii++){
					              Map areaInfo = dbHelper.getMap(" select   area_name from comm_area   where area_id = ? ",new Object [] {citys[iii]});
                                     if(areaInfo!=null){
									    if(city.equals(CommonString.getFormatPara(areaInfo.get("area_name")))||city.indexOf(CommonString.getFormatPara(areaInfo.get("area_name")))>=0|| CommonString.getFormatPara(areaInfo.get("area_name")).indexOf(city)>=0){
														    specialPersonId=CommonString.getFormatPara(m.get("id"));
															specialPersonUsern=CommonString.getFormatPara(m.get("usern"));
															break;
										}
									 }								  
                            }
					  }
				   }
				}
			
        if(!specialPersonId.equals("")&&!specialPersonUsern.equals("")){         
		 
                	String sqlString = "insert into pro_agent_products_form(";
			        sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			        sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',141,factoryname,12993,agentname,catanum,cataname,product_id,product_name,contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',message,company,name,"+1+",id,call_result1,buy_type,'102001',"+specialPersonId;
			        sqlString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			        new_formid = dbHelper.executeUpdate(sqlString);

			//PushSyncActon push= new PushSyncActon();
			//微信消息推送
			CommonAction commonAction=new CommonAction();
			int flagno=102001;
			String orderNo=CommonString.getFormatPara(CommonString.getFormatPara(one_proform.get("id")));
			Map proMap = dbHelper.getMap("select img2,factoryname,catalogname,name from pro_products where id="+CommonString.getFormatPara(one_proform.get("product_id")));
			String machineNo=CommonString.getFormatPara(proMap.get("factoryname"))+CommonString.getFormatPara(proMap.get("catalogname"))+CommonString.getFormatPara(proMap.get("name"));
			String machineImg=CommonString.getFormatPara(proMap.get("img2"));
			String createDate=CommonDate.getFormatDate("yyyy-MM-dd HH:mm",CommonString.getFormatPara(one_proform.get("add_date")));
			String linkMan=CommonString.getFormatPara(CommonString.getFormatPara(one_proform.get("name"))); ;
			String linkTel=CommonString.getFormatPara(CommonString.getFormatPara(one_proform.get("contact_tel")));
			String address=CommonString.getFormatPara(CommonString.getFormatPara(one_proform.get("contact_address")));
			String receiveMan="";
			int receiveManId=0;
			int agentId=12993;
			//push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+specialPersonUsern);	
			if(!linkTel.equals("555-666-0606")){
				commonAction.sendWxMsg(new_formid,"xJx7heYIt8IuqSMLY-wf1eiiozXxP36rP5xw3WycrBc");
			}
			
		}
				
			}
			
			
			
		}
		
		
 
						   //宝鼎订单邮件提醒		  
          if ("13570".equals(factoryid)) {
			  
			  			WEBEmail.sendMailByUrl("156955048@qq.com", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
			  

		  }
		
		

             //徐工随车订单邮件
             /*
 		    if ("209".equals(factoryid)&&catanum.equals("102006")) {
 		                WEBEmail.sendMailByUrl("lirk@xcmg.com", "", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids "utf-8");
 		    }*/

	
			//龙工订单邮件
			if ("135".equals(factoryid)&&1==2) {

						
						
						//大装
						if(catanum.indexOf("101002")>=0&&!jr_proid.equals("804")&&!jr_proid.equals("787")&&!jr_proid.equals("4397")&&!jr_proid.equals("7539")&&!jr_proid.equals("7588")&&!jr_proid.equals("15874")&&!jr_proid.equals("15875")&&!jr_proid.equals("21541")&&!jr_proid.equals("21539")&&!jr_proid.equals("15873")&&!jr_proid.equals("15872")){
						
						WEBEmail.sendMailByUrl("scb@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						try {
			                Map root = new HashMap() ;
				            root.put("phone","15960333311") ;
				            root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				            root.put("source","195002");
				            String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			            } catch (Exception e) {}
						
						}
						//叉车
						if(catanum.indexOf("107")>=0){
							
						WEBEmail.sendMailByUrl("salescc@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						try {
			                Map root = new HashMap() ;
				            root.put("phone","13611663580") ;
				            root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				            root.put("source","195002");
				            String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			            } catch (Exception e) {}
						
						}
						//路面机械和小装
						if(catanum.indexOf("106")>=0||jr_proid.equals("804")||jr_proid.equals("787")||jr_proid.equals("4397")||jr_proid.equals("7539")||jr_proid.equals("7588")||jr_proid.equals("15874")||jr_proid.equals("15875")||jr_proid.equals("21541")||jr_proid.equals("21539")||jr_proid.equals("15873")||jr_proid.equals("15872")){
				
						WEBEmail.sendMailByUrl("wxc@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						try {
			                Map root = new HashMap() ;
				            root.put("phone","13512100228") ;
				            root.put("content","来自铁臂商城询价单，"+CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				            root.put("source","195002");
				            String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			            } catch (Exception e) {}
						
						
						}
						//旋挖钻、推土机
						if(catanum.equals("105003")||catanum.indexOf("101003")>=0){

						WEBEmail.sendMailByUrl("57644948@163.com", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						}
						
						
						//挖掘机
						if(catanum.indexOf("101001")>=0){
						WEBEmail.sendMailByUrl("cxj@lonking.cn", "sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("cataname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						}
						
			}
			//德基订单邮件
			if ("489".equals(factoryid)) {
					try { 
							Map root1 = new HashMap() ;  
							root1.put("title","德基订单") ;  
                            String	cc=CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"的"+CommonString.getFormatPara(one_proform.get("name"))+"询价"+CommonString.getFormatPara(one_proform.get("factoryname"))+ CommonString.getFormatPara(one_proform.get("product_name"))+ CommonString.getFormatPara(one_proform.get("catalogname"))+",电话:"+CommonString.getFormatPara(one_proform.get("mobile_phone"));					
							root1.put("content",CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"的"+CommonString.getFormatPara(one_proform.get("name"))+"询价"+CommonString.getFormatPara(one_proform.get("factoryname"))+ CommonString.getFormatPara(one_proform.get("product_name"))+ CommonString.getFormatPara(one_proform.get("catalogname"))+",电话:"+CommonString.getFormatPara(one_proform.get("mobile_phone"))) ;  
							root1.put("to","info@dgmachinery.com,zengfc@21-sun.com");
							Common.doPost("http://service.21-sun.com/http/utils/sendmail.jsp",root1);
					} catch (Exception e) {
					}
				         /*
						WEBEmail.sendMailByUrl("zengfc@21-sun.com", null, null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						*/
						//WEBEmail.sendMail("zengfc@21-sun.com","zengfc@21-sun.com","德基订单",CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"的"+CommonString.getFormatPara(one_proform.get("name"))+"询价"+CommonString.getFormatPara(one_proform.get("factoryname"))+ CommonString.getFormatPara(one_proform.get("product_name"))+ CommonString.getFormatPara(one_proform.get("catalogname"))+",电话:"+CommonString.getFormatPara(one_proform.get("contact_tel")));
			}
			//金土地订单邮件
			if ("16859".equals(factoryid)) {
				    try { 
							Map root1 = new HashMap() ;  
							root1.put("title","金土地订单") ;   
							root1.put("content",CommonString.getFormatPara(one_proform.get("province"))+CommonString.getFormatPara(one_proform.get("city"))+"的"+CommonString.getFormatPara(one_proform.get("name"))+"询价"+CommonString.getFormatPara(one_proform.get("factoryname"))+ CommonString.getFormatPara(one_proform.get("product_name"))+ CommonString.getFormatPara(one_proform.get("catalogname"))+",电话:"+CommonString.getFormatPara(one_proform.get("mobile_phone"))) ;  
							root1.put("to","452708008@qq.com,zengfc@21-sun.com,wangyn@jerei.com");
							Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sendmail.jsp",root1);
					} catch (Exception e) {
					}
			}
			//信达订单邮件
			if ("1235".equals(factoryid)) {
				    

						WEBEmail.sendMailByUrl("327844026@qq.com", "zengfc@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
			}
			//临工订单邮件
			/**if ("137".equals(factoryid)) {
                        String lingongEmail="youhua.wang@sdlg.com.cn";
						WEBEmail.sendMailByUrl(lingongEmail, "wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
			}**/
			//洋马订单邮件
			if ("191".equals(factoryid)) {
				        String ymEmail="jun_yao@yanmar.com";
						WEBEmail.sendMailByUrl(ymEmail, "qimeng_hu@yanmar.com,wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
			}
			//柳工订单发送
			if ("136".equals(factoryid)&&!province.equals("江苏")&&!province.equals("云南")&&!province.equals("贵州")) {
				/*
			    if(catanum.indexOf("101001")>=0){
						WEBEmail.sendMailByUrl("zengpy@liugong.com", null, null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}else if(catanum.indexOf("101002")>=0){
						WEBEmail.sendMailByUrl("luqy@liugong.com", null, null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}else {
						WEBEmail.sendMailByUrl("sales@liugong.com", null, null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}
				*/
			}
			
			
			
			
			//现代的订单发给客户
			if ("194".equals(factoryid)) {
				
						String phone_to_agent="";
						if(province.indexOf("江苏")!=-1||province.indexOf("山东")!=-1||province.indexOf("福建")!=-1||province.indexOf("浙江")!=-1||province.indexOf("上海")!=-1){
						WEBEmail.sendMailByUrl("huangqun.js@hhichina.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="13301502397";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}


						if(province.indexOf("陕西")!=-1||province.indexOf("宁夏")!=-1||province.indexOf("河南")!=-1 ){
						WEBEmail.sendMailByUrl("jiangyang.js@hhichina.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="18661108686";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}						
						
						
						if(province.indexOf("湖南")!=-1||province.indexOf("江西")!=-1||province.indexOf("广东")!=-1 ){
						WEBEmail.sendMailByUrl("wyg.js@hhichina.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="13915007887";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						if(province.indexOf("四川")!=-1||province.indexOf("重庆")!=-1){
						WEBEmail.sendMailByUrl("ruizhenyu18@163.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="13601094608";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
	

						if(province.indexOf("黑龙江")!=-1||province.indexOf("吉林")!=-1||province.indexOf("辽宁")!=-1||province.indexOf("北京")!=-1||province.indexOf("河北")!=-1||province.indexOf("内蒙古")!=-1||province.indexOf("宁夏")!=-1){
						WEBEmail.sendMailByUrl("jfjs23@sina.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="13915011516";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						
						if(province.indexOf("山西")!=-1||province.indexOf("甘肃")!=-1||province.indexOf("新疆")!=-1){
						WEBEmail.sendMailByUrl("59502008@qq.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="18630173225";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						
						if(province.indexOf("湖南")!=-1||province.indexOf("湖北")!=-1||province.indexOf("广西")!=-1){
						WEBEmail.sendMailByUrl("wangjkunpeng829@163.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="13880536515";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						
						
						if(province.indexOf("上海")!=-1||province.indexOf("浙江")!=-1||province.indexOf("安徽")!=-1||province.indexOf("山东")!=-1){
						WEBEmail.sendMailByUrl("songhao730814@sina.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="18915803577";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
	
			}
			
			//把来自日立的订单发送给客户
			if ("184".equals(factoryid)&&1==2) {
				
				
						String phone_to_agent="";
						if(province.indexOf("山东")!=-1||province.indexOf("河北")!=-1||province.indexOf("北京")!=-1||province.indexOf("天津")!=-1){
						WEBEmail.sendMailByUrl("x.wang.zd@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						
						phone_to_agent="13501639342,13601626163,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						
						if(province.indexOf("山西")!=-1){
						WEBEmail.sendMailByUrl("y.xu.dz@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");	
						phone_to_agent="13817806260,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }
						}
						
						
						if(province.indexOf("陕西")!=-1){
						WEBEmail.sendMailByUrl("x.shi.zz@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="13761411735,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
				
				
						if(province.indexOf("甘肃")!=-1||province.indexOf("青海")!=-1||province.indexOf("西藏")!=-1){
						WEBEmail.sendMailByUrl("j.wang.pn@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="13636606985,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
				
				
						if(province.indexOf("江苏")!=-1||province.indexOf("上海")!=-1){
						WEBEmail.sendMailByUrl("y.liu.ie@hitachi-kenki.com,x.gu.ib@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="15900908726,13817813937,13601626163,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
				
				
						if(province.indexOf("安徽")!=-1||province.indexOf("湖北")!=-1||province.indexOf("河南")!=-1||province.indexOf("江西")!=-1){
						WEBEmail.sendMailByUrl("y.hou.wm@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="18217781711,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
				
				
						if(province.indexOf("浙江")!=-1 ){
						WEBEmail.sendMailByUrl("j.sun.mo@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="15921435230,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	

						
						if(province.indexOf("福建")!=-1||province.indexOf("新疆")!=-1 ){
						WEBEmail.sendMailByUrl("b.jiang.ig@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="13761970327,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
						
						
						if(province.indexOf("辽宁")!=-1||province.indexOf("吉林")!=-1||province.indexOf("黑龙江")!=-1 ){
						WEBEmail.sendMailByUrl("x.chen.dz@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="15821506125,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
						
						if(	province.indexOf("内蒙古")!=-1||city.indexOf("银川")!=-1){
						WEBEmail.sendMailByUrl("p.wang.zk@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="13817304023,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}
					
						
				        if(province.indexOf("重庆")!=-1||city.indexOf("成都")!=-1){
						WEBEmail.sendMailByUrl("x.yang.dx@hitachi-kenki.com,s.yu.gl@hitachi-kenki.com,c.zhao.qf@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="13917875217,13816301854,13585827632,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	

						if(province.indexOf("云南")!=-1){
						WEBEmail.sendMailByUrl("x.lu.ja@hitachi-kenki.com,j.shen.rg@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="13918345015,13818965857,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}							
						
						
						if(province.indexOf("广东")!=-1||province.indexOf("海南")!=-1||province.indexOf("广西")!=-1||province.indexOf("湖南")!=-1){
						WEBEmail.sendMailByUrl("y.li.nx@hitachi-kenki.com,l.li.vg@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="13681989075,13761981051,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
						
						
						if(province.indexOf("贵州")!=-1){
						WEBEmail.sendMailByUrl("y.zhang.ki@hitachi-kenki.com,j.shen.rg@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						phone_to_agent="15801775671,13818965857,13601659760";
				        try {
			                    Map root = new HashMap() ;
				                root.put("phone",phone_to_agent) ;
				                root.put("content","来自铁臂商城询价单，"+province+"，"+CommonString.getFormatPara(one_proform.get("name"))+"，"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"，"+CommonString.getFormatPara(one_proform.get("product_name"))) ;
				                root.put("source","195002");
				                String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			                } catch (Exception e) {
			            }				
						}	
						
						
			}else if ("174".equals(factoryid)) { // 卡特挖掘机订单推送接口
				 Map proMaps = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
                int tonandmeters=0;
                if(proMaps!=null){
			        tonandmeters=CommonString.getFormatInt(proMaps.get("tonandmeter"));
		         }
				   if(tonandmeters!=0&&tonandmeters<10){
				      //Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat_admin_auto_normal.jsp?uuid=" + uuids, one_proform);
				   }else{
					Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat_admin.jsp?uuid=" + uuids, one_proform);
				  }
			 }else if ("133".equals(factoryid)) { // 三一订单推送接口
				Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/sany_admin.jsp?uuid=" + uuids, one_proform);
				
			 }else if ("138".equals(factoryid)) { // 山工挖掘机订单推送接口
				//Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/shangong_admin.jsp?uuid=" + uuids, one_proform);
			 }else if ("209".equals(factoryid)) { // 徐工单独发送邮件该接口
				Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/xcmg_admin.jsp?uuid=" + uuids, one_proform);
			}
			
			 else if("1742".equals(factoryid)){ //林德单独邮件发送  分地域
			       /*
			       //Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuids + "'");
			      if("福建".equals(one_proform.get("province"))||"四川".equals(one_proform.get("province"))||"重庆".equals(one_proform.get("province"))||"湖南".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("xm.tm-region@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("北京".equals(one_proform.get("province"))||"天津".equals(one_proform.get("province"))||"内蒙古".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("beijing.tm@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("辽宁".equals(one_proform.get("province"))||"河北".equals(one_proform.get("province"))||"山东".equals(one_proform.get("province"))||"吉林".equals(one_proform.get("province"))){
				  //
				  				 WEBEmail.sendMailByUrl("amily.xin@hotmail.com,1085103026@qq.com", "",null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("安徽".equals(one_proform.get("province"))||"江苏".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("sz.marketing-region@linde-china.com",  "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("浙江".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("sh.mkt-region@linde-china.com",  "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("上海".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("sh.mkt-region@linde-china.com",  "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("广东".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("guangzhou.telemarket@linde-china.com",  "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("陕西".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("31727621@qq.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("河南".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("新疆".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("山西".equals(one_proform.get("province"))){
				  			     WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("海南".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("广西".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("黑龙江".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("江西".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("湖北".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("甘肃".equals(one_proform.get("province"))||"青海".equals(one_proform.get("province"))||"宁夏".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("云南".equals(one_proform.get("province"))||"贵州".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }else{
				  				 WEBEmail.sendMailByUrl("marketing@linde-china.com", "", null, CommonString.getFormatPara(one_proform.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname"))+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  */
			 }
		   	
			 else if("1220".equals(factoryid)){ //华通动力-20140707
				 //华东区（江苏、安徽、浙江、江西）
			      if("江苏".equals(one_proform.get("province"))||"安徽".equals(one_proform.get("province"))||"浙江".equals(one_proform.get("province"))||"江西".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("luc@jhkinetics.com", "ganh@jhkinetics.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //华南区（广东、湖北）
				  else if("广东".equals(one_proform.get("province"))||"湖北".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("wangxf@jhkinetics.com", "ganh@jhkinetics.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //西南区（云南、贵州、四川）
				  else if("云南".equals(one_proform.get("province"))||"贵州".equals(one_proform.get("province"))||"四川".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("zhuhb@jhkinetics.com", "ganh@jhkinetics.com",null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //华北区（北京、天津、河北、内蒙、山东）
				  else if("北京".equals(one_proform.get("province"))||"天津".equals(one_proform.get("province"))||"河北".equals(one_proform.get("province"))||"内蒙".equals(one_proform.get("province"))||"山东".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("yuhq@jhkinetics.com",  "ganh@jhkinetics.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //西北区（新疆、青海、河南、甘肃、陕西、山西、宁夏）
				  else if("新疆".equals(one_proform.get("province"))||"青海".equals(one_proform.get("province"))||"河南".equals(one_proform.get("province"))||"甘肃".equals(one_proform.get("province"))||"陕西".equals(one_proform.get("province"))||"山西".equals(one_proform.get("province"))||"宁夏".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("yangzs@jhkinetics.com",  "ganh@jhkinetics.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //东北区（黑龙江、吉林、辽宁）
				  else if("黑龙江".equals(one_proform.get("province"))||"吉林".equals(one_proform.get("province"))||"辽宁".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("wuqz@jhkinetics.com",  "ganh@jhkinetics.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }else{
				  				 WEBEmail.sendMailByUrl("ganh@jhkinetics.com", "", null, CommonString.getFormatPara(one_proform.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname"))+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
			 }
			 
			 

			 
			 
			 
		/**	 else if("749".equals(factoryid)){  // 洛阳东方红 发送邮件
				if(CommonString.getFormatPara(one_proform.get("province")).indexOf("河南")!=-1 || CommonString.getFormatPara(one_proform.get("province")).indexOf("甘肃")!=-1){
					WEBEmail.sendMailByUrl("yituojixie@163.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
							+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
								+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}
				WEBEmail.sendMailByUrl("lyxiehua@126.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
							+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
			}*/
			
			 else if (!"".equals(factoryid)) {
			
			}
 
	//	  WEBEmail.sendMailByUrl("zhanghl@21-sun.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
		//			+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
		//			+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
		
		
		
		
		
		
		//app订单自动推送
		jr_message="我对你的产品感兴趣，请联系我";
		String person_id="0";
		String usern="";
		String agent_id="";
		String areaNum="0000000000";
		Map areaMap = dbHelper.getMap(" select  area_id   from comm_area   where parent_area_id !=129250 and  area_name like '%"+city+"%' " );
        if(areaMap!=null){
		  areaNum=CommonString.getFormatPara(areaMap.get("area_id"));
		}
	     if(city.equals("鞍山市")){
			areaNum="120260";
		}
		if(city.equals("马鞍山")){
			areaNum="101940";
		}
		//wyn 20190528
		if(CommonString.getFormatPara(one_proform.get("city")).equals("大连")){
			areaNum="123230";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("宿迁")){
			areaNum="112040";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("凯里")){
			areaNum="132680";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("北京")){
			areaNum="105499";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("天津")){
			areaNum="105689";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("重庆")){
			areaNum="105879";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("大同")){
			areaNum="108420";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("思茅")){
			areaNum="137600";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("博乐")){
			areaNum="117780";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("锡林浩特")){
			areaNum="110660";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("上海")){
			areaNum="105290";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("吉林")){
			areaNum="119120";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("衡阳")){
			areaNum="126270";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("抚顺县")){
			areaNum="120340";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("巴州")){
			areaNum="117600";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("克州")){
			areaNum="117550";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("集宁")){
			areaNum="110470";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("海拉尔")){
			areaNum="110260";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("东胜")){
			areaNum="110180";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("临河")){
			areaNum="110390";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("长临河镇")){
			areaNum="102320";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("海口")){
			areaNum="141510";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("潢川县")){
			areaNum="131430";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("眉山")){
			areaNum="140260";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("朝阳县")){
			areaNum="121000";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("江汉")){
			areaNum="124010";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("海淀")){
			areaNum="105500";
		}
		if(CommonString.getFormatPara(one_proform.get("city")).equals("六安")){
			areaNum="102900";
		}
		
		List<Map> agentList =null;
		if(!factoryid.equals("")&&!factoryid.equals("0")){
		agentList=dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+factoryid+"%'  and  city_num like '%"+areaNum+"%'" );
		}
		if(factoryid.equals("182")){//小松
			//agentList=dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and   agent_fac  like '%"+factoryid+"%'  " );
			if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("陕西")>=0){
		         agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=319 " );
		    }else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("河南")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=18351 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("江苏")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=370 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("烟台")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("威海")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("青岛")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=18940 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("日照")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("济宁")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("临沂")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("枣庄")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("菏泽")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("潍坊")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("淄博")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("滨州")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("东营")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("济南")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("泰安")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("德州")>=0||CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("聊城")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=18945 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("安徽")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=340 " );
			}else if(CommonString.getFormatPara(one_proform.get("contact_address")).indexOf("广东")>=0){
				 agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=237 " );
			}else{
				 agentList=null;
			}
		}
        //三一的做产品控制
		if(factoryid.equals("133")){
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")!=-1){
			}else{
			agentList=null;	
			}
		}
		//吉尼的做产品控制
		if(factoryid.equals("16855")||factoryid.equals("1524")){
			agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=16855 " );
		}
		//山推挖机的不推送
		if(factoryid.equals("152")){
			agentList = null;
		}
		//英轩写死
		if(factoryid.equals("1777")){
			//英轩暂时停止
			 if(CommonString.getFormatPara(one_proform.get("name")).indexOf("D")>=0||CommonString.getFormatPara(one_proform.get("name")).indexOf("L")>=0||CommonString.getFormatPara(one_proform.get("name")).indexOf("T")>=0||CommonString.getFormatPara(one_proform.get("name")).indexOf("W")>=0){
		         agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=16776 " );
		     }else{
				 agentList=null;
			 }
		}
		//龙工的做下类别判断
		if(factoryid.equals("135")){
		    //龙工装载机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")!=-1){	
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16350  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//龙工推土机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16349 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//龙工挖掘机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16348 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}			
			//龙工旋挖钻
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("105003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16347  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//龙工路面机械
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("106001")!=-1){
				//agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
				if(province.indexOf("浙江")>=0||province.indexOf("上海")>=0||province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("河北")>=0||province.indexOf("西藏")>=0||province.indexOf("新疆")>=0||province.indexOf("贵州")>=0||province.indexOf("青海")>=0||province.indexOf("甘肃")>=0||province.indexOf("云南")>=0){
					//一部分给装载机
					agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16350  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
				    //agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			    }else{
					//一部分给叉车
					agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
				}
			}
			//龙工叉车
		    if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("107")!=-1||CommonString.getFormatPara(one_proform.get("catanum")).indexOf("118004")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			agentList=null;
		}
		//雷沃做下判断
		if(factoryid.equals("141")&&1==2){
			//挖掘机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")!=-1){	
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=14245  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}
			//装载机
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")!=-1){	
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=14244  and is_cooperate=1 and push_show!=1   and  city_num like '%"+areaNum+"%'" );
			}				
		}
		if(factoryid.equals("141")){
			//agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16840 " );
		}
		if(factoryid.equals("141")){
			agentList=null;
		}
		//山推别的系的不推送	
	    if(factoryid.equals("144")&&CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")==-1){	
		    agentList=null;
		}	
		//柳工推土机的判断
		if(factoryid.equals("136")){
			agentList=null;
            if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101003")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16658 " );
			}
			//else{
			//	agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id!=16658  and  is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+CommonString.getFormatPara(one_proform.get("factoryid"))+"%'  and  city_num like '%"+areaNum+"%'" );
			//}
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18866 " );
			}
			if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")>=0||CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101005")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18865 " );
			}
		}
		if(factoryid.equals("209") ){//徐工基础		
			agentList=null;
			if(jr_catalogname.indexOf("钻机")>=0||jr_catalogname.indexOf("连续墙")>=0||jr_catalogname.indexOf("水平定向钻")>=0||jr_catalogname.indexOf("采煤机")>=0||jr_catalogname.indexOf("掘进机")>=0){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16860 " );
			}
		}
		if(factoryid.equals("142") ){//山河智能机型判断		
			agentList=null;
			if(jr_catalogname.indexOf("挖掘机")>=0){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18869 " );
			}
			if(jr_catalogname.indexOf("旋挖钻")>=0){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18863 " );
			}
		}
		
		//临工 订单宝推送wyn
		if(factoryid.equals("137")){
            agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18845 " );
		    if("102003".equals(CommonString.getFormatPara(one_proform.get("catanum")))){
				agentList=null;
			}
			if(jr_proid.equals("10068")||jr_proid.equals("7182")){
				agentList=null;
			}
		}
		//徐工随车起重机代理商
	    if(factoryid.equals("209")&&CommonString.getFormatPara(one_proform.get("catanum")).equals("102006")){	
		     agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=18938 " );
		}
		if(null!=agentList&&agentList.size() > 0){
		for(Map mm : agentList){
        usern="";	person_id="0";	   
		agent_id=CommonString.getFormatPara(mm.get("id"));
		List<Map> list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});
		
		//龙工的做下类别判断
		if(factoryid.equals("135")){
		    //龙工几款装载机
			if(theProId.equals("7592")||theProId.equals("7609")||theProId.equals("7608")||theProId.equals("7607")||theProId.equals("21539")||theProId.equals("21541")||theProId.equals("15875")||theProId.equals("15874")||theProId.equals("15872")||theProId.equals("7588")||theProId.equals("7539")||theProId.equals("4397")||theProId.equals("7538")||theProId.equals("21540")||theProId.equals("7584")||theProId.equals("7586")||theProId.equals("7585")||theProId.equals("7587")||theProId.equals("7589")||theProId.equals("7590")||theProId.equals("768")||theProId.equals("763")||theProId.equals("766")){

				list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});		
			}else {
				list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id!=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});			
			}
			if(province.indexOf("浙江")>=0||province.indexOf("上海")>=0||province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("河北")>=0||province.indexOf("西藏")>=0||province.indexOf("新疆")>=0||province.indexOf("贵州")>=0||province.indexOf("青海")>=0||province.indexOf("甘肃")>=0||province.indexOf("云南")>=0){
			    if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("106001")!=-1){
					list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});		
				}
			}
			list=null;
		}
		
		if(null!=list){
				for(Map m : list){			  
				   String nums=CommonString.getFormatPara(m.get("city_num"));
				   if(!nums.equals("")){
				      String  []citys=nums.split(",");
					  if(citys.length>0){
					        for(int i=0;i<citys.length;i++){
					              Map areaInfo = dbHelper.getMap(" select   area_name from comm_area   where area_id = ? ",new Object [] {citys[i]});
                                     if(areaInfo!=null){
									    if(city.equals(CommonString.getFormatPara(areaInfo.get("area_name")))||city.indexOf(CommonString.getFormatPara(areaInfo.get("area_name")))>=0|| CommonString.getFormatPara(areaInfo.get("area_name")).indexOf(city)>=0){
														    person_id=CommonString.getFormatPara(m.get("id"));
															usern=CommonString.getFormatPara(m.get("usern"));
															break;
										}
									 }								  
                            }
					  }
				   }
				}				
		}
		
			//雷沃的特殊人群做一些判断
			if(agent_id.equals("16840")){
			if(cata_name.indexOf("装载")>=0&&(province.indexOf("天津")>=0||city.indexOf("廊坊")>=0||city.indexOf("保定")>=0||city.indexOf("沧州")>=0||city.indexOf("石家庄")>=0||city.indexOf("邢台")>=0||city.indexOf("邯郸")>=0||city.indexOf("衡水")>=0)){
				person_id="482";
				usern="ligq";
			}
			if(cata_name.indexOf("挖掘")>=0&&province.indexOf("上海")>=0 ){
				person_id="506";
				usern="cheyj";
			}
			if( (cata_name.indexOf("装载")>=0&&province.indexOf("上海")>=0) || province.indexOf("浙江")>=0 ){
				person_id="499";
				usern="wangfw";
			}
			if((city.indexOf("济宁")>=0||city.indexOf("泰安")>=0||city.indexOf("聊城")>=0||city.indexOf("菏泽")>=0||city.indexOf("莱芜")>=0||city.indexOf("济南")>=0||city.indexOf("德州")>=0)||(city.indexOf("滨州")>=0&&cata_name.indexOf("装载")>=0)){
				person_id="504";
				usern="lily";
			}
			if((city.indexOf("青岛")>=0||city.indexOf("日照")>=0||city.indexOf("潍坊")>=0||city.indexOf("烟台")>=0||city.indexOf("威海")>=0||city.indexOf("临沂")>=0||city.indexOf("东营")>=0||city.indexOf("枣庄")>=0||city.indexOf("淄博")>=0)||(city.indexOf("滨州")>=0&&cata_name.indexOf("挖掘")>=0)){
			    person_id="503";
				usern="zhaonb";
			}
			
			if((province.indexOf("北京")>=0)||(province.indexOf("天津")>=0&&cata_name.indexOf("挖掘")>=0)||(city.indexOf("承德")>=0||city.indexOf("张家口")>=0||city.indexOf("唐山")>=0||city.indexOf("秦皇岛")>=0)||(city.indexOf("廊坊")>=0&&cata_name.indexOf("挖掘")>=0)||(city.indexOf("保定")>=0&&cata_name.indexOf("挖掘")>=0)){
			    person_id="501";
				usern="chengh";
			}
			}
			
			if(factoryid.equals("136")){
				if(catanum.indexOf("101002")>=0){//装载机
					if(province.indexOf("北京")>=0||province.indexOf("天津")>=0||city.indexOf("唐山")>=0){
						person_id="711";
					}
					if(province.indexOf("山西")>=0||(province.indexOf("河北")>=0 && city.indexOf("唐山")<0)){
						person_id="712";
					}
					if(province.indexOf("陕西")>=0||province.indexOf("宁夏")>=0){
						person_id="713";
					}
					if(province.indexOf("山东")>=0||province.indexOf("河南")>=0){
						person_id="724";
					}
					if(province.indexOf("福建")>=0||province.indexOf("江苏")>=0||city.indexOf("温州")>=0||city.indexOf("宁波")>=0||city.indexOf("绍兴")>=0||city.indexOf("舟山")>=0||city.indexOf("丽水")>=0||city.indexOf("台州")>=0){
						person_id="714";
					}
					if(province.indexOf("广东")>=0||province.indexOf("海南")>=0){
						person_id="715";
					}
					if(province.indexOf("云南")>=0||province.indexOf("贵州")>=0){
						person_id="716";
					}
					if(province.indexOf("四川")>=0||province.indexOf("重庆")>=0){
						person_id="717";
					}
					if(province.indexOf("西藏")>=0||province.indexOf("青海")>=0){
						person_id="718";
					}
					if(province.indexOf("广西")>=0||province.indexOf("湖南")>=0){
						person_id="719";
					}
					if(province.indexOf("新疆")>=0||province.indexOf("甘肃")>=0){
						person_id="720";
					}
					if(province.indexOf("内蒙古")>=0){
						person_id="721";
					}
					if(province.indexOf("黑龙江")>=0||province.indexOf("吉林")>=0||province.indexOf("辽宁")>=0||province.indexOf("安徽")>=0){
						person_id="722";
					}
					if(province.indexOf("湖北")>=0||province.indexOf("江西")>=0||province.indexOf("上海")>=0||city.indexOf("金华")>=0||city.indexOf("衢州")>=0||city.indexOf("杭州")>=0||city.indexOf("湖州")>=0||city.indexOf("嘉兴")>=0){
						person_id="723";
					}
				}
				if(catanum.indexOf("101005002")>=0){//平地机
					if(province.indexOf("贵州")>=0||province.indexOf("四川")>=0||province.indexOf("云南")>=0||province.indexOf("西藏")>=0||province.indexOf("重庆")>=0||province.indexOf("陕西")>=0||province.indexOf("甘肃")>=0||province.indexOf("宁夏")>=0||province.indexOf("青海")>=0||province.indexOf("新疆")>=0){
						person_id="727";
					}
					if(province.indexOf("内蒙")>=0||province.indexOf("山西")>=0||province.indexOf("河南")>=0||province.indexOf("河北")>=0){
						person_id="728";
					}
					if(province.indexOf("山东")>=0||province.indexOf("江苏")>=0||province.indexOf("浙江")>=0||province.indexOf("福建")>=0||province.indexOf("安徽")>=0){
						person_id="729";
					}
					if(province.indexOf("江西")>=0||province.indexOf("湖北")>=0||province.indexOf("湖南")>=0||province.indexOf("广西")>=0||province.indexOf("广东")>=0||province.indexOf("海南")>=0){
						person_id="730";
					}
					if(province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("辽宁")>=0||province.indexOf("吉林")>=0||province.indexOf("黑龙江")>=0){
						person_id="731";
					}
				}
				if(catanum.indexOf("101001")>=0){//挖掘机
					if(province.indexOf("河南")>=0){
						person_id="732";
					}
					if(province.indexOf("山东")>=0){
						person_id="733";
					}
					if(city.indexOf("抚顺")>=0||city.indexOf("铁岭")>=0||city.indexOf("朝阳")>=0||city.indexOf("锦州")>=0||city.indexOf("葫芦岛")>=0||city.indexOf("阜新")>=0){
						person_id="734";
					}
					if(city.indexOf("沈阳")>=0||city.indexOf("鞍山")>=0||city.indexOf("丹东")>=0||city.indexOf("辽阳")>=0||city.indexOf("盘锦")>=0||city.indexOf("大连")>=0||city.indexOf("营口")>=0||city.indexOf("本溪")>=0){
						person_id="735";
					}
					if(province.indexOf("吉林")>=0){
						person_id="736";
					}
					if(province.indexOf("黑龙江")>=0){
						person_id="737";
					}
					if(province.indexOf("内蒙古")>=0){
						person_id="738";
					}
					if(province.indexOf("山西")>=0&&city.indexOf("阳泉")<0){
						person_id="739";
					}
					if(city.indexOf("邢台")>=0||city.indexOf("邯郸")>=0){
						person_id="740";
					}
					if(city.indexOf("石家庄")>=0||city.indexOf("保定")>=0||city.indexOf("沧州")>=0||city.indexOf("衡水")>=0||city.indexOf("阳泉")>=0){
						person_id="741";
					}
					if(city.indexOf("唐山")>=0||city.indexOf("秦皇岛")>=0){
						person_id="742";
					}
					if(province.indexOf("北京")>=0||city.indexOf("张家口")>=0||city.indexOf("承德")>=0||city.indexOf("廊坊")>=0){
						person_id="743";
					}
					if(province.indexOf("天津")>=0){
						person_id="744";
					}
					if(province.indexOf("广西")>=0){
						person_id="745";
					}
					if(province.indexOf("湖南")>=0){
						person_id="746";
					}
					if(province.indexOf("广东")>=0&&city.indexOf("湛江")<0&&city.indexOf("茂名")<0&&city.indexOf("阳江")<0){
						person_id="747";
					}
					if(city.indexOf("湛江")>=0||city.indexOf("茂名")>=0||city.indexOf("阳江")>=0){
						person_id="748";
					}
					if(province.indexOf("海南")>=0){
						person_id="749";
					}
					if(province.indexOf("江西")>=0){
						person_id="750";
					}
					if(province.indexOf("上海")>=0||(province.indexOf("江苏")>=0)&&city.indexOf("徐州")<0){
						person_id="751";
					}
					if(province.indexOf("福建")>=0){
						person_id="752";
					}
					if(province.indexOf("湖北")>=0){
						person_id="753";
					}
					if(province.indexOf("浙江")>=0){
						person_id="754";
					}
					if(province.indexOf("安徽")>=0||city.indexOf("徐州")>=0){
						person_id="755";
					}
					if(province.indexOf("甘肃")>=0||province.indexOf("宁夏")>=0||province.indexOf("青海")>=0){
						person_id="756";
					}
					if(province.indexOf("新疆")>=0){
						person_id="757";
					}
					if(province.indexOf("西藏")>=0){
						person_id="758";
					}
					if(province.indexOf("陕西")>=0){
						person_id="759";
					}
					if(province.indexOf("云南")>=0){
						person_id="760";
					}
					if(province.indexOf("贵州")>=0){
						person_id="761";
					}
					if(province.indexOf("四川")>=0&&city.indexOf("达州")<0){
						person_id="762";
					}
					if(province.indexOf("重庆")>=0||city.indexOf("达州")>=0){
						person_id="763";
					}
				}
			}
			if(factoryid.equals("142")){//山河智能刚改的
				if(province.indexOf("江西")>=0){
					person_id="764";
				}
				if(province.indexOf("北京")>=0||(province.indexOf("河北")>=0&&city.indexOf("秦皇岛")<0&&city.indexOf("唐山")<0)){
					person_id="765";
				}
				if(province.indexOf("海南")>=0||city.indexOf("来宾")>=0||city.indexOf("贵港")>=0||city.indexOf("柳州")>=0||city.indexOf("桂林")>=0||city.indexOf("贺州")>=0||city.indexOf("梧州")>=0){
					person_id="766";
				}
				if(province.indexOf("湖北")>=0){
					person_id="767";
				}
				if(city.indexOf("济南")>=0||city.indexOf("泰安")>=0||city.indexOf("济宁")>=0||city.indexOf("枣庄")>=0||city.indexOf("临沂")>=0||city.indexOf("菏泽")>=0||city.indexOf("聊城")>=0||city.indexOf("德州")>=0||city.indexOf("滨州")>=0||city.indexOf("东营")>=0||city.indexOf("淄博")>=0||city.indexOf("莱芜")>=0){
					person_id="768";
				}
				if(province.indexOf("上海")>=0){
					person_id="769";
				}
				if(city.indexOf("南京")>=0||city.indexOf("苏州")>=0||city.indexOf("无锡")>=0||city.indexOf("常州")>=0||city.indexOf("镇江")>=0){
					person_id="770";
				}
				if(city.indexOf("合肥")>=0||city.indexOf("阜阳")>=0||city.indexOf("蚌埠")>=0||city.indexOf("宿州")>=0||city.indexOf("滁州")>=0||city.indexOf("淮南")>=0||city.indexOf("淮北")>=0||city.indexOf("亳州")>=0){
					person_id="771";
				}
				if(city.indexOf("六安")>=0||city.indexOf("巢湖")>=0||city.indexOf("马鞍山")>=0||city.indexOf("安庆")>=0||city.indexOf("池州")>=0||city.indexOf("黄山")>=0||city.indexOf("宣城")>=0||city.indexOf("芜湖")>=0||city.indexOf("铜陵")>=0){
					person_id="773";
				}
				if(city.indexOf("南阳")>=0||city.indexOf("平顶山")>=0||city.indexOf("新乡")>=0||city.indexOf("鹤壁")>=0||city.indexOf("濮阳")>=0||city.indexOf("郑州")>=0){
					person_id="774";
				}
				if(city.indexOf("安阳")>=0||city.indexOf("焦作")>=0||city.indexOf("济源")>=0||city.indexOf("洛阳")>=0||city.indexOf("三门峡")>=0||city.indexOf("信阳")>=0||city.indexOf("驻马店")>=0||city.indexOf("漯河")>=0||city.indexOf("许昌")>=0){
					person_id="775";
				}
				if(province.indexOf("湖南")>=0){
					person_id="776";
				}
				if(city.indexOf("西安")>=0||city.indexOf("汉中")>=0||city.indexOf("安康")>=0||city.indexOf("商洛")>=0||city.indexOf("咸阳")>=0||city.indexOf("宝鸡")>=0){
					person_id="777";
				}
				if(city.indexOf("烟台")>=0||city.indexOf("青岛")>=0||city.indexOf("潍坊")>=0||city.indexOf("威海")>=0||city.indexOf("日照")>=0){
					person_id="778";
				}
				if(city.indexOf("扬州")>=0||city.indexOf("泰州")>=0||city.indexOf("南通")>=0||city.indexOf("盐城")>=0||city.indexOf("淮安")>=0||city.indexOf("宿迁")>=0||city.indexOf("徐州")>=0||city.indexOf("连云港")>=0){
					person_id="779";
				}
				if(city.indexOf("周口")>=0||city.indexOf("商丘")>=0||city.indexOf("开封")>=0){
					person_id="780";
				}
				if(province.indexOf("福建")>=0){
					person_id="781";
				}
				if(province.indexOf("山西")>=0){
					person_id="782";
				}
				if(province.indexOf("黑龙江")>=0||province.indexOf("吉林")>=0||province.indexOf("辽宁")>=0){
					person_id="783";
				}
				if(province.indexOf("甘肃")>=0){
					person_id="784";
				}
				if(city.indexOf("百色")>=0||city.indexOf("南宁")>=0||city.indexOf("北海")>=0||city.indexOf("防城港")>=0||city.indexOf("钦州")>=0||city.indexOf("崇左")>=0||city.indexOf("玉林")>=0||city.indexOf("河池")>=0){
					person_id="785";
				}
				if(province.indexOf("广东")>=0){
					person_id="786";
				}
				//if(city.indexOf("泸州")>=0||city.indexOf("自贡")>=0||city.indexOf("内江")>=0||city.indexOf("宜宾")>=0){
				//	person_id="787";
				//}
				if(city.indexOf("银川")>=0||city.indexOf("固原")>=0||city.indexOf("中卫")>=0){
					person_id="788";
				}
				if(city.indexOf("乌鲁木齐")>=0||city.indexOf("北屯")>=0||city.indexOf("塔城")>=0||city.indexOf("克拉玛依")>=0||city.indexOf("奎屯")>=0||city.indexOf("博乐")>=0||city.indexOf("石河子")>=0||city.indexOf("伊宁")>=0||city.indexOf("哈密")>=0||city.indexOf("库尔勒")>=0||city.indexOf("阿克苏")>=0||city.indexOf("和田")>=0){
					person_id="789";
				}
				if(city.indexOf("喀什")>=0||city.indexOf("克孜勒苏柯尔克自治州")>=0){
					person_id="790";
				}
				if(province.indexOf("重庆")>=0||(province.indexOf("云南")>=0&&city.indexOf("曲靖")<0&&city.indexOf("昭通")<0)||(province.indexOf("贵州")>=0&&city.indexOf("黔西")<0&&city.indexOf("六盘水")<0)){
					person_id="791";
				}
				if(province.indexOf("四川")>=0){
					person_id="792";
				}
				if(province.indexOf("浙江")>=0){
					person_id="793";
				}
				if(city.indexOf("宜昌")>=0||city.indexOf("荆州")>=0||city.indexOf("恩施")>=0){
					person_id="767";
				}
				if(city.indexOf("黔西")>=0||city.indexOf("六盘水")>=0){
					person_id="843";
				}
				if(city.indexOf("曲靖")>=0||city.indexOf("昭通")>=0){
					person_id="844";
				}
				if(city.indexOf("渭南")>=0||city.indexOf("铜川")>=0||city.indexOf("延安")>=0){
					person_id="845";
				}
				
			}
			if(factoryid.equals("182")){//小松
				if(agent_id.equals("319")){//西安安松
					person_id = "692";
				}
				if(agent_id.equals("237")){//广东粤松
					person_id = "876";
				}
				if(agent_id.equals("18940")){//青岛小松烟威青
					if(city.indexOf("烟台")>=0||city.indexOf("青岛")>=0||city.indexOf("威海")>=0){
						person_id="870";
					}
				}
				if(agent_id.equals("18945")){//	山东德润丰
					if(city.indexOf("日照")>=0){
						person_id="872";
					}
					if(city.indexOf("济宁")>=0||city.indexOf("临沂")>=0||city.indexOf("枣庄")>=0||city.indexOf("菏泽")>=0){
						person_id="873";
					}
					if(city.indexOf("潍坊")>=0||city.indexOf("淄博")>=0||city.indexOf("滨州")>=0||city.indexOf("东营")>=0){
						person_id="874";
					}
					if(city.indexOf("济南")>=0||city.indexOf("泰安")>=0||city.indexOf("德州")>=0||city.indexOf("聊城")>=0){
						person_id="875";
					}
				}
				if(agent_id.equals("340")){//安徽小松
					person_id = "871";
				}
				if(agent_id.equals("18351")){//河南凯隆
					if(city.indexOf("郑州")>=0){
						person_id="846";
					}
					if(city.indexOf("南阳")>=0){
						person_id="847";
					}
					if(city.indexOf("信阳")>=0){
						person_id="848";
					}
					if(city.indexOf("周口")>=0||city.indexOf("漯河")>=0){
						person_id="849";
					}
					if(city.indexOf("驻马店")>=0){
						person_id="850";
					}
					if(city.indexOf("洛阳")>=0){
						person_id="851";
					}
					if(city.indexOf("安阳")>=0||city.indexOf("濮阳")>=0||city.indexOf("鹤壁")>=0||city.indexOf("新乡")>=0||city.indexOf("焦作")>=0||city.indexOf("济源")>=0){
						person_id="852";
					}
					if(city.indexOf("许昌")>=0||city.indexOf("平顶山")>=0){
						person_id="853";
					}
					if(city.indexOf("开封")>=0||city.indexOf("商丘")>=0){
						person_id="854";
					}
					if(city.indexOf("三门峡")>=0){
						person_id="855";
					}
				}
				if(agent_id.equals("370")){//江苏宁隆
					if(city.indexOf("南京")>=0){
						person_id="856";
					}
					if(city.indexOf("苏州")>=0){
						person_id="857";
					}
					if(city.indexOf("无锡")>=0){
						person_id="858";
					}
					if(city.indexOf("徐州")>=0){
						person_id="859";
					}
					if(city.indexOf("扬州")>=0||city.indexOf("盐城")>=0||city.indexOf("淮安")>=0){
						person_id="860";
					}
					if(city.indexOf("连云港")>=0||city.indexOf("宿迁")>=0){
						person_id="861";
					}
					if(city.indexOf("常州")>=0||city.indexOf("镇江")>=0){
						person_id="862";
					}
					if(city.indexOf("泰州")>=0||city.indexOf("南通")>=0){
						person_id="863";
					}
				}
			}
			if(agent_id.equals("16860")){//徐工基础
				if(jr_catalogname.indexOf("钻机")>=0||jr_catalogname.indexOf("连续墙")>=0||jr_catalogname.indexOf("水平定向钻")>=0||jr_catalogname.indexOf("采煤机")>=0||jr_catalogname.indexOf("掘进机")>=0){
					person_id="809";
				}
			}
			if ("209".equals(factoryid)&&catanum.equals("102006")) {//徐工起重机
                   person_id="866";
                   usern="xcmgscqzj";
			}
             System.out.println("==========="+person_id+usern+agent_id);
             if(!person_id.equals("0")||agent_id.equals("16776")||factoryid.equals("14238")){	
            //把订单推给合作的代理商订单中 
            String sqlString="";
		    //正式表
			sqlString = "insert into pro_agent_products_form(";
			sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factoryid+",'"+jr_factoryname+"',"+agent_id+",agentname,catanum,'"+jr_catalogname+"',"+jr_proid+",'"+jr_proname+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',"+person_id;
			sqlString += " from pro_product_form WHERE uuid = '"+jr_uuid+"'";
			new_formid = dbHelper.executeUpdate(sqlString);
            }
		 
				

		   
			
			
			 if(!usern.equals("")){
			    System.out.println("============================订单宝推送订单==============================");       
			    //产品中心后台向手机端推送
			    //PushSyncActon push= new PushSyncActon();
				//微信消息推送
				CommonAction commonAction=new CommonAction();
			    int flagno=102001;
			    String orderNo="20150123212321";
			    String machineNo=jr_factoryname+jr_catalogname+jr_proname;
			    //Map proMap = dbHelper.getMap("select img2 from pro_products where id="+CommonString.getFormatPara(orderInfo.get("product_id")));
			    String machineImg="/img/";
			    String createDate=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
			    String linkMan=man; 
			    String linkTel= mobile_phone;
			    String address=province+city;
			    String receiveMan="";
			    int receiveManId=0;
			    int agentId=Integer.parseInt(factoryid);
			    //push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+usern);	
			    if(!linkTel.equals("555-666-0606")){
					commonAction.sendWxMsg(new_formid,"xJx7heYIt8IuqSMLY-wf1eiiozXxP36rP5xw3WycrBc");
				}
				}
			
		       }
		    }
		
		
 	
		
		}
	}
%>