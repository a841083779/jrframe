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
<%  	
	request.setCharacterEncoding("utf-8");
	String productids = CommonString.getFormatPara(request.getParameter("productids")); // 获得产品id
	String uuids = CommonString.getFormatPara(request.getParameter("uuids")); // 订单表单中的uuid
	String factoryid = "";
	DBHelper dbHelper = DBHelper.getInstance();
	String[] productid = null;
	String[] uuid = null;
	String province = null ;
	String catanum = null ;
	//产品信息
	String pro_name="";
	int pro_id=0;
	String jr_message="";

	if (!"".equals(uuids)) {
		uuid = uuids.split(",");
		if (null != uuid && uuid.length == 2) { // 二个产品
			for (int i = 0; i < uuid.length; i++) {
				Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuid[i] + "'");	
				if (null != one_proform) {
					//  因牟总要求我们做三一、斗山线上活动，3.18日之前邮件停发湖南、
					// 山东所有品牌挖掘机的询价信息，请您协助设置处理，谢谢。
				    province = CommonString.getFormatPara(one_proform.get("province")) ;
					catanum = CommonString.getFormatPara(one_proform.get("catanum")) ;
					if((province.indexOf("湖南")!=-1 || province.indexOf("山东")!=-1) && catanum.indexOf("101001")!=-1){
						return ;
					}
					factoryid = CommonString.getFormatPara(one_proform.get("factoryid")); // 获得品牌id		
					String jr_catalogname= CommonString.getFormatPara(one_proform.get("cataname")) ;
			        String jr_factoryname= CommonString.getFormatPara(one_proform.get("factoryname")) ;
			        String jr_proid= CommonString.getFormatPara(one_proform.get("product_id")) ;
			        String jr_proname= CommonString.getFormatPara(one_proform.get("product_name")) ;
			        String jr_uuid= CommonString.getFormatPara(one_proform.get("uuid")) ;
			        
					//如果是挖掘机的某些品牌就给卡特复制出一条订单
			        if(catanum.indexOf("101001001")>=0){
						if(factoryid.equals("482")||factoryid.equals("187")||factoryid.equals("142")||factoryid.equals("14238")||factoryid.equals("190")||factoryid.equals("188")||factoryid.equals("177")||factoryid.equals("191")||factoryid.equals("134")||factoryid.equals("133")||factoryid.equals("182")||factoryid.equals("183")||factoryid.equals("175")||factoryid.equals("194")||factoryid.equals("192")||factoryid.equals("455")||factoryid.equals("179")||factoryid.equals("189")||factoryid.equals("185")||factoryid.equals("16367")||factoryid.equals("16373")){
						Map proMap = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
						int tonandmeter=0;
                        if(proMap!=null){
						   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
						}
						Map pushProMap=null;
						if(tonandmeter<=15){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (20164,20163) order by newid()");
						}else if(tonandmeter<=30){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (9548,400,9550,445,11366,390,3503) order by newid()");
						}else{
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (3525,19946,9551,522,403,9552,9553,407,9554,9555) order by newid()  " );
						}
						if(pushProMap!=null){
							 pro_id=CommonString.getFormatInt(pushProMap.get("id"));
							 pro_name=CommonString.getFormatPara(pushProMap.get("name"));
							 jr_message="我对卡特彼勒"+pro_name+"感兴趣，请联系我";
						}
			            String sqlCopyString = "insert into pro_product_form(";
			            sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
			            sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,174,'卡特彼勒',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',disposal_content,state,province,city,mobile_phone,view_count,'"+CommonString.getUUID()+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,"+0+","+1+",uuid,buy_type";
			            sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid[i]+"'";
			            dbHelper.execute(sqlCopyString);	
						
						}
			       }
 
			
			//临工订单邮件
			if ("137".equals(factoryid)) {
				    String lingongEmail="liling.xin@sdlg.com.cn";
					if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")>=0){
						lingongEmail="zhijun.zhang@sdlg.com.cn";
					}
					if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")>=0){
						lingongEmail="min.liu@sdlg.com.cn";
					}
						WEBEmail.sendMailByUrl(lingongEmail, "wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
			}
			//洋马订单邮件
			if ("191".equals(factoryid)) {
				    String ymEmail="jun_yao@yanmar.com";
						WEBEmail.sendMailByUrl(ymEmail, "qimeng_hu@yanmar.com,mujie@21-sun.com,wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
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
					if ("184".equals(factoryid)) {
						
						String phone_to_agent="";
						if(province.indexOf("山东")!=-1||province.indexOf("河北")!=-1||province.indexOf("北京")!=-1||province.indexOf("天津")!=-1){
						WEBEmail.sendMailByUrl("x.wang.zd@hitachi-kenki.com,t.hayashi.tv@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
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
						WEBEmail.sendMailByUrl("y.liu.ie@hitachi-kenki.com,x.gu.ib@hitachi-kenki.com,t.hayashi.tv@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
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
						//Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat.jsp?uuid=" + uuids, one_proform);
				    } 
					else if ("133".equals(factoryid)) { // 三一订单推送接口
						Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/sany_admin.jsp?uuid=" + uuids, one_proform);
					} else if ("138".equals(factoryid)) { // 山工挖掘机订单推送接口
						Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/shangong_admin.jsp?uuid=" + uuids, one_proform);
					} else if ("209".equals(factoryid)) { // 徐工单独发送邮件
						String content="";
						content+="姓名:"+CommonString.getFormatPara(one_proform.get("name"))+"\r";
						content+="省份:"+CommonString.getFormatPara(one_proform.get("province"))+"\r";
						content+="城市:"+CommonString.getFormatPara(one_proform.get("city"))+"\r";
						content+="所属产品线:"+CommonString.getFormatPara(one_proform.get("cataname"))+"\r";
						content+="联系电话:"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"\r";
						content+="邮箱:"+CommonString.getFormatPara(one_proform.get("email"))+"\r";
						content+="内容:"+CommonString.getFormatPara(one_proform.get("message"))+"\r";
						WEBEmail.sendMail("service@xgmg.com","","webcall",content);
					} else if (!"".equals(factoryid)) {
						Map one_factory = dbHelper.getMap(" select email from pro_agent_factory where id ='" + factoryid + "'");
						String emails = CommonString.getFormatPara(one_factory.get("email"));
						if (!"".equals(emails) && emails.indexOf(",") != -1 && emails.indexOf("@") != -1) {
							String[] email = emails.split(",");
							for (int j = 0; email.length > 0 && j < email.length; j++) {
								if (email[j].length() > 0 && email[j].indexOf("@") != -1) {
									WEBEmail.sendMailByUrl(email[j], null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
											+ CommonString.getFormatPara(one_proform.get("product_name"))
											+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
											"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
									WEBEmail.sendMailByUrl("mujie@21-sun.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
											+ CommonString.getFormatPara(one_proform.get("product_name"))
											+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
											"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
								}
							}
						} else {
							WEBEmail.sendMailByUrl(emails, null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
									+ CommonString.getFormatPara(one_proform.get("product_name"))
									+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
									"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
							WEBEmail.sendMailByUrl("mujie@21-sun.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
									+ CommonString.getFormatPara(one_proform.get("product_name"))
									+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
									"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
						}
					}
					WEBEmail.sendMailByUrl("mujie@21-sun.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
							+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
							+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i],
							"utf-8");
							
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
		
		
		List<Map> agentList = dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+CommonString.getFormatPara(one_proform.get("factoryid"))+"%'  and  city_num like '%"+areaNum+"%'" );
       
        //英轩写死
		if(factoryid.equals("1777")){
		     agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=16776 " );
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
		if(factoryid.equals("141")){
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
            if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101003")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16658 " );
			}else{
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id!=16658  and  is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+CommonString.getFormatPara(one_proform.get("factoryid"))+"%'  and  city_num like '%"+areaNum+"%'" );
			}
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
			            dbHelper.execute(sqlString);
			        }
			}
		  
			
			
			 if(!usern.equals("")){
			    System.out.println("============================订单宝推送订单==============================");       
			    //产品中心后台向手机端推送
			    PushSyncActon push= new PushSyncActon();
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
			    push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+usern);	
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
			        dbHelper.execute(sqlString);

			PushSyncActon push= new PushSyncActon();
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
			push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+specialPersonUsern);	
        }
				
			}
			
			
			
		}
				
				
		}
			

			
			
			
					

			
			
			
			
			
			
		} else { // 一个产品
			Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuids + "'");
			factoryid = CommonString.getFormatPara(one_proform.get("factoryid")); // 获得品牌id		
			province = CommonString.getFormatPara(one_proform.get("province")) ;
			String city = CommonString.getFormatPara(one_proform.get("city"));
            String mobile_phone = CommonString.getFormatPara(one_proform.get("mobile_phone"));
			String man= CommonString.getFormatPara(one_proform.get("name"));
			String theProId= CommonString.getFormatPara(one_proform.get("product_id"));
			//  因牟总要求我们做三一、斗山线上活动，3.18日之前邮件停发湖南、
			// 山东所有品牌挖掘机的询价信息，请您协助设置处理，谢谢。
			/**
		    province = CommonString.getFormatPara(one_proform.get("province")) ;
			catanum = CommonString.getFormatPara(one_proform.get("catanum")) ;
			if((province.indexOf("湖南")!=-1 || province.indexOf("山东")!=-1) && catanum.indexOf("101001")!=-1){
				return ;
		   	}*/
			String jr_catalogname= CommonString.getFormatPara(one_proform.get("cataname")) ;
			String jr_factoryname= CommonString.getFormatPara(one_proform.get("factoryname")) ;
			String jr_proid= CommonString.getFormatPara(one_proform.get("product_id")) ;
			String jr_proname= CommonString.getFormatPara(one_proform.get("product_name")) ;
			String jr_uuid= CommonString.getFormatPara(one_proform.get("uuid")) ;
			catanum = CommonString.getFormatPara(one_proform.get("catanum")) ;
			
			
					//如果是挖掘机的某些品牌就给卡特复制出一条订单
			        if(catanum.indexOf("101001001")>=0){
						if(factoryid.equals("482")||factoryid.equals("187")||factoryid.equals("142")||factoryid.equals("14238")||factoryid.equals("190")||factoryid.equals("188")||factoryid.equals("177")||factoryid.equals("191")||factoryid.equals("134")||factoryid.equals("133")||factoryid.equals("182")||factoryid.equals("183")||factoryid.equals("175")||factoryid.equals("194")||factoryid.equals("192")||factoryid.equals("455")||factoryid.equals("179")||factoryid.equals("189")||factoryid.equals("185")||factoryid.equals("16367")||factoryid.equals("16373")){
						Map proMap = dbHelper.getMap(" select  tonandmeter   from pro_products   where  id= "+jr_proid );
						int tonandmeter=0;
                        if(proMap!=null){
						   tonandmeter=CommonString.getFormatInt(proMap.get("tonandmeter"));
						}
						Map pushProMap=null;
						if(tonandmeter<=15){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (20164,20163) order by newid()");
						}else if(tonandmeter<=30){
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (9548,400,9550,445,11366,390,3503) order by newid()");
						}else{
							pushProMap = dbHelper.getMap(" select top 1  id,name   from pro_products   where  id  in (3525,19946,9551,522,403,9552,9553,407,9554,9555) order by newid()  " );
						}
						if(pushProMap!=null){
							 pro_id=CommonString.getFormatInt(pushProMap.get("id"));
							 pro_name=CommonString.getFormatPara(pushProMap.get("name"));
							 jr_message="我对卡特彼勒"+pro_name+"感兴趣，请联系我";
						}
			            String sqlCopyString = "insert into pro_product_form(";
			            sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
			            sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,174,'卡特彼勒',0,agentname,catanum,'挖掘机',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',disposal_content,state,province,city,mobile_phone,view_count,'"+CommonString.getUUID()+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,"+0+","+1+",uuid,buy_type";
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
			        dbHelper.execute(sqlString);

			PushSyncActon push= new PushSyncActon();
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
			push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+specialPersonUsern);	
        }
				
			}
			
			
			
		}
			
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
			//临工订单邮件
			if ("137".equals(factoryid)) {
				    String lingongEmail="liling.xin@sdlg.com.cn";
					if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")>=0){
						lingongEmail="zhijun.zhang@sdlg.com.cn";
					}
					if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")>=0){
						lingongEmail="min.liu@sdlg.com.cn";
					}
						WEBEmail.sendMailByUrl(lingongEmail, "wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
						.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name"))
						+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
						"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
			}
			//洋马订单邮件
			if ("191".equals(factoryid)) {
				        String ymEmail="jun_yao@yanmar.com";
						WEBEmail.sendMailByUrl(ymEmail, "qimeng_hu@yanmar.com,mujie@21-sun.com,wangll@21-sun.com", null, CommonString.getFormatPara(one_proform
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
			//把来自日立的订单发送给客户
			if ("184".equals(factoryid)) {
				
				
						String phone_to_agent="";
						if(province.indexOf("山东")!=-1||province.indexOf("河北")!=-1||province.indexOf("北京")!=-1||province.indexOf("天津")!=-1){
						WEBEmail.sendMailByUrl("x.wang.zd@hitachi-kenki.com,t.hayashi.tv@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
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
						WEBEmail.sendMailByUrl("y.liu.ie@hitachi-kenki.com,x.gu.ib@hitachi-kenki.com,t.hayashi.tv@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com", "", null, CommonString.getFormatPara(one_proform
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
				//Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat.jsp?uuid=" + uuids, one_proform);
			 }else if ("133".equals(factoryid)) { // 三一订单推送接口
				Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/sany_admin.jsp?uuid=" + uuids, one_proform);
			 }else if ("138".equals(factoryid)) { // 山工挖掘机订单推送接口
				Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/shangong_admin.jsp?uuid=" + uuids, one_proform);
			 }else if ("209".equals(factoryid)) { // 徐工单独发送邮件
				String content="";
				content+="姓名:"+CommonString.getFormatPara(one_proform.get("name"))+"<br />";
				content+="省份:"+CommonString.getFormatPara(one_proform.get("province"))+"<br />";
				content+="城市:"+CommonString.getFormatPara(one_proform.get("city"))+"<br />";
				content+="所属产品线:"+CommonString.getFormatPara(one_proform.get("cataname"))+"<br />";
				content+="联系电话:"+CommonString.getFormatPara(one_proform.get("mobile_phone"))+"<br />";
				content+="邮箱:"+CommonString.getFormatPara(one_proform.get("email"))+"<br />";
				content+="内容:"+CommonString.getFormatPara(one_proform.get("message"))+"<br />";
				WEBEmail.sendMail("service@xgmg.com","","webcall",content);
			}
			
			 else if("1742".equals(factoryid)){ //林德单独邮件发送  分地域
			       /*
			       //Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuids + "'");
			      if("福建".equals(one_proform.get("province"))||"四川".equals(one_proform.get("province"))||"重庆".equals(one_proform.get("province"))||"湖南".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("xm.tm-region@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("北京".equals(one_proform.get("province"))||"天津".equals(one_proform.get("province"))||"内蒙古".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("beijing.tm@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("辽宁".equals(one_proform.get("province"))||"河北".equals(one_proform.get("province"))||"山东".equals(one_proform.get("province"))||"吉林".equals(one_proform.get("province"))){
				  //
				  				 WEBEmail.sendMailByUrl("amily.xin@hotmail.com,1085103026@qq.com", "mujie@21-sun.com",null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("安徽".equals(one_proform.get("province"))||"江苏".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("sz.marketing-region@linde-china.com",  "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("浙江".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("sh.mkt-region@linde-china.com",  "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("上海".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("sh.mkt-region@linde-china.com",  "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("广东".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("guangzhou.telemarket@linde-china.com",  "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("陕西".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("31727621@qq.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("河南".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("新疆".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("山西".equals(one_proform.get("province"))){
				  			     WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("海南".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("广西".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("黑龙江".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("江西".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("湖北".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("甘肃".equals(one_proform.get("province"))||"青海".equals(one_proform.get("province"))||"宁夏".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  else if("云南".equals(one_proform.get("province"))||"贵州".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("dealersupport@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }else{
				  				 WEBEmail.sendMailByUrl("marketing@linde-china.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname"))+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				  */
			 }
		   	
			 else if("1220".equals(factoryid)){ //华通动力-20140707
				 //华东区（江苏、安徽、浙江、江西）
			      if("江苏".equals(one_proform.get("province"))||"安徽".equals(one_proform.get("province"))||"浙江".equals(one_proform.get("province"))||"江西".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("luc@jhkinetics.com", "ganh@jhkinetics.com,mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //华南区（广东、湖北）
				  else if("广东".equals(one_proform.get("province"))||"湖北".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("wangxf@jhkinetics.com", "ganh@jhkinetics.com,mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //西南区（云南、贵州、四川）
				  else if("云南".equals(one_proform.get("province"))||"贵州".equals(one_proform.get("province"))||"四川".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("zhuhb@jhkinetics.com", "ganh@jhkinetics.com,mujie@21-sun.com",null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //华北区（北京、天津、河北、内蒙、山东）
				  else if("北京".equals(one_proform.get("province"))||"天津".equals(one_proform.get("province"))||"河北".equals(one_proform.get("province"))||"内蒙".equals(one_proform.get("province"))||"山东".equals(one_proform.get("province"))){
				  				 WEBEmail.sendMailByUrl("yuhq@jhkinetics.com",  "ganh@jhkinetics.com,mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //西北区（新疆、青海、河南、甘肃、陕西、山西、宁夏）
				  else if("新疆".equals(one_proform.get("province"))||"青海".equals(one_proform.get("province"))||"河南".equals(one_proform.get("province"))||"甘肃".equals(one_proform.get("province"))||"陕西".equals(one_proform.get("province"))||"山西".equals(one_proform.get("province"))||"宁夏".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("yangzs@jhkinetics.com",  "ganh@jhkinetics.com,mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }
				 //东北区（黑龙江、吉林、辽宁）
				  else if("黑龙江".equals(one_proform.get("province"))||"吉林".equals(one_proform.get("province"))||"辽宁".equals(one_proform.get("province"))){
				  				WEBEmail.sendMailByUrl("wuqz@jhkinetics.com",  "ganh@jhkinetics.com,mujie@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				  }else{
				  				 WEBEmail.sendMailByUrl("ganh@jhkinetics.com", "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
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
				Map one_factory = dbHelper.getMap(" select email from pro_agent_factory where id ='" + factoryid + "'");
				String emails = CommonString.getFormatPara(one_factory.get("email"));
				if (!"".equals(emails) && emails.indexOf(",") != -1 && emails.indexOf("@") != -1) {
					String[] email = emails.split(",");
					for (int i = 0; email.length > 0 && i < email.length; i++) {
						if (email[i].length() > 0 && email[i].indexOf("@") != -1) {
							WEBEmail.sendMailByUrl(email[i], "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
									+ CommonString.getFormatPara(one_proform.get("product_name"))
									+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
									"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						}
					}
				} else {
					WEBEmail.sendMailByUrl(emails, "mujie@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
							+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
							+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids,
							"utf-8");
				}
			}
			WEBEmail.sendMailByUrl("mujie@21-sun.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
				+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
					+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
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
		
		
		List<Map> agentList = dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+factoryid+"%'  and  city_num like '%"+areaNum+"%'" );
        
		//英轩写死
		if(factoryid.equals("1777")){
		     agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=16776 " );
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
		if(factoryid.equals("141")){
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
            if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101003")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16658 " );
			}else{
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id!=16658  and  is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+CommonString.getFormatPara(one_proform.get("factoryid"))+"%'  and  city_num like '%"+areaNum+"%'" );
			}
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
			dbHelper.execute(sqlString);
}
			}
				
		   
			
			
			 if(!usern.equals("")){
			    System.out.println("============================订单宝推送订单==============================");       
			    //产品中心后台向手机端推送
			    PushSyncActon push= new PushSyncActon();
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
			    push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+usern);	
			    }
			
		       }
		    }
		
		
		
		
		}
	}
%>