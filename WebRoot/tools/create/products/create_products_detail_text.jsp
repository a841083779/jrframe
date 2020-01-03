<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
   
    DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String resule="false";
	String sql="";
	String sql1="";
	try{
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
		
		
				
			Map<String,String> postMap = new HashMap<String,String>();
			//本条产品信息
			list = dbHelper.getMapList(" select    * from pro_products where is_show=1 and file_name!='' and id in(20671,25473,25475)    order by id  asc ");
			out.print("count="+list.size()); 
			for(Map model:list){
			String ids =  CommonString.getFormatPara(model.get("id"));
			String catalognum =  CommonString.getFormatPara(model.get("catalognum")) ;
			String tonandmeter = CommonString.getFormatPara(model.get("tonandmeter"));
			float tonandNum=Float.parseFloat(tonandmeter);
			String tonand="";
			out.println("ids="+ids);
			
			List <Map> categoryList=dbHelper.getMapList(" select id,name   from pro_category where parent_no="+catalognum); //参数再分类别
			root.put("categoryList", categoryList); 
			List <Map> categoryParamsList =  dbHelper.getMapList(" select id,name,category_id,no,order_no from pro_catalog_param where parent_no="+catalognum);//参数字段
			root.put("categoryParamsList", categoryParamsList); 
			String param=CommonString.getFormatPara(model.get("param")) ;
			List<Map> paramList=new  ArrayList<Map>();
			if(!param.equals("[]")){
			JSONArray keyParaAry = new JSONArray(param); //关键参数列表
          		if(keyParaAry!=null && keyParaAry.length()>0){
					 String param_product_no="",param_id="",param_name="",param_type="",param_order_no="",param_enum_no="",param_value="";
				   for(int j=0;j<keyParaAry.length();j++){
				        Map parmaMap = new HashMap();
          				JSONObject keyParaObj = keyParaAry.getJSONObject(j);
							 param_product_no = CommonString.getFormatPara(keyParaObj.get("product_no"));
							    parmaMap.put("param_product_no", param_product_no);
							 param_id = CommonString.getFormatPara(keyParaObj.get("no"));
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
								System.out.println("parmaMap="+parmaMap);
						paramList.add(parmaMap);
						}
					
					}
			 }
			 root.put("paramList", paramList);  

			
			root.put("model", model);
			String precatalogname = CommonString.getFormatPara(catalognum).length()>6?CommonString.getFormatPara(catalogMap.get(catalognum.substring(0,6))):CommonString.getFormatPara(catalogMap.get(catalognum)) ;
			String precatalognum="";
			String topcatalogname="";
			String topcatalognum="";
			if(catalognum.length()>6){precatalognum=catalognum.substring(0,6);}else{precatalognum=catalognum;}
			if(catalognum.length()>3){topcatalognum=catalognum.substring(0,3);topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}
			else{topcatalognum=catalognum; topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}	
			root.put("model", model);
			root.put("precatalogname",precatalogname) ;
			root.put("precatalognum",precatalognum) ;
			root.put("topcatalogname",topcatalogname) ;
			root.put("topcatalognum",topcatalognum) ;
			//吨位
			if(catalognum.indexOf("101001")!=-1&&(tonandNum<=13)){
			tonand = "tonandmeter<=13";
			}else if(catalognum.indexOf("101001")!=-1&&(tonandNum>13)&&(tonandNum<=30)){
			tonand = "tonandmeter<=30 and tonandmeter>13";
			}else if(catalognum.indexOf("101001")!=-1&&(tonandNum>30)){
			tonand = "tonandmeter>30";
			}
			root.put("tonand", tonand);
			//新闻和二手
			List<Map> getNewsList  = WEBDBHelper.getMapList("select top 5 title,CONVERT(varchar(100),add_date, 23) as add_date,html_filename from article where is_pub=1 and title like '%"+CommonString.getFormatPara(model.get("factoryname"))+"%' ","Web21sunDBHelper");
			root.put("getNewsList",getNewsList) ;
			List<Map> usedList  = WEBDBHelper.getMapList("select  top 2  used_area.area_name,used_equipment.import_brand,used_equipment.price,used_equipment.workingtime,used_equipment.img1_1,used_equipment.factorydate,used_equipment.model,used_equipment.id,used_catalog.name from used_equipment,used_catalog,used_area  where used_equipment.is_review=1 and used_equipment.brand_id="+CommonString.getFormatPara(model.get("factoryid"))+" and  used_equipment.is_pub=1 and  used_equipment.brand_id!='' and used_equipment.category_id=used_catalog.id and used_area.area_id=used_equipment.province_id and used_equipment.img1_1 like '%resource.21-sun%' order by  used_equipment.id desc","Web21usedDBHelper");
			root.put("usedList",usedList) ;
			//产品的品牌信息
			 sql=" select full_name,logo,usern from pro_agent_factory where id="+model.get("factoryid");
				List<Map> brandInfo = dbHelper.getMapList(sql) ;
				if(null != brandInfo && brandInfo.size()>0){
					for(Map brandMode:brandInfo){
						root.put("brandMode", brandMode);
					}
			}
			String absPath = Common.getAbsolutePath(request);
			String pageFlag1 = "paras";	
				String fileName = CommonString.getFormatPara(model.get("file_name"));
				String  createName1 = absPath+"proDetails/"+fileName;
				root.put("cName1","/proDetails/"+fileName);
				
				String pageFlag2 = "intro";
				String fileName2 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag2+".shtm";
				String createName2 = absPath+"proDetails/"+fileName2;			
				root.put("cName2","/proDetails/"+fileName2);
				
				String pageFlag3 = "pic";
				String fileName3 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag3+".shtm";
				String createName3 = absPath+"proDetails/"+fileName3;			
				root.put("cName3","/proDetails/"+fileName3);
				
				String pageFlag4 = "agent";
				String fileName4 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag4+".shtm";
				String createName4 = absPath+"proDetails/"+fileName4;			
				root.put("cName4","/proDetails/"+fileName4);
				
				String pageFlag5 = "message";
				String fileName5 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag5+".shtm";
				String createName5 = absPath+"proDetails/"+fileName5;			
				root.put("cName5","/proDetails/"+fileName5);
				
				String pageFlag6 = "order";
				String fileName6 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag6+".shtm";
				String createName6 = absPath+"proDetails/"+fileName6;			
				root.put("cName6","/proDetails/"+fileName6);
				
				String pageFlag7 = "parameter";
				String fileName7 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag7+".shtm";
				String createName7 = absPath+"proDetails/"+fileName7;			
				root.put("cName7","/proDetails/"+fileName7);
				
				String pageFlag8 = "video";
				String fileName8 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag8+".shtm";
				String createName8 = absPath+"proDetails/"+fileName8;			
				root.put("cName8","/proDetails/"+fileName8);
				
			    String pageFlag9 = "story";
				String fileName9 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag9+".shtm";
				String createName9 = absPath+"proDetails/"+fileName9;			
				root.put("cName9","/proDetails/"+fileName9);
					
				String pageFlag10 = "manual";
				String fileName10 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag10+".shtm";
				String createName10 = absPath+"proDetails/"+fileName10;			
				root.put("cName10","/proDetails/"+fileName10);	
				
				String pageFlag11 = "weixiu";
				String fileName11 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag11+".shtm";
				String createName11 = absPath+"proDetails/"+fileName11;			
				root.put("cName11","/proDetails/"+fileName11);
				
				String pageFlag12 = "shouhou";
					String fileName12 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag12+".shtm";
					String createName12 = absPath+"proDetails/"+fileName12;			
					root.put("cName12","/proDetails/"+fileName12);
					
					root.put("pageFlag",pageFlag1);
					freemarkerUtils.generate("/proDetail_new/text/detail_zongshu.shtm", root, createName1 ,request);
								
				
					root.put("pageFlag",pageFlag7);
					freemarkerUtils.generate("/proDetail_new/text/detail_canshu.shtm", root, createName7 ,request);
					
					
					resule="true";
		  }	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>