<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
    DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String resule="false";
	String sql="";
	String sql1="";
	int result=0;
	String bigid = CommonString.getFormatPara(request.getParameter("bigid"));
	String cata = CommonString.getFormatPara(request.getParameter("cata"));
	
	String yes = CommonString.getFormatPara(request.getParameter("yes"));
	String no = CommonString.getFormatPara(request.getParameter("no"));
	String ids = CommonString.getFormatPara(request.getParameter("ids"));

	Map keyParamMap = (Map) application.getAttribute("keyParamMap");
	Map paramListMap = (Map) application.getAttribute("paramListMap");
	Map salePolicyListMap = (Map) application.getAttribute("salePolicyListMap");
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
				
			Map<String,String> postMap = new HashMap<String,String>();
			//本条产品信息


			//list = dbHelper.getMapList(" select *  from pro_products where id in (2986,2992,2998,3002,3005) order by id desc");
			//list = dbHelper.getMapList(" select *  from pro_products where id in (10332,11025,11026,11027,11028,11049,11068,11071,11073,11078,11081,11104,11113,11116,11206,11284,11297,11298,11609,11611,11621,11877,11927,11928,11929,11930,11931,11932,12017,12018,12019,12028,12050,12134,12135,12604,12882,12883,12886,12889,12892,12893,12894,12895,12896,12897,12898,12901,12902,12903,12904,12917,12934,12935,12937,13227,13319,15551,17133,17134,17716,17719,17984,17985,17999,18009,18043,18697,19120,19123,19801) and id <12889  order by id desc");
			//list = dbHelper.getMapList(" select *  from pro_products where id in (2986,2992,2998,3002,3005,5324,5497,5498,5499,5500,5678,5687,6550,6551,6932,8024,9037,9040,9041,9042,9222,9750,10262,10327,10431,10432,10617,10620,10621,10646,10654,10655,10656,10657,10658,10662,10674,10676,10680,10874,10877,10882,10918,10952,10954,10959,10984,10993,10997,11001,11005,11006,11008,11024,11025,11026,11027,11028,11049,11068,11071,11073,11078,11081,11104,11113,11116,11206,11284,11297,11298,11609,11611,11621,11877,11927,11928,11929,11930,11931,11932,12017,12018,12019,12028,12050,12134,12135,12160,12163,12171,12577,12578,12579,12599,12600,12604,12882,12883,12886,12887,12888,12889,12890,12891,12892,12893,12894,12895,12896,12897,12898,12899,12900,12901,12902,12903,12904,12917,12934,12935,12937,13227,13319,15551,17133,17134,17716,17719,17984,17985,17999,18009,18043,18697,19120,19123,19801,20441,20442,20443,20444,20445,20446,20447,20448,20449,22545,26558,27306,27307,27308,28484,29896,29897,29899,29903,29904,29906,29908,29909,29910,29912,29913,29914,29915,29916,29917,29918,29919,29920,29921,29922,29923,33827,36358)  order by id desc");
			//list = dbHelper.getMapList(" select *  from pro_products where file_name_y like '%/%'  order by id desc ");
			//list = dbHelper.getMapList(" select *  from pro_products where file_name_y like '%/%' and id in(36552,36550,36549,36548)  order by id desc ");
			list=dbHelper.getMapList("select top 500 * from pro_products where  is_create_mobile=0  order by id desc ");
			for(Map model:list){
				out.println(list.size());
			String id = CommonString.getFormatPara(model.get("id"));

			String upt_sql = "update pro_products  set new_last_modify_date=? where id=?" ;
		    dbHelper.execute(upt_sql,new Object[]{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),id}) ;
			postMap.put("id",id);
			String tonand="";

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
				
			//其他参数
			String param1=CommonString.getFormatPara(proSameList.get(0).get("param")) ;
			String param2=CommonString.getFormatPara(proSameList.get(1).get("param")) ;
			String param3=CommonString.getFormatPara(proSameList.get(2).get("param")) ;
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
			
			List<Map> newsList  = WEBDBHelper.getMapList("select top 5 title,CONVERT(varchar(100),add_date, 23) as add_date,html_filename from article where is_pub=1 and title like '%"+CommonString.getFormatPara(model.get("factoryname"))+"%'  and html_filename<>'' and html_filename is not null  order by id desc","Web21NewsDBHelper");
			List<Map> picList=dbHelper.getMapList(" select * from pro_product_pic where product_id= "+CommonString.getFormatPara(model.get("id")));  
			List<Map> reviewList=null;
	        Connection conn_21sun = null;
			Map  newsMap=new HashMap();
	        /**try{
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
	        }**/			
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
			/**Map cc = (Map) application.getAttribute("brandLetterList");
			List<Map> brandList=null;
            brandList=(List)(cc.get(catalognum));
	        if(brandList==null){
		        brandList=(List)(cc.get("000"));
	        }
			root.put("brandList",brandList) ;**/
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
				String fileName =CommonString.getFormatPara(model.get("file_name"));
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
				
				//String pageFlag8 = "review";
				//String fileName8 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag8+".shtm";
				//String createName8 = absPath+"proDetail/"+fileName8;			
				//root.put("cName8","/proDetail/"+fileName8);
				 

				
				root.put("pageFlag",pageFlag1);
				System.out.println(createName1);
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
 
 				//root.put("pageFlag",pageFlag8);
				//freemarkerUtils.generate("/proDetail2018/detail_review.shtm", root, createName8 ,request);	
			

				result=	dbHelper.executeUpdate(" update pro_products set is_create_mobile=1 where id=?  ",new Object[]{id});
				out.println(id+"-"+result+";");
		    }	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
		
	}
	%>