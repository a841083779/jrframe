<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%><%
	String event = CommonString.getFormatPara(request.getParameter("eventAfter"));
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String [] eventArr = event.split(",");
	List<String> eventList =Arrays.asList(eventArr);
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map model = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
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
		//抽出新闻的图片存到相应字段
		if(eventList.contains("updateInformationImg")){
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			Map infoMap = dbHelper.getMap(" select img,content from "+tablePrefix+"information where id = ? ",new Object [] {id},connection);
			String img = CommonString.getFormatPara(infoMap.get("img"));
			//如果图片是空
			if("".equals(img)){
				String content = CommonString.getFormatPara(infoMap.get("content"));
				img = CommonString.getOnePicFromContent(content);
				if(!"".equals(img)){
					dbHelper.execute(" update "+tablePrefix+"information set img = ? where id = ? ",new Object [] {img,id},connection);
				}
			}
		}
		//更新订单呼叫结果
		if(eventList.contains("updateFormCallRs")){
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			String is_high_quality = CommonString.getFormatPara(request.getParameter("is_high_quality"));
			String message=CommonString.getFormatPara(request.getParameter("jr_textarea"));
			Map task1Map = dbHelper.getMap(" select form_uuid,call_rs,remark from pro_400_task1 where id = ? ",new Object [] {id},connection);
			String formUUID = CommonString.getFormatPara(task1Map.get("form_uuid"));
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
					message,
					message,
					formUUID
			},connection);
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
						sqlString += "source_id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first";
						sqlString += ") select id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first";
						sqlString += " from pro_product_form WHERE uuid = '"+idsArr[i]+"'";
						Integer rs = dbHelper.execute(sqlString, connection);
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
			String zd_call_rs_task2 = CommonString.getFormatPara(request.getParameter("zd_call_rs_task2"));
			String formUUID = CommonString.getFormatPara(request.getParameter("zd_form_uuid"));
			String contents= CommonString.getFormatPara(request.getParameter("jr_textarea"));
			//是否二手，是否星标记
			String is_high_quality= CommonString.getFormatPara(request.getParameter("ihq"));
			String is_push= CommonString.getFormatPara(request.getParameter("is_star"));
			//获取第二次的具体订购信息
			String main_brand= CommonString.getFormatPara(request.getParameter("main_brand"));
			String main_category= CommonString.getFormatPara(request.getParameter("main_category"));
			String main_model= CommonString.getFormatPara(request.getParameter("main_model"));
			
			String brand_id= CommonString.getFormatPara(request.getParameter("brand_id"));
			String pro_id= CommonString.getFormatPara(request.getParameter("pro_id"));
			//判断订单是否进行结束
			String sql = "";
			//1:如果是拒访
			if("103004".equals(zd_call_rs_task2)){
				//结束订单，并添加任务2数量
				sql = " update pro_product_form set task2_count = isnull(task2_count,0)+1 , task2_over = 1 , call_rs_task2 = ?,call_result2=?,is_high_quality=?,is_star=?,factoryname=?,cataname=?,product_name=?,factoryid,product_id where uuid = ?  ";
				dbHelper.execute(sql,new Object [] {zd_call_rs_task2,contents,is_high_quality,is_push,main_brand,main_category,main_model,brand_id,pro_id,formUUID},connection);
			}else if("103002".equals(zd_call_rs_task2)){//2:如果外呼结果为成功，更新订单信息
				Boolean isUpdateForm = false;
				Integer task2_over = 0;
				//如果已联系并且是购买订单设备的话，更新订单信息，并设置为订单结束状态1
				if(CommonString.getFormatPara(request.getParameter("main_is_link")).equals("1")&&CommonString.getFormatPara(request.getParameter("main_is_buy_self")).equals("1")){
					isUpdateForm = true;
					task2_over = 1;
				//如果已联系并且是购买其它设备的话，更新订单信息，并设置为订单结束状态2
				}else if(CommonString.getFormatPara(request.getParameter("main_is_link")).equals("1")&&CommonString.getFormatPara(request.getParameter("main_is_buy")).equals("1")&&CommonString.getFormatPara(request.getParameter("main_is_buy_self")).equals("1")){
					isUpdateForm = true;
					task2_over = 2;
				//如果是未联系并且购买其它品牌的话，更新订单信息，并设置为订单结束状态2
				}else if(CommonString.getFormatPara(request.getParameter("main_is_link")).equals("0")&&CommonString.getFormatPara(request.getParameter("main_is_buy")).equals("1")){
					isUpdateForm = true;
					task2_over = 2;
				//如果是已联系，但是也是未购买的话，更新订单信息，并设置为订单结束状态3
				}else if(CommonString.getFormatPara(request.getParameter("main_is_link")).equals("1")&&CommonString.getFormatPara(request.getParameter("main_is_buy_self")).equals("0")&&CommonString.getFormatPara(request.getParameter("main_is_buy")).equals("0")){
					isUpdateForm = true;
					task2_over = 3;
				//如果是已联系，但是是联系中的话
				}else if(CommonString.getFormatPara(request.getParameter("main_is_link")).equals("1")&&CommonString.getFormatPara(request.getParameter("main_is_buy_self")).equals("2")){
					isUpdateForm = true;
					task2_over = 0;
				}
				if(isUpdateForm){
					sql = " update pro_product_form set  is_link = ?  , is_buy = ?  , is_buy_self = ?  ";
					sql += "  , not_buy_reson1 = ? , not_buy_reson2 = ? , brand = ?  , category = ?  , model = ?  , price = ? , ";
					sql += " is_intention = ?  , plan_to_buy = ?  , intention_brand = ?  , intention_category = ?  ";
					sql += "  , intention_model = ? , intention_price = ? , other_brand = ? , other_category = ? , other_model = ? , other_price = ? ";
					sql += " , task2_count = isnull(task2_count,0)+1 , task2_over = ? , call_rs_task2 = ?,call_result2=?,is_high_quality=?,is_star=?,factoryname=?,cataname=?,product_name=?,factoryid=?,product_id=?";
					sql += " where uuid = ? ";
					Float main_price = 0f;
					try{
						main_price = Float.parseFloat(request.getParameter("main_price"));
					}catch(Exception e){
						main_price = 0f;
					}
					Float main_intention_price = 0f;
					try{
						main_intention_price = Float.parseFloat(request.getParameter("main_intention_price"));
					}catch(Exception e){
						main_intention_price = 0f;
					}
					Float main_other_price = 0f;
					try{
						main_other_price = Float.parseFloat(request.getParameter("main_other_price"));
					}catch(Exception e){
						main_other_price = 0f;
					}
					dbHelper.execute(sql,new Object [] {
							CommonString.getFormatPara(request.getParameter("main_is_link")),
							CommonString.getFormatPara(request.getParameter("main_is_buy")),
							CommonString.getFormatPara(request.getParameter("main_is_buy_self")),
							CommonString.getFormatPara(request.getParameter("main_not_buy_reson1")),
							CommonString.getFormatPara(request.getParameter("main_not_buy_reson2")),
							CommonString.getFormatPara(request.getParameter("main_brand")),
							CommonString.getFormatPara(request.getParameter("main_category")),
							CommonString.getFormatPara(request.getParameter("main_model")),
							main_price,
							CommonString.getFormatPara(request.getParameter("main_is_intention")),
							CommonString.getFormatPara(request.getParameter("main_plan_to_buy")),
							CommonString.getFormatPara(request.getParameter("main_intention_brand")),
							CommonString.getFormatPara(request.getParameter("main_intention_category")),
							CommonString.getFormatPara(request.getParameter("main_intention_model")),
							main_intention_price,
							CommonString.getFormatPara(request.getParameter("main_other_brand")),
							CommonString.getFormatPara(request.getParameter("main_other_category")),
							CommonString.getFormatPara(request.getParameter("main_other_model")),
							main_other_price,
							task2_over,
							zd_call_rs_task2,
							contents,
							is_high_quality,
							is_push,
							main_brand,main_category,main_model,brand_id,pro_id,
							formUUID
					},connection);
				}else{
					//更新当前订单的呼叫状态
					dbHelper.execute(" update pro_product_form set call_rs_task2 = ? , task2_count = isnull(task2_count,0)+1 ,call_result2=?,is_high_quality=?,is_star=?,factoryname=?,cataname=?,product_name=?,factoryid=?,product_id=?  where uuid = ? ",new Object [] {zd_call_rs_task2,contents,is_high_quality,is_push,main_brand,main_category,main_model,brand_id,pro_id,formUUID},connection);
				}
			}else{
				//更新当前订单的呼叫状态
				dbHelper.execute(" update pro_product_form set call_rs_task2 = ? , task2_count = isnull(task2_count,0)+1 ,call_result2=?,is_high_quality=?,is_star=?,factoryname=?,cataname=?,product_name=?,factoryid=?,product_id=? where uuid = ? ",new Object [] {zd_call_rs_task2,contents,is_high_quality,is_push,main_brand,main_category,main_model,brand_id,pro_id,formUUID},connection);
			}
			//如果是无效号码删除该订单
			if("106005".equals(zd_call_rs_task2)){ //如果是无效号码直接删除到订单仓库
				if (null != formUUID && formUUID.length() > 0) {// 删除
					String [] idsArr = formUUID.split(",");
					Integer id = 0;
					for(int i=0;i<idsArr.length;i++){
						//查询数据
						id = (Integer)dbHelper.getOne(" select id from pro_product_form where uuid =  '"+idsArr[i]+"'",connection);
						//gaopeng add at 20131204-begin
						//把订单插入订单回收站表
						String sqlString = "insert into pro_product_form_del(";
						sqlString += "source_id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first";
						sqlString += ") select id,add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first";
						sqlString += " from pro_product_form WHERE uuid = '"+idsArr[i]+"'";
						Integer rs = dbHelper.execute(sqlString, connection);
						//gaopeng add at 20131204-end
						String del="update pro_product_form set is_deleted=1 where uuid= '"+idsArr[i]+"'";
						dbHelper.execute(del,connection);
						dbHelper.execute(" delete from pro_agent_products_form where source_id = ? and source_id is not null and source_id <> '' and source_id <> 0 ",new Object [] {
							id
						},connection);
					}
				}
				//将该手机号码拉黑
				String mobile_phone= CommonString.getFormatPara(request.getParameter("mobile_phone"));
			    String delPhone="insert into pro_product_form_blacklist";
			    delPhone+="(add_ip,add_user,add_date,uuid,tel)";
			    delPhone+="values('119.180.98.134','system',getDate(),'"+CommonString.getUUID()+"','"+mobile_phone+"')";
				dbHelper.execute(delPhone,connection);
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
			String company_name = CommonString.getFormatPara(request.getParameter("company_name"));
			String cata_name = CommonString.getFormatPara(request.getParameter("cata_name"));
			String pro_name = CommonString.getFormatPara(request.getParameter("pro_name"));
			String factory_id = CommonString.getFormatPara(request.getParameter("factory_id"));
			String brand_id = CommonString.getFormatPara(request.getParameter("brand_id"));
			String pro_id = CommonString.getFormatPara(request.getParameter("pro_id"));
			//获取合作客户是厂家还是代理商
			Map typeInfo=dbHelper.getMap("select flag from pro_agent_factory where id = ? ",new Object [] {factory_id},connection);
			String flag= CommonString.getFormatPara(typeInfo.get("flag"));
			Map orderInfo = dbHelper.getMap(" select factoryname,cataname,product_name from pro_product_form where uuid = ? ",new Object [] {uuid},connection);	
			String company = CommonString.getFormatPara(orderInfo.get("factoryname"));
			String cata = CommonString.getFormatPara(orderInfo.get("cataname"));
			String pro = CommonString.getFormatPara(orderInfo.get("product_name"));
			if(flag.equals("2")){
            //把订单推给合作的代理商订单中 ifgroup,buy_time
			String sqlString = "insert into pro_agent_products_form(";
			sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,is_push,source_id,call_result1";
			sqlString += ") select add_ip,add_date,'"+CommonString.getUUID()+"',"+brand_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',"+pro_id+",'"+pro_name+"',contact_address,mobile_phone,province,city,state,add_date,message,company,name,"+1+",id,call_result1";
			sqlString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			dbHelper.execute(sqlString,connection);
			}
			else if(flag.equals("1")){
			//把订单复制给合作的厂商订单中
			String sqlCopyString = "insert into pro_product_form(";
			sqlCopyString += "add_ip,add_user,add_date,channel_uuid,factoryid,factoryname,agentid,agentname,catanum,cataname,name,email,company,product_id,product_name,contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,uuid,is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,is_first,push_order,is_success";
			sqlCopyString += ") select add_ip,add_user,add_date,channel_uuid,"+brand_id+",'"+company_name+"',"+factory_id+",agentname,catanum,'"+cata_name+"',name,email,company,"+pro_id+",'"+pro_name+"',contact_address,contact_tel,message,disposal_content,state,province,city,mobile_phone,view_count,'"+CommonString.getUUID()+"',is_send,buy_time,ifgroup,is_success,call_rs,call_rs_task2,is_high_quality,is_push,task1_count,task2_count,task1_over,task2_over,from_factoryid,from_factoryname,rebate,is_link,is_buy,is_buy_self,not_buy_reson1,not_buy_reson2,brand,category,model,price,is_intention,plan_to_buy,intention_brand,intention_category,intention_model,intention_price,other_brand,other_category,other_model,other_price,is_lock_for_agent,agent_can_view,dispose_ps,referer,to_brands,is_deal,deal_desc,"+0+","+1+","+0;
			sqlCopyString += " from pro_product_form WHERE uuid = '"+uuid+"'";
			dbHelper.execute(sqlCopyString, connection);	
			}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>