<%@ page language="java" import="java.io.*,java.net.*,com.jerehnet.webservice.*,com.jerehnet.util.images.*,org.json.*,org.apache.commons.io.FileUtils,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.io.File" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
    String pro_id = CommonString.getFormatPara(request.getParameter("pro_id")) ;   // 产品id 
	Connection conn = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String rs = "fail";
	try{
		conn = dbHelper.getConnection();
		conn.setAutoCommit(false); 
		//登录
		if("login".equals(flag)){ 
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String password = CommonString.getFormatPara(request.getParameter("password"));
			adminInfo = dbHelper.getMap(" select * from "+tablePrefix+"common_user where usern = ? and password = ? ",new Object [] {usern,password},conn);
			if(null!=adminInfo){
				if(adminInfo.get("state").equals(0)){
					rs = "state0";
				}else{
					session.setAttribute("adminInfo",adminInfo);
					Map postMap = new HashMap();
					postMap.putAll(request.getParameterMap());
					postMap.put("uuid",adminInfo.get("uuid"));
					postMap.put("logFlag","101004");
					//Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/log.jsp",postMap);
					//修改最后登录信息
					String sql = " UPDATE "+tablePrefix+"common_user SET login_count = isnull(login_count,0)+1 , last_login_date = '"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"' , last_login_ip = '"+Common.getIp(request)+"' ";
					sql += " WHERE id = ? ";
					dbHelper.execute(sql,new Object [] {adminInfo.get("id")},conn);
					rs = "ok";
				}
			}
		}
		//设置角色权限
		if("set_power".equals(flag)){
			String role_uuid = CommonString.getFormatPara(request.getParameter("role_uuid"));
			String sql = " delete from "+tablePrefix+"common_role_resource where role_uuid = ? ";
			dbHelper.execute(sql,new Object [] {role_uuid},conn);
			String powerStr = CommonString.getFormatPara(request.getParameter("power"));
			String [] powerArr = powerStr.split(",");
			sql = " INSERT INTO "+tablePrefix+"common_role_resource ( add_user , add_date , add_ip , uuid , resource_uuid , role_uuid , usern ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? ) ";
			if(null!=powerArr&&powerArr.length>0){
				Object [] [] params  = new Object [powerArr.length] [7];
				for(int i=0;i<powerArr.length;i++){
					params[i][0]=adminInfo.get("usern");
					params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
					params[i][2]=Common.getIp(request);
					params[i][3]=CommonString.getUUID();
					params[i][4]=powerArr[i].replaceAll("'","");
					params[i][5]=role_uuid;
					params[i][6]="";
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		//设置用户权限
		if("set_power_user".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String sql = " delete from "+tablePrefix+"common_role_resource where usern = ? ";
			dbHelper.execute(sql,new Object [] {usern},conn);
			String powerStr = CommonString.getFormatPara(request.getParameter("power"));
			String [] powerArr = powerStr.split(",");
			sql = " INSERT INTO "+tablePrefix+"common_role_resource ( add_user , add_date , add_ip , uuid , resource_uuid , role_uuid , usern ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? ) ";
			if(null!=powerArr&&powerArr.length>0){
				Object [] [] params  = new Object [powerArr.length] [7];
				for(int i=0;i<powerArr.length;i++){
					params[i][0]=adminInfo.get("usern");
					params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
					params[i][2]=Common.getIp(request);
					params[i][3]=CommonString.getUUID();
					params[i][4]=powerArr[i].replaceAll("'","");
					params[i][5]="4CCDF227-7F10-4E09-A47C-085CCB4A45FF";
					params[i][6]=usern;
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		if("saveSort".equals(flag)){
			String sortId = CommonString.getFormatPara(request.getParameter("sortId"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String [] idArr =sortId.split(",");
			if(null!=idArr&&idArr.length>0){
				String sql = " update "+tableName+" set order_no = ? where uuid = ? ";
				Object [] [] params = new Object [idArr.length] [2];
				for(int i=0;i<idArr.length;i++){
					if(tableName.equals("pro_catalog")){
						params[i][0]=i;
					}else{
						params[i][0]=(idArr.length-i);	
					}
					params[i][1]=idArr[i];
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		
		if("newsaveSort".equals(flag)){
			String sortId = CommonString.getFormatPara(request.getParameter("sortId"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String [] idArr =sortId.split(",");
			if(null!=idArr&&idArr.length>0){
				String sql = " update "+tableName+" set order_num = ? where uuid = ? ";
				Object [] [] params = new Object [idArr.length] [2];
				for(int i=0;i<idArr.length;i++){
					if(tableName.equals("pro_catalog")){
						params[i][0]=i;
					}else{
						params[i][0]=(idArr.length-i);	
					}
					params[i][1]=idArr[i];
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		
		
		if("fenleisaveSort".equals(flag)){
			String sortId = CommonString.getFormatPara(request.getParameter("sortId"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String [] idArr =sortId.split(",");
			if(null!=idArr&&idArr.length>0){
				String sql = " update "+tableName+" set catanum_no = ? where uuid = ? ";
				Object [] [] params = new Object [idArr.length] [2];
				for(int i=0;i<idArr.length;i++){
					if(tableName.equals("pro_catalog")){
						params[i][0]=i;
					}else{
						params[i][0]=(idArr.length-i);	
					}
					params[i][1]=idArr[i];
				}
				dbHelper.executeBatch(sql,params,conn);
			}
			rs = "ok";
		}
		if("writeTemplate".equals(flag)){
			String fileName = CommonString.getFormatPara(request.getParameter("fileName"));
			if(!"".equals(fileName)){
				String content = CommonString.getFormatPara(request.getParameter("content"));
				String absolutePath = Common.getAbsolutePath(request);
				File f = new File(absolutePath+"/template/"+fileName);
				FileUtils.writeStringToFile(f,content,"utf-8");
				//更新与模板相关的数据
				List<Map> commonTemplates = dbHelper.getMapList(" select channel_uuid from "+tablePrefix+"common_template where template_file_name = ? ",new Object [] {fileName},conn);
				List<Map> channels = dbHelper.getMapList(" select no as channel_uuid from "+tablePrefix+"common_channel where template_file_name = ? ",new Object [] {fileName},conn);
				Map params = null;
				Map channel = null;
				Set<Map> t_s = new HashSet<Map>();
				t_s.addAll(commonTemplates);
				t_s.addAll(channels);
				for(Map m : t_s){
					params = new HashMap();
					params.put("eventAfter", "channelTemplate");
					params.put("channel_uuid", m.get("channel_uuid"));
					Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/after.jsp", params);
				}
				rs = "ok";
			}
		}
		//保存设备图片
		if("saveMacImg".equals(flag)){
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String machine_id = CommonString.getFormatPara(request.getParameter("machine_id"));
			String imgStr = CommonString.getFormatPara(request.getParameter("imgStr"));
			JSONArray imgArr = new JSONArray(imgStr);
			JSONObject jsonObject = null;
			String sql = " INSERT INTO "+tablePrefix+"machine_image ( add_user , add_date , add_ip , uuid , channel_uuid , machine_id , title , img , small_img , order_no , is_show ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
			Object [][] params = new Object [imgArr.length()][11];
			for(int i=0;i<params.length;i++){
				jsonObject = imgArr.getJSONObject(i);
				params[i][0]=adminInfo.get("usern");
				params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
				params[i][2]=Common.getIp(request);
				params[i][3]=CommonString.getUUID();
				params[i][4]=channel_uuid;
				params[i][5]=machine_id;
				params[i][6]=jsonObject.getString("title");
				params[i][7]=jsonObject.getString("url");
				params[i][8]=Common.getSmallImg(jsonObject.getString("url"));
				params[i][9]=0;
				params[i][10]=1;
			}
			dbHelper.executeBatch(sql,params,conn);
			rs = "ok";
		}
		
		// 保存产品图片
		if("saveProImg".equals(flag)){
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String machine_id = CommonString.getFormatPara(request.getParameter("machine_id"));
			String imgStr = CommonString.getFormatPara(request.getParameter("imgStr"));
			String picFlag = CommonString.getFormatPara(request.getParameter("picFlag"));

			JSONArray imgArr = new JSONArray(imgStr);
			JSONObject jsonObject = null;
			String sql = " INSERT INTO "+tablePrefix+"product_pic ( product_id , name , placeflag , img_name , is_show , page_pic_flag,uuid ,pic_flag ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? ,?) ";
			//system.out.println(pro_id) ;
			Object [][] params = new Object [imgArr.length()][8];
			for(int i=0;i<params.length;i++){
				jsonObject = imgArr.getJSONObject(i);
				params[i][0]= pro_id ;
				params[i][1]= jsonObject.getString("title") ;
				params[i][2]= 0 ;
				params[i][3]= jsonObject.getString("url") ;
				params[i][4]= 0 ;
				params[i][5]= 0 ;
				 params[i][6]= java.util.UUID.randomUUID().toString() ;
				 params[i][7]= picFlag;
			}
			//system.out.println(sql+"--") ;
			 dbHelper.executeBatch(sql,params,conn);
			rs = "ok";
		}
		
		// 保存人物图片
		if("saveSubImg".equals(flag)){
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String machine_id = CommonString.getFormatPara(request.getParameter("machine_id"));
			String imgStr = CommonString.getFormatPara(request.getParameter("imgStr"));
			String table_name = CommonString.getFormatPara(request.getParameter("table_name"));
			JSONArray imgArr = new JSONArray(imgStr);
			JSONObject jsonObject = null;
			String sql = " INSERT INTO "+table_name+" ( product_id , name , placeflag , img_name , is_show , page_pic_flag,uuid  ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? ) ";
			//system.out.println(pro_id) ;
			Object [][] params = new Object [imgArr.length()][7];
			for(int i=0;i<params.length;i++){
				jsonObject = imgArr.getJSONObject(i);
				params[i][0]= pro_id ;
				params[i][1]= jsonObject.getString("title") ;
				params[i][2]= 0 ;
				params[i][3]= jsonObject.getString("url") ;
				params[i][4]= 0 ;
				params[i][5]= 0 ;
				 params[i][6]= java.util.UUID.randomUUID().toString() ;
			}
			//system.out.println(sql+"--") ;
			 dbHelper.executeBatch(sql,params,conn);
			rs = "ok";
		}
		
		//多删除
		if("groupDel".equals(flag)){
			String ids = CommonString.getFormatPara(request.getParameter("ids"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String sql = " delete from "+tableName+" where uuid in ("+ ids +")";
			dbHelper.execute(sql,conn);
			rs = "ok";
		}
		//通用修改
		if("commonUpdate".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
			String key =CommonString.getFormatPara(request.getParameter("key"));
			String value = CommonString.getFormatPara(request.getParameter("value"));
			String [] keyArr = key.split(",");
			String sql = " update " + tableName + " set "+key+" = ? where uuid = ? ";
			Object [] params = new Object [keyArr.length+1];
			String [] valArr = value.split(",");
			sql = " update "+tableName+" set ";
			for(int i=0;i<keyArr.length;i++){
				sql += keyArr[i]+" = ? , ";
				params[i]=valArr[i];
			}
			params[keyArr.length]=uuid;
			sql = sql.substring(0,sql.lastIndexOf(",")-1);
			sql += " where uuid = ? ";
			dbHelper.execute(sql,params,conn);
			rs = "ok";
		}
		//删除设备图片
		if("delMacImg".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" delete from "+tablePrefix+"machine_image where uuid = ? ",new Object [] {id},conn);
			rs = "ok";
		}
		
		//保存配件图片
		if("savePartsImg".equals(flag)){
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String machine_id = CommonString.getFormatPara(request.getParameter("machine_id"));
			String imgStr = CommonString.getFormatPara(request.getParameter("imgStr"));
			JSONArray imgArr = new JSONArray(imgStr);
			JSONObject jsonObject = null;
			String sql = " INSERT INTO "+tablePrefix+"parts_image ( add_user , add_date , add_ip , uuid , channel_uuid , machine_id , title , img , small_img , order_no , is_show ) ";
			sql += " VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
			Object [][] params = new Object [imgArr.length()][11];
			for(int i=0;i<params.length;i++){
				jsonObject = imgArr.getJSONObject(i);
				params[i][0]=adminInfo.get("usern");
				params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
				params[i][2]=Common.getIp(request);
				params[i][3]=CommonString.getUUID();
				params[i][4]=channel_uuid;
				params[i][5]=machine_id;
				params[i][6]=jsonObject.getString("title");
				params[i][7]=jsonObject.getString("url");
				params[i][8]=Common.getSmallImg(jsonObject.getString("url"));
				params[i][9]=0;
				params[i][10]=1;
			}
			dbHelper.executeBatch(sql,params,conn);
			rs = "ok";
		}
		//删除配件图片
		if("delPartsImg".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" delete from "+tablePrefix+"parts_image where uuid = ? ",new Object [] {id},conn);
			rs = "ok";
		}
		
		// 批量导入代理产品
		if("inputall".equals(flag)){
			String agentid = CommonString.getFormatPara(request.getParameter("agentid")) ;  // 代理品牌 
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;  // 品牌id
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;  // 类别
			StringBuffer whereStr = new StringBuffer(" where 1=1") ;
			if(!"".equals(factoryid)){
				whereStr.append(" and factoryid='"+factoryid+"'") ;
			}
			if(!"".equals(catalognum)){
				whereStr.append(" and catalognum like '%"+catalognum+"%'") ;
			}
			List<Map> allids = dbHelper.getMapList(" select id from pro_products "+whereStr.toString()) ;
			if(null !=allids && !"".equals(factoryid) && !"".equals(agentid)){
				String insert_sql = "" ;
 				for(Map oneMap:allids){ // 所有符合条件的品牌
				 if(!"".equals(CommonString.getFormatPara(oneMap.get("id")))){
					 insert_sql = "insert into pro_agent_products(agent_id,factory_id,uuid,product_id) values('"+agentid+"','"+factoryid+"','"+UUID.randomUUID().toString()+"'"+",'"+CommonString.getFormatPara(oneMap.get("id"))+"')"; 
				    dbHelper.execute(insert_sql) ;
				    rs = "ok" ;
				 }
				}
			}
		}
		if("set_brandrecommend".equals(flag)){
			String brandids = CommonString.getFormatPara(request.getParameter("brandids")) ;  // 获取选取的品牌id
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ; // 类别编号 
			String catalogname = CommonString.getFormatPara(catalogMap.get(catalognum)) ; // 类别名
			List<Map> hasbrands = null ; // 已经推荐的品牌
			String hasbrandsstr = "" ;
			if(!"".equals(catalognum)){
				hasbrands = dbHelper.getMapList(" select factoryid from pro_catalog_factory where catalognum = '"+catalognum+"'") ;
			// 	dbHelper.execute(" delete from pro_catalog_factory where catalognum like'"+catalognum+"%'") ;
			}
			if(null != hasbrands){
				for(Map oneMap:hasbrands){
					hasbrandsstr +=CommonString.getFormatPara(oneMap.get("factoryid"))+"," ;
				}
			}
			String brandname = "" ;
			String[] brandid = null ;
			String insert_sql = "" ;
			int result = 0 ;
			if(!"".equals(brandids)){
				brandid = brandids.split(",") ;
			}
			if(null!=brandid&&brandid.length>0){
				for(String str:brandid){
					brandname = CommonString.getFormatPara(brandMap.get(str)) ; // 品牌名字
					insert_sql =  " insert into pro_catalog_factory(catalognum,catalogname,factoryid,factoryname,order_no,uuid) values ('"+catalognum+"','"+catalogname+"','"+str+"','"+brandname+"','1','"+UUID.randomUUID().toString()+"')" ;
					if(hasbrandsstr.indexOf(str)==-1){
					 result += dbHelper.execute(insert_sql) ;
					}
				}
			}
			if(result>=0){
				if(!"".equals(brandids))
				{
				dbHelper.execute(" delete from pro_catalog_factory where factoryid not in("+brandids+") and catalognum like'"+catalognum+"%'") ;
				}else
				{
					dbHelper.execute(" delete from pro_catalog_factory where catalognum like'"+catalognum+"%'") ;
				}
				rs = "ok" ;
			}
		}
		if("set_catalogrecommend".equals(flag)){ 
			String catalogids = CommonString.getFormatPara(request.getParameter("catalogids")) ;
			String[] catalogid_s = null ;
			if(!"".equals(catalogids)){
				catalogid_s = catalogids.split(",") ;
			}
			String facId = CommonString.getFormatPara(request.getParameter("facId")) ; // catalogMap
			String facName = "" ;
			String cataName = "" ;
			String del_sql = "delete from pro_catalog_factory where factoryid=?" ;
			String ins_sql = "insert into pro_catalog_factory(catalognum,catalogname,factoryid,factoryname,order_no,uuid) values(?,?,?,?,?,?)" ;
			if(!"".equals(facId)){
				facName = CommonString.getFormatPara(brandMap.get(facId)) ;
				 int res = dbHelper.execute(del_sql,new Object[]{facId}) ;
				if(null!=catalogid_s && catalogid_s.length>0){
					for(String str:catalogid_s){
						cataName = CommonString.getFormatPara(catalogMap.get(str)) ;
						dbHelper.execute(ins_sql,new Object[]{
								str,
								cataName,
								facId,
								facName,
								1,
								UUID.randomUUID().toString()
						}) ;
					}
				}
			}
			out.println("ok") ;
			return ;
		}
		
		if("iswartermark".equals(flag)){
			String ismark = CommonString.getFormatPara(request.getParameter("ismark")) ;
			application.setAttribute("ismark",ismark) ;
		}
		if("changeagent".equals(flag)){
			String choose = CommonString.getFormatPara(request.getParameter("choose")) ;	  // 是否显示
			String brandid = CommonString.getFormatPara(request.getParameter("brandid")) ; // 品牌id
			String show = choose.equals("1")?"0":"1" ;
			String count_sql = "select count(*) from  pro_agent_factory  where flag=2 and is_show="+show+" and agent_fac like '%"+brandid+"%'" ; ;
 			String sql = "update  pro_agent_factory set is_show="+choose+" where flag=2 and is_show="+show+" and agent_fac like '%"+brandid+"%'" ;
 			 // dbHelper.execute(count_sql) ;  // 改变的个数
 			dbHelper.execute(sql) ;
 			 rs = "ok" ;
		}
		//订单短信发送
		if("sendSms".equals(flag)){
			String content =CommonString.getFormatPara(request.getParameter("content"));
			String tel_sms = CommonString.getFormatPara(request.getParameter("tel_sms"));
			String id = CommonString.getFormatPara(request.getParameter("order_id"));
			int state = 0;
			String phone = tel_sms;
			try {
			 	Map root = new HashMap() ;
				root.put("phone",phone) ;
				root.put("content",content) ;
				root.put("source","195002");
				String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
			} catch (Exception e) {
				state = -4;
			}
			if(state >= 0){
				//修改订单是否发送
				String sql = " UPDATE pro_product_form SET is_send = 1 ";
				sql += " WHERE id = ? ";
				dbHelper.execute(sql,new Object [] {id},conn);
				rs = "ok";
			}
		}
		if("sendSms_test".equals(flag)){
			int state = 0;
			try {
				String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp?source=195002&content=安徽安庆市吴疆13074038060询三一SSR220AC-8单钢轮压路机&phone=13573587540",null) ;
				state=CommonString.getFormatInt(srt);
			} catch (Exception e) {
				state = -4;
			}
			rs=state+"";
		}
		if("changeProductCategory".equals(flag)){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			String sel_sql = "select num,catalogid_old,catalogname from pro_factory_category where factoryid=? " ;
			String upt_sql = " select id from pro_products where factoryid=? and catalognum=?" ;
			String upt_sql2 = " update pro_products set catalogname_spe=?,catalognum_spe=? where id=? and (catalogname_spe is null or catalogname_spe ='' or catalognum_spe='' or catalognum_spe is null)" ;
			// 把与 pro_factory_category表中和pro_products表对应的num对应num更新到产品表中 
			List<Map> chageProductsIdsList = null ;// 需要改更的产品 id
			List<Map> catalog_old_list = null ;
			if(!"".equals(factoryid)){
				catalog_old_list = dbHelper.getMapList(sel_sql,new Object[]{factoryid}) ;
			}
			if(catalog_old_list!=null && catalog_old_list.size()>0){
				for(Map oneMap:catalog_old_list){
					String catalogid_old = CommonString.getFormatPara(oneMap.get("catalogid_old")) ;  // 原产品对应的 catalogid
					String newcatalogid = CommonString.getFormatPara(oneMap.get("num")) ;  // 需要更改的类别 id
					String catalogname = CommonString.getFormatPara(oneMap.get("catalogname")) ;  // 需要更改的类别 名字
					if(!"".equals(catalogid_old) && !"".equals(factoryid)){
						chageProductsIdsList = dbHelper.getMapList(upt_sql,new Object[]{factoryid,catalogid_old}) ;
						if(null!=chageProductsIdsList && chageProductsIdsList.size()>0){
							for(Map twoMap:chageProductsIdsList){
								if(!"".equals(CommonString.getFormatPara(twoMap.get("id")))){
									  dbHelper.execute(upt_sql2, new Object[]{catalogname,newcatalogid,CommonString.getFormatPara(twoMap.get("id"))}) ;
								}
							}
						}
					}
				}
			}
			String do_sql = "update pro_agent_factory set flag_import=1 where id=?" ;
			if(!"".equals(factoryid) && dbHelper.execute(do_sql,new Object[]{factoryid})>0){
				rs = "ok" ;
			}
		}
		// 更新产品厂家
		if("changeProductFactory".equals(flag)){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;  // 需要改更的厂家id 
			String factoryname = CommonString.getFormatPara(request.getParameter("factoryname")) ; // 需要更改的厂家名字
			String sel_sql = " select parent_factoryid,parent_factoryname from pro_agent_factory where id=?" ;
			String sel_sql2 = " select num from pro_factory_category where factoryid=?" ; // 该品牌拥有栏目
			String sel_sql3 = " select id from pro_products where factoryid=? and catalognum_spe=? " ;
			String upt_sql = " update pro_products set factoryid_sub=?,factoryname_sub=? where id=?" ;
			List<Map> catalognumList = null ;
			List<Map> changeProductList = null ;
			if(!"".equals(factoryid)){
				catalognumList = dbHelper.getMapList(sel_sql2,new Object[]{factoryid}) ;
			}
			String parent_factoryid = "" ;
			String parent_factoryname = "" ;
			if(!"".equals(factoryid)){
				parent_factoryid = CommonString.getFormatPara(dbHelper.getMap(sel_sql,new Object[]{factoryid}).get("parent_factoryid")) ;  // 所属厂家 id 
				parent_factoryname = CommonString.getFormatPara(dbHelper.getMap(sel_sql,new Object[]{factoryid}).get("parent_factoryname")) ; // 所属厂家 名字
			}
			if(null!=catalognumList && catalognumList.size()>0 && !"".equals(parent_factoryid)){
				for(Map oneMap:catalognumList){
					String catalognum = CommonString.getFormatPara(oneMap.get("num")) ;  // 所属厂家下的产品栏目
					changeProductList = dbHelper.getMapList(sel_sql3,new Object[]{parent_factoryid,catalognum}) ;
					if(null!=changeProductList && changeProductList.size()>0){
						for(Map twoMap:changeProductList){
							dbHelper.execute(upt_sql,new Object[]{factoryid,factoryname,CommonString.getFormatPara(twoMap.get("id"))}) ;
						}
					}
				}
			}
			rs = "ok" ;
		}
		// 导入集团的栏目到子公司
		if("importFactoryCatagory".equals(flag)){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;  // 子公司 id 
			String parent_factoryid = CommonString.getFormatPara(request.getParameter("parent_factoryid")) ; // 集团 id
			String idStr = CommonString.getFormatPara(request.getParameter("idStr")) ;  // 选择的 栏目
			String sel_sql = " select count(id) total from pro_factory_category where factoryid=?" ; // 查询是否已经导入过
			// 查询集团下的栏目
			String sel_sql2 = " select parentid,num,catalogname,order_no,catalogid_old,catalogname_old,add_user,is_show from pro_factory_category where uuid in("+idStr+")" ;
			String ins_sql = " insert into pro_factory_category(factoryid,parentid,num,catalogname,order_no,catalogid_old,catalogname_old,add_user,is_show) values(?,?,?,?,?,?,?,?,?)" ;
			List<Map> parentCatalogList = null ;
			if(!"".equals(factoryid)){
				if((Integer)dbHelper.getMap(sel_sql,new Object[]{factoryid}).get("total")<=0 && !"".equals(parent_factoryid)){  // 可以进行导入
					parentCatalogList = dbHelper.getMapList(sel_sql2) ;
						if(null!=parentCatalogList && parentCatalogList.size()>0){
							for(Map oneMap:parentCatalogList){
								dbHelper.execute(ins_sql,new Object[]{factoryid,oneMap.get("parentid"),oneMap.get("num"),oneMap.get("catalogname"),oneMap.get("order_no"),oneMap.get("catalogid_old"),oneMap.get("catalogname_old"),oneMap.get("add_user"),oneMap.get("is_show")}) ;
							}
						}
						rs = "ok" ;
				 }else{
					 rs = "had" ;
				 }
			}
		}
		// 更改已导入catalognum
		if("importFactoryCatagoryAgain".equals(flag)){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;  // 子公司 id 
			String parent_factoryid = CommonString.getFormatPara(request.getParameter("parent_factoryid")) ; // 集团 id
			String idStr = CommonString.getFormatPara(request.getParameter("idStr")) ;  // 选择的 栏目
			String del_sql = " delete from pro_factory_category where factoryid=?" ; // 查询是否已经导入过
			
			// 查询集团下的栏目
			String sel_sql2 = " select parentid,num,catalogname,order_no,catalogid_old,catalogname_old,add_user,is_show from pro_factory_category where uuid in("+idStr+")" ;
			String ins_sql = " insert into pro_factory_category(factoryid,parentid,num,catalogname,order_no,catalogid_old,catalogname_old,add_user,is_show) values(?,?,?,?,?,?,?,?,?)" ;
			List<Map> parentCatalogList = null ;
			if(!"".equals(factoryid)){
				if(dbHelper.execute(del_sql,new Object[]{factoryid})>0 && !"".equals(parent_factoryid)){  // 可以进行更改导入
					parentCatalogList = dbHelper.getMapList(sel_sql2) ;
						if(null!=parentCatalogList && parentCatalogList.size()>0){
							for(Map oneMap:parentCatalogList){
								dbHelper.execute(ins_sql,new Object[]{factoryid,oneMap.get("parentid"),oneMap.get("num"),oneMap.get("catalogname"),oneMap.get("order_no"),oneMap.get("catalogid_old"),oneMap.get("catalogname_old"),oneMap.get("add_user"),oneMap.get("is_show")}) ;
							}
						}
						rs = "ok" ;
				 }else{
					 rs = "had" ;
				 }
			}
		}
 // 
 if("had_import_catalog".equals(flag)){
	 String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	 String sel_sql = " select num from pro_factory_category where factoryid=?" ;
	 List<Map> hasCatalogList = null ;
	 if(!"".equals(factoryid)){
		 hasCatalogList = dbHelper.getMapList(sel_sql,new Object[]{factoryid}) ;
	 }
	 StringBuffer sbf = new StringBuffer(",") ;
	 if(null!=hasCatalogList && hasCatalogList.size()>0){
		 for(Map oneMap:hasCatalogList){
			 sbf.append(oneMap.get("num")) ;
			 sbf.append(",") ;
		 }
	 }
	 out.println(sbf.toString()) ;
	 return ;
 }
		//如果是推荐至其它品牌
		if("recommend_to_other_brand".equals(flag)){
			/*
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String other_brand_id = CommonString.getFormatPara(request.getParameter("other_brand_id"));
			String other_brand_name = CommonString.getFormatPara(request.getParameter("other_brand_name"));
			Map m = dbHelper.getMap(" select * from pro_product_form where uuid = ? ",new Object [] {id},conn);
			m.put("from_factoryid",m.get("factoryid"));
			m.put("from_factoryname",m.get("factoryname"));
			m.put("factoryid",other_brand_id);
			m.put("factoryname",other_brand_name);
			m.put("uuid",CommonString.getUUID());
			String sql = " insert into pro_product_form ( ";
			String key = "";
			for(Object k : m.keySet()){
				key = CommonString.getFormatPara(k);
				if(!"id".equals(key)){
					if(null!=m.get(key)){
						sql += key+",";
					}
				}
			}
			sql = sql.substring(0,sql.length()-1);
			sql += " ) ";
			sql += " values ( ";
			for(Object k : m.keySet()){
				key = CommonString.getFormatPara(k);
				if(!"id".equals(key)){
					if(null!=m.get(key)){
						sql +="'"+ m.get(key)+"',";
					}					
				}
			}
			sql = sql.substring(0,sql.length()-1);
			sql += " ) ";
			dbHelper.execute(sql,conn);
			*/
			rs = "ok";
		}
		if("saveBatchParentId".equals(flag)){
			String uuids = CommonString.getFormatPara(request.getParameter("ids"));
			String parentId = CommonString.getFormatPara(request.getParameter("parent_id"));
			String [] uuidArr = uuids.split(",");
			if(null!=uuidArr&&uuidArr.length>0){
				for(int i=0;i<uuidArr.length;i++){
					dbHelper.execute(" update pro_agent_factory set parent_id = ? , is_show = 1 where uuid = ? ",new Object [] {
							parentId,uuidArr[i]
					},conn);
				}
			}
		}
		if(flag.equals("cancelProductsOrder")){
			String del_id = CommonString.getFormatPara(request.getParameter("del_id")) ;
			String upt_sql = "update pro_products set order_no=0 where uuid in("+del_id+")" ;
			if(!"".equals(del_id)){
				dbHelper.execute(upt_sql) ;
			}
		}
		//增加试用期
		if("addProbation".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String dateAdded = CommonDate.dateAdd("15","yyyy-MM-dd HH:mm:ss");
			dbHelper.execute(" update pro_agent_factory set probation_date = '"+dateAdded+"' where uuid = '"+id+"' ",conn);
			rs = dateAdded;
		}
		// 把所选产品批量设为显示或不显示 
		if(flag.equals("setProductShow") || flag.equals("setProductHide")){
			String opt_id = CommonString.getFormatPara(request.getParameter("opt_id")) ; 
			String opt_sql = "update pro_products set is_show=?,ddb_is_show=?,year=? where uuid in("+opt_id+")" ; 
			if(flag.equals("setProductShow")){
				dbHelper.execute(opt_sql,new Object[]{1,1,1}) ;
				Map<String,String> postMap = new HashMap<String,String>();
			    postMap.put("id",opt_id);
				Common.doPostHttpAsync("http://sowa.21-sun.com//writer/product.21-sun.com/product_create_one.jsp?id="+opt_id,postMap);
			}
			if(flag.equals("setProductHide")){
				dbHelper.execute(opt_sql,new Object[]{0,0,9999}) ;
				Map<String,String> postMap = new HashMap<String,String>();
			    postMap.put("id",opt_id);
				Common.doPostHttpAsync("http://sowa.21-sun.com//writer/product.21-sun.com/product_create_one.jsp?id="+opt_id,postMap);
			}
		}
		//产品中心类别参数，插入父类别参数
		if("insertParent".equals(flag)){
			/** 
			String category = CommonString.getFormatPara(request.getParameter("category"));
			String parentCategory = "";
			if(category != null && category.length() >= 6){
				parentCategory = category.substring(0,category.length()-3);
			}
			List paramL = Tools.getCategoryParam(parentCategory,"1060001");
					
			String sql = " insert into pro_catalog_param(add_user,add_date,add_ip,uuid,parent_no,no,name,type,enum_no,is_search,is_key,is_show,order_no) values (?,?,?,?,?,?,?,?,?,?,?,?,?) ";
			Object [][] params = new Object [paramL.size()][13];
			Map m = null;				
			double maxNo = Double.parseDouble(Tools.getNo(category,"pro_catalog_param","106001"));
			for(int i=0;i < paramL.size();i++){
				m = (Map)paramL.get(i);
				params[i][0] = adminInfo.get("usern");
				params[i][1] = CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
				params[i][2] = Common.getIp(request);
				params[i][3] = CommonString.getUUID();
				params[i][4] = category;
				params[i][5] = (maxNo+i)+"";
				params[i][6] = CommonString.getFormatPara(m.get("name"));
				params[i][7] = CommonString.getFormatPara(m.get("type"));
				params[i][8] = CommonString.getFormatPara(m.get("enum_no"));
				params[i][9] = CommonString.getFormatPara(m.get("is_search"));
				params[i][10] = CommonString.getFormatPara(m.get("is_key"));
				params[i][11] = CommonString.getFormatPara(m.get("is_show"));
				params[i][12] = CommonString.getFormatPara(m.get("order_no"));
			}
			dbHelper.executeBatch(sql,params);
			rs = "ok";
			*/
		}
		// 设置推荐品牌
		if("set_tobrands".equals(flag)){
			/*
			String fomId = CommonString.getFormatPara(request.getParameter("fomId")) ; // 订单 id 
			String set_tobrands = CommonString.getFormatPara(request.getParameter("brandids")) ; // 引导品牌
			String upt_sql = "update pro_product_form set to_brands=? where id=?" ; 
			if(!"".equals(fomId)){
				dbHelper.execute(upt_sql,new Object[]{set_tobrands,fomId}) ;
			}
			*/
			out.println("ok") ;
			return ;
		}
		// 更新产品中心订单是否成交
		if("isDeal".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid")) ;
			String value = CommonString.getFormatPara(request.getParameter("value")) ;
			String upt_sql = "update pro_product_form set is_deal=? where uuid=?" ;
			if(!"".equals(uid)){
				dbHelper.execute(upt_sql,new Object[]{value,uid}) ;
			}
		}
		// 更新产品中心订单成交备注
		if("isDeal_desc".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid")) ;
			String value = CommonString.getFormatPara(request.getParameter("value")) ;
			String upt_sql = "update pro_product_form set deal_desc=? where uuid=?" ;
			if(!"".equals(uid)){
				dbHelper.execute(upt_sql,new Object[]{value,uid}) ;
			}
		}
		// 清除 订单实时提醒
		if("clearOrderInfo".equals(flag)){
			// 清除新订单session
			 application.removeAttribute("applicationOrderId") ;
			return ;
		}
		if("english_name".equals(flag)){ 
			String uuid = CommonString.getFormatPara(request.getParameter("uid")) ;
			String value = CommonString.getFormatPara(request.getParameter("value")) ;
			String upt_sql = "update pro_agent_factory set english_name=? where uuid=?" ;
			dbHelper.execute(upt_sql,new Object[]{value.toUpperCase(),uuid},conn) ;
			System.out.println(uuid+"--"+value) ;
		}
		// 把所选产品批量设为显示或不显示 
		if(flag.equals("setYmtShow") || flag.equals("setYmtHide")){
			String opt_id = CommonString.getFormatPara(request.getParameter("opt_id")) ; 
			String opt_sql = "update pro_ymt_activity set is_show=? where uuid in("+opt_id+")" ; 
			if(flag.equals("setYmtShow")){
				dbHelper.execute(opt_sql,new Object[]{1}) ;
			}
			if(flag.equals("setYmtHide")){
				dbHelper.execute(opt_sql,new Object[]{0}) ;
			}
		}
		
		
		
		//代理商批量隐藏
		if("hideAgent".equals(flag)){
			String idList = CommonString.getFormatPara(request.getParameter("idList"));
			if (null != idList && idList.length() > 0) {// 删除
				String sql = " update pro_agent_factory  set is_show = 0  where id in (" + idList+ ") ";
				dbHelper.execute(sql,conn);
				rs = "ok";
			}
		}
		
		//更新产品seo标题
		if("updateKeywords".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String value = CommonString.getFormatPara(request.getParameter("value"));
			String sql = " update pro_products   set web_title = '"+value+"' where id= "+id;
			dbHelper.execute(sql,conn);
			rs = "ok";
		}
		
		if("updateIntro".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String value = CommonString.getFormatPara(request.getParameter("value"));
			String sql = " update pro_shuang_user   set intro = '"+value+"' where id= "+id;
			dbHelper.execute(sql,conn);
			rs = "ok";
		}
		
		if("updateKnRemark".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String value = CommonString.getFormatPara(request.getParameter("value"));
			String sql = " update pro_kn_order   set remark = '"+value+"' where id= "+id;
			dbHelper.execute(sql,conn);
			rs = "ok";
		}
		
		//更新吨位
	    if("updateTonandmeter".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String value = CommonString.getFormatPara(request.getParameter("value"));
			String sql = " update pro_products   set tonandmeter = "+value+" where id= "+id;
			dbHelper.execute(sql,conn);
			rs = "ok";
		}
		conn.commit();
	}catch(Exception e){
		conn.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(conn);
	}
	out.print(rs);
%>