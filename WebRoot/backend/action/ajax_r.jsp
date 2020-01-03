<%@ page language="java" import="org.json.*,java.io.File,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,org.apache.commons.io.FileUtils" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	String rs = "fail";
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		//更新application
		if("updateApp".equals(flag)){
			CommonApplication.updateApplication(request,tableName);
		}
		//产品文件名称
		if("file_name".equals(flag)){
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String htmlName = name;
			htmlName = htmlName.replace(" ","").replace("　","").replace("|","-").replace("/","-").replace("\\","-").replace("_","-");
			htmlName = Common.getSingleSpell(htmlName).replaceAll("\\+","");
			
			List <Map>products = dbHelper.getMapList("select id from pro_products where file_name = '"+htmlName+".shtm'");
			if(products == null || products.size() <= 0){
				rs = htmlName+".shtm";
			}else{
				int random = new Random().nextInt(100);
				rs = htmlName+"-"+random+".shtm";
			}
		}
		//频道树
		if("channel_tree".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}
			
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeData(channels);
		}
		//产品类别
		if("catalog".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}
			
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeData(channels,"parentid","id");
		}
		// 厂家类别
		if("factory_catalog".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}
			
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeData(channels,"parentid","num");
		}
		//频道树
		if("eunm_tree".equals(flag)){
			String whereStr = CommonString.getFormatPara(request.getParameter("whereStr"));
			String orderByStr = CommonString.getFormatPara(request.getParameter("orderByStr"));
			//目前是全部
			String sql = " select * from "+tableName+" where 1 = 1 ";
			sql += whereStr;
			if(!"".equals(orderByStr)){
				sql += " order by "+orderByStr;
			}else{
				sql += " order by order_no desc , id asc ";
			}
			List channels = dbHelper.getMapList(sql , connection);
			rs = Common.getTreeNo(channels);
		}
		//获得编号
		if("get_no".equals(flag)){
			rs = Common.getNo(CommonString.getFormatPara(request.getParameter("pno")),tableName);
		}
		if("get_no_catalog".equals(flag)){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ; // 厂家 id
			if(!"".equals(factoryid)){
				rs = Common.getNo(CommonString.getFormatPara(request.getParameter("pno")),tableName,"parentid","num",factoryid);
			}else{
				rs = Common.getNo(CommonString.getFormatPara(request.getParameter("pno")),tableName,"parentid","num");
			}
		}
		//获得键枚举
		if("get_enum".equals(flag)){
			Map enumMap = (Map)application.getAttribute("enumMap");
			JSONObject jsonObject = new JSONObject(enumMap);
			rs = CommonString.getFormatPara(request.getParameter("callback"))+"("+jsonObject.toString()+")";
		}

                //获得产品名
		if("get_Pro".equals(flag)){
			String sql="select id,name as factoryname from pro_products where id="+request.getParameter("productid");
			List<Map> productlist = dbHelper.getMapList(sql , connection);
			if(productlist.size()>0){
			    rs = CommonString.getFormatPara(productlist.get(0).get("factoryname"));
			}else{
			    rs = "";
			}
			
		}

		//获得文件的内容
		if("get_file_html".equals(flag)){
			String absolutePath = Common.getAbsolutePath(request);
			String fileName = CommonString.getFormatPara(request.getParameter("fileName"));
			File f = new File(absolutePath+"/template/"+fileName);
			rs = FileUtils.readFileToString(f,"utf-8");
		}
		//获取表的字段
		if("get_field_by_table".equals(flag)){
			String sql = " select a.name from syscolumns a,systypes b,sysobjects c ";
			sql += " where a.xtype=b.xtype and a.id=c.id and c.name= '"
					+ tableName + "' ";
			sql += " and b.name <> 'sysname' ";
			sql += " order by a.id ";
			List columns = dbHelper.getMapList(sql, connection);
			Map m = null;
			for (int i = 0; i < columns.size(); i++) {
				m = (Map) columns.get(i);
				out.print(m.get("name"));
				if(i!=(columns.size()-1)){
					out.print("&nbsp;,&nbsp;");
				}
			}
		}
		//更新浏览次数并返回浏览次数
		if("upd_view_count".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" update "+tableName+" set view_count = isnull(view_count,0)+1 where uuid = ? ",new Object [] {uuid},connection);
			Integer times = (Integer)dbHelper.getOne(" select view_count from "+tableName+" where uuid = ? ",new Object [] {uuid},connection);
			rs = ""+times;
		}
		//获取图形验证码
		if("rand".equals(flag)){
			Common.getAuthImg(request, response);
			out.clear();
			out = pageContext.pushBody();
			return;
		}
		//获取验证码(字符串格式)
		if("getRandNum".equals(flag)){
			rs = (String)session.getAttribute("rand");
		}
		//全站生成
		if("allHtmlCreate".equals(flag)){
			Integer second = 0;
			long d1 = Calendar.getInstance().getTime().getTime();
			List<Map> channels = dbHelper.getMapList(" select id from "+table_prefix+"common_channel ",connection);
			Map params = null;
			for(Map m : channels){
				params = new HashMap();
				params.put("eventAfter", "channelTemplate");
				params.put("keyId", m.get("id"));
				Common.doPost(Common.getDomain(request)+"/backend/action/after_own.jsp", params);
			}
			long d2 = Calendar.getInstance().getTime().getTime();
			long l = d2-d1;
			long day=l/(24*60*60*1000);  
			long hour=(l/(60*60*1000)-day*24);  
			long min=((l/(60*1000))-day*24*60-hour*60);  
			long s=(l/1000-day*24*60*60-hour*60*60-min*60);  
			rs = "生成成功<br />共计用时"+s+"秒";
		}
		//商家从车源车辆总数
		if("getDealerCount".equals(flag)){
			
		}
		//任务一列表请求地址
		if("task1_list_report".equals(flag)){
			JSONObject obj = new JSONObject();
			String sql = " select pce.name,count(p4t.call_rs) as counts from ";
			sql += " pro_common_enum pce left join pro_400_task1 p4t on p4t.call_rs = pce.no ";
			sql += " where pce.parent_no = '103' group by p4t.call_rs,pce.name ";
			List<Map> enumCounts = dbHelper.getMapList(sql,connection);
			obj.put("Rows",new JSONArray(enumCounts));
			obj.put("Total",enumCounts.size());
			rs = obj.toString();
		}
		//任务二列表请求地址
		if("task2_list_report".equals(flag)){
			JSONObject obj = new JSONObject();
			String sql = " select pce.name,count(p4t.call_rs) as counts from ";
			sql += " pro_common_enum pce left join pro_400_task2 p4t on p4t.call_rs = pce.no ";
			sql += " where pce.parent_no = '103' group by p4t.call_rs,pce.name ";
			List<Map> enumCounts = dbHelper.getMapList(sql,connection);
			obj.put("Rows",new JSONArray(enumCounts));
			obj.put("Total",enumCounts.size());
			rs = obj.toString();
		}
		//将订单状态改为已删除
		if(flag.equals("updateProductOrderDelete")){
			//前置事件
			String eventBefore = CommonString.getFormatPara(request.getParameter("eventBefore"));
			//如果有前置事件
			if(!"".equals(eventBefore)){
				Common.doPost(Common.getDomain(request)+"/backend/action/before.jsp",request.getParameterMap());
			}
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			rs = String.valueOf(dbHelper.execute("update pro_product_form set is_deleted=1 where uuid in (" + ids + ")", connection));
		}
		//获取代理商及厂家代理的品牌
		if(flag.equals("getBrand")){
		    String factoryId = CommonString.getFormatPara(request.getParameter("factoryId"));
			if(!"".equals(factoryId)){
			String ids="";
			String sql="";
			String daili="select agent_fac from pro_agent_factory where id="+factoryId;
			List<Map> dailiList =(ArrayList) dbHelper.getMapList(daili , connection);
			if(dailiList!=null&&dailiList.size()>0){
			    for(Map m : dailiList){
				    ids=(String)(m.get("agent_fac"));
				}
			}
			if(ids.equals("")){	 sql = " select id,name from pro_agent_factory where 1 = 1 and flag=1 and id="+factoryId;}else{
			 sql = " select id,name from pro_agent_factory where 1 = 1 and flag=1 and (id="+factoryId+" or id in("+ids+"))";}
			List<Map> brandList =(ArrayList) dbHelper.getMapList(sql , connection);
		    String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(brandList != null){
			    for(Map m : brandList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
			}
		  }
		}
		//获取改品牌下产品
		if(flag.equals("getPro")){
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
		if(!"".equals(brandId)){	
		    String  sql="select id,name from pro_products where is_show=1 and  factoryid="+brandId;
			if(brandId.equals("174")){
				 sql="select id,name from pro_products where   factoryid="+brandId;
			}
			if(!catalognum.equals("")){sql=sql+"and catalognum='"+catalognum+"'";}
         	List<Map> proList =(ArrayList) dbHelper.getMapList(sql , connection);
			String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(proList != null){
			    for(Map m : proList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
			}
		 }	
		}
		
		
		
		//获取改品牌下产品
		if(flag.equals("getAgentList")){
			String factoryId = CommonString.getFormatPara(request.getParameter("factoryId"));
		if(!"".equals(factoryId)){	
		    String  sql="select id,name from pro_agent_factory where is_show=1 and flag=2 and  agent_fac like '%"+factoryId+"%'";
         	List<Map> proList =(ArrayList) dbHelper.getMapList(sql , connection);
			String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(proList != null){
			    for(Map m : proList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
			}
		  }	
		}
		
		// 留言批量放入回收站
		if("orderDeleteCheck".equals(flag)){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			if (null != ids && ids.length() > 0) {
				String sql = "update pro_comments set is_show=0  where uuid in (" + ids+ ") ";
				rs = dbHelper.execute(sql,connection)+"";
			}
		}
		// 留言批量从回收站移回评论栏目
		if("orderRebackCheck".equals(flag)){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			if (null != ids && ids.length() > 0) {
				String sql = "update pro_comments set is_show=1  where uuid in (" + ids+ ") ";
				rs = dbHelper.execute(sql,connection)+"";
			}
		}
		//该订单为恶意垃圾订单，删除至垃圾订单仓库
		if(flag.equals("updateProductOrderDeleteNew")){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			rs = String.valueOf(dbHelper.execute("update pro_product_form set is_garbage=1,is_deleted=1 where uuid in (" + ids + ")", connection));
		}
		
		//app订单状态
		if(flag.equals("appOrderState")){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
			String orderid = CommonString.getFormatPara(request.getParameter("orderid"));
			Integer state = (Integer)dbHelper.getOne(" select top 1 person_id from  pro_agent_products_form    where person_id!=''  and person_id is not null and person_id!=0  and  factory_id = "+factoryid+" and contact_tel='"+orderid+"' " ,connection);
            if(state!=null&&state!=0){
				rs="已分配";
			}else{
				rs="未分配";
			}

		}
		
		//重新推送订单到app
		if(flag.equals("sendAppOrder")){
			
			
		
			String factory_id = CommonString.getFormatPara(request.getParameter("factoryid"));
			String brand_id=factory_id;
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String catanum = CommonString.getFormatPara(request.getParameter("catanum"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			String jr_proid = CommonString.getFormatPara(request.getParameter("proid"));
			
			
	        String person_id="0";	
			String usern="";
			List<Map> agentList = dbHelper.getMapList(" select id from pro_agent_factory  where is_cooperate=1 and push_show!=1 and  agent_fac  like '%"+factory_id+"%' " );	   
	        //龙工的做下类别判断
		    if(brand_id.equals("135")){   
		    //龙工装载机
			if(catanum.indexOf("101002")!=-1){
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16350    " );
			}
			//龙工推土机
			if(catanum.indexOf("101003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16349   " );
			}
			//龙工挖掘机
			if(catanum.indexOf("101001")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16348     " );
			}			
			//龙工旋挖钻
			if(catanum.indexOf("105003")!=-1){
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16347    " );
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
				agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16346     " );
			}
		}
		//雷沃做下判断
		if(brand_id.equals("141")){     
 
			   agentList = dbHelper.getMapList(" select id from pro_agent_factory  where id=16840       " );
 
 
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
		System.out.println("有代理商");
		for(Map mm : agentList){
		usern="";	person_id="0";	 
		List<Map> list = dbHelper.getMapList(" select city_num,id,usern from pro_agent_personnel  where agent_id = ? ",new Object [] {CommonString.getFormatPara(mm.get("id"))},connection);		
		//龙工的做下类别判断
		if(brand_id.equals("135")){
		    //龙工几款装载机
			
			if(jr_proid.equals("7592")||jr_proid.equals("7609")||jr_proid.equals("7608")||jr_proid.equals("7607")||jr_proid.equals("7592")||jr_proid.equals("21539")||jr_proid.equals("21541")||jr_proid.equals("15875")||jr_proid.equals("15874")||jr_proid.equals("15872")||jr_proid.equals("7588")||jr_proid.equals("7539")||jr_proid.equals("4397")||jr_proid.equals("7538")||jr_proid.equals("21540")||jr_proid.equals("7584")||jr_proid.equals("7586")||jr_proid.equals("7585")||jr_proid.equals("7587")||jr_proid.equals("7589")||jr_proid.equals("7590")||jr_proid.equals("768")||jr_proid.equals("763")||jr_proid.equals("766")){
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
			System.out.println("有业务员");
				for(Map m : list){		  
				   String nums=CommonString.getFormatPara(m.get("city_num"));
				   if(!nums.equals("")){
				      String  []citys=nums.split(",");
					  if(citys.length>0){
					        for(int i=0;i<citys.length;i++){
					              Map areaInfo = dbHelper.getMap(" select   area_name from comm_area   where area_id = ? ",new Object [] {citys[i]},connection);
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
			if(brand_id.equals("141")&&catanum.indexOf("101002")>=0&&(province.indexOf("天津")>=0||city.indexOf("廊坊")>=0||city.indexOf("保定")>=0||city.indexOf("沧州")>=0||city.indexOf("石家庄")>=0||city.indexOf("邢台")>=0||city.indexOf("邯郸")>=0||city.indexOf("衡水")>=0)){
				person_id="482";
				usern="houyg";
			}
			if(brand_id.equals("141")&&catanum.indexOf("101001")>=0&&province.indexOf("上海")>=0 ){
				person_id="506";
				usern="cheyj";
			}
			if( brand_id.equals("141")&&((catanum.indexOf("101002")>=0&&province.indexOf("上海")>=0) || province.indexOf("浙江")>=0) ){
				person_id="499";
				usern="wangfw";
			}
			if(brand_id.equals("141")&&((city.indexOf("济宁")>=0||city.indexOf("泰安")>=0||city.indexOf("聊城")>=0||city.indexOf("菏泽")>=0||city.indexOf("莱芜")>=0||city.indexOf("济南")>=0||city.indexOf("德州")>=0)||(city.indexOf("滨州")>=0&&catanum.indexOf("101002")>=0))){
				person_id="504";
				usern="liwb";
			}
			if(brand_id.equals("141")&&((city.indexOf("青岛")>=0||city.indexOf("日照")>=0||city.indexOf("潍坊")>=0||city.indexOf("烟台")>=0||city.indexOf("威海")>=0||city.indexOf("临沂")>=0||city.indexOf("东营")>=0||city.indexOf("枣庄")>=0||city.indexOf("淄博")>=0)||(city.indexOf("滨州")>=0&&catanum.indexOf("101001")>=0))){
			    person_id="503";
				usern="zhaonb";
			}
			
			if(brand_id.equals("141")&&((province.indexOf("北京")>=0)||(province.indexOf("天津")>=0&&catanum.indexOf("101001")>=0)||(city.indexOf("承德")>=0||city.indexOf("张家口")>=0||city.indexOf("唐山")>=0||city.indexOf("秦皇岛")>=0)||(city.indexOf("廊坊")>=0&&catanum.indexOf("101001")>=0)||(city.indexOf("保定")>=0&&catanum.indexOf("101001")>=0))){
			    person_id="501";
				usern="chengh";
			}
			
			
			if(!person_id.equals("0")){
				
				
 

            //把订单推给合作的代理商订单中 ifgroup,buy_time
			String sqlString = "insert into pro_agent_products_form(";
			sqlString += "add_ip,add_date,uuid,factory_id,factory_name,agent_id,agent_name,cata_num,cata_name,product_id,product_name,contact_address,contact_tel,province,city,state,form_date,message,company_name,user_name,push_order,source_id,call_result1,buy_type,order_state,person_id";
			sqlString += ") select add_ip,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+CommonString.getUUID()+"',"+factory_id+",'',"+CommonString.getFormatPara(mm.get("id"))+",agentname,catanum,cataname,product_id,product_name,contact_address,mobile_phone,province,city,state,'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',message,company,name,"+1+",id,call_result1,buy_type,'102001',"+person_id;
			sqlString += " from pro_product_form WHERE id = "+id;
			System.out.println(sqlString);
			dbHelper.execute(sqlString,connection);
			 
			
			
			}
			
	
			
			
			}}

			
		}
		
		
		
		
		//厂家查看app订单状态
		if(flag.equals("appOrderStateF")){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
			String contact_tel = CommonString.getFormatPara(request.getParameter("contact_tel"));
			String state = (String)dbHelper.getOne(" select top 1 order_state  from  pro_agent_products_form    where person_id!=''  and person_id is not null and person_id!=0  and  factory_id = "+factoryid+" and contact_tel='"+contact_tel+"' " ,connection);
            if(state!=null&&!state.equals("")){
						if(state.equals("102001")){
							rs="未接收";
						}else if(state.equals("102002")){
					        rs="已接收";
						}else if(state.equals("102009")){
					        rs="流失";
						}else if(state.equals("102003")){
					        rs="初次见面";
						}else if(state.equals("102004")){
					        rs="确认意向";
						}else if(state.equals("102005")){
					        rs="明确购机需求";
						}else if(state.equals("102006")){
					        rs="形成共识，交付押金";
						}else if(state.equals("102007")){
					        rs="签订购机合同";
						}else if(state.equals("102008")){
					        rs="成交";
						}
			}else{
				rs="-";
			}

		}
		
		
		//代理商查看app订单状态
		if(flag.equals("appOrderStateA")){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String state = (String)dbHelper.getOne(" select top 1 order_state  from  pro_agent_products_form    where person_id!=''  and person_id is not null and person_id!=0  and  id = "+id+" " ,connection);
            if(state!=null&&!state.equals("")){
						if(state.equals("102001")){
							rs="未接收";
						}else if(state.equals("102002")){
					        rs="已接收";
						}else if(state.equals("102009")){
					        rs="流失";
						}else if(state.equals("102003")){
					        rs="初次见面";
						}else if(state.equals("102004")){
					        rs="确认意向";
						}else if(state.equals("102005")){
					        rs="明确购机需求";
						}else if(state.equals("102006")){
					        rs="形成共识，交付押金";
						}else if(state.equals("102007")){
					        rs="签订购机合同";
						}else if(state.equals("102008")){
					        rs="成交";
						}else if(state.equals("102010")){
					        rs="沟通中";
						}
			}else{
				rs="-";
			}

		}

		if("koubei_count".equals(flag)){
			String productid = CommonString.getFormatPara(request.getParameter("productid"));
			String sql = " select count(id) as sums from pro_comments  where is_show=1 and   product_id ="+productid;
	        Map commentMap = dbHelper.getMap(sql);
			if(commentMap!=null){
				rs=CommonString.getFormatPara(commentMap.get("sums"));
			}else{
				 rs="0";
			}

		}
		
		//产品复制
		if("copyProduct".equals(flag)){
			String productid = CommonString.getFormatPara(request.getParameter("productid"));
			String add_user="";
			 if(null!=adminInfo){
					add_user=(String)(adminInfo.get("usern"));
				}else{
					add_user=("none");
		    }
			String sqlString = "INSERT INTO pro_products(";
			sqlString += "[file_name],[add_user],[add_date],[add_ip],[uuid] ,[factoryid],[factoryname] ,[catalogid] ,[catalognum] ,[catalogname] ,[name] ,[price_start],[price_end],[place] ,[para1],[para_value1] ,[para2],[para_value2] ,[para3] ,[para_value3] ,[para4],[para_value4] ,[img1] ,[img2] ,[img3],[introduce],[summary],[view_count],[is_show] ,[page_hot_flag],[page_recom_flag] ,[positionflag] ,[index_hot_flag],[index_pic],[index_price],[lastvisitedate],[order_no] ,[tonandmeter] ,[paras],[catalognum_spe],[catalogname_spe],[factoryid_sub],[factoryname_sub],[zoomlion_hot],[last_modify_date],[is_rec] ,[md5password],[zoomlion_hot_pic],[order_no_all],[referer],[param],[manual],[catalognum_spe_second],[web_title],[catalognum_new],[order_num],[year]";
			sqlString += ") select '','"+add_user+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',[add_ip],'"+CommonString.getUUID()+"' ,[factoryid],[factoryname] ,[catalogid] ,[catalognum] ,[catalogname] ,[name] ,[price_start],[price_end],[place] ,[para1],[para_value1] ,[para2],[para_value2] ,[para3] ,[para_value3] ,[para4],[para_value4] ,[img1] ,[img2] ,[img3],[introduce],[summary] ,"+0+",[is_show] ,[page_hot_flag],[page_recom_flag] ,[positionflag] ,[index_hot_flag],[index_pic],[index_price],[lastvisitedate],[order_no] ,[tonandmeter] ,[paras],[catalognum_spe],[catalogname_spe],[factoryid_sub],[factoryname_sub],[zoomlion_hot],[last_modify_date],[is_rec] ,[md5password],[zoomlion_hot_pic],[order_no_all],[referer],[param],[manual],[catalognum_spe_second],[web_title],[catalognum_new],[order_num],[year]";
			sqlString += " from pro_products  WHERE id = "+productid;
			System.out.println(sqlString);
			dbHelper.execute(sqlString,connection);

		}
		
		
		

		if("category_name".equals(flag)){
			String category_id = CommonString.getFormatPara(request.getParameter("category_id"));
			String category_name = (String)dbHelper.getOne(" select  name   from  pro_category    where id = "+category_id ,connection);
            if(category_name==null||category_name.equals("")){
			   category_name="无";
			}
            rs=category_name;
		}
		
		if("categoryCount".equals(flag)){
			String no = CommonString.getFormatPara(request.getParameter("no"));
			String sql = " select count(id) as sums from pro_category   where parent_no ='"+no+"'";
	        Map commentMap = dbHelper.getMap(sql);
			if(commentMap!=null){
				rs=CommonString.getFormatPara(commentMap.get("sums"));
			}else{
				 rs="0";
			}

		}
		
		if("checkFileName".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String file_name = CommonString.getFormatPara(request.getParameter("file_name"));
			String sql = " select top 1 id from pro_products where file_name='"+file_name+"' ";
			if(!id.equals("")){
				sql = " select top 1 id from pro_products where file_name='"+file_name+"'  and id !="+id;
			}
	        Map commentMap = dbHelper.getMap(sql);
			if(commentMap==null){
				rs="success";
			}
		}
		
		if("checkRepeat".equals(flag)){
			String mobile_phone = CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String sql = " select id  from pro_product_form where mobile_phone='"+mobile_phone+"' and factoryid=139 and  is_success=1";
	
	        Map commentMap = dbHelper.getMap(sql);
			if(commentMap==null){
				rs="norepeat";
			}
		}
		
		if("checkRepeatSany".equals(flag)){
			String mobile_phone = CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String sql = " select id  from pro_product_form where mobile_phone='"+mobile_phone+"' and factoryid=133 and  is_success=1";
	
	        Map commentMap = dbHelper.getMap(sql);
			if(commentMap==null){
				rs="norepeat";
			}
		}
		
		//将农机产品询价状态改为已删除
		if(flag.equals("updateMachineProductLogicalDel")){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			rs = String.valueOf(dbHelper.execute("update pro_machine_products_inquiry set is_del=1 where uuid in (" + ids + ")", connection));
		}
		
		
		//获取改品牌下产品
		if(flag.equals("getProWjj")){
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
		    String  sql="select id,name from pro_products where catalognum in('101001001','101001004','101001007') and  is_show=1 and  factoryid="+brandId+" order by name desc ";
         	List<Map> proList =(ArrayList) dbHelper.getMapList(sql , connection);
			String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(proList != null){
			    for(Map m : proList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
			}
		   
		}
		
		//获取改品牌下产品
		if(flag.equals("getProZzj")){
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
		    String  sql="select id,name from pro_products where catalognum like '%101002%' and  is_show=1 and  factoryid="+brandId+" order by name desc ";
         	List<Map> proList =(ArrayList) dbHelper.getMapList(sql , connection);
			String options="<option value=''>-请选择-</option>";
			rs="<option value=''>-请选择-</option>";
			if(proList != null){
			    for(Map m : proList){
				     options= "<option value='"+m.get("id")+"'  >"+m.get("name")+"</option> ";
					 rs+=options;
				}
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