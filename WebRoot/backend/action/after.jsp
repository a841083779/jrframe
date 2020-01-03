<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%
	String event = CommonString.getFormatPara(request.getParameter("eventAfter"));
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String [] eventArr = event.split(",");
	List<String> eventList =Arrays.asList(eventArr);
	DBHelper dbHelper = DBHelper.getInstance();
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Connection connection = null;
	Map model = null;
		Map keyParamMap = (Map) application.getAttribute("keyParamMap");
	Map paramListMap = (Map) application.getAttribute("paramListMap");
	Map salePolicyListMap = (Map) application.getAttribute("salePolicyListMap");
	List <Map>list = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		if(eventList.contains("createSubblock_lost")){
			String sql = CommonString.getFormatPara(request.getParameter("zd_data_sql"));
			String listName = CommonString.getFormatPara(request.getParameter("zd_list_name"));
			String tName = CommonString.getFormatPara(request.getParameter("zd_template_file_name"));
			String cName = CommonString.getFormatPara(request.getParameter("zd_create_file_name"));
			FreemarkerUtils fm = new FreemarkerUtils(application.getRealPath("/"));
			fm.toHtml(sql, listName, tName, application.getRealPath("/")+cName);
			fm = null;
		}

		//枚举更新Application
		if(eventList.contains("updateApplicationEnum")){
			CommonApplication.getEnumMap(application);
		}
		//栏目更新Application
		if(eventList.contains("updateApplicationChannel")){
			CommonApplication.getChannelMap(application);
		}
		//seo Application
		//产品类别更新Application
		if(eventList.contains("updateApplicationCatalog")){
			CommonApplication.getCatalogMap(application);
			CommonApplication.getSEOTitleKeyword(application);
		}
		//子块生成静态页
		if(eventList.contains("createSubblock_lost")){
			String sql = CommonString.getFormatPara(request.getParameter("zd_data_sql"));
			String listName = CommonString.getFormatPara(request.getParameter("zd_list_name"));
			String tName = CommonString.getFormatPara(request.getParameter("zd_template_file_name"));
			String cName = CommonString.getFormatPara(request.getParameter("zd_create_file_name"));
			FreemarkerUtils fm = new FreemarkerUtils(application.getRealPath("/"));
			fm.toHtml(sql, listName, tName, application.getRealPath("/")+cName);
			fm = null;
		}
		
		//生成产品的详细页
		if(eventList.contains("productsCreate")){
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			Map<String,String> postMap = new HashMap<String,String>();
			postMap.put("id",id);
			String upt_sql = "update pro_products  set old_last_modify_date=? where id=?" ;
		    dbHelper.execute(upt_sql,new Object[]{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),id}) ;
            String realPath = Common.getAbsolutePath(request) ;
            //提交id
			Common.doPostHttpAsync("http://spec.21-sun.com/tools/create_detail.jsp?id="+id,postMap);
			Common.doPostHttpAsync("http://m.product.21-sun.com/tools/create/create_mobile_detail.jsp?id="+id,postMap);
			
		
		}
	    
		
		
		//生成产品的详细页
		if(eventList.contains("productsCreateNew")){
            String sql="";
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			String upt_sql = "update pro_products  set new_last_modify_date=? where id=?" ;
		    dbHelper.execute(upt_sql,new Object[]{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),id}) ;
			Map<String,String> postMap = new HashMap<String,String>();
			postMap.put("id",id);
            String realPath = Common.getAbsolutePath(request) ;
			String tonand="";
			//本条产品信息
			model = dbHelper.getMap(" select *  from "+request.getParameter("tableName")+" where id = ? ",new Object [] {id},connection);
					Map root = new HashMap();
		Map root1 = new HashMap();
		List <Map>list1 = null;
		List <Map>list2 = null;
			String tonandmeter = CommonString.getFormatPara(model.get("tonandmeter"));
			float tonandNum=Float.parseFloat(tonandmeter);
			String is_show = CommonString.getFormatPara(model.get("is_show")) ;
			//处理类别
			String catalognum = (String)model.get("catalognum") ;
			String precatalogname = CommonString.getFormatPara(catalognum).length()>6?CommonString.getFormatPara(catalogMap.get(catalognum.substring(0,6))):CommonString.getFormatPara(catalogMap.get(catalognum)) ;
			String precatalognum="";
			String topcatalogname="";
			String topcatalognum="";
			if(catalognum.length()>6){precatalognum=catalognum.substring(0,6);}else{precatalognum=catalognum;}
			if(catalognum.length()>3){topcatalognum=catalognum.substring(0,3);topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}
			else{topcatalognum=catalognum; topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}	
            //优惠政策
			Map saleMap =(Map)salePolicyListMap.get(CommonString.getFormatPara(model.get("factoryid"))+"-"+catalognum);  
			if(saleMap==null){
				//saleMap = dbHelper.getMap(" select q1,q2,q3 from pro_sale_policy where factoryid = ?  and  catalognum  like '"+precatalognum+"%'",new Object [] {CommonString.getFormatPara(model.get("factoryid"))},connection);
			    //saleMap =(Map)salePolicyListMap.get(CommonString.getFormatPara(model.get("factoryid"))+"-"+precatalognum);  
			}
			if(saleMap==null){saleMap=new HashMap();}
			root.put("saleMap", saleMap); 
			//参数
			List <Map> categoryKeyList=(List<Map>)keyParamMap.get("keyParam"); //参数再分类别
			Map parmaMainMap = new HashMap();
            String paramIds="";
			String param=CommonString.getFormatPara(model.get("param")) ;
			List<Map> paramList=new  ArrayList<Map>();
			if(!param.equals("[]")&&!param.equals("")){
			JSONArray keyParaAry = new JSONArray(param); //关键参数列表
          		if(keyParaAry!=null && keyParaAry.length()>0){
					 String param_product_no="",param_id="",param_name="",param_type="",param_order_no="",param_enum_no="",param_value="";
					 int paramCount=1;
				    for(int j=0;j<keyParaAry.length();j++){
				        Map parmaMap = new HashMap();
          				JSONObject keyParaObj = keyParaAry.getJSONObject(j);
							 param_product_no = CommonString.getFormatPara(keyParaObj.get("product_no"));
							 parmaMap.put("param_product_no", param_product_no);
							 param_id = CommonString.getFormatPara(keyParaObj.get("no"));
							 if(param_id.equals("")){param_id="0";}
							    parmaMap.put("param_id", param_id);
							 param_name = CommonString.getFormatPara(keyParaObj.get("name"));
							    parmaMap.put("param_name", param_name);
							 param_type = CommonString.getFormatPara(keyParaObj.get("type"));
							    parmaMap.put("param_type", param_type);
							 param_order_no = CommonString.getFormatPara(keyParaObj.get("order_no"));
							    parmaMap.put("param_order_no", param_order_no);
							 param_enum_no = CommonString.getFormatPara(keyParaObj.get("enum_no"));
							    parmaMap.put("param_enum_no", param_enum_no);
							 param_value = CommonString.getFormatPara(keyParaObj.get("value"));
							    parmaMap.put("param_value", param_value);
							 if(paramCount<=6&&!param_value.equals("")){
								 if(null != categoryKeyList && categoryKeyList.size()>0){
									 for(Map oneMap:categoryKeyList){
										if(CommonString.getFormatPara(oneMap.get("id")).equals(param_id)){
								                parmaMainMap.put("p"+paramCount,param_name);
								                parmaMainMap.put("v"+paramCount,param_value);
								                paramCount++;
										 }
									 }
								 }
							 }
							 if(!param_value.equals("")&&paramIds.indexOf(param_id)<0){
								 
								 paramIds+=param_id+",";
							 }
						paramList.add(parmaMap);
						}
					}
			}
			paramIds=paramIds+"0"; 
			List <Map> categoryList=dbHelper.getMapList(" select id,name   from pro_category where parent_no="+catalognum+" and id in (select category_id from pro_catalog_param where id  in ("+paramIds+") group by  category_id)"); //参数再分类别
			if(null == categoryList || categoryList.size()<=0){
				if(catalognum.length()>=6){
				    categoryList=dbHelper.getMapList(" select id,name   from pro_category where parent_no="+catalognum.substring(0,6)+" and id in (select category_id from pro_catalog_param where id  in ("+paramIds+") group by  category_id)"); //参数再分类别
			    }
				 if(catalognum.indexOf("107")>=0){
					categoryList =  dbHelper.getMapList(" select id,name   from pro_category where parent_no='107' and id in (select category_id from pro_catalog_param where id  in ("+paramIds+") group by  category_id)"); //参数再分类别
				}
			}
			
			
			List <Map> categoryLists=dbHelper.getMapList(" select id,name   from pro_category where parent_no="+catalognum+" "); //参数再分类别
			if(null == categoryLists || categoryLists.size()<=0){
				if(catalognum.length()>=6){
				    categoryLists=dbHelper.getMapList(" select id,name   from pro_category where parent_no="+catalognum.substring(0,6)+"  "); //参数再分类别
			    }
				 if(catalognum.indexOf("107")>=0){
					categoryLists =  dbHelper.getMapList(" select id,name   from pro_category where parent_no='107' "); //参数再分类别
				}
			}
			
			
			List<Map> proList=dbHelper.getMapList(" select * from pro_products where is_show=1 and id!="+CommonString.getFormatPara(model.get("id"))+" and  factoryid="+CommonString.getFormatPara(model.get("factoryid"))+"  and catalognum like '%"+CommonString.getFormatPara(model.get("catalognum"))+"%' order by view_count desc");  
            if(proList==null){
				proList= new ArrayList<Map>();
			}
			List<Map> topList=dbHelper.getMapList(" select top 6 * from pro_products where is_show=1 and id!="+CommonString.getFormatPara(model.get("id"))+" and     catalognum like '%"+CommonString.getFormatPara(model.get("catalognum"))+"%' order by view_count desc");  
            if(topList==null){
				topList= new ArrayList<Map>();
			}
			String tonStr="";
			String otherStr="";
			if(catalognum.equals("101001001")||catalognum.equals("101001004")||catalognum.equals("101002007")){
				if(tonandNum!=0.0){
					 tonStr=" and (tonandmeter>="+(tonandNum-5.0)+" and tonandmeter<="+(tonandNum+5.0)+")";
				}
				otherStr=" and  view_count>=1000 ";
			}else{
				otherStr=" and  view_count>=200 ";
			}
			
			List<Map> proSameList=dbHelper.getMapList(" select top 6  * from pro_products where is_show=1 "+tonStr+" and id!="+CommonString.getFormatPara(model.get("id"))+" and  factoryid!="+CommonString.getFormatPara(model.get("factoryid"))+"  and catalognum like '%"+CommonString.getFormatPara(model.get("catalognum"))+"%'  "+otherStr+" order by newid() desc");  
	        List<Map> paramList1=new  ArrayList<Map>(); 
	        List<Map> paramList2=new  ArrayList<Map>();           
			List<Map> paramList3=new  ArrayList<Map>();           
            if(proSameList==null||(proSameList!=null&&proSameList.size()<3)){
				proSameList=dbHelper.getMapList(" select top 6  * from pro_products where is_show=1 "+tonStr+" and id!="+CommonString.getFormatPara(model.get("id"))+" and  factoryid!="+CommonString.getFormatPara(model.get("factoryid"))+"  and catalognum like '%"+CommonString.getFormatPara(model.get("catalognum"))+"%'  order by newid() desc");  
			}
		    if(proSameList==null||(proSameList!=null&&proSameList.size()<3)){
				proSameList=dbHelper.getMapList(" select top 6  * from pro_products where is_show=1  and id!="+CommonString.getFormatPara(model.get("id"))+" and  factoryid!="+CommonString.getFormatPara(model.get("factoryid"))+"  and catalognum like '%"+CommonString.getFormatPara(model.get("catalognum"))+"%'  order by newid() desc");  
			}
			if(proSameList==null||(proSameList!=null&&proSameList.size()<3)){
				proSameList=dbHelper.getMapList(" select top 6  * from pro_products where is_show=1  and id!="+CommonString.getFormatPara(model.get("id"))+"  and catalognum like '%"+CommonString.getFormatPara(model.get("catalognum"))+"%'  order by newid() desc");  
			}
		   if(proSameList==null||proSameList.size()==0){
				proSameList= new ArrayList<Map>();
			}else{
				System.out.println("==========="+proSameList.size());
			//其他参数
			String param1=proSameList.size()>0?CommonString.getFormatPara(proSameList.get(0).get("param")):"[]" ;
			String param2=proSameList.size()>1?CommonString.getFormatPara(proSameList.get(1).get("param")):"[]" ;
			String param3=proSameList.size()>2?CommonString.getFormatPara(proSameList.get(2).get("param")):"[]" ;
			if(!param1.equals("[]")&&!param1.equals("")){
			JSONArray keyParaAry = new JSONArray(param1); //关键参数列表
          		if(keyParaAry!=null && keyParaAry.length()>0){
					 String param_product_no="",param_id="",param_name="",param_type="",param_order_no="",param_enum_no="",param_value="";
					 int paramCount=1;
				    for(int j=0;j<keyParaAry.length();j++){
				        Map parmaMap = new HashMap();
          				JSONObject keyParaObj = keyParaAry.getJSONObject(j);
							 param_product_no = CommonString.getFormatPara(keyParaObj.get("product_no"));
							 parmaMap.put("param_product_no", param_product_no);
							 param_id = CommonString.getFormatPara(keyParaObj.get("no"));
							 if(param_id.equals("")){param_id="0";}
							    parmaMap.put("param_id", param_id);
							 param_name = CommonString.getFormatPara(keyParaObj.get("name"));
							    parmaMap.put("param_name", param_name);
							 param_type = CommonString.getFormatPara(keyParaObj.get("type"));
							    parmaMap.put("param_type", param_type);
							 param_order_no = CommonString.getFormatPara(keyParaObj.get("order_no"));
							    parmaMap.put("param_order_no", param_order_no);
							 param_enum_no = CommonString.getFormatPara(keyParaObj.get("enum_no"));
							    parmaMap.put("param_enum_no", param_enum_no);
							 param_value = CommonString.getFormatPara(keyParaObj.get("value"));
							    parmaMap.put("param_value", param_value);
							 if(paramCount<=6&&!param_value.equals("")){
								 if(null != categoryKeyList && categoryKeyList.size()>0){
									 for(Map oneMap:categoryKeyList){
										if(CommonString.getFormatPara(oneMap.get("id")).equals(param_id)){
								                paramCount++;
										 }
									 }
								 }
							 }
			 
						paramList1.add(parmaMap);
						}
					}
			}
			
			if(!param2.equals("[]")&&!param2.equals("")){
			JSONArray keyParaAry = new JSONArray(param2); //关键参数列表
          		if(keyParaAry!=null && keyParaAry.length()>0){
					 String param_product_no="",param_id="",param_name="",param_type="",param_order_no="",param_enum_no="",param_value="";
					 int paramCount=1;
				    for(int j=0;j<keyParaAry.length();j++){
				        Map parmaMap = new HashMap();
          				JSONObject keyParaObj = keyParaAry.getJSONObject(j);
							 param_product_no = CommonString.getFormatPara(keyParaObj.get("product_no"));
							 parmaMap.put("param_product_no", param_product_no);
							 param_id = CommonString.getFormatPara(keyParaObj.get("no"));
							 if(param_id.equals("")){param_id="0";}
							    parmaMap.put("param_id", param_id);
							 param_name = CommonString.getFormatPara(keyParaObj.get("name"));
							    parmaMap.put("param_name", param_name);
							 param_type = CommonString.getFormatPara(keyParaObj.get("type"));
							    parmaMap.put("param_type", param_type);
							 param_order_no = CommonString.getFormatPara(keyParaObj.get("order_no"));
							    parmaMap.put("param_order_no", param_order_no);
							 param_enum_no = CommonString.getFormatPara(keyParaObj.get("enum_no"));
							    parmaMap.put("param_enum_no", param_enum_no);
							 param_value = CommonString.getFormatPara(keyParaObj.get("value"));
							    parmaMap.put("param_value", param_value);
							 if(paramCount<=6&&!param_value.equals("")){
								 if(null != categoryKeyList && categoryKeyList.size()>0){
									 for(Map oneMap:categoryKeyList){
										if(CommonString.getFormatPara(oneMap.get("id")).equals(param_id)){
								                paramCount++;
										 }
									 }
								 }
							 }
			 
						paramList2.add(parmaMap);
						}
					}
			}
			
			
		  if(!param3.equals("[]")&&!param3.equals("")){
			JSONArray keyParaAry = new JSONArray(param3); //关键参数列表
          		if(keyParaAry!=null && keyParaAry.length()>0){
					 String param_product_no="",param_id="",param_name="",param_type="",param_order_no="",param_enum_no="",param_value="";
					 int paramCount=1;
				    for(int j=0;j<keyParaAry.length();j++){
				        Map parmaMap = new HashMap();
          				JSONObject keyParaObj = keyParaAry.getJSONObject(j);
							 param_product_no = CommonString.getFormatPara(keyParaObj.get("product_no"));
							 parmaMap.put("param_product_no", param_product_no);
							 param_id = CommonString.getFormatPara(keyParaObj.get("no"));
							 if(param_id.equals("")){param_id="0";}
							    parmaMap.put("param_id", param_id);
							 param_name = CommonString.getFormatPara(keyParaObj.get("name"));
							    parmaMap.put("param_name", param_name);
							 param_type = CommonString.getFormatPara(keyParaObj.get("type"));
							    parmaMap.put("param_type", param_type);
							 param_order_no = CommonString.getFormatPara(keyParaObj.get("order_no"));
							    parmaMap.put("param_order_no", param_order_no);
							 param_enum_no = CommonString.getFormatPara(keyParaObj.get("enum_no"));
							    parmaMap.put("param_enum_no", param_enum_no);
							 param_value = CommonString.getFormatPara(keyParaObj.get("value"));
							    parmaMap.put("param_value", param_value);
							 if(paramCount<=6&&!param_value.equals("")){
								 if(null != categoryKeyList && categoryKeyList.size()>0){
									 for(Map oneMap:categoryKeyList){
										if(CommonString.getFormatPara(oneMap.get("id")).equals(param_id)){
								                paramCount++;
										 }
									 }
								 }
							 }
			 
						paramList3.add(parmaMap);
						}
					}
			}
			
			
			}
			
			List<Map> newsList  = WEBDBHelper.getMapList("select top 5 title,CONVERT(varchar(100),add_date, 23) as add_date,html_filename from article where is_pub=1 and title like '%"+CommonString.getFormatPara(model.get("factoryname"))+"%'  order by id desc","Web21NewsDBHelper");
			List<Map> picList=dbHelper.getMapList(" select * from pro_product_pic where product_id= "+CommonString.getFormatPara(model.get("id")));  
			List<Map> reviewList=null;
	        Connection conn_21sun = null;
			Map  newsMap=new HashMap();
	        try{
                conn_21sun = dbHelper.getConnection("web21sun_news");
				//reviewList = dbHelper.getMapList("select * from vi_pro_review where pro_id="+id,conn_21sun);
	        	Map topNewsMap = dbHelper.getMap(" select top 1 news_id  from vi_pro_review where pro_id = ? order by pub_date desc ",new Object [] {id},conn_21sun);
                if(topNewsMap!=null){
					//newsMap=dbHelper.getMap("select * from article where id="+CommonString.getFormatPara(topNewsMap.get("news_id")),conn_21sun);
					newsMap=dbHelper.getMap(" select n.*,c.content from news n left join News_content c on n.id=c.groud_id where n.id= "+CommonString.getFormatPara(topNewsMap.get("news_id")),conn_21sun);
				}
				if(newsMap==null){
					newsMap=new HashMap();
				}
			}catch(Exception e){
		        e.printStackTrace() ;
	        }finally{
		        DBHelper.freeConnection(conn_21sun) ;
	        }			
            if(reviewList==null){
				reviewList= new ArrayList<Map>(); 
			}
		   if(picList==null){
				picList= new ArrayList<Map>();
			}
			
			root.put("newsMap",newsMap);
			root.put("reviewList",reviewList);
			root.put("paramList1", paramList1); 
			root.put("paramList2", paramList2); 
			root.put("paramList3", paramList3); 
			root.put("topList", topList); 

			root.put("newsList", newsList); 
			root.put("proSameList", proSameList); 
			root.put("proList", proList); 
			root.put("proCount", proList.size()+1); 
			if(!CommonString.getFormatPara(model.get("img2")).equals("")){
					root.put("picCount", picList.size()+1); 
			}else{
					root.put("picCount", proList.size()); 
			}
			root.put("categoryLists", categoryLists); 
			root.put("categoryList", categoryList); 
			List <Map> categoryParamsList =(List<Map>) paramListMap.get(catalognum);//参数字段
			if(null == categoryParamsList || categoryParamsList.size()<=0){
				if(catalognum.length()>=6){
				categoryParamsList =  (List<Map>)paramListMap.get(catalognum.substring(0,6));//参数字段
				}
				if(catalognum.indexOf("107")>=0){
				categoryParamsList =  (List<Map>)paramListMap.get("107");//参数字段
				}
			}
			if(categoryParamsList==null){
				categoryParamsList=new ArrayList<Map>();
			}
			root.put("categoryParamsList", categoryParamsList); 
			root.put("parmaMainMap", parmaMainMap);  
			root.put("paramList", paramList);  
			root.put("model", model);
			root.put("precatalogname",precatalogname) ;
			root.put("catalogname",CommonString.getFormatPara(catalogMap.get(catalognum))) ;
			root.put("precatalognum",precatalognum) ;
			root.put("topcatalogname",topcatalogname) ;
			root.put("topcatalognum",topcatalognum) ;
			Map cc = (Map) application.getAttribute("brandLetterList");
			List<Map> brandList=null;
            brandList=(List)(cc.get(catalognum));
	        if(brandList==null){
		        brandList=(List)(cc.get("000"));
	        }
			root.put("brandList",brandList) ;
			//吨位
			if(catalognum.indexOf("101001")!=-1&&(tonandNum<=13)){
			tonand = "(tonandmeter<=13)";
			}else if(catalognum.indexOf("101001")!=-1&&(tonandNum>13)&&(tonandNum<=30)){
			tonand = "middle";
			}else if(catalognum.indexOf("101001")!=-1&&(tonandNum>30)){
			tonand = "(tonandmeter>30)";
			}
			root.put("tonand", tonand);
			//产品的品牌信息
			sql=" select full_name,logo,usern  from pro_agent_factory where id="+model.get("factoryid");
			List<Map> brandInfo = dbHelper.getMapList(sql) ;
			if(null != brandInfo && brandInfo.size()>0){
				for(Map brandMode:brandInfo){
					root.put("brandMode", brandMode);
				}
			}
			//开始生成
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"/template/");
			    String pageFlag1 = "paras";	
				String fileName = CommonString.getFormatPara(model.get("file_name"));
				String  createName1 = absPath+"proDetail/"+fileName;
				root.put("cName1","/proDetail/"+fileName);
				
				String pageFlag2 = "intro";
				String fileName2 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag2+".shtm";
				String createName2 = absPath+"proDetail/"+fileName2;			
				root.put("cName2","/proDetail/"+fileName2);
				
				String pageFlag3 = "pic";
				String fileName3 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag3+".shtm";
				String createName3 = absPath+"proDetail/"+fileName3;			
				root.put("cName3","/proDetail/"+fileName3);
				
				String pageFlag4 = "agent";
				String fileName4 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag4+".shtm";
				String createName4 = absPath+"proDetail/"+fileName4;			
				root.put("cName4","/proDetail/"+fileName4);
				
				String pageFlag5 = "message";
				String fileName5 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag5+".shtm";
				String createName5 = absPath+"proDetail/"+fileName5;			
				root.put("cName5","/proDetail/"+fileName5);
				
				String pageFlag6 = "order";
				String fileName6 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag6+".shtm";
				String createName6 = absPath+"proDetail/"+fileName6;			
				root.put("cName6","/proDetail/"+fileName6);
				
				String pageFlag7 = "parameter";
				String fileName7 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag7+".shtm";
				String createName7 = absPath+"proDetail/"+fileName7;			
				root.put("cName7","/proDetail/"+fileName7);
				
				String pageFlag8 = "review";
				String fileName8 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag8+".shtm";
				String createName8 = absPath+"proDetail/"+fileName8;			
				root.put("cName8","/proDetail/"+fileName8);
				 

				
				root.put("pageFlag",pageFlag1);
				freemarkerUtils.generate("/proDetail2018/detail_zongshu.shtm", root, createName1 ,request);
							
				//root.put("pageFlag",pageFlag2);
				//freemarkerUtils.generate("/proDetail2018/detail_xingneng.shtm", root, createName2 ,request);
				
				root.put("pageFlag",pageFlag3);
				freemarkerUtils.generate("/proDetail2018/detail_pic.shtm", root, createName3 ,request);
				
				root.put("pageFlag",pageFlag4);
				freemarkerUtils.generate("/proDetail2018/detail_dailishang.shtm", root, createName4 ,request);
				
				root.put("pageFlag",pageFlag5);
				freemarkerUtils.generate("/proDetail2018/detail_koubei.shtm", root, createName5 ,request);
							
				root.put("pageFlag",pageFlag7);
				freemarkerUtils.generate("/proDetail2018/detail_canshu.shtm", root, createName7 ,request);	 
 
 				root.put("pageFlag",pageFlag8);
				freemarkerUtils.generate("/proDetail2018/detail_review.shtm", root, createName8 ,request);	
			
			//手机端详细页同步生成
			Common.doPostHttpAsync("http://49.4.80.151:7662/product/tools/create_pro_one.jsp?id="+id,postMap);
			//更新索引
			Common.doPostHttpAsync("http://sowa.21-sun.com//writer/product.21-sun.com/product_create_one.jsp?id="+id,postMap);

		}
		
		//农机产品详细页
		if(eventList.contains("productsMachineCreate")){
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
            String realPath = Common.getAbsolutePath(request) ;
			//本条产品信息
			model = dbHelper.getMap(" select * from pro_machine_products where id = ? ",new Object [] {id},connection);
			String is_show = CommonString.getFormatPara(model.get("is_show")) ;
			Map root = new HashMap();
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath);
			String pageFlag1 = "paras";	
			String fileName = CommonString.getFormatPara(model.get("file_name"));
			String  createName1 = absPath+"nj/proDetail/"+fileName;
			root.put("model",model);
			
			list=dbHelper.getMapList(" select name,file_name from pro_machine_products where brand_id="+CommonString.getFormatPara(model.get("brand_id"))+" and catalog_num="+CommonString.getFormatPara(model.get("catalog_num"))+" ",connection);
			root.put("list",list);
			freemarkerUtils.generate("nj/template/detail.htm", root, createName1 ,request);
				
		}
		
		
	    //生成店铺的详细页
		if(eventList.contains("brandCreate")){
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			Map root = new HashMap();
			// 生成所有的品牌详显页
	        String realPath = Common.getAbsolutePath(request) ;
	        FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
            FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ; 	
	        Map allbrandMap = dbHelper.getMap("select  usern from pro_agent_factory where is_show=1 and  flag = 1 and usern<>'tdbenniu' and id="+id+" order by id asc") ;
			
			String  usern = CommonString.getFormatPara(allbrandMap.get("usern")) ;
			Map brandModel = dbHelper.getMap(" select name from pro_agent_factory  where usern = ? ",new Object [] {usern});
			List<Map> newsList =null;
			if(brandModel!=null){
				newsList= WEBDBHelper.getMapList("select top 9 title,CONVERT(varchar(100),add_date, 23) as add_date,html_filename from article where is_pub=1 and title like '%"+CommonString.getFormatPara(brandModel.get("name"))+"%'  order by id desc","Web21NewsDBHelper");
			}
			root.put("newsList",newsList) ;
			root.put("usern",usern) ;
			freemarkerUtils.generate("brand/revision.html",root,realPath+"/brand/"+usern+"/index.htm") ;  // 生成所有的品牌详显页

				
		}
	    
	    
	    
		//存元素和频道的关系
		if(eventList.contains("saveChannelSubblock")){
			//信息表
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String [] cuuidArr = channel_uuid.split(",");
			Map subblock = dbHelper.getMap(" select * from "+tablePrefix+"common_channel_subblock where id = ? ",new Object [] {id},connection);
			String uuid = (String)subblock.get("uuid");
			dbHelper.execute(" delete from " + tablePrefix + "common_acl_channel_subblock where subblock_uuid = ? " , new Object [] {uuid},connection);
			for(int i=0;i<cuuidArr.length;i++){
				dbHelper.execute(" insert into "+tablePrefix+"common_acl_channel_subblock ( channel_uuid , subblock_uuid ) values ( ? , ? )", new Object [] {cuuidArr[i],uuid},connection);
			}
		}
		//删除元素和频道的关系
		if(eventList.contains("deleteChannelSubblock")){
			String id = CommonString.getFormatPara(request.getParameter("del_id"));
			dbHelper.execute(" delete from "+tablePrefix+"common_acl_channel_subblock where subblock_uuid in ("+id+") " , connection);
		}
		// 更新 application 品牌
		if(eventList.contains("updateBrand")){
			CommonApplication.getBrandMap(application);
		}
		//更新专栏品牌
		if(eventList.contains("updateBrandSpec")){
			Map para = new HashMap();
			para.put("target", "brand");
			Common.doPostHttpAsync("http://spec.21-sun.com/tools/application/update_spec_application.jsp", para);
		}
		if(eventList.contains("updateAdAreaAgent")){
		 // 设置代理商信息的时候进行广告投放区域表设定
			List<Map> agent_facsList = null;
			String is_shop = CommonString.getFormatPara(request.getParameter("zd_is_shop")) ;
			String agentId = CommonString.getFormatPara(request.getParameter("zd_id")) ;
	 
			if("1".equals(is_shop) || "2".equals(is_shop) ||"3".equals(is_shop)){
			String fac_sql = "select agent_fac from pro_agent_factory where id=?" ;  // 选出当前代理商代理的品牌
			String agent_fac = "" ;
			 if(!"".equals(agentId)){
					agent_fac = CommonString.getFormatPara(dbHelper.getMap(fac_sql,new Object[]{agentId}).get("agent_fac")) ;  // 得到 代理商代理的品牌id
				}
				StringBuffer agent_fac_sbf = new StringBuffer("") ;
				String[] agent_facs_arr = null ;
				if(!"".equals(agent_fac)){
					agent_facs_arr = agent_fac.split(",") ;
					if(agent_facs_arr!=null && agent_facs_arr.length>0){
						for(int i=0;i<agent_facs_arr.length;i++){
							 if(!agent_facs_arr[i].trim().equals("")){
								 agent_fac_sbf.append(agent_facs_arr[i]).append(",") ;
							 }
						}
					}else{
						agent_fac_sbf = new StringBuffer(agent_fac) ;
					}
				}
				if(!"".equals(agent_fac_sbf.toString())&&agent_fac_sbf.toString().indexOf(",")!=-1){
					agent_fac_sbf = new StringBuffer(agent_fac_sbf.substring(0,agent_fac_sbf.length()-1)) ;
				}
				if(!"".equals(agent_fac)){
					if(agent_fac.startsWith(",")){
						agent_fac = "0"+agent_fac;
					}
					if(agent_fac.endsWith(",")){
						agent_fac = agent_fac + "0";
					}
				}
				String agent_facs = "select id,name,logo from pro_agent_factory where id in("+agent_fac_sbf+")" ;
				agent_facsList = dbHelper.getMapList(agent_facs,connection);	
				List<Map> cityList = null ;
		    	   String fid = "";
		    	   String sql = " select b.area_id,b.area_name,b.parent_area_id";
		    	   sql += ",checked = ( case when c.agent_id is null then 'false' else 'true' end )";
		    	   sql += " from pro_agent_factory_and_area a ";
		    	   sql += " inner join comm_area b on a.area_id = b.area_id and a.agent_id = "+agentId+" and a.factory_id = ?";
		    	   sql += " left join pro_agent_ad_area c on a.area_id = c.area_id and c.agent_id = "+agentId+" and c.factory_id = ?";
		    	   sql += " order by b.area_id asc ";
		    	   String ins_sql = "insert into pro_agent_ad_area(agent_id,area_id,factory_id) values(?,?,?)" ;
		  
		}
		}
		if(eventList.contains("open_mem_shop")){
			String is_shop_flag = CommonString.getFormatPara(request.getParameter("is_shop_flag")) ;
			String is_shop = CommonString.getFormatPara(request.getParameter("zd_is_shop")) ; 
			String zd_id = CommonString.getFormatPara(request.getParameter("zd_id")) ;
			String upt_sql = "update pro_agent_factory set mem_open_date=? ,mem_end_date = ? where id=?" ;
			if(!"0".equals(is_shop) && !is_shop.equals(is_shop_flag)){
				dbHelper.execute(upt_sql,new Object[]{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),CommonDate.dateAdd("365","yyyy-MM-dd HH:mm:ss"),zd_id}) ;
			}
			
			//生成代理商详细页
			Map<String,String> postMap = new HashMap<String,String>();
			postMap.put("id",zd_id);
            //提交id
			Common.doPostHttpAsync("http://product.21-sun.com/tools/create/agent/create_agent_shop_one.jsp?id="+zd_id,postMap);
		}
		//更新代理商订单中的信息
		if(eventList.contains("updateAgentOrder")){

		}
		//代理商代理区域
		if(eventList.contains("update_agent_city")){
			String zd_city = CommonString.getFormatPara(request.getParameter("zd_area_names")) ; 
			String zd_city_num = CommonString.getFormatPara(request.getParameter("zd_city_num")) ; 
	   
			String zd_id = CommonString.getFormatPara(request.getParameter("zd_agent_id")) ;

			String upt_sql = "update pro_agent_factory set city_num=?,order_area=? where id=?" ;
			
		    dbHelper.execute(upt_sql,new Object[]{zd_city_num,zd_city,zd_id}) ;
		}
		
	    //代理商坐标
		if(eventList.contains("updateAgentLocation")){
			//System.out.println(jr_agent_id);
		    //System.out.println(jr_location);
			String jr_name = CommonString.getFormatPara(request.getParameter("jr_name")) ; 

			String jr_agent_id = CommonString.getFormatPara(request.getParameter("jr_agent_id")) ; 
			String jr_location = CommonString.getFormatPara(request.getParameter("jr_location")) ; 
            String loc[]=jr_location.split(",");
			String upt_sql = "update pro_agent_factory set lng=?,lat=?,last_modified_date=?,address=? where id=?" ;
		    dbHelper.execute(upt_sql,new Object[]{loc[0],loc[1],CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),jr_name,jr_agent_id}) ;
		}
		
		
		if(eventList.contains("doLog")){//记录外呼日志
			String add_user=CommonString.getFormatPara(request.getParameter("jr_user"));
			String log_mobile_phone= CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String log_id = CommonString.getFormatPara(request.getParameter("log_id"));
            if(log_id.equals("")){log_id="0";}
			if(log_mobile_phone.equals("")){log_mobile_phone="0";}
			
			//Map theMap1 = dbHelper.getMap(" select id  from phone_log  where flag=1 and  order_id = ? ",new Object [] {log_id},connection);
			String log_sql = " insert into phone_log(order_id,log_date,log_user,phone,flag)  values";
			log_sql+="("+log_id+",'"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+add_user+"','"+log_mobile_phone+"',1)";
		 
			dbHelper.execute(log_sql, connection);
	 
		}
		
		
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	request.getRequestDispatcher("/backend/action/after_own.jsp").forward(request,response);
%>