<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.util.common.Common"%>
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
					//把来自日立的订单发送给客户和宛树
					if ("184".equals(factoryid)) {
						WEBEmail.sendMailByUrl("zhang.guo.jun@hitachi-kenki.co.jp", "mujie@21-sun.com,wuws@21-sun.com", null, CommonString.getFormatPara(one_proform
								.get("factoryname"))
								+ CommonString.getFormatPara(one_proform.get("product_name"))
								+ CommonString.getFormatPara(one_proform.get("catalogname")) + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD",
								"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i], "utf-8");
					} 
					else if ("174".equals(factoryid)) { // 卡特挖掘机订单推送接口
						//Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat.jsp?uuid=" + uuids, one_proform);
				    } 
					else if ("133".equals(factoryid)) { // 三一订单推送接口
						Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/sany.jsp?uuid=" + uuids, one_proform);
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
				 // WEBEmail.sendMailByUrl("zhanghl@21-sun.com", null, null, CommonString.getFormatPara(one_proform.get("factoryname"))
				//			+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
				//		+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuid[i],
			//				"utf-8");
				}
			}
		} else { // 一个产品
			Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuids + "'");
			factoryid = CommonString.getFormatPara(one_proform.get("factoryid")); // 获得品牌id		
			//  因牟总要求我们做三一、斗山线上活动，3.18日之前邮件停发湖南、
			// 山东所有品牌挖掘机的询价信息，请您协助设置处理，谢谢。
			/**
		    province = CommonString.getFormatPara(one_proform.get("province")) ;
			catanum = CommonString.getFormatPara(one_proform.get("catanum")) ;
			if((province.indexOf("湖南")!=-1 || province.indexOf("山东")!=-1) && catanum.indexOf("101001")!=-1){
				return ;
		   	}*/
			//把来自日立的订单发送给客户和宛树
			if ("184".equals(factoryid)) {
				  WEBEmail.sendMailByUrl("zhang.guo.jun@hitachi-kenki.co.jp", "mujie@21-sun.com,wuws@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
						+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
						+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
			}else if ("174".equals(factoryid)) { // 卡特挖掘机订单推送接口
				//Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/cat.jsp?uuid=" + uuids, one_proform);
			 }else if ("133".equals(factoryid)) { // 三一订单推送接口
				Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/sany.jsp?uuid=" + uuids, one_proform);
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
			 
			 
			else if("135".equals(factoryid)){  // 龙工分类别机型发送邮件
				//叉车
				if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("107")!=-1){  
					WEBEmail.sendMailByUrl("salescc@lonking.cn,postmaster@lonking.cn", "mujie@21-sun.com,sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
							+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
								+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}
				//滑移
				if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002009")!=-1){
				
							WEBEmail.sendMailByUrl("lmyx@lonking.cn,postmaster@lonking.cn", "mujie@21-sun.com,sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
				+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
					+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}
				//旋挖钻
				if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("105")!=-1){
					WEBEmail.sendMailByUrl("yxb@refined.hk,postmaster@lonking.cn", "mujie@21-sun.com,sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
							+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
								+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}
				//挖机
				if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101001")!=-1){

				
							WEBEmail.sendMailByUrl("ws@lonking.cn,postmaster@lonking.cn", "mujie@21-sun.com,sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
				+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
					+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}
				//推土机
				if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101003")!=-1){
					WEBEmail.sendMailByUrl("lqlily@lonking.cn,postmaster@lonking.cn", "mujie@21-sun.com,sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
							+ CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
								+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
				}
				//装载机
				if(CommonString.getFormatPara(one_proform.get("catanum")).indexOf("101002")!=-1&&!CommonString.getFormatPara(one_proform.get("catanum")).equals("101002009")){
					Map pro = dbHelper.getMap("  select  tonandmeter  from pro_products where id=" + CommonString.getFormatPara(one_proform.get("product_id")) + "");	
					if(pro!=null){
					    if((Double)(pro.get("tonandmeter"))<=3.0){
					         WEBEmail.sendMailByUrl("lmyx@lonking.cn,postmaster@lonking.cn", "mujie@21-sun.com,sunwj@21-sun.com",null, CommonString.getFormatPara(one_proform.get("factoryname"))
							 + CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
							 + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
							 }else if((Double)(pro.get("tonandmeter"))>3.0){
							 WEBEmail.sendMailByUrl("scb@lonking.cn,postmaster@lonking.cn", "mujie@21-sun.com,sunwj@21-sun.com", null, CommonString.getFormatPara(one_proform.get("factoryname"))
							 + CommonString.getFormatPara(one_proform.get("product_name")) + CommonString.getFormatPara(one_proform.get("catalogname"))
							 + "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + uuids, "utf-8");
						}
					}
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
		}
	}
%>