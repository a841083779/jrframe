<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
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
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String resule="false";
	String sql="";
	String sql1="";
	String bigid = CommonString.getFormatPara(request.getParameter("bigid"));

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
			list = dbHelper.getMapList(" select  id,factoryid,factoryname,catalognum,catalogname,img1,img2,introduce,file_name,view_count,param,catalognum_new,instruments,is_show,tonandmeter,name  from pro_products where   id in(select  product_id from pro_comments where  is_show=1  and  CONVERT(varchar(100), add_date, 23)=CONVERT(varchar(100), GETDATE(), 23) and product_id!=''  group by  product_id  )  ");
			out.print("count="+list.size()); 
			for(Map model:list){
			String id = CommonString.getFormatPara(model.get("id"));
			String upt_sql = "update pro_products  set new_last_modify_date=? where id=?" ;
		    dbHelper.execute(upt_sql,new Object[]{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),id}) ;

			postMap.put("id",id);
			String tonand="";
			//本条产品信息
			//model = dbHelper.getMap(" select * from "+request.getParameter("tableName")+" where id = ? ",new Object [] {id},connection);
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
			Map saleMap = dbHelper.getMap(" select q1,q2,q3 from pro_sale_policy where factoryid = ?  and  catalognum= ?",new Object [] {CommonString.getFormatPara(model.get("factoryid")),catalognum},connection);
			if(saleMap==null){
				saleMap = dbHelper.getMap(" select q1,q2,q3 from pro_sale_policy where factoryid = ?  and  catalognum  like '"+precatalognum+"%'",new Object [] {CommonString.getFormatPara(model.get("factoryid"))},connection);
			}
			if(saleMap==null){saleMap=new HashMap();}
			root.put("saleMap", saleMap); 
			//参数
			List <Map> categoryKeyList=dbHelper.getMapList(" select id,name   from pro_catalog_param where is_key=1 "); //参数再分类别
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
			root.put("categoryList", categoryList); 
			List <Map> categoryParamsList =  dbHelper.getMapList(" select id,name,category_id,no,order_no from pro_catalog_param where parent_no="+catalognum);//参数字段
			root.put("categoryParamsList", categoryParamsList); 
			root.put("parmaMainMap", parmaMainMap);  
			root.put("paramList", paramList);  
			root.put("model", model);
			root.put("precatalogname",precatalogname) ;
			root.put("precatalognum",precatalognum) ;
			root.put("topcatalogname",topcatalogname) ;
			root.put("topcatalognum",topcatalognum) ;
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
				
				String pageFlag8 = "video";
				String fileName8 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag8+".shtm";
				String createName8 = absPath+"proDetail/"+fileName8;			
				root.put("cName8","/proDetail/"+fileName8);
				
			    String pageFlag9 = "story";
				String fileName9 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag9+".shtm";
				String createName9 = absPath+"proDetail/"+fileName9;			
				root.put("cName9","/proDetail/"+fileName9);
					
				String pageFlag10 = "manual";
				String fileName10 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag10+".shtm";
				String createName10 = absPath+"proDetail/"+fileName10;			
				root.put("cName10","/proDetail/"+fileName10);	
				
				String pageFlag11 = "weixiu";
				String fileName11 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag11+".shtm";
				String createName11 = absPath+"proDetail/"+fileName11;			
				root.put("cName11","/proDetail/"+fileName11);
				
				String pageFlag12 = "shouhou";
				String fileName12 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag12+".shtm";
				String createName12 = absPath+"proDetail/"+fileName12;			
				root.put("cName12","/proDetail/"+fileName12);			
				root.put("pageFlag",pageFlag1);
				freemarkerUtils.generate("/proDetail_temp/detail_zongshu.shtm", root, createName1 ,request);
							
				root.put("pageFlag",pageFlag2);
				freemarkerUtils.generate("/proDetail_temp/detail_xingneng.shtm", root, createName2 ,request);
				
				root.put("pageFlag",pageFlag3);
				freemarkerUtils.generate("/proDetail_temp/detail_pic.shtm", root, createName3 ,request);
				
				root.put("pageFlag",pageFlag4);
				freemarkerUtils.generate("/proDetail_temp/detail_dailishang.shtm", root, createName4 ,request);
				
				root.put("pageFlag",pageFlag5);
				freemarkerUtils.generate("/proDetail_temp/detail_koubei.shtm", root, createName5 ,request);
				
				root.put("pageFlag",pageFlag7);
				freemarkerUtils.generate("/proDetail_temp/detail_canshu.shtm", root, createName7 ,request);
				
			
		    }	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	%>