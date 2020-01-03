<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.mobile.sync.PushSyncActon"%>
<%@page import="com.jerehnet.mobile.action.*"%>
<%
	String event = CommonString.getFormatPara(request.getParameter("eventAfter"));
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	HashMap<String, String> catalogMap = (HashMap<String, String>)application.getAttribute("catalogMap");
	String [] eventArr = event.split(",");
	List<String> eventList =Arrays.asList(eventArr);
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map model = null;
	try{
		connection = dbHelper.getConnection();
		//频道模板生成(二手)
		if(eventList.contains("channelTemplate")){
			//频道编号
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			if("".equals(channel_uuid)){
				channel_uuid = CommonString.getFormatPara(request.getParameter("zd_channel_uuid"));
			}
			Map root = new HashMap();
			String t_sql = " select *,(select count(*) from "+tablePrefix+"common_template where cc.uuid = channel_uuid ) as t_counts from "+tablePrefix+"common_channel cc where cc.id = ? ";
			if(!"".equals(channel_uuid)){
				t_sql = " select *,(select count(*) from "+tablePrefix+"common_template where cc.uuid = channel_uuid) as t_counts from "+tablePrefix+"common_channel cc where cc.uuid = ? ";
				id = channel_uuid;
			}
			/*组织数据*/
			//频道
			Map channel = dbHelper.getMap(t_sql,new Object [] {id},connection);
			root.put("channel",channel);
			root.putAll(DBUtils.getRoot((String)channel.get("uuid")));
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"/template/");
			String templateFileName = (String)channel.get("template_file_name");
			String createFileName = (String)channel.get("create_file_name");
			if(!"".equals(templateFileName)&&!"".equals(createFileName)){
				freemarkerUtils.generate(templateFileName,root,absPath+createFileName,request);
			}
			String sql = " select * from "+tablePrefix+"common_template where channel_uuid = ? ";
			//得到所有的扩展模板
			List<Map> t_s = dbHelper.getMapList(sql,new Object [] {channel.get("uuid")},connection);
			String kz_template_file_name = "";
			String kz_create_file_name = "";
			//扩展频道号
			String ext_channel_uuid = "";
			Map kzRoot = null;
			for(Map kz : t_s){
				kzRoot = new HashMap();
				kz_template_file_name = CommonString.getFormatPara(kz.get("template_file_name"));
				kz_create_file_name = CommonString.getFormatPara(kz.get("create_file_name"));
				ext_channel_uuid = CommonString.getFormatPara(kz.get("ext_channel_uuid"));
				if("".equals(ext_channel_uuid)){
					ext_channel_uuid = CommonString.getFormatPara(channel.get("uuid"));
				}
				kzRoot.put("template", kz);
				kzRoot.putAll(root);
				//如果不是详细页
				if(CommonString.getFormatPara(kz.get("is_detail")).equals("0")){
					if(!"".equals(kz_template_file_name)&&!"".equals(kz_create_file_name)){
						//生成他们
						freemarkerUtils.generate(kz_template_file_name,kzRoot,absPath+kz_create_file_name,request);
					}
				}else{//如果是详细页
					//更新所有设备
					List machines = dbHelper.getMapList(" select * from "+tablePrefix+"machine where channel_uuid = ? ",new Object [] {ext_channel_uuid},connection);
					Map m = null;
					Map detailRoot = null;
					Map dealer = null;
					List imgs = null;
					String dealerSql = "select top 1 * from "+tablePrefix+"dealers where uuid = ? ";
					String imgSql = " select * from "+tablePrefix+"machine_image where machine_id = ? order by order_no desc , id desc ";
					for(int i=0;i<machines.size();i++){
						m = (Map)machines.get(i);
						if(CommonString.getFormatPara(m.get("file_name")).equals("")){
							continue;
						}
						detailRoot = new HashMap();
						//加载经销商
						if(null!=m.get("dealer_id")){
							dealer = dbHelper.getMap(dealerSql,new Object [] {m.get("dealer_id")},connection);
							detailRoot.put("dealer", dealer);
						}
						//加载图片列表
						imgs = dbHelper.getMapList(imgSql,new Object [] {m.get("uuid")},connection);
						detailRoot.put("imgs", imgs);
						detailRoot.put("model", m);
						detailRoot.put("template", kz);
						detailRoot.putAll(root);
						freemarkerUtils.generate(kz_template_file_name,detailRoot,absPath+kz_create_file_name+CommonString.getFormatPara(m.get("file_name")),request);
					}
					//更新所有新闻
					List informations = dbHelper.getMapList(" select * from "+tablePrefix+"information where channel_no = ? ",new Object [] {ext_channel_uuid},connection);
					m = null;
					detailRoot = null;
					for(int i=0;i<informations.size();i++){
						m = (Map)informations.get(i);
						if(CommonString.getFormatPara(m.get("file_name")).equals("")){
							continue;
						}
						detailRoot = new HashMap();
						detailRoot.put("model", m);
						detailRoot.put("template", kz);
						detailRoot.putAll(root);
						freemarkerUtils.generate(kz_template_file_name,detailRoot,absPath+kz_create_file_name+CommonString.getFormatPara(m.get("file_name")),request);
					}
					//更新所有经销商
					List dealers = dbHelper.getMapList(" select * from "+tablePrefix+"dealers where channel_uuid = ? ",new Object [] {ext_channel_uuid},connection);
					m = null;
					detailRoot = null;
					for(int i=0;i<dealers.size();i++){
						m = (Map)dealers.get(i);
						if(CommonString.getFormatPara(m.get("file_name")).equals("")){
							continue;
						}
						detailRoot = new HashMap();
						detailRoot.put("model", m);
						detailRoot.put("template", kz);
						detailRoot.putAll(root);
						freemarkerUtils.generate(kz_template_file_name,detailRoot,absPath+kz_create_file_name+CommonString.getFormatPara(m.get("file_name")),request);
					}
				}
			}
		}
 

		
		//更新订单呼叫结果
		if(eventList.contains("updateFormCallRs")){
			String add_user="";
	        Map adminInfo = (Map)session.getAttribute("adminInfo");
	        if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("none");
		    }
		     add_user=CommonString.getFormatPara(request.getParameter("jr_user"));
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			String is_high_quality = CommonString.getFormatPara(request.getParameter("is_high_quality"));
			String message=CommonString.getFormatPara(request.getParameter("jr_textarea"));
			String jr_remark1=CommonString.getFormatPara(request.getParameter("jr_remark1"));
			Map task1Map = dbHelper.getMap(" select form_uuid,call_rs,remark from pro_400_task1 where id = ? ",new Object [] {id},connection);
			String formUUID = CommonString.getFormatPara(task1Map.get("form_uuid"));
			String forumID = CommonString.getFormatPara(task1Map.get("id"));
			String log_mobile_phone= CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String log_id = CommonString.getFormatPara(request.getParameter("log_id"));
            if(log_id.equals("")){log_id="0";}
			if(log_mobile_phone.equals("")){log_mobile_phone="0";}
			/**
			Map theMap1 = dbHelper.getMap(" select id  from phone_log  where order_id = ? ",new Object [] {log_id},connection);
			String log_sql = " insert into phone_log(order_id,log_date,log_user,phone,flag)  values";
			log_sql+="("+log_id+",'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+add_user+"','"+log_mobile_phone+"',1)";
			if(theMap1==null){
			dbHelper.execute(log_sql, connection);
			}
			**/
			
			//找出最后一个呼叫
			
			task1Map = dbHelper.getMap(" select top 1 form_uuid,call_rs,remark from pro_400_task1 where form_uuid = ? order by id desc ",new Object [] {formUUID},connection);
			Integer task1_count = (Integer)dbHelper.getOne(" select count(*) from pro_400_task1 where form_uuid = ? ",new Object [] {formUUID},connection);
			String callRs = CommonString.getFormatPara(task1Map.get("call_rs"));
			String contents= CommonString.getFormatPara(task1Map.get("remark"));
			Integer task1_over = 0;
			if("103002".equals(callRs)){
				task1_over = 1;
			}
			dbHelper.execute(" update pro_product_form set call_rs = ? , is_high_quality = ? , task1_count = ? , task1_over = ?, call_result1=?,message=? where uuid = ? ",new Object [] {
					callRs,
					is_high_quality,
					task1_count,
					task1_over,
					jr_remark1,
					message,
					formUUID
			},connection);
			
			
			//同步更新推送至厂家的订单一次外呼状态
			 dbHelper.execute(" update pro_product_form set call_rs = ? , is_high_quality = ? , task1_count = ? , task1_over = ?, call_result1=? where source_uuid = ? and push_order=1 ",new Object [] {
					callRs,
					is_high_quality,
					task1_count,
					task1_over,
					jr_remark1,
					formUUID
			},connection);
			//同步更新推送至代理商的订单一次外呼状态
			dbHelper.execute(" update pro_agent_products_form set call_result1=? where source_id = ? and push_order=1 ",new Object [] { jr_remark1, forumID },connection);
			
			//同步更新其父订单的状态
				Map theMap = dbHelper.getMap(" select source_uuid  from pro_product_form  where uuid = ? ",new Object [] {formUUID},connection);
                if(theMap!=null){
				    String  parentUUID=CommonString.getFormatPara(theMap.get("source_uuid"));
					if(!parentUUID.equals("")){
					
					dbHelper.execute(" update pro_product_form set call_rs = ? , is_high_quality = ? , task1_count = ? , task1_over = ?, call_result1=? where source_uuid = ? and push_order=1 ",new Object [] {
					callRs,
					is_high_quality,
					task1_count,
					task1_over,
					jr_remark1,
					parentUUID
			        },connection);
					
					dbHelper.execute(" update pro_product_form set call_rs = ? , is_high_quality = ? , task1_count = ? , task1_over = ?, call_result1=? where uuid = ?   ",new Object [] {
					callRs,
					is_high_quality,
					task1_count,
					task1_over,
					jr_remark1,
					parentUUID
			        },connection);
					
					
					
					}
			}
			
			
			
			//如果是无效号码删除该订单
			if("103003".equals(callRs)){ //如果是无效号码直接删除到订单仓库
				String mobile_phone= CommonString.getFormatPara(request.getParameter("mobile_phone"));
				if (null != formUUID && formUUID.length() > 0) {// 删除
					String [] idsArr = formUUID.split(",");
					Integer dele_id = 0;
					for(int i=0;i<idsArr.length;i++){
						//查询数据
						dele_id = (Integer)dbHelper.getOne(" select id from pro_product_form where uuid =  '"+idsArr[i]+"'",connection);
						//gaopeng add at 20131204-begin
						//把订单插入订单回收站表
						String sqlString = "insert into pro_product_form_del(";
						sqlString += "dele_reason,source_id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first";
						sqlString += ") select '无效号码',id,add_ip,'"+add_user+"',add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first";
						sqlString += " from pro_product_form WHERE uuid = '"+idsArr[i]+"'";
						
						//zeng20170216
						//Integer rs = dbHelper.execute(sqlString, connection);
						
						//gaopeng add at 20131204-end
						String del="update pro_product_form set is_deleted=1 where uuid= '"+idsArr[i]+"'";
						dbHelper.execute(del,connection);
						dbHelper.execute(" delete from pro_agent_products_form where source_id = ? and source_id is not null and source_id <> '' and source_id <> 0 ",new Object [] {
								dele_id
						},connection);
					}
				}
			  //将该手机号码拉黑
			    String delPhone="insert into pro_product_form_blacklist";
			    delPhone+="(add_ip,add_user,add_date,uuid,tel)";
			    delPhone+="values('119.180.98.134','system',getDate(),'"+CommonString.getUUID()+"','"+mobile_phone+"')";
				dbHelper.execute(delPhone,connection);
			}	
		}
		
		

		if(eventList.contains("updateFormTask2Count")){
			String add_user="";
	        Map adminInfo = (Map)session.getAttribute("adminInfo");
	        if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("none");
		    }
			String factory_form_id=CommonString.getFormatPara(request.getParameter("zd_id"));
			add_user=CommonString.getFormatPara(request.getParameter("jr_user"));
			String zd_call_rs_task2 = CommonString.getFormatPara(request.getParameter("zd_call_rs_task2"));
			String formUUID = CommonString.getFormatPara(request.getParameter("zd_form_uuid"));
			String formID = CommonString.getFormatPara(request.getParameter("formID"));
			String contents= CommonString.getFormatPara(request.getParameter("jr_textarea"));
			String last_buy= CommonString.getFormatPara(request.getParameter("jr_last_buy"));
			//是否二手，是否星标记
			String is_high_quality= CommonString.getFormatPara(request.getParameter("ihq"));
			String is_push= CommonString.getFormatPara(request.getParameter("is_star"));
			
			//获取第二次的具体订购信息
			String main_brand= CommonString.getFormatPara(request.getParameter("main_brand"));
			String main_category= CommonString.getFormatPara(request.getParameter("main_category"));
			String main_model= CommonString.getFormatPara(request.getParameter("main_model"));
			
			//获取真实购买机器并更新信息
			String jr_deal_factoryid= CommonString.getFormatPara(request.getParameter("jr_deal_factoryid"));
			String jr_deal_factoryname= CommonString.getFormatPara(request.getParameter("jr_deal_factoryname"));
			String jr_deal_model= CommonString.getFormatPara(request.getParameter("jr_deal_model"));
			String jr_deal_proid= CommonString.getFormatPara(request.getParameter("jr_deal_proid"));
			String jr_brand_series= CommonString.getFormatPara(request.getParameter("jr_brand_series"));
			String jr_pro_condition= CommonString.getFormatPara(request.getParameter("jr_pro_condition"));
			String jr_special_remark= CommonString.getFormatPara(request.getParameter("jr_special_remark"));
			String is_deal= CommonString.getFormatPara(request.getParameter("is_deal"));
			
			String jr_cataname=CommonString.getFormatPara(request.getParameter("jr_cataname"));
		    String mobile_phone=CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String jr_province=CommonString.getFormatPara(request.getParameter("jr_province"));
		    String jr_city=CommonString.getFormatPara(request.getParameter("jr_city"));
			String order_name=CommonString.getFormatPara(request.getParameter("name"));
			
			
			
            String brand_series="";
			String pro_condition="";
			Map seriesMap = (Map)CommonApplication.getEnumChildren("108",application);
		    Map conditionMap = (Map)CommonApplication.getEnumChildren("109",application);
			brand_series=CommonString.getFormatPara(seriesMap.get(jr_brand_series)) ;
			pro_condition=CommonString.getFormatPara(conditionMap.get(jr_pro_condition)) ;
			
            String sql = "";
			if(!"103004".equals(zd_call_rs_task2)){
				sql = " update pro_product_form set is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?  where uuid = ?  ";
				dbHelper.execute(sql,new Object [] {is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,formUUID},connection);
			   
     			//同步更新该订单的子订单及父订单
				//同步更新推送至厂家的订单二次外呼状态
			    dbHelper.execute(" update pro_product_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_rs_task2 =?,call_result2=? where push_order=1 and source_uuid = ? ",new Object [] {is_push,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,zd_call_rs_task2,contents,formUUID},connection);
			    //同步更新推送至代理商的订单二次外呼状态
			    dbHelper.execute(" update pro_agent_products_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_result2=?,call_rs_task2=?  where source_id = ? and push_order=1 ",new Object [] {is_push,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,contents,zd_call_rs_task2,formID},connection);
			    //同步更新其父订单的状态
				Map theMap = dbHelper.getMap(" select source_uuid from pro_product_form  where uuid = ? ",new Object [] {formUUID},connection);
                if(theMap!=null){
				    String  parentUUID=CommonString.getFormatPara(theMap.get("source_uuid"));
					//String agentFormID=CommonString.getFormatPara(theMap.get("id"));
					if(!parentUUID.equals("")){
						dbHelper.execute(" update pro_product_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_result2=?,call_rs_task2=?  where uuid = ? ",new Object [] {is_push,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,contents,zd_call_rs_task2,parentUUID},connection);
						dbHelper.execute(" update pro_product_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_rs_task2 =?,call_result2=? where push_order=1 and source_uuid = ? ",new Object [] {is_push,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,zd_call_rs_task2,contents,parentUUID},connection);	
						Map theAgentMap = dbHelper.getMap(" select id from pro_product_form  where uuid = ? ",new Object [] {parentUUID},connection);
                        if(theAgentMap!=null){
						dbHelper.execute(" update pro_agent_products_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_rs_task2 =?,call_result2=? where  source_id = ? ",new Object [] {is_push,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,zd_call_rs_task2,contents,CommonString.getFormatPara(theAgentMap.get("id"))},connection);
                        }
					}
					

				} 
			
			}
			
			
		}
		if(eventList.contains("updateAgentForm")){
			String keyId = CommonString.getFormatPara(request.getParameter("zd_id"));
			List<Map> list = dbHelper.getMapList(" select * from pro_product_form where id = ? ",new Object [] {keyId},connection);
			if(null!=list){
				for(Map m : list){
				  //System.out.println((Integer)(m.get("state"))+(String)(m.get("name"))+(String)(m.get("mobile_phone"))+(Integer)(m.get("id")));
				   int a=	dbHelper.execute("update pro_agent_products_form set state = ?,user_name=?,contact_tel=? where source_id = ? ",new Object[]{(Integer)(m.get("state")),(String)(m.get("name")),(String)(m.get("mobile_phone")),(Integer)(m.get("id"))},connection);
				}
				//更新订单中的基本信息
				
			}
		}
		//合作客户手动推送订单
		if(eventList.contains("updateAgentFormsss")){
			String uuid = CommonString.getFormatPara(request.getParameter("pro_uuid"));
			String bdUid="";
			Map orderInfo = dbHelper.getMap(" select factoryname,cataname,product_name,name,mobile_phone,province,city,catanum from pro_product_form where uuid = ? ",new Object [] {uuid},connection);	
			for(int i=1;i<=5;i++){
			String company_name = CommonString.getFormatPara(request.getParameter("company_name"+(i==1?"":i)));
			String cata_name = CommonString.getFormatPara(request.getParameter("cata_name"+(i==1?"":i)));
			String pro_name = CommonString.getFormatPara(request.getParameter("pro_name"+(i==1?"":i)));
			String factory_id = CommonString.getFormatPara(request.getParameter("factory_id"+(i==1?"":i)));
			String brand_id = CommonString.getFormatPara(request.getParameter("brand_id"+(i==1?"":i)));
			String pro_id = CommonString.getFormatPara(request.getParameter("pro_id"+(i==1?"":i)));	
			String jr_message = CommonString.getFormatPara(request.getParameter("jr_message"+(i==1?"":i)));
			//都不为空才会操作
			if(!company_name.equals("")&&!cata_name.equals("")&&!pro_name.equals("")&&!factory_id.equals("")&&!brand_id.equals("")&&!pro_id.equals("")&&!jr_message.equals("")){
				//System.out.println(company_name+"--"+cata_name+"--"+pro_name+"--"+factory_id+"--"+brand_id+"--"+pro_id+"--"+jr_message);
			//获取合作客户是厂家还是代理商
			String flag= "0";
			if(factory_id.equals("13570")||factory_id.equals("151")||factory_id.equals("154")||factory_id.equals("133")||factory_id.equals("174")||factory_id.equals("489")||factory_id.equals("138")||factory_id.equals("139")){
				flag= "1";
			}else{
				flag= "2";
			}
			String company = CommonString.getFormatPara(orderInfo.get("factoryname"));
			String cata = CommonString.getFormatPara(orderInfo.get("cataname"));
			String pro = CommonString.getFormatPara(orderInfo.get("product_name"));
			String username = CommonString.getFormatPara(orderInfo.get("name"));
			String mobile_phone = CommonString.getFormatPara(orderInfo.get("mobile_phone"));
			String province = CommonString.getFormatPara(orderInfo.get("province"));
			String city = CommonString.getFormatPara(orderInfo.get("city"));
			String catanum= CommonString.getFormatPara(orderInfo.get("catanum"));
			if(flag.equals("2")){
				//把订单推给合作的代理商订单中 ifgroup,buy_time
				int num = (Integer)dbHelper.getOne(" SELECT count(id) as a FROM pro_agent_products_form where agent_id="+factory_id+" and  datediff(day,add_date,getdate())<=183  and contact_tel=(select mobile_phone from pro_product_form where uuid= ? )  ",new Object[]{uuid});
				if(num==0){
					String sqlString = "insert into pro_agent_products_form(";
					sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type";
					sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+brand_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',"+pro_id+",'"+pro_name+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type";
					sqlString += " from pro_product_form WHERE uuid = '"+uuid+"'";
					//dbHelper.execute(sqlString,connection);
				}
			}
			if(flag.equals("1")){
			String tUUID=CommonString.getUUID();
			//把订单复制给合作的厂商订单中,卡特特殊处理
			if("174".equals(factory_id)){
			String sqlCopyString = "insert into pro_product_form(";
			sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
			sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,"+brand_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tUUID+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",'',buy_type";
			sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			dbHelper.execute(sqlCopyString, connection);
			}else if("151".equals(factory_id)){//wyn 德工 重复推送验证 存在该手机号的不再推送
				int num = (Integer)dbHelper.getOne(" select count(id) as a  from pro_product_form where factoryid=151 and mobile_phone = (select mobile_phone from pro_product_form where uuid= ? ) ",new Object[]{uuid});
				if(num==0){
					String sqlCopyString = "insert into pro_product_form(";
					sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
					sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,"+brand_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tUUID+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",uuid,buy_type";
					sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid+"'";
					dbHelper.execute(sqlCopyString, connection);
				}
			}else if("16920".equals(factory_id)){//wyn 合九 重复推送验证 存在该手机号的不再推送
				int num = (Integer)dbHelper.getOne(" select count(id) as a  from pro_product_form where factoryid=16920 and mobile_phone = (select mobile_phone from pro_product_form where uuid= ? ) ",new Object[]{uuid});
				if(num==0){
					String sqlCopyString = "insert into pro_product_form(";
					sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
					sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,"+brand_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tUUID+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",uuid,buy_type";
					sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid+"'";
					dbHelper.execute(sqlCopyString, connection);
				}
			}else{
				int num = (Integer)dbHelper.getOne(" select count(id) as a  from pro_product_form where factoryid="+factory_id+" and mobile_phone = (select mobile_phone from pro_product_form where uuid= ? ) ",new Object[]{uuid});
				if(num==0){
				String sqlCopyString = "insert into pro_product_form(";
				sqlCopyString += "call_result1,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first,push_order,source_uuid,buy_type";
				sqlCopyString += ") select call_result1,add_ip,add_user,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',channel_uuid,"+brand_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,'"+jr_message+"',state,province,city,mobile_phone,view_count,'"+tUUID+"',is_send,buy_time,ifgroup,"+0+",call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,"+0+","+1+",uuid,buy_type";
				sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid+"'";
				dbHelper.execute(sqlCopyString, connection);
				}				
			}
			
			//卡特代理商推送
			if("174".equals(factory_id)&&province.indexOf("甘肃")>=0){
					String sqlStringAgent = "insert into pro_agent_products_form(";
			        sqlStringAgent += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			        sqlStringAgent += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factory_id+",'"+company_name+"',353,agentname,catanum,'"+cata_name+"',"+pro_id+",'"+pro_name+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',0";
			        sqlStringAgent += " from pro_product_form WHERE uuid = '"+uuid+"'";
			        dbHelper.execute(sqlStringAgent,connection);
			}
			if("138".equals(factory_id)&&province.indexOf("甘肃")>=0&&catanum.indexOf("101002")>=0){
					String sqlStringAgent = "insert into pro_agent_products_form(";
			        sqlStringAgent += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			        sqlStringAgent += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factory_id+",'"+company_name+"',353,agentname,catanum,'"+cata_name+"',"+pro_id+",'"+pro_name+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',0";
			        sqlStringAgent += " from pro_product_form WHERE uuid = '"+uuid+"'";
			        dbHelper.execute(sqlStringAgent,connection);
			}
			//宝鼎
			if("13570".equals(factory_id) ){
				bdUid=tUUID;	
			}
			}
						
		}
			if(!bdUid.equals("")&&1==2){	
				WEBEmail.sendMailByUrl("156955048@qq.com", "sunwj@21-sun.com", null,   "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心",
				"http://product.21-sun.com/tools/email/email_detail_new.jsp?uuid=" + bdUid, "utf-8");
            }
	
		}
		}

		if(eventList.contains("insertAgentProductForm")){

			String sqlStr=" insert into pro_agent_relate_product (agent_id,agent_name,brand_id,brand_name,catalog_num,catalog_name) values (?,?,?,?,?,?) ";
			String agentId = CommonString.getFormatPara(request.getParameter("agent_id"));
			String agentName = CommonString.getFormatPara(request.getParameter("agent_name"));
			for(int i=1;i<=6;i++){
				String brandId = CommonString.getFormatPara(request.getParameter("brand_id"+i));
				String brandName = CommonString.getFormatPara(request.getParameter("brand_name"+i));
				String catalogNum = CommonString.getFormatPara(request.getParameter("catalog_num"+i));
				String catalogName ="";
				if(!"".equals(catalogNum)){
					for(int j=0;j<catalogNum.split(";").length;j++){
						if(j< catalogNum.split(";").length-1){
							if("120".equals(catalogNum.split(";")[j])){
								catalogName += "风机;";
							}else if("113".equals(catalogNum.split(";")[j])){
								catalogName += "破碎设备;";
							}else if("101".equals(catalogNum.split(";")[j])){
								catalogName += "土方机械;";
							}else{
								catalogName += catalogMap.get(catalogNum.split(";")[j])+";";
							}
						}else{
							if("120".equals(catalogNum.split(";")[j])){
								catalogName += "风机";
							}else if("113".equals(catalogNum.split(";")[j])){
								catalogName += "破碎设备";
							}else if("101".equals(catalogNum.split(";")[j])){
								catalogName += "土方机械";
							}else{
								catalogName += catalogMap.get(catalogNum.split(";")[j]);
							}
						}
					}
				}
				if(!"".equals(brandId)&&!"".equals(brandName)&&!"".equals(catalogNum)){
					dbHelper.execute(sqlStr,new Object[]{agentId,agentName,brandId,brandName,catalogNum,catalogName},connection);
				}
				
			}
		}
		if(eventList.contains("updateAgentProductForm")){

			String sql_update=" update pro_agent_relate_product set brand_id = ?,brand_name = ?,catalog_num = ?,catalog_name= ?  where id = ? ";
			String sql_insert=" insert into pro_agent_relate_product (agent_id,agent_name,brand_id,brand_name,catalog_num,catalog_name) values (?,?,?,?,?,?) ";
			String agentId = CommonString.getFormatPara(request.getParameter("agent_id"));
			String agentName = CommonString.getFormatPara(request.getParameter("agent_name"));
			for(int i=1;i<=6;i++){
				int relateId = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("relate_id"+i)));
				String brandId = CommonString.getFormatPara(request.getParameter("brand_id"+i));
				String brandName = CommonString.getFormatPara(request.getParameter("brand_name"+i));
				String catalogNum = CommonString.getFormatPara(request.getParameter("catalog_num"+i));
				String catalogName ="";
				if(!"".equals(catalogNum)){
					for(int j=0;j<catalogNum.split(";").length;j++){
						System.out.println(catalogNum.split(";")[j]);
						if(j< catalogNum.split(";").length-1){
							if("120".equals(catalogNum.split(";")[j])){
								catalogName += "风机;";
							}else if("113".equals(catalogNum.split(";")[j])){
								catalogName += "破碎设备;";
							}else if("101".equals(catalogNum.split(";")[j])){
								catalogName += "土方机械;";
							}else{
								catalogName += catalogMap.get(catalogNum.split(";")[j])+";";
							}
						}else{
							if("120".equals(catalogNum.split(";")[j])){
								catalogName += "风机";
							}else if("113".equals(catalogNum.split(";")[j])){
								catalogName += "破碎设备";
							}else if("101".equals(catalogNum.split(";")[j])){
								catalogName += "土方机械";
							}else{
								catalogName += catalogMap.get(catalogNum.split(";")[j]);
							}
						}
					}
				}
				if(!"".equals(brandId)&&!"".equals(brandName)&&!"".equals(catalogNum)){
					if(relateId>0){
						dbHelper.execute(sql_update,new Object[]{brandId,brandName,catalogNum,catalogName,relateId},connection);
					}else{
						dbHelper.execute(sql_insert,new Object[]{agentId,agentName,brandId,brandName,catalogNum,catalogName},connection);
					}
					
				}
				
			}
		}
		
		//订单宝推送订单
		if(eventList.contains("updateOrderForm")){
			System.out.println("-------------进入方法1");
			String uuid = CommonString.getFormatPara(request.getParameter("pro_uuid"));
			Map orderInfo = dbHelper.getMap(" select mobile_phone,contact_address,contact_tel,name,add_date,product_id,factoryname,cataname,product_name,province,city,catanum from pro_product_form where uuid = ? ",new Object [] {uuid},connection);	
			for(int i=1;i<=5;i++){
			String company_name = CommonString.getFormatPara(request.getParameter("company_name"+(i==1?"":i)));
			String cata_name = CommonString.getFormatPara(request.getParameter("cata_name"+(i==1?"":i)));
			String pro_name = CommonString.getFormatPara(request.getParameter("pro_name"+(i==1?"":i)));
			String factory_id = CommonString.getFormatPara(request.getParameter("factory_id"+(i==1?"":i)));
			String brand_id = CommonString.getFormatPara(request.getParameter("brand_id"+(i==1?"":i)));
			String pro_id = CommonString.getFormatPara(request.getParameter("pro_id"+(i==1?"":i)));	
			String jr_message = CommonString.getFormatPara(request.getParameter("jr_message"+(i==1?"":i)));
			if(!company_name.equals("")&&!cata_name.equals("")&&!pro_name.equals("")&&!factory_id.equals("")&&!brand_id.equals("")&&!pro_id.equals("")&&!jr_message.equals("") ){	
			//获取合作客户是厂家还是代理商
			String flag= "0";
			if(factory_id.equals("13570")||factory_id.equals("151")||factory_id.equals("154")||factory_id.equals("133")||factory_id.equals("174")||factory_id.equals("489")||factory_id.equals("138")||factory_id.equals("139")){
				flag= "1";
			}else{
				flag= "2";
			}
			String company = CommonString.getFormatPara(orderInfo.get("factoryname"));
			String cata = CommonString.getFormatPara(orderInfo.get("cataname"));
			String pro = CommonString.getFormatPara(orderInfo.get("product_name"));
			String province = CommonString.getFormatPara(orderInfo.get("province"));
			String city = CommonString.getFormatPara(orderInfo.get("city"));
			String uname = CommonString.getFormatPara(orderInfo.get("name"));
			String uphone = CommonString.getFormatPara(orderInfo.get("mobile_phone"));
			//一些城市因为叫法存在差异，做特殊处理
			if(city.equals("宣州区")){city="宣城市";}
		    if(city.equals("六安畈镇")){city="六安市";}
            String catanum = CommonString.getFormatPara(orderInfo.get("catanum"));
			String jr_proid = CommonString.getFormatPara(orderInfo.get("product_id"));
			//代理商订单app推送
			String person_id="0";
			String usern="";	
			String agent_id="";
			int new_formid=0;
			if(flag.equals("2")){	
			List<Map> list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where agent_id = ? ",new Object [] {factory_id},connection);
			if(null!=list){
				for(Map m : list){		  
				   String nums=CommonString.getFormatPara(m.get("city_num"));
				   if(!nums.equals("")){
				      String  []citys=nums.split(",");
					  if(citys.length>0){
					        for(int ii=0;ii<citys.length;ii++){
					              Map areaInfo = dbHelper.getMap(" select   area_name from comm_area   where area_id = ? ",new Object [] {citys[ii]},connection);
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
	       
		   if("278".equals(factory_id)&&person_id.equals("0")){
			    if(province.indexOf("河南")>=0){
					person_id="367";
				}else if(province.indexOf("湖北")>=0){
					person_id="368";
				}else if(province.indexOf("安徽")>=0){
					if(city.indexOf("芜湖")>=0||city.indexOf("铜陵")>=0||city.indexOf("马鞍")>=0||city.indexOf("安庆")>=0||city.indexOf("黄山")>=0||city.indexOf("池州")>=0||city.indexOf("宣城")>=0||city.indexOf("合肥")>=0||city.indexOf("六安")>=0||city.indexOf("巢湖")>=0){
						person_id="363";
					}else{
						person_id="369";
					}
				}
		   }
	
		   //斗山判断
		   
		   if(factory_id.equals("16853")){ 
			 Map dsMap = dbHelper.getMap("  select id from pro_agent_products_form where agent_id=16853 and contact_tel='"+uphone+"' ");
            if(dsMap==null){
			//把订单推给合作的代理商订单中 ifgroup,buy_time
			String sqlString = "insert into pro_agent_products_form(";
			sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factory_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',"+pro_id+",'"+pro_name+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',"+person_id;
			sqlString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			new_formid = dbHelper.executeUpdate(sqlString,connection);   
             }			
		   }else{
			   Map agentTsMap = dbHelper.getMap("  select id from pro_agent_products_form where agent_id="+factory_id+" and contact_tel='"+uphone+"' ");
			     if(agentTsMap==null){
		    //把订单推给合作的代理商订单中 ifgroup,buy_time
			String sqlString = "insert into pro_agent_products_form(";
			sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factory_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',"+pro_id+",'"+pro_name+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',"+person_id;
			sqlString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			new_formid = dbHelper.executeUpdate(sqlString,connection);
				 }			
		   }

			
		 
			if(!usern.equals("")){
			//产品中心后台向手机端推送
			//PushSyncActon push= new PushSyncActon();
			//微信消息推送
			CommonAction commonAction=new CommonAction();
			int flagno=102001;
			String orderNo=CommonString.getFormatPara(orderInfo.get("id"));
			Map proMap = dbHelper.getMap("select img2,factoryname,catalogname,name from pro_products where id="+pro_id);
			String machineNo=CommonString.getFormatPara(proMap.get("factoryname"))+CommonString.getFormatPara(proMap.get("catalogname"))+CommonString.getFormatPara(proMap.get("name"));
			String machineImg=CommonString.getFormatPara(proMap.get("img2"));
			String createDate=CommonDate.getFormatDate("yyyy-MM-dd HH:mm",orderInfo.get("add_date"));
			String linkMan=CommonString.getFormatPara(orderInfo.get("name")); ;
			String linkTel=CommonString.getFormatPara(orderInfo.get("contact_tel"));
			String address=CommonString.getFormatPara(orderInfo.get("contact_address"));
			String receiveMan="";
			int receiveManId=0;
			int agentId=Integer.parseInt(factory_id);
			//push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+usern);	
			commonAction.sendWxMsg(new_formid,"xJx7heYIt8IuqSMLY-wf1eiiozXxP36rP5xw3WycrBc");
			}
			}
			

			//推送厂家订单时给代理商进行app订单推送
			if(flag.equals("1")){	
			List<Map> agentList = dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+factory_id+"%' " );
			if(brand_id.equals("151")&&catanum.indexOf("101002")!=-1){
                agentList = dbHelper.getMapList(" select id from pro_agent_factory  where   id=16915  " );
			}
			if(brand_id.equals("151")&&catanum.indexOf("104")!=-1){
                agentList = dbHelper.getMapList(" select id from pro_agent_factory  where   id=16916  " );
			}
            if((brand_id.equals("151")&&jr_proid.equals("29703"))||(brand_id.equals("151")&&catanum.indexOf("101001")!=-1)){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where   id=16917  " );
			}        
		    List<Map> specialPersonList=null;	 String specialPersonId="";  String specialPersonUsern="";		
           //三一的特殊处理
           if(brand_id.equals("133")&&catanum.indexOf("101001")!=-1){
		      agentList = dbHelper.getMapList(" select id from pro_agent_factory  where  id=16328 or id=530 " );
		   }			  
	       //龙工的做下类别判断
		   if(brand_id.equals("135")){
		     
		    //龙工装载机
			if(catanum.indexOf("101002")!=-1){
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16350  and is_cooperate=1 and push_show!=1    " );
			}
			//龙工推土机
			if(catanum.indexOf("101003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16349 and is_cooperate=1 and push_show!=1    " );
			}
			//龙工挖掘机
			if(catanum.indexOf("101001")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16348 and is_cooperate=1 and push_show!=1    " );
			}			
			//龙工旋挖钻
			if(catanum.indexOf("105003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16347  and is_cooperate=1 and push_show!=1   " );
			}
			//龙工路面机械
			if(catanum.indexOf("106001")!=-1){
				if(province.indexOf("浙江")>=0||province.indexOf("上海")>=0||province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("河北")>=0||province.indexOf("西藏")>=0||province.indexOf("新疆")>=0||province.indexOf("贵州")>=0||province.indexOf("青海")>=0||province.indexOf("甘肃")>=0||province.indexOf("云南")>=0){
					//一部分给装载机
					agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16350  and is_cooperate=1  " );
			    }else{
					//一部分给叉车
					agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1    " );
				}
			}
			//龙工叉车
		    if(catanum.indexOf("107")!=-1||catanum.indexOf("118004")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346 and is_cooperate=1 and push_show!=1   " );
			}
		}
			
		//雷沃做下判断
		if(brand_id.equals("141")){     
                  agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16840   " );
		}	
		 //山推别的系的不推送	
	    if(brand_id.equals("144")&&catanum.indexOf("101002")==-1){	
		    agentList=null;
		}
		//柳工推土机的判断
		if(brand_id.equals("136")){
			String areaNum="0000000000";
		    Map areaMap = dbHelper.getMap(" select  area_id   from comm_area   where parent_area_id !=129250 and  area_name like '%"+city+"%' " );
            if(areaMap!=null){
		          areaNum=CommonString.getFormatPara(areaMap.get("area_id"));
		     }
            if(catanum.indexOf("101003")>=0){			
		        agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16658 " );
			}else{
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id!=16658  and    agent_fac  like '%136%'  and  city_num like '%"+areaNum+"%'" );
			}
		}
		
		
 
		
		if(null!=agentList&&agentList.size() > 0){
		    for(Map mm : agentList){
			usern="";	person_id="0";	 
			List<Map> list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))},connection);
			
		//龙工的做下类别判断
		if(brand_id.equals("135")){
		    //龙工几款装载机
			if(jr_proid.equals("7592")||jr_proid.equals("7609")||jr_proid.equals("7608")||jr_proid.equals("7607")||jr_proid.equals("21539")||jr_proid.equals("21541")||jr_proid.equals("15875")||jr_proid.equals("15874")||jr_proid.equals("15872")||jr_proid.equals("7588")||jr_proid.equals("7539")||jr_proid.equals("4397")||jr_proid.equals("7538")||jr_proid.equals("21540")||jr_proid.equals("7584")||jr_proid.equals("7586")||jr_proid.equals("7585")||jr_proid.equals("7587")||jr_proid.equals("7589")||jr_proid.equals("7590")||jr_proid.equals("768")||jr_proid.equals("763")||jr_proid.equals("766")){
				list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});		
			}else{
				list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id!=144  and agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))});		
			}
			if(province.indexOf("浙江")>=0||province.indexOf("上海")>=0||province.indexOf("北京")>=0||province.indexOf("天津")>=0||province.indexOf("河北")>=0||province.indexOf("西藏")>=0||province.indexOf("新疆")>=0||province.indexOf("贵州")>=0||province.indexOf("青海")>=0||province.indexOf("甘肃")>=0||province.indexOf("云南")>=0){
			    if(catanum.indexOf("106001")!=-1){
					list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where id=144   ",new Object [] { });		
				}
			}
		}
		

        		
			
			if(null!=list){
				for(Map m : list){		  
				   String nums=CommonString.getFormatPara(m.get("city_num"));
				   if(!nums.equals("")){
				      String  []citys=nums.split(",");
					  if(citys.length>0){
					        for(int iii=0;iii<citys.length;iii++){
					              Map areaInfo = dbHelper.getMap(" select   area_name from comm_area   where area_id = ? ",new Object [] {citys[iii]},connection);
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
			if(CommonString.getFormatPara(mm.get("id")).equals("16840")){
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
			
			
				if(CommonString.getFormatPara(mm.get("id")).equals("14245")&&cata_name.indexOf("装载")>=0){
			    }else if(CommonString.getFormatPara(mm.get("id")).equals("14244")&&cata_name.indexOf("挖掘")>=0){
			    }else{
					//14238
					if(!person_id.equals("0")||CommonString.getFormatPara(mm.get("id")).equals("16776")||factory_id.equals("16776")){
                    //把订单推给合作的代理商订单中 ifgroup,buy_time
			        String sqlString = "insert into pro_agent_products_form(";
			        sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			        sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factory_id+",'"+company_name+"',"+CommonString.getFormatPara(mm.get("id"))+",agentname,catanum,'"+cata_name+"',"+pro_id+",'"+pro_name+"',contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+jr_message+"',company,name,"+1+",id,call_result1,buy_type,'102001',"+person_id;
			        sqlString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			        new_formid=dbHelper.executeUpdate(sqlString,connection);
					
					
					
					
					}
			    }
		
		  
			
           if(!usern.equals("")){
			//产品中心后台向手机端推送
			//PushSyncActon push= new PushSyncActon();
			//微信消息推送
			CommonAction commonAction=new CommonAction();
			int flagno=102001;
			String orderNo=CommonString.getFormatPara(orderInfo.get("id"));
			Map proMap = dbHelper.getMap("select img2,factoryname,catalogname,name from pro_products where id="+pro_id);
			String machineNo=CommonString.getFormatPara(proMap.get("factoryname"))+CommonString.getFormatPara(proMap.get("catalogname"))+CommonString.getFormatPara(proMap.get("name"));
			String machineImg=CommonString.getFormatPara(proMap.get("img2"));
			String createDate=CommonDate.getFormatDate("yyyy-MM-dd HH:mm",orderInfo.get("add_date"));
			String linkMan=CommonString.getFormatPara(orderInfo.get("name")); ;
			String linkTel=CommonString.getFormatPara(orderInfo.get("contact_tel"));
			String address=CommonString.getFormatPara(orderInfo.get("contact_address"));
			String receiveMan="";
			int receiveManId=0;
			int agentId=Integer.parseInt(CommonString.getFormatPara(mm.get("id")));
			//push.pushMessage(flagno,orderNo,machineNo,machineImg,createDate,linkMan,linkTel,address,receiveMan,receiveManId,agentId,"1_"+usern);	
			commonAction.sendWxMsg(new_formid,"xJx7heYIt8IuqSMLY-wf1eiiozXxP36rP5xw3WycrBc");
			
		   }
	 
			
			
			}}
			
			
		}
			
	}}
		
		}
		
		//添加优买团活动产品
		if(eventList.contains("ymtActivity")){
			String pro_uuid = CommonString.getFormatPara(request.getParameter("pro_uuid"));
			String jr_activity_user = CommonString.getFormatPara(request.getParameter("jr_activity_user"));	
			String jr_activity_img = CommonString.getFormatPara(request.getParameter("jr_activity_img"));
			String jf_flag = CommonString.getFormatPara(request.getParameter("jf_flag"));
			String jr_textarea = CommonString.getFormatPara(request.getParameter("jr_textarea"));
            String jr_ids= CommonString.getFormatPara(request.getParameter("jr_ids"));	
            String jr_title= CommonString.getFormatPara(request.getParameter("jr_title"));	
            //获取活动方信息
			Map fatoryInfo=dbHelper.getMap("select id,name,logo,agent_fac,city from pro_agent_factory where id = ? ",new Object [] {jr_activity_user},connection);
			String factoryid = CommonString.getFormatPara(fatoryInfo.get("id"));
			String factoryname = CommonString.getFormatPara(fatoryInfo.get("name"));
			String factorylogo = CommonString.getFormatPara(fatoryInfo.get("logo"));
			String agent_fac = CommonString.getFormatPara(fatoryInfo.get("agent_fac"));
			String agent_area = CommonString.getFormatPara(fatoryInfo.get("city"));
			//获取产品信息 
			Map proInfo = dbHelper.getMap(" select id,tonandmeter,name,catalognum,catalogname,factoryid,factoryname,price_start,price_end from pro_products where uuid = ? ",new Object [] {pro_uuid},connection);	
	
	        String pro_name  = CommonString.getFormatPara(proInfo.get("name"));
	        String pro_catanum  = CommonString.getFormatPara(proInfo.get("catalognum"));
	        String pro_cataname  = CommonString.getFormatPara(proInfo.get("catalogname"));
	        String pro_factoryid  = CommonString.getFormatPara(proInfo.get("factoryid"));
	        String pro_factoryname  = CommonString.getFormatPara(proInfo.get("factoryname"));
	        String pro_start_price  = CommonString.getFormatPara(proInfo.get("price_start"));
	        String pro_end_price  = CommonString.getFormatPara(proInfo.get("price_end"));
	        String tonandmeter= CommonString.getFormatPara(proInfo.get("tonandmeter"));
		    String pro_id= CommonString.getFormatPara(proInfo.get("id"));

	        String add_user="";
	        Map adminInfo = (Map)session.getAttribute("adminInfo");
	        if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("other");
		    }
	        String is_show="1"; 
			//将所有信息汇总添加到优买团活动中
			String sql = "insert into pro_ymt_activity(";
			sql+= "add_ip,add_user,add_date,uuid,is_show,description,img,factoryname,factorylogo,factoryid,agent_fac,agent_area,flag,pro_name,pro_catanum,pro_cataname,pro_factoryid,pro_factoryname,pro_start_price,pro_end_price,pro_uuid,tonandmeter,pro_id,pro_ids,title)";
            sql+="values('"+Common.getIp(request)+"','"+add_user+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+is_show+",'"+jr_textarea+"','"+jr_activity_img+"','"+factoryname+"','"+factorylogo+"',"+factoryid+",'"+agent_fac+"','"+agent_area+"',"+jf_flag+",'"+pro_name+"','"+pro_catanum+"','"+pro_cataname+"',"+pro_factoryid+",'"+pro_factoryname+"',"+pro_start_price+","+pro_end_price+",'"+pro_uuid+"',"+tonandmeter+","+pro_id+",'"+jr_ids+"','"+jr_title+"')";
			dbHelper.execute(sql, connection);	
	
		}
		
		
		//删除订单并且添加留言
		if(eventList.contains("deleteOrder")){
		    String add_user="";
	        Map adminInfo = (Map)session.getAttribute("adminInfo");
	        if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("none");
		    }
		    String id = CommonString.getFormatPara(request.getParameter("form_id"));
		    String  message=CommonString.getFormatPara(request.getParameter("jr_message"));
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
		   
		    String [] idList=id.split(",");
			if(idList.length>0){
			    for(int i=0;i<idList.length;i++){
                //更新订单状态和订单删除原因
			    dbHelper.execute(" update  pro_product_form set dele_reason='"+message+"', is_deleted=1  where    id="+idList[i],connection);
		        //把订单插入订单回收站表
			    String sqlString = "insert into pro_product_form_del(";
			    sqlString += "dele_reason,source_id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first";
			    sqlString += ") select dele_reason,id,add_ip,'"+add_user+"',add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,state,province,city,mobile_phone,view_count,'"+CommonString.getUUID()+"',is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,agent_can_view,referer,is_deal,deal_desc,is_first";
			    sqlString += " from pro_product_form WHERE   id ="+idList[i];
			    Integer rs = dbHelper.execute(sqlString, connection);
			    //删除代理商中对应推送的订单
			    dbHelper.execute(" delete from pro_agent_products_form where source_id = ? and source_id is not null and source_id <> '' and source_id <> 0 ",new Object [] {idList[i]},connection);
			    }
			}
			
		}
		
		
		if(eventList.contains("updateAgentTask2")){
			String agent_form_id= CommonString.getFormatPara(request.getParameter("zd_id"));
			String source_id= CommonString.getFormatPara(request.getParameter("source_id"));
			String jr_deal_factoryid= CommonString.getFormatPara(request.getParameter("zd_deal_factoryid"));
			String jr_deal_factoryname= CommonString.getFormatPara(request.getParameter("zd_deal_factoryname"));
			String jr_deal_model= CommonString.getFormatPara(request.getParameter("zd_deal_model"));
			String jr_deal_proid= CommonString.getFormatPara(request.getParameter("zd_deal_proid"));
			String jr_brand_series= CommonString.getFormatPara(request.getParameter("zd_brand_series"));
			String jr_pro_condition= CommonString.getFormatPara(request.getParameter("zd_pro_condition"));
			String jr_special_remark= CommonString.getFormatPara(request.getParameter("zd_special_remark"));
			String is_deal= CommonString.getFormatPara(request.getParameter("zd_is_deal"));
			String is_star= CommonString.getFormatPara(request.getParameter("zd_is_star"));
            String zd_call_rs_task2= CommonString.getFormatPara(request.getParameter("zd_call_rs_task2"));
			String contents= CommonString.getFormatPara(request.getParameter("zd_call_result2"));
			String jr_cataname=CommonString.getFormatPara(request.getParameter("jr_cataname"));
		    String mobile_phone=CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String jr_province=CommonString.getFormatPara(request.getParameter("jr_province"));
		    String jr_city=CommonString.getFormatPara(request.getParameter("jr_city"));
			String order_name=CommonString.getFormatPara(request.getParameter("name"));
            String brand_series="";
			String pro_condition="";
			Map seriesMap = (Map)CommonApplication.getEnumChildren("108",application);
		    Map conditionMap = (Map)CommonApplication.getEnumChildren("109",application);
			brand_series=CommonString.getFormatPara(seriesMap.get(jr_brand_series)) ;
			pro_condition=CommonString.getFormatPara(conditionMap.get(jr_pro_condition)) ;
	        String add_user="";
	        Map adminInfo = (Map)session.getAttribute("adminInfo");
	        if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("none");
		    }
			if(!source_id.equals("")){
			//更新父厂家订单信息
			dbHelper.execute(" update pro_product_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_rs_task2 =?,call_result2=? where id= ? ",new Object [] {is_star,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,zd_call_rs_task2,contents,source_id},connection);
            //更新父厂家订单推送的代理商订单
			dbHelper.execute(" update pro_agent_products_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_result2=?,call_rs_task2=?  where source_id = ? and push_order=1 ",new Object [] {is_star,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,contents,zd_call_rs_task2,source_id},connection);
			//更新父厂家订单推送的厂家订单
			Map theMap = dbHelper.getMap(" select uuid  from pro_product_form  where id = ? ",new Object [] {source_id},connection);
                if(theMap!=null){
				    String  UUID=CommonString.getFormatPara(theMap.get("uuid"));
					dbHelper.execute(" update pro_product_form set is_star=?,is_deal=?,special_remark=?,deal_factoryid=?,deal_factoryname=?,deal_model=?,deal_proid=?,brand_series=?,pro_condition=?,call_rs_task2 =?,call_result2=? where push_order=1 and source_uuid = ?   ",new Object [] {is_star,is_deal,jr_special_remark,jr_deal_factoryid,jr_deal_factoryname,jr_deal_model,jr_deal_proid,jr_brand_series,jr_pro_condition,zd_call_rs_task2,contents,UUID},connection);
		        } 
			}
			
			//如果是成交，再往成交订单表中插入或者更新之前存入的订单数据
			if(zd_call_rs_task2.equals("106002")){
				Map agentFormMap = dbHelper.getMap(" select id  from pro_product_deal_form  where agent_form_id = ? ",new Object [] {agent_form_id},connection);
                if(agentFormMap!=null){
				dbHelper.execute("update pro_product_deal_form  set factoryname=?,cataname=?,name=?,product_name=?,contact_tel=?,province=?,city=?,remark=?,brand_series=?,pro_condition=?,agent_form_id=?,factory_form_id=0  where  id=?  ",new Object [] { jr_deal_factoryname,jr_cataname,order_name,jr_deal_model,mobile_phone,jr_province,jr_city,jr_special_remark,brand_series,pro_condition,agent_form_id,CommonString.getFormatPara(agentFormMap.get("id"))},connection);
				}else{
				dbHelper.execute(" insert into pro_product_deal_form (add_ip,add_user,add_date,factoryname,cataname,name,product_name,contact_tel,province,city,uuid,remark,brand_series,pro_condition,agent_form_id,factory_form_id)   values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)  ",new Object [] {Common.getIp(request),add_user,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),jr_deal_factoryname,jr_cataname,order_name,jr_deal_model,mobile_phone,jr_province,jr_city,CommonString.getUUID(),jr_special_remark,brand_series,pro_condition,agent_form_id,0},connection);
			    }
			}	
		}
		
		//批量添加参数
		if(eventList.contains("paramList")){
			String jr_parent_no = CommonString.getFormatPara(request.getParameter("jr_parent_no"));
	        String add_user="";
	        Map adminInfo = (Map)session.getAttribute("adminInfo");
	        if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("none");
		    }
			for(int i=1;i<=15;i++){
			    String jr_name = CommonString.getFormatPara(request.getParameter("jr_name"+(i==1?"1":i)));
			    String jr_category_id = CommonString.getFormatPara(request.getParameter("jr_category_id"+(i==1?"1":i)));
				if(jr_category_id.equals("")){jr_category_id = CommonString.getFormatPara(request.getParameter("jr_category_id1"));}
				 

				String jr_is_key = CommonString.getFormatPara(request.getParameter("jr_is_key"+(i==1?"1":i)));

		 	    if(!jr_name.equals("")&&!jr_category_id.equals("")){
		            String sql = " insert into pro_catalog_param(add_user,add_date,add_ip,uuid,parent_no,name,type,is_show,is_key,category_id)  values";
					sql+="('"+add_user+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+Common.getIp(request)+"','"+CommonString.getUUID()+"','"+jr_parent_no+"','"+jr_name+"',1,1,"+jr_is_key+","+jr_category_id+")";
					dbHelper.execute(sql, connection);
			   }
			}
			
		}
		
		//插入订单日志
		if(eventList.contains("order_log_f")){
			String add_user= CommonString.getFormatPara(request.getParameter("jr_user")); 

			String log_sql = " insert into phone_log(order_id,log_date,log_user,phone,flag)  values";
			String log_mobile_phone= CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String log_id= CommonString.getFormatPara(request.getParameter("formID"));

			log_sql+="("+log_id+",'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+add_user+"','"+log_mobile_phone+"',2)";
			dbHelper.execute(log_sql, connection);
		}
		
		if(eventList.contains("order_log_a")){
			String add_user= CommonString.getFormatPara(request.getParameter("jr_user")); 
			String log_sql = " insert into phone_log(order_id,log_date,log_user,phone,flag)  values";
			String log_mobile_phone= CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String log_id= CommonString.getFormatPara(request.getParameter("zd_id"));
			log_sql+="("+log_id+",'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+add_user+"','"+log_mobile_phone+"',3)";
			dbHelper.execute(log_sql, connection);
		}
		
		//挖掘机推荐排序
		if(eventList.contains("wjjOrder")){
			dbHelper.execute("update pro_products set orderno =0 where is_show =1 and catalognum in('101001001','101001004','101001007')  ", connection);
			for(int i=1;i<=15;i++){
			String pro_id = CommonString.getFormatPara(request.getParameter("pro_id"+(i==1?"":i)));
			 dbHelper.execute("update pro_products set orderno ="+(16-i)+"    where id= "+pro_id, connection);
   			}
		}
		//装载机推荐排序
		if(eventList.contains("zzjOrder")){
			dbHelper.execute("update pro_products set orderno =0 where is_show =1 and  catalognum like '%101002%' ", connection);
			for(int i=1;i<=15;i++){
			String pro_id = CommonString.getFormatPara(request.getParameter("pro_id"+(i==1?"":i)));
			    dbHelper.execute("update pro_products set orderno ="+(16-i)+"    where id= "+pro_id, connection);
   			}
		}
		

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>