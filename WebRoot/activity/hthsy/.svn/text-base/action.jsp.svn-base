<%@ page language="java" import="java.net.URLEncoder,java.util.*,com.jerehnet.util.dbutil.*,java.sql.Connection,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Boolean canSendSms = true;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String rs = "";
	try{
		connection = dbHelper.getConnection();
		if("reg".equals(flag)){
			Map yzm = (Map)session.getAttribute("hthsy_code");
			Integer msgCounts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where CONVERT(varchar(100), reg_date, 1) = '"+CommonDate.getToday("MM/dd/yy")+"' and type_id = 2  ",connection);
			//产生随机码
			Double _td = Math.random()*100000;
			String sui_ji = _td.intValue()+"";
			//优惠码
			String preferential_code = sui_ji;
			//判断是否需要验证码注册
			if(msgCounts<200){//如果一天注册人数小于200，需要验证码注册
				String hthsy_code = "";
				//如果验证码不为空
				if(null!=yzm){
					hthsy_code = CommonString.getFormatPara(yzm.get("code"));
					Long oldDate = (Long)yzm.get("date");
					Long newDate = Calendar.getInstance().getTime().getTime();
					Long _cha = newDate-oldDate;
					int cha = _cha.intValue();
					if(cha<60000){
						String code = CommonString.getFormatPara(request.getParameter("code"));
						//验证码正确
						if(code.equals(hthsy_code)){
							Map param = new HashMap();
							param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
							param.put("name",CommonString.getFormatPara(request.getParameter("name")));
							param.put("city",CommonString.getFormatPara(request.getParameter("city")));
							param.put("model",CommonString.getFormatPara(request.getParameter("model")));
							param.put("preferential_code",preferential_code);
							param.put("ip",Common.getIp(request));
							param.put("type_id","2");
							String myRs = Common.doPost("http://service.21-sun.com/http/web21sun/phone_reg.jsp",param);
							rs = myRs;
							if(rs.indexOf("exist")!=-1){
								rs = "exist";
							}else{
								String smsText = "“宏通好声音,三一挖掘机全城乐享惠”线上挖机订购活动，验证码"+preferential_code+",线上注册可享受购机代金券，当场兑现！0535-6727793";
								param = new HashMap();
						        param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
						        param.put("content",URLEncoder.encode(smsText,"utf-8"));
						        param.put("source","195002");
						        param.put("Referer",Common.getDomain(request)+"/activity/hthsy");
						        if(canSendSms){
						        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
						        }else{
						        	System.out.println(smsText);
						        }
								rs = "ok";
							}
						}else{
							rs = "code_error";
						}
					}else{
						session.removeAttribute("hthsy_code");
						rs = "overtime";
					}
				}else{
					rs = "no_code";
				}
			}else{//如果不需要验证码，正常注册
				Map param = new HashMap();
				param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
				param.put("name",CommonString.getFormatPara(request.getParameter("name")));
				param.put("city",CommonString.getFormatPara(request.getParameter("city")));
				param.put("model",CommonString.getFormatPara(request.getParameter("model")));
				param.put("preferential_code",preferential_code);
				param.put("ip",Common.getIp(request));
				param.put("type_id","2");
				String myRs = Common.doPost("http://service.21-sun.com/http/web21sun/phone_reg.jsp",param);
				rs = myRs;
				if(rs.indexOf("exist")!=-1){
					rs = "exist";
				}else{
					String smsText = "“宏通好声音,三一挖掘机全城乐享惠”线上挖机订购活动，验证码"+preferential_code+",线上注册可享受购机代金券，当场兑现！0535-6727793";
					param = new HashMap();
			        param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
			        param.put("content",URLEncoder.encode(smsText,"utf-8"));
			        param.put("source","195002");
			        param.put("Referer",Common.getDomain(request)+"/activity/hthsy");
			        if(canSendSms){
			        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
			        }else{
			        	System.out.println(smsText);
			        }
					rs = "ok";
				}
			}
		}
		if("getCode".equals(flag)){
			Map codeMap = (Map)session.getAttribute("hthsy_phone");
			Boolean getBool = true;
			//如果获取过验证码
			if(null!=codeMap){
				Long oldDate = (Long)codeMap.get("date");
				Long newDate = Calendar.getInstance().getTime().getTime();
				Long _cha = newDate-oldDate;
				int cha = _cha.intValue();
				//如果是一分钟之内
				if(cha<60000){
					getBool = false;
					rs = "code_no_time";
				}
			}
			if(getBool){
				Map yzm = new HashMap();
				Set<Integer> set = new HashSet<Integer>(); 
				Random random = new Random();
				while (set.size() < 4) {
		            // nextInt返回一个伪随机数，它是取自此随机数生成器序列的、在 0（包括）  
		            // 和指定值（不包括）之间均匀分布的 int 值。  
		            set.add(random.nextInt(10));  
		        }  
				// 使用迭代器  
		        Iterator<Integer> iterator = set.iterator();  
		        // 临时记录数据  
		        String temp = "";  
		        while (iterator.hasNext()) {  
		            temp += iterator.next();
		        }
		        String smsTxt = "您好，本次宏通好声音活动的短信口令为："+temp+"。【中国工程机械商贸网】";
		        Map param = new HashMap();
		        param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
		        param.put("content",URLEncoder.encode(smsTxt,"utf-8"));
		        param.put("source","195002");
		        param.put("Referer","http://"+Common.getDomain(request)+"/activity/hthsy");
		        if(canSendSms){
		        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
		        }else{
		        	System.out.println(smsTxt);
		        }
		        yzm.put("code",temp);
		        yzm.put("date",Calendar.getInstance().getTime().getTime());
		        session.setAttribute("hthsy_code",yzm);
		        Map phone_times = new HashMap();
		        phone_times.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
		        phone_times.put("date",Calendar.getInstance().getTime().getTime());
		        session.setAttribute("hthsy_phone",phone_times);
		        rs = "ok";
			}
		}
		if("cha_xun_zhong_jiang".equals(flag)){
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String code = CommonString.getFormatPara(request.getParameter("code"));
			Map map = dbHelper.getMap(" select * from activities_reg where phone = ? and preferential_code = ? ",new Object [] {
					phone,code
			},connection);
			if(null!=map){
				rs = "验证成功：<br />";
				rs += CommonString.getFormatPara(map.get("name"))+"的验证码为："+CommonString.getFormatPara(map.get("preferential_code"));
				rs += "<br />预约机型为："+CommonString.getFormatPara(map.get("model"));
			}else{
				rs = "no";
			}
		}
		if("renwei".equals(flag)){
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String name = CommonString.getFormatPara(request.getParameter("name"));
			Integer regCounts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where type_id = 2 and phone = ? ", new Object [] {
				phone
			},connection);
			//判断电话是否重复
			if(regCounts>0){
				rs = "exist";
			}else{
				String sql = " insert into activities_reg ( uuid , phone , name , reg_date , type_id , reg_ip , preferential_code , city ) ";
				sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? ) ";
				//产生随机码
				Double _td = Math.random()*100000;
				String preferential_code = _td.intValue()+"";
				//过滤其它中奖信息
				
				//插入注册信息
				dbHelper.execute(sql,new Object [] {
						CommonString.getUUID(),phone,name,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
						2,Common.getIp(request),preferential_code,CommonString.getFormatPara(request.getParameter("city"))
				},connection);
				String smsText = "“宏通好声音,三一挖掘机全城乐享惠”线上挖机订购活动，验证码"+preferential_code+",线上注册可享受购机代金券，当场兑现！0535-6727793";
				Map param = new HashMap();
		        param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
		        param.put("content",URLEncoder.encode(smsText,"utf-8"));
		        param.put("source","195002");
		        param.put("Referer",Common.getDomain(request)+"/activity/hthsy");
		        if(canSendSms){
		        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
		        }else{
		        	System.out.println(smsText);
		        }
				rs = "ok";
			}			
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>