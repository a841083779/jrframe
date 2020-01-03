<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String sql = "";
	String ip  = request.getHeader("x-forwarded-for");
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("X-Real-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	try{
		connection = dbHelper.getConnection();
		//代理商列表
		if("agentList".equals(flag)){
			Integer nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
			Integer cityCount = 0;
			Integer provinceCount = 0;
			Integer pageSize = CommonString.getFormatInt(request.getParameter("pageSize"));
			if(pageSize.equals(0)){
				pageSize = 10;
			}
			String brand = CommonString.getFormatPara(request.getParameter("brand"));
			String model = CommonString.getFormatPara(request.getParameter("model"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			String isAuto = CommonString.getFormatPara(request.getParameter("isAuto"));
			String orderProvince = CommonString.getFormatPara(request.getParameter("orderProvince"));
			String orderCity = CommonString.getFormatPara(request.getParameter("orderCity"));
			
			String fp = "0";
			if(province.equals("")){
				fp = "1";
				String objStr = Tools.getMyProvinceAndCity(ip);
				JSONObject obj = new JSONObject(objStr);
				if(null!=obj&&obj.length()>0){
					province = CommonString.getFormatPara(obj.getString("province"));
					//city = CommonString.getFormatPara(obj.getString("city"));
				}
			}
			// 统计用户浏览代理商查询条件
			Map agentViewHabitMap = new HashMap() ;
			agentViewHabitMap.put("flag","customer_agent_view_habit") ; // 品牌
			agentViewHabitMap.put("factoryid",brand) ; // 品牌
			agentViewHabitMap.put("province",province) ; //省份
			agentViewHabitMap.put("city",city) ; //城市
			agentViewHabitMap.put("catalogid",model) ; //类别
			agentViewHabitMap.put("now_page",nowPage) ; //当前页
			Common.doPostHttpAsync("http://product.21-sun.com/tools/ajax.jsp",agentViewHabitMap) ;
			if(nowPage <= 0){ 
				nowPage = 1;
			}
			String cacheKey = flag+nowPage+province+city+isAuto+brand+model+pageSize+"odps"+orderProvince+"odcs"+orderCity;
			%>
			<cache:cache  cron="*/1 * * * *"><%
			String whereStr = " and flag = 2 and is_show = 1 ";
			//如果是自动调取，做等级判断
			/*
			if("".equals(isAuto) ){
				if(!"".equals(city)){
					//判断匹配的城市代理商是否够
					cityCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory where 1=1 "+whereStr+" and city like '%"+city+"%' ",connection);
					if(cityCount>0){
						if(!"".equals(city)){
							if(city.indexOf(" ")!=-1){
								city = city.split(" ")[1];
							}
							whereStr += " and city like '%"+city+"%' ";
						}
					}else{
						//判断匹配的省份代理商是否够
						provinceCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory  where 1=1 "+whereStr+" and city like '%"+province+"%' ",connection);
						if(provinceCount>0){
							if(!"".equals(province)){
								if(province.indexOf(" ")!=-1){
									province = province.split(" ")[1];
								}
								whereStr  += " and ( city like '%"+province+"%') ";
							}
						}
					}
				}else{
					//判断匹配的省份代理商是否够
					provinceCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory  where 1=1 "+whereStr+" and city like '%"+province+"%' ",connection);
					if(provinceCount>0){
						if(!"".equals(province)){
							if(province.indexOf(" ")!=-1){
								province = province.split(" ")[1];
							}
							whereStr  += " and ( city like '%"+province+"%') ";
						}
					}
				}
			}else{
				
				if(!"".equals(province)){
					if(province.indexOf(" ")!=-1){
						province = province.split(" ")[1];
					}
					if(!"".equals(city)){
						if(city.indexOf(" ")!=-1){
							city = city.split(" ")[1];
						}
						whereStr += " and ( ( city like '%"+province+"%' ) ";
						whereStr += " or city like '%"+city+"%' ) ";
					}else{
						provinceCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory  where 1=1 and ( agent_fac LIKE '%"+brand+",%' OR agent_fac LIKE '%,"+brand+"%' or agent_fac = '"+brand+"' ) "+whereStr+" and ( city like '%"+province+"%' or city = '"+province+"' ) ",connection);
						if(provinceCount>0 || fp.equals("0")){
							whereStr += " and ( city like '%"+province+"%' or city = '"+province+"' )";
						}
						Common.println(whereStr+provinceCount);
					}
				}
			}
			*/
			//如果有品牌，首先查询出该品牌的全部代理商
			if(!"".equals(brand)){
			 	whereStr += " and ( agent_fac LIKE '%"+brand+",%' OR agent_fac LIKE '%,"+brand+"%' or agent_fac = '"+brand+"' ) ";
			}
			if(brand.equals("154")){
				whereStr += " and ( full_name like '%分公司%' ) ";
			}
			/*
			//如果有代理类型
			if(!"".equals(model)){
				whereStr += " and id in ( ";
				whereStr += " select distinct agent_id from pro_agent_products ";
				whereStr += " where product_id in ( select id from pro_products where catalognum like '"+model+"%' and is_show = 1 ) ";
				whereStr += " ) ";   
			}
			*/
			String orderByStr = " ";
			orderByStr += " is_shop desc,flag ASC , name DESC , id DESC " ;
			
			PageBean pageBean = new PageBean();
			pageBean.setTableName("pro_agent_factory");  
			pageBean.setFields("id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made");
			pageBean.setCondition(whereStr);
			pageBean.setIsShowSql(true);
			pageBean.setOrderBy(orderByStr);
			pageBean.setNowPage(nowPage);
			pageBean.setPageSize(pageSize);
			List<Map> agents = pageBean.getDatas(connection);
			JSONArray arrays = new JSONArray(agents);
			JSONObject obj = new JSONObject();
			obj.put("list",arrays);
			obj.put("total",pageBean.getTotal());
			obj.put("nowPage",nowPage);
			obj.put("pageSize",pageBean.getPageSize());
			obj.put("pageCount",pageBean.getPageCount());
			out.print(obj.toString());
			%></cache:cache><%
		}
		
		//代理商列表新
		if("agentListNew".equals(flag)){
			Integer nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
			Integer cityCount = 0;
			Integer provinceCount = 0;
			Integer pageSize = CommonString.getFormatInt(request.getParameter("pageSize"));
			if(pageSize.equals(0)){
				pageSize = 10;
			}

			//获取搜素条件
			String province = CommonString.getFormatPara(request.getParameter("province"));   //省份
			String city = CommonString.getFormatPara(request.getParameter("city"));           //城市
			String brand = CommonString.getFormatPara(request.getParameter("brand"));           //品牌
			String model = CommonString.getFormatPara(request.getParameter("model"));          //类别
			String brandId= CommonString.getFormatPara(request.getParameter("brandId"));      
			String cataNo= CommonString.getFormatPara(request.getParameter("cataNo"));       
		
			String isAuto = CommonString.getFormatPara(request.getParameter("isAuto"));
			String orderProvince = CommonString.getFormatPara(request.getParameter("orderProvince"));
			String orderCity = CommonString.getFormatPara(request.getParameter("orderCity"));
			
			String fp = "0";
			if(province.equals("")){
				fp = "1";
				//zfc
				//String objStr = Tools.getMyProvinceAndCity(ip);
				String objStr="{}";
				JSONObject obj = new JSONObject(objStr);
				if(null!=obj&&obj.length()>0){
					province = CommonString.getFormatPara(obj.getString("province"));
					city = CommonString.getFormatPara(obj.getString("city"));
				}
			}
			// 统计用户浏览代理商查询条件
			Map agentViewHabitMap = new HashMap() ;
			agentViewHabitMap.put("flag","customer_agent_view_habit") ; // 品牌
			agentViewHabitMap.put("factoryid",brand) ; // 品牌
			agentViewHabitMap.put("province",province) ; //省份
			agentViewHabitMap.put("city",city) ; //城市
			agentViewHabitMap.put("catalogid",model) ; //类别
			agentViewHabitMap.put("now_page",nowPage) ; //当前页
			Common.doPostHttpAsync("http://product.21-sun.com/tools/ajax.jsp",agentViewHabitMap) ;
			if(nowPage <= 0){ 
				nowPage = 1;
			}
			String cacheKey = flag+nowPage+province+city+isAuto+brand+model+pageSize+"odps"+orderProvince+"odcs"+orderCity;
			%><cache:cache key="<%=cacheKey %>" cron="*/1 * * * *"><%
			String whereStr = " and flag = 2 and is_show = 1 ";
			//如果是自动调取，做等级判断
			if("".equals(isAuto) ){
				if(!"".equals(city)){
					//判断匹配的城市代理商是否够
					cityCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory where 1=1 "+whereStr+" and city like '%"+city+"%' ",connection);
					if(cityCount>0){
						if(!"".equals(city)){
							if(city.indexOf(" ")!=-1){
								city = city.split(" ")[1];
							}
							whereStr += " and city like '%"+city+"%' ";
						}
					}else{
						//判断匹配的省份代理商是否够
						provinceCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory  where 1=1 "+whereStr+" and city like '%"+province+"%' ",connection);
						if(provinceCount>0){
							if(!"".equals(province)){
								if(province.indexOf(" ")!=-1){
									province = province.split(" ")[1];
								}
								whereStr  += " and ( city like '%,"+province+"%' or city like '%"+province+",%' or city = '"+province+"' ) ";
							}
						}
					}
				}else{
					//判断匹配的省份代理商是否够
					provinceCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory  where 1=1 "+whereStr+" and city like '%"+province+"%' ",connection);
					if(provinceCount>0){
						if(!"".equals(province)){
							if(province.indexOf(" ")!=-1){
								province = province.split(" ")[1];
							}
							whereStr  += " and ( city like '%,"+province+"%' or city like '%"+province+",%' or city = '"+province+"' ) ";
						}
					}
				}
			}else{
				
				if(!"".equals(province)){
					if(province.indexOf(" ")!=-1){
						province = province.split(" ")[1];
					}
					if(!"".equals(city)){
						if(city.indexOf(" ")!=-1){
							city = city.split(" ")[1];
						}
						whereStr += " and ( ( city like '%,"+province+"%' or city like '%"+province+",%' or city = '"+province+"' ) ";
						whereStr += " or city like '%"+city+"%' ) ";
					}else{
						provinceCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory  where 1=1 and ( agent_fac LIKE '%"+brand+",%' OR agent_fac LIKE '%,"+brand+"%' or agent_fac = '"+brand+"' ) "+whereStr+" and ( city like '%"+province+"%' or city = '"+province+"' ) ",connection);
						if(provinceCount>0 || fp.equals("0")){
							whereStr += " and ( city like '%"+province+"%' or city = '"+province+"' )";
						}
						Common.println(whereStr+provinceCount);
					}
				}
			}
			//如果有品牌，首先查询出该品牌的全部代理商
			if(!"".equals(brand)){
			 	whereStr += " and ( agent_fac LIKE '%"+brand+",%' OR agent_fac LIKE '%,"+brand+"%' or agent_fac = '"+brand+"' ) ";
			//	whereStr += " and agent_fac in  ( '"+brand+"' ) ";
			}
			//如果有代理类型
			if(!"".equals(model)){
				whereStr += " and id in ( ";
				whereStr += " select distinct agent_id from pro_agent_products ";
				whereStr += " where product_id in ( select id from pro_products where catalognum like '"+model+"%' and is_show = 1 ) ";
				whereStr += " ) ";   
			}
			//城市
		
			if(!"".equals(city)){
			    city=city.replace("市","");
				whereStr += " and (address like '%"+city+"%' or full_name like '%"+city+"%')";  
			}
			String orderByStr = " ";
			if(!"".equals(orderProvince)&&!"".equals(orderCity)){ 
				orderByStr += " CASE WHEN city LIKE '%"+orderCity+"%' THEN 2 ELSE 0 END DESC  , ";
				orderByStr += " CASE WHEN city LIKE '%"+orderProvince+"%' THEN 1 ELSE 0 END DESC , ";
				orderByStr += "  flag ASC , name DESC , id DESC ";
			}else if(!"".equals(orderProvince)){
				orderByStr += " CASE WHEN city LIKE '%"+orderProvince+"%' THEN 1 ELSE 0 END DESC ,  ";
				orderByStr += "  flag ASC , name DESC , id DESC ";
			}else{ 
				orderByStr += " flag ASC , name DESC , id DESC ";
			}
			orderByStr += ", is_shop desc " ;
			PageBean pageBean = new PageBean();
			pageBean.setTableName("pro_agent_factory");  
			pageBean.setFields("id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made");
			pageBean.setCondition(whereStr);
			pageBean.setIsShowSql(true);
			pageBean.setOrderBy(orderByStr);
			pageBean.setNowPage(nowPage);
			pageBean.setPageSize(pageSize);
			List<Map> agents = pageBean.getDatas(connection);
			JSONArray arrays = new JSONArray(agents);
			JSONObject obj = new JSONObject();
			obj.put("list",arrays);
			obj.put("total",pageBean.getTotal());
			obj.put("nowPage",nowPage);
			obj.put("pageSize",pageBean.getPageSize());
			obj.put("pageCount",pageBean.getPageCount());
			out.print(obj.toString());
			%></cache:cache><%
		}
		
		if("seePhone".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			sql = " select * from pro_agent_factory where id = ? ";
			//查询代理商信息
			Map agentMap  = dbHelper.getMap(sql,new Object [] {id},connection);
			sql = " insert into pro_product_form ( province , city , uuid , add_ip , add_user , add_date , name , mobile_phone , contact_address , agentid , agentname , message , ifgroup , buy_time , factoryid , factoryname , catanum , cataname ) ";
			sql += " values ( ? , ? ,? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
			//插入询价记录
			//dbHelper.execute(sql,new Object [] {
				//CommonString.getFormatPara(request.getParameter("province")),
				//CommonString.getFormatPara(request.getParameter("city")),
				//CommonString.getUUID(),
				//ip,"front",CommonDate.getToday("yyyy-MM-dd"),
				//CommonString.getFormatPara(request.getParameter("name")),
				//CommonString.getFormatPara(request.getParameter("mobile_phone")),
				//CommonString.getFormatPara(request.getParameter("province"))+CommonString.getFormatPara(request.getParameter("city")),
				//id,CommonString.getFormatPara(agentMap.get("full_name")),
				//"您好，我对"+CommonString.getFormatPara(agentMap.get("full_name"))+"的产品感兴趣，想要咨询，请您给我回复，谢谢。",
				//"个人","102006",CommonString.getFormatPara(request.getParameter("brand")),
				//CommonString.getFormatPara(request.getParameter("brandName")),
				//CommonString.getFormatPara(request.getParameter("catalog")),
				//CommonString.getFormatPara(request.getParameter("catalogName"))
			//},connection);
			// 更新 pro_agent_phone_view 表中数据 
			String sql2 = " insert into pro_agent_phone_view(add_user,add_date,add_ip,uuid,agent_id,order_area,order_phone,intention_brand,intention_catalog,view_date) values(?,?,?,?,?,?,?,?,?,?)" ;
				dbHelper.execute(sql2,new Object [] {
				CommonString.getFormatPara(request.getParameter("name")),
				CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
				ip,
				UUID.randomUUID().toString(),
				CommonString.getFormatPara(agentMap.get("id")),
				CommonString.getFormatPara(request.getParameter("province"))+CommonString.getFormatPara(request.getParameter("city")),
				CommonString.getFormatPara(request.getParameter("mobile_phone")),
				CommonString.getFormatPara(request.getParameter("brand")),
				CommonString.getFormatPara(request.getParameter("catalogName")),
				CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
			},connection);
			out.print(CommonString.getFormatPara(agentMap.get("telphone")));
		}
		if("agentProList".equals(flag)){
			String cacheKey = "";
			String myPros = CommonString.getFormatPara(request.getParameter("myPros"));
			String factoryid  = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			String catalognum = CommonString.getFormatPara(request.getParameter("catalog")) ;
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			cacheKey = flag+"_"+myPros+"_"+factoryid+"_"+catalognum+"_"+province+"_"+city;
			%><cache:cache key="<%=cacheKey %>" cron="* */10 * * *"><%
			String url = "";
			String [] proArr = myPros.split(",");
			StringBuffer html = new StringBuffer();
			Integer count = 0;
			String likeProvicne = "";
			for(int i=0;i<proArr.length;i++){
				likeProvicne = proArr[i];
				if(!"".equals(likeProvicne)&&likeProvicne.indexOf(" ")!=-1){
					likeProvicne = likeProvicne.split(" ")[1];
				}
				sql = " select count(id) from pro_agent_factory where flag = 2 and is_show = 1 and ( city like '%"+likeProvicne+"%' or city = '"+likeProvicne+"' ) ";
				if(!"".equals(factoryid)){
					sql += " and id in ( select agent_id from pro_agent_products where factory_id = '"+factoryid+"' )";
				}
				if(!"".equals(catalognum)){
					sql += " select distinct pro_agent_products.agent_id ";
					sql += " from pro_agent_products , pro_products ";
					sql += " where pro_agent_products.product_id = pro_products.id ";
					sql += " and pro_products.catalognum = '"+catalognum+"' ";
				}
				count = (Integer)dbHelper.getOne(sql,connection);
				
				url = "";
				 if(!"".equals(factoryid)){
		        	  url += "&factoryid="+factoryid;
		          }
				 if(!"".equals(url)){
					 url = url.substring(1);
					 url = "/agent/list.jsp?"+url;
					 url += "&province="+proArr[i];
				 }else{
					 url = "/agent/list.jsp?province="+proArr[i];
				 }
				 if(!"".equals(catalognum)){
		        	  url += "&catalogid="+catalognum;
		          }
				html.append("<a href='"+url+"' title='"+proArr[i]+"'><span>"+proArr[i]+"</span><em>("+count+")</em></a>");
			}
			out.print(html.toString());
			%></cache:cache><%
		}
		if("agentCitList".equals(flag)){
			String factoryid  = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			String catalognum = CommonString.getFormatPara(request.getParameter("catalog")) ;
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			String cacheKey = flag+"_"+factoryid+"_"+catalognum+"_"+province+"_"+city;
			%><cache:cache key="<%=cacheKey %>" cron="* */10 * * *"><%
			String myCits = CommonString.getFormatPara(request.getParameter("myCits"));
			String [] citArr = myCits.split(",");
			StringBuffer html = new StringBuffer();
			Integer count = 0;
			String likeProvince = province;
			if(!"".equals(likeProvince)&&likeProvince.indexOf(" ")!=-1){
				likeProvince = likeProvince.split(" ")[1];
			}
			String likeCity = "";
			String url = "";
			for(int i=0;i<citArr.length;i++){
				sql = " select count(id) from pro_agent_factory where flag = 2 and is_show = 1 and ( ( city like '%,"+likeProvince+"%' or city like '%"+likeProvince+",%' or city = '"+likeProvince+"' ) ";
				likeCity = citArr[i];
				if(!"".equals(likeCity)&&likeCity.indexOf(" ")!=-1){
					likeCity = likeCity.split(" ")[1];
				}
				sql += " or city like '%"+likeCity+"%' ) ";
				if(!"".equals(factoryid)){
					sql += " and id in ( select agent_id from pro_agent_products where factory_id = '"+factoryid+"' )";
				}
				if(!"".equals(catalognum)){
					sql += " select distinct pro_agent_products.agent_id ";
					sql += " from pro_agent_products , pro_products ";
					sql += " where pro_agent_products.product_id = pro_products.id ";
					sql += " and pro_products.catalognum = '"+catalognum+"' ";
				}
				count = (Integer)dbHelper.getOne(sql,connection);
				url = "";
				 if(!"".equals(factoryid)){
		        	  url += "?factoryid="+factoryid;
		          }
				 if(!"".equals(url)){
					 url = "/agent/list.jsp" + url + "&city="+citArr[i];
				 }else{
					 url += "/agent/list.jsp?city="+citArr[i];
				 }
				 url += "&province="+province;
				 
				 if(!"".equals(catalognum)){
		        	  url += "&catalogid="+catalognum;
		          }
				html.append("<a href='"+url+"' title='"+citArr[i]+"'><span>"+citArr[i]+"</span><em>("+(count)+")</em></a>");
			}
			out.print(html.toString());
			%></cache:cache><%
		}
		if("getCatalogList".equals(flag)){
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
			String cacheKey = "getCatalogList"+brandId;
			%><cache:cache key="<%=cacheKey %>" cron="* */10 * * *"><%
			sql = " select catalognum from pro_products  ";
			sql += " where factoryid = '"+brandId+"' and catalognum is not null and catalognum <> '' ";
			sql += " group by catalognum ";
			List<Map> catalogs = dbHelper.getMapList(sql,connection);
			String catalognumStr = "";
			for(Map m : catalogs){
				catalognumStr += "'"+m.get("catalognum")+"',";
			}
			if(!"".equals(catalognumStr)&&catalognumStr.indexOf(",")!=-1){
				catalognumStr = catalognumStr.substring(0,catalognumStr.length()-1);
			}
			if(!"".equals(catalognumStr)){
				sql = " select num as id,name from pro_catalog where num in ("+catalognumStr+") ";
				catalogs = dbHelper.getMapList(sql,connection);
				String name = "";
				String pinyin = "";
				for(Map m : catalogs){
					name = CommonString.getFormatPara(m.get("name"));
					pinyin = CnToFullSpell.getFirstSpell(name).substring(0,1);
					m.put("pinyin",pinyin);
					m.put("name",pinyin+ " " + name);
				}
				Collections.sort(catalogs,new java.util.Comparator(){
					public int compare(Object o1, Object o2) {
						Map m1 = (Map)o1;
						Map m2 = (Map)o2;
						return m1.get("pinyin").toString().compareTo(m2.get("pinyin").toString());
					}
				});
				out.print(new JSONArray(catalogs));
			}else{
				out.print("[]");	
			}
			%></cache:cache><%
		}
		if("viewPhoneClickCount".equals(flag)){
			int id = CommonString.getFormatInt(request.getParameter("id"));
			dbHelper.execute(" update pro_agent_factory set view_phone_click_count = isnull(view_phone_click_count,0) + 1 where id = '"+id+"' ",connection);
		}
		//客户产品条件浏览记录
		if("customer_product_view_habit".equals(flag)){
			String factory = CommonString.getFormatPara(request.getParameter("factory"));
			int catalog = CommonString.getFormatInt(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			int offset = CommonString.getFormatInt(request.getParameter("offset"));
			sql = " select count(*) from pro_customer_product_view_habit where 1=1 ";
			String whereStr = " and factory = '"+factory+"' and catalog = '"+catalog+"' and tonandmeter = '"+tonandmeter+"' and offset = '"+offset+"' ";
			sql += whereStr;
			Integer counts = (Integer)dbHelper.getOne(sql,connection);
			if(counts>0){
				sql = " update pro_customer_product_view_habit set counts = counts + 1 where 1=1 "+whereStr;
				dbHelper.execute(sql,connection);
			}else{
				sql = " insert into pro_customer_product_view_habit ( factory , catalog , tonandmeter , offset , counts ) ";
				sql += " values ( ? , ? , ? , ? , ? ) ";
				dbHelper.execute(sql,new Object [] {
						factory,catalog,tonandmeter,offset,1
				},connection);
			}
		}
		if("customer_agent_view_habit".equals(flag)){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			String province = CommonString.getFormatPara(request.getParameter("province")).replaceAll("\\?","") ;
			String city = CommonString.getFormatPara(request.getParameter("city")).replaceAll("\\?","") ;
			String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;
			String now_page = CommonString.getFormatPara(request.getParameter("now_page")) ;
			String whereStr = " where factoryid=? and province=? and city=? and catalogid=? and now_page=?";
			String sel_sql = " select count(*) total from pro_customer_agent_view_habit" ;
			String ins_sql = " insert into pro_customer_agent_view_habit(factoryid,province,city,catalogid,now_page) values(?,?,?,?,?)"; 
			String upt_sql = " update pro_customer_agent_view_habit set counts = isnull(counts,0)+1 " ;
			Object[] objs = new Object[]{factoryid,province,city,catalogid,now_page} ;
			Integer total = Integer.parseInt(dbHelper.getOne(sel_sql+whereStr,objs).toString()) ;
			if(total>0){ // 此条件已被查询
				dbHelper.execute(upt_sql+whereStr,objs,connection) ;
			}else{
				dbHelper.execute(ins_sql,objs,connection) ;
			}
		}
		
		if("pro_customer_brand_view_countMap".equals(flag)){
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			String today = CommonDate.getToday("yyyy-MM-dd") ;
			String year = CommonDate.getToday("yyyy") ;
			String month = CommonDate.getToday("MM") ;
			String day = CommonDate.getToday("dd") ;
			String whereStr = " where 1=1 and year(statistics_date)=? and month(statistics_date)=? and day(statistics_date)=? and factory=?" ;
			String sel_sql = " select count(*) total from pro_customer_brand_view_count" ;
			String ins_sql = " insert into pro_customer_brand_view_count(statistics_date,factory,counts) values(?,?,?)" ;
			String upt_sql = " update pro_customer_brand_view_count set counts=isnull(counts,0)+1 " ;
			Object[] objs = new Object[]{year,month,day,factoryid} ;
			Object[] objs2 = new Object[]{today,factoryid,1} ;
			if(!"".equals(factoryid)){
				Integer total = Integer.parseInt(dbHelper.getOne(sel_sql+whereStr,objs).toString()) ;
				if(total>0){
					dbHelper.execute(upt_sql+whereStr,objs,connection) ;
				}else{
					dbHelper.execute(ins_sql,objs2,connection) ;
				}
			}
		}
		if("pro_agent_phone_view".equals(flag)){
			String province = CommonString.getFormatPara(request.getParameter("province")) ;
		}
		if("get_city".equals(flag)){
			String p = CommonString.getFormatPara(request.getParameter("p"));
			if("105499".equals(p)){ // 北京
				p = "105500" ;
			}
			if("105290".equals(p)){ // 北京 
				p = "105300" ;
			}
			if("105879".equals(p)){ // 重庆  
				p = "105880" ;
			}
			if("105689".equals(p)){ // 天津   
				p = "105690" ;
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {
					p
			},connection);
			out.print(new JSONArray(areas));
		}
		
		
	    if("getProByBrand".equals(flag)){
			String cacheKey = "";
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
			String cataNum  = CommonString.getFormatPara(request.getParameter("cataNum")) ;
			%><cache:cache  cron="* */10 * * *"><%
		    StringBuffer html = new StringBuffer();
			sql = "select name,id from pro_products where is_show=1 and factoryid="+brandId+"  and catalognum like '"+cataNum+"%'";
			List<Map> proList = dbHelper.getMapList(sql,connection);
            //html.append("<option>请选择型号</option>");
			if(proList != null && proList.size() > 0){
			html = new StringBuffer();
			for(Map m : proList){
				    html.append("<option value='"+CommonString.getFormatPara(m.get("id"))+"'>"+CommonString.getFormatPara(m.get("name"))+"</option>");
			}
			}else{
			html = new StringBuffer();
			html.append("<option>暂无该类别产品</option>");
			}
			out.print(html.toString());
			%></cache:cache><%
		}
		
		if("getProInfo".equals(flag)){
			String cacheKey = "";
			String proId = CommonString.getFormatPara(request.getParameter("proId"));
			%><cache:cache  cron="* */10 * * *"><%
		    StringBuffer html = new StringBuffer();
			sql = "select img2,factoryname,catalogname,name from pro_products where  id="+proId;
			Map proMap= dbHelper.getMap(sql);
			if(proMap!=null){
			        if(CommonString.getFormatPara(proMap.get("img2")).equals("")){
				    html.append("<img   src='http://product.21-sun.com/uploadfiles/no_big.gif' width='310' height='230' title='"+CommonString.getFormatPara(proMap.get("factoryname"))+CommonString.getFormatPara(proMap.get("name"))+CommonString.getFormatPara(proMap.get("catalogname"))+"'/>");
			        }else{
					html.append("<img src='http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(proMap.get("img2"))+"' width='310' height='230' title='"+CommonString.getFormatPara(proMap.get("factoryname"))+CommonString.getFormatPara(proMap.get("name"))+CommonString.getFormatPara(proMap.get("catalogname"))+"'/>");
					}
			}
			out.print(html.toString());
			%></cache:cache><%
		}
		
		if("get_city_new".equals(flag)){
			String p = CommonString.getFormatPara(request.getParameter("p"));
			if("105499".equals(p)){ // 北京
				//p = "105500" ;
			}
			if("105290".equals(p)){ // 北京 
				//p = "105300" ;
			}
			if("105879".equals(p)){ // 重庆  
				//p = "105880" ;
			}
			if("105689".equals(p)){ // 天津   
				//p = "105690" ;
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			StringBuffer html = new StringBuffer();
		   for(Map m : areas){
				    html.append("<a onclick='selectCity(this)' value='"+CommonString.getFormatPara(m.get("area_id"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</a>");
			}
			out.print(html.toString());
		}
		
		if("get_city_new_used".equals(flag)){
			String p = CommonString.getFormatPara(request.getParameter("p"));
			if("105499".equals(p)){ // 北京
				//p = "105500" ;
			}
			if("105290".equals(p)){ // 北京 
				//p = "105300" ;
			}
			if("105879".equals(p)){ // 重庆  
				//p = "105880" ;
			}
			if("105689".equals(p)){ // 天津   
				//p = "105690" ;
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			StringBuffer html = new StringBuffer();
		    for(Map m : areas){
				    html.append("<a  id='used_list_city' data-val='"+CommonString.getFormatPara(m.get("area_name"))+"' value='"+CommonString.getFormatPara(m.get("area_id"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</a>");
			}
			out.print(html.toString());
		}
		if("get_city_xg01".equals(flag)){
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String p="0";
            Map one_proform = dbHelper.getMap("  select  area_id  from comm_area where area_name  like '%" + province + "%' ");
			if(one_proform !=null ){
				p = CommonString.getFormatPara(one_proform.get("area_id"));
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			StringBuffer html = new StringBuffer();
		    for(Map m : areas){
				    html.append("<a style='height:30px;margin-left:15px;' onclick='selectCity01()' value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</a>");
			}
			out.print(html.toString());
		}
		
		if("get_city_xg02".equals(flag)){
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String p="0";
            Map one_proform = dbHelper.getMap("  select  area_id  from comm_area where area_name  like '%" + province + "%' ");
			if(one_proform !=null ){
				p = CommonString.getFormatPara(one_proform.get("area_id"));
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			StringBuffer html = new StringBuffer();
		    for(Map m : areas){
				    html.append("<a style='height:30px;margin-left:15px;' onclick='selectCity02(this)' value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</a>");
			}
			out.print(html.toString());
		}
		
		if("get_city_xg03".equals(flag)){
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String p="0";
            Map one_proform = dbHelper.getMap("  select  area_id  from comm_area where area_name  like '%" + province + "%' ");
			if(one_proform !=null ){
				p = CommonString.getFormatPara(one_proform.get("area_id"));
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			StringBuffer html = new StringBuffer();
		    for(Map m : areas){
				    html.append("<a style='height:30px;margin-left:15px;' onclick='selectCity03(this)' value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</a>");
			}
			out.print(html.toString());
		}
		
		//图库详细点击量+1
		if("photoViewCount".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id")) ;
	        String update="update pro_photo_group set view_count=view_count+1 where id="+id+"";
	        dbHelper.execute(update);
		}

		if("get_city_xg03".equals(flag)){
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String p="0";
            Map one_proform = dbHelper.getMap("  select  area_id  from comm_area where area_name  like '%" + province + "%' ");
			if(one_proform !=null ){
				p = CommonString.getFormatPara(one_proform.get("area_id"));
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			StringBuffer html = new StringBuffer();
		    for(Map m : areas){
				    html.append("<a style='height:30px;margin-left:15px;' onclick='selectCity03(this)' value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</a>");
			}
			out.print(html.toString());
		}
		
		if("detail_get_city".equals(flag)){
			String p = CommonString.getFormatPara(request.getParameter("p"));
			
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {
					p
			},connection);
			StringBuffer html = new StringBuffer("<option selected>--请选择--</option>");
		    for(Map m : areas){
					html.append("<option value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</option>");
            }
			out.print(html.toString());
		}
		
		if("rili_used".equals(flag)){
		    String uname = CommonString.getFormatPara(request.getParameter("uname"));
		    String model = CommonString.getFormatPara(request.getParameter("model"));
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			//WEBEmail.sendMail("contact_hcs_used@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com,wuws@21-sun.com","来自商贸网的二手车询价",uname+"询价"+model+",电话为："+phone);
			WEBEmail.sendMail("contact_hcs_used@hitachi-kenki.com,g.zhang.hc@hitachi-kenki.com,h.jin.sq@hitachi-kenki.com,wuws@21-sun.com,zengfc@21-sun.com","来自商贸网的二手车询价",province+city+"的"+uname+"询价"+model+",电话为："+phone);

		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>