<%@ page language="java" import="java.net.URLEncoder,org.json.*,java.util.*,com.jerehnet.util.dbutil.*,java.sql.Connection,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);	
	//是否能够发送短信
	Boolean canSendSms = true;
	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String rs = "";
	List<String> zhongJiangList = new ArrayList<String>();
	zhongJiangList.add("23743");
	zhongJiangList.add("74637");
	zhongJiangList.add("1856");
	zhongJiangList.add("96545");
	zhongJiangList.add("65748");
	zhongJiangList.add("4548");
	zhongJiangList.add("3827");
	zhongJiangList.add("85745");
	zhongJiangList.add("48392");
	
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		if("reg".equals(flag)){
			Map yzm = (Map)session.getAttribute("yhqg_code");
			Integer msgCounts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where CONVERT(varchar(100), reg_date, 1) = '"+CommonDate.getToday("MM/dd/yy")+"' and type_id = 1 ",connection);
			//判断是否需要验证码注册
			if(msgCounts<200){//如果一天注册人数小于200，需要验证码注册
				String yhgq_code = "";
				//如果验证码不为空
				if(null!=yzm){
					yhgq_code = CommonString.getFormatPara(yzm.get("code"));
					Long oldDate = (Long)yzm.get("date");
					Long newDate = Calendar.getInstance().getTime().getTime();
					Long _cha = newDate-oldDate;
					int cha = _cha.intValue();
					if(cha<60000){
						String code = CommonString.getFormatPara(request.getParameter("code"));
						//验证码正确
						if(code.equals(yhgq_code)){
							Map param = new HashMap();
							param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
							param.put("name",CommonString.getFormatPara(request.getParameter("name")));
							param.put("password",CommonString.getFormatPara(request.getParameter("password")));
							param.put("ip",Common.getIp(request));
							param.put("type_id","1");
							String myRs = Common.doPost("http://service.21-sun.com/http/web21sun/phone_reg.jsp",param);
							rs = myRs;
							if(rs.indexOf("exist")!=-1){
								rs = "exist";
							}else{
								Map userInfo = new HashMap();
								userInfo.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
								userInfo.put("name",CommonString.getFormatPara(request.getParameter("name")));
								session.setAttribute("yhqg_userInfo",userInfo);
							}
						}else{
							rs = "code_error";
						}
					}else{
						session.removeAttribute("yhqg_code");
						rs = "overtime";
					}
				}else{
					rs = "no_code";
				}
			}else{//如果不需要验证码，正常注册
				Map param = new HashMap();
				param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
				param.put("name",CommonString.getFormatPara(request.getParameter("name")));
				param.put("password",CommonString.getFormatPara(request.getParameter("password")));
				param.put("ip",Common.getIp(request));
				param.put("type_id","1");
				String myRs = Common.doPost("http://service.21-sun.com/http/web21sun/phone_reg.jsp",param);
				rs = myRs;
				if(rs.indexOf("exist")!=-1){
					rs = "exist";
				}else{
					Map userInfo = new HashMap();
					userInfo.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
					userInfo.put("name",CommonString.getFormatPara(request.getParameter("name")));
					session.setAttribute("yhqg_userInfo",userInfo);
				}
			}
		}
		if("login".equals(flag)){
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String password = CommonString.getFormatPara(request.getParameter("password"));
			Map userInfo = dbHelper.getMap(" select phone,name from activities_reg where phone = ? and password = ? and type_id = 1 ",new Object [] {
					phone,password
			},connection);
			if(null==userInfo){
				Integer counts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where phone = ? and type_id = 1 ",new Object [] {
					phone
				},connection);
				//如果帐号存在
				if(counts>0){
					rs = "error_password";
				}else{//如果帐号不存在
					rs = "no_id";
				}
			}else{
				session.setAttribute("yhqg_userInfo",userInfo);
				rs = "ok";
			}
		}
		if("getCode".equals(flag)){
			Map codeMap = (Map)session.getAttribute("yhqg_phone");
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
		        String smsTxt = "您好，本次斗山挖掘机抢购活动的短信口令为："+temp+"。【中国工程机械商贸网】";
		        Map param = new HashMap();
		        param.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
		        param.put("content",URLEncoder.encode(smsTxt,"utf-8"));
		        param.put("source","195002");
		        param.put("Referer","http://"+Common.getDomain(request)+"/activity/yhqg");
		        if(canSendSms){
		        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
		        }else{
		        	System.out.println(smsTxt);
		        }
		        yzm.put("code",temp);
		        yzm.put("date",Calendar.getInstance().getTime().getTime());
		        session.setAttribute("yhqg_code",yzm);
		        Map phone_times = new HashMap();
		        phone_times.put("phone",CommonString.getFormatPara(request.getParameter("phone")));
		        phone_times.put("date",Calendar.getInstance().getTime().getTime());
		        session.setAttribute("yhqg_phone",phone_times);
		        rs = "ok";
			}
		}
		if("counts".equals(flag)){
			String name = CommonString.getFormatPara(request.getParameter("name"));
			dbHelper.execute(" update activities_counts set counts = counts + 1 where name = ? and type_id = 1 ",new Object [] {
				name
			},connection);
		}
		if("gz".equals(flag)){
			List<Map> list = dbHelper.getMapList(" SELECT TOP 4 counts FROM activities_counts WHERE type_id = 1 ORDER BY id ASC ",connection);
			JSONObject obj = new JSONObject();
			obj.put("gz_1",list.get(0).get("counts"));
			obj.put("gz_2",list.get(1).get("counts"));
			obj.put("gz_3",list.get(2).get("counts"));
			obj.put("gz_4",list.get(3).get("counts"));
			String callback = CommonString.getFormatPara(request.getParameter("callback"));
			rs = callback + "("+obj.toString()+")";
		}
		if("vPhoneIsIn".equals(flag)){
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			Integer counts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where phone = ? and type_id = 1 ",new Object [] {phone},connection);
			if(counts>0){
				rs = "exist";
			}else{
				rs = "ok";
			}
		}
		if("isLogin".equals(flag)){
			Map userInfo = (Map)session.getAttribute("yhqg_userInfo");
			if(null!=userInfo){
				rs = CommonString.getFormatPara(userInfo.get("name"));
			}else{
				rs = "no_login";
			}
		}
		if("qiangGou".equals(flag)){
			String items = CommonString.getFormatPara(request.getParameter("items"));
			Map userInfo = (Map)session.getAttribute("yhqg_userInfo");
			//产生随机码
			Double _td = Math.random()*100000;
			String sui_ji = _td.intValue()+"";
			//过滤内定奖项
			if("3827".equals(sui_ji)){
				sui_ji = sui_ji.substring(0,sui_ji.length()-1);
			}else if("85745".equals(sui_ji)){
				sui_ji = sui_ji.substring(0,sui_ji.length()-1);
			}else if("48392".equals(sui_ji)){
				sui_ji = sui_ji.substring(0,sui_ji.length()-1);
			}else if("65748".equals(sui_ji)){
				sui_ji = sui_ji.substring(0,sui_ji.length()-1);
			}else if("74637".equals(sui_ji)){
				sui_ji = sui_ji.substring(0,sui_ji.length()-1);
			}else if("23743".equals(sui_ji)){
				sui_ji = sui_ji.substring(0,sui_ji.length()-1);
			}
			//过滤内定奖项
			
			//判断是否可以继续抽
			Integer counts = (Integer)dbHelper.getOne(" select count(*) from activities_record where type_id = 1 and phone = ? and items = ? ",new Object [] {
				CommonString.getFormatPara(userInfo.get("phone")),items
			},connection);
			if(counts<=0){
				//如果是抽了就中
				if("other2".equals(items)){
					dbHelper.execute(" insert into activities_record ( phone , type_id , items , rs , code , winning_items , add_ip , add_date ) values ( ? , ? , ? , ? , ? , ? , ? , ? ) ",new Object [] {
							CommonString.getFormatPara(userInfo.get("phone")),1,
							items,1,sui_ji,items,Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
						},connection);
					rs = items;
					String smsText = "恭喜您获得本活动购机优惠，优惠码"+sui_ji+"，价值两千小时的保养配件及五千元优惠券，请在72小时内至当地代理商处兑换0535-6792733";
					if(!"".equals(smsText)){
						Map param = new HashMap();
						param.put("phone",CommonString.getFormatPara(userInfo.get("phone")));
						param.put("content",URLEncoder.encode(smsText,"utf-8"));
						param.put("source","195002");
						param.put("Referer","http://"+Common.getDomain(request)+"/activity/yhqg");
				        if(canSendSms){
				        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
				        }else{
				        	System.out.println(smsText);
				        }
					}
				}else{
					//查询出未被中的奖，进行随机比对
					List<Map> zhong_jiang = dbHelper.getMapList(" select winning_code,items from activities_winning where use_counts = 0 and id not in (5,7,8,9) ",connection);
					Map<String,String> zhongJiangMap = CommonCollection.listToMap(zhong_jiang,"winning_code","items");
					String winning_items = "";
					String zhongJiangJieGuo = "0";
					//如果中奖了
					if(zhongJiangMap.get(sui_ji)!=null){
						//中奖项目
						winning_items = zhongJiangMap.get(sui_ji);
						if(winning_items.indexOf(items)!=-1){
							zhongJiangJieGuo = "1";
							//修改中奖结果次数
							dbHelper.execute(" update activities_winning set use_counts = use_counts + 1 where type_id = 1 and items = ? and winning_code = ? ",new Object [] {
									winning_items,sui_ji
							},connection);
							rs = winning_items;
							String smsText = "";
							if("DX345LC_2".equals(winning_items)){
								smsText = "恭喜您获得本活动的二等奖，优惠码为"+sui_ji+"，您可以八八折购买DX345LC，请在72小时内至当地代理商处兑换0535-6792733";
							}else if("DX380LC_2".equals(winning_items)){
								smsText = "恭喜您获得本活动二等奖，优惠码为"+sui_ji+"，3年六千小时超长保修及一万元优惠券，请在72小时内至当地代理商处兑换0535-6792733";
							}else if("DX345LC_3".equals(winning_items)){
								smsText = "恭喜您获得本活动的三等奖，优惠码为"+sui_ji+"，您可以九折购买DX345LC，请在72小时内至当地代理商处兑换0535-6792733";
							}else if("DX380LC_3".equals(winning_items)){
								smsText = "恭喜您获得本活动三等奖，优惠码为"+sui_ji+"，3年六千小时超长保修及五千元优惠券，请在72小时内至当地代理商处兑换0535-6792733";
							}else if("other1_3".equals(winning_items)){
								smsText = "恭喜您获得本活动的三等奖，优惠码"+sui_ji+"，价值三千小时的保养配件，请在72小时内至当地代理商处兑换0535-6792733";
							}else{
								smsText = "恭喜您获得本活动购机优惠，优惠码"+sui_ji+"，价值两千小时的保养配件及五千元优惠券，请在72小时内至当地代理商处兑换0535-6792733 ";
							}
							if(!"".equals(smsText)){
								Map param = new HashMap();
								param.put("phone",CommonString.getFormatPara(userInfo.get("phone")));
								param.put("content",URLEncoder.encode(smsText,"utf-8"));
								param.put("source","195002");
								param.put("Referer","http://"+Common.getDomain(request)+"/activity/yhqg");
						        if(canSendSms){
						        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
						        }else{
						        	System.out.println(smsText);
						        }
							}
						}else{
							winning_items = "";
							rs = "no";
						}
					}else{
						rs = "no";
					}
					//插入抽奖记录
					dbHelper.execute(" insert into activities_record ( phone , type_id , items , rs , code , winning_items , add_ip , add_date ) values ( ? , ? , ? , ? , ? , ? , ? , ? ) ",new Object [] {
						CommonString.getFormatPara(userInfo.get("phone")),1,
						items,zhongJiangJieGuo,sui_ji,winning_items,Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
					},connection);
					//如果未中奖
					if("no".equals(rs)){
						//判断抽奖是否结束
						Integer cjCounts = (Integer)dbHelper.getOne(" select count(*) from activities_record where phone = ? ",new Object [] {
								CommonString.getFormatPara(userInfo.get("phone"))
						},connection);
						//如果抽了3次，证明已经抽奖结束
						if(cjCounts>=3){
							rs = "no_over";
						}
					}
				}
			}else{
				rs = "exist";	
			}
		}
		if("renwei".equals(flag)){
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String name = CommonString.getFormatPara(request.getParameter("name"));
			Integer regCounts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where type_id = 1 and phone = ? ", new Object [] {
				phone
			},connection);
			//判断电话是否重复
			if(regCounts>0){
				rs = "exist";
			}else{
				String sql = " insert into activities_reg ( uuid , phone , name , reg_date , password , type_id , reg_ip ) ";
				sql += " values ( ? , ? , ? , ? , ? , ? , ? ) ";
				//插入注册信息
				dbHelper.execute(sql,new Object [] {
						CommonString.getUUID(),phone,name,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
						"123456",1,Common.getIp(request)
				},connection);
				//插入中奖信息
				sql = " insert into activities_record ( phone , type_id , items , code , rs , winning_items , add_ip , add_date ) ";
				sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? ) ";
				//产生随机码
				Double _td = Math.random()*100000;
				String sui_ji = _td.intValue()+"";
				
				//过滤其它中奖信息
				if(zhongJiangList.contains(sui_ji)){
					sui_ji = sui_ji.substring(0,sui_ji.length()-1);
				}
				//过滤其它中奖信息
				
				dbHelper.execute(sql,new Object [] {
						phone,1,"other2",sui_ji,1,"",Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
				},connection);
				//发送短信
				String smsText = "恭喜您获得本活动购机优惠，优惠码"+sui_ji+"，价值两千小时的保养配件及五千元优惠券，请在72小时内至当地代理商处兑换0535-6792733 ";
				if(!"".equals(smsText)){
					Map param = new HashMap();
					param.put("phone",phone);
					param.put("content",URLEncoder.encode(smsText,"utf-8"));
					param.put("source","195002");
					param.put("Referer","http://"+Common.getDomain(request)+"/activity/yhqg");
			        if(canSendSms){
			        	 Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",param);
			        }else{
			        	System.out.println(smsText);
			        }
				}
				rs = "ok";
			}			
		}
		if("getNextQiangGou".equals(flag)){
			Map userInfo = (Map)session.getAttribute("yhqg_userInfo");
			String phone = CommonString.getFormatPara(userInfo.get("phone"));
			List<Map> list = dbHelper.getMapList(" select items from activities_record where phone = ? and type_id = 1 ",new Object [] {
					phone
			},connection);
			List<String> pros = new ArrayList<String>();
			pros.add("DX345LC");
			pros.add("DX380LC");
			pros.add("other1");
			for(Map m : list){
				if("DX345LC".equals(CommonString.getFormatPara(m.get("items")))){
					pros.remove("DX345LC");
				}else if("DX380LC".equals(CommonString.getFormatPara(m.get("items")))){
					pros.remove("DX380LC");
				}else if("other1".equals(CommonString.getFormatPara(m.get("items")))){
					pros.remove("other1");
				}
			}
			if(null!=pros&&pros.size()>0){
				rs = pros.get(0);
			}else{
				rs = "no";
			}
		}
		if("cha_xun_zhong_jiang".equals(flag)){
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String code = CommonString.getFormatPara(request.getParameter("code"));
			//查询姓名
			Map user = dbHelper.getMap(" select * from activities_reg where phone = ? ",new Object [] {
					phone
			},connection);
			String name = "";
			if(null!=user){
				name = CommonString.getFormatPara(user.get("name"));
			}
			Map map = dbHelper.getMap(" select winning_items from activities_record where type_id = 1 and phone = ? and rs = 1 and code = ? ",new Object [] {
					phone,code
			},connection);
			if(null!=map){
				String winning_items = CommonString.getFormatPara(map.get("winning_items"));
				if("DX345LC_2".equals(winning_items)){
					rs = "DX345LC抢购第二名，8.8折购买该挖掘机";
				}else if("DX345LC_3".equals(winning_items)){
					rs = "DX345LC抢购第三名，9折购买该挖掘机";
				}else if("DX380LC_2".equals(winning_items)){
					rs = "DX380LC抢购第二名，获得3年6000小时超长保修期及10000元优惠券";
				}else if("DX380LC_3".equals(winning_items)){
					rs = "DX380LC抢购第三名，获得3年6000小时超长保修期及5000元优惠券";
				}else if("other1_2".equals(winning_items)){
					rs = "保养及优惠券限时抢购抢购第二名，获得4000小时保养配件";
				}else if("other1_3".equals(winning_items)){
					rs = "保养及优惠券限时抢购抢购第三名，获得3000小时保养配件";
				}else if("DX345LC_1".equals(winning_items)){
					rs = "DX345LC抢购第一名，8.5折购买该挖掘机";
				}else if("DX380LC_1".equals(winning_items)){
					rs = "DX380LC抢购第一名，获得3年6000小时超长保修期及15000元优惠券";
				}else if("other1_1".equals(winning_items)){
					rs = "保养及优惠券限时抢购抢购第一名，获得5000小时保养配件";
				}else{
					rs = "2000小时的保养配件及5000优惠券";
				}
			}else{
				rs = "很遗憾，您未中奖";
			}
			if(!"".equals(name)){
				rs = name + "的中奖信息为："+rs;
			}else{
				rs = "中奖信息为："+rs;
			}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>