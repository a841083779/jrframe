<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
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
	String catalog = "";
	String factoryid ="";
	String catalogWhere="";
	String brandWhere="";
	    if(!"".equals(catalog)){
			catalogWhere = " and num like '"+catalog+"%'" ;
		}
		if(!"".equals(factoryid)){
			brandWhere += " and id ='"+factoryid+"'" ;
		}
	String resule="false";
	String sql="";String sql1="";String sql2="";String sql3="";String sql4="";
	try{
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		List <Map>list3 = null;
		List <Map>list4 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
			//根据大类调取二级类别
			  
				sql = "select  catanum as num  from pro_product_form where CONVERT(varchar(100), add_date, 23)=CONVERT(varchar(100), GETDATE(), 23) order by id desc";//类别
			    list = dbHelper.getMapList(sql);
				    if(list != null && list.size() > 0){
						for(Map cataloge:list){
						String catalogNum=CommonString.getFormatPara(cataloge.get("num"));
						    String whereStr = " 1=1 " ;
							if(!"".equals(catalogNum)){
								whereStr += " and catanum like '"+catalogNum+"%'" ;
							}
							String order_sql = "select top 10 id,province,city,name,factoryname,cataname,product_name,add_date,datediff( minute, add_date, GETDATE()) as limitDate  from pro_product_form where "+whereStr+" order by add_date desc";
							List <Map> order_list= dbHelper.getMapList(order_sql);
								if(order_list != null && order_list.size() > 0){
									root.put("list",order_list);
									freemarkerUtils.generate("products_page/products_list_order.htm",root,realPath+"include/products_page/products_list_order/products_list_order_0_"+catalogNum+".htm");
									resule="true";
								}
						    }
						}
				sql3 = "select factoryid as id  from pro_product_form where CONVERT(varchar(100), add_date, 23)=CONVERT(varchar(100), GETDATE(), 23) order by id desc";//品牌
			    list3 = dbHelper.getMapList(sql3);
				    if(list3 != null && list3.size() > 0){
						for(Map brandd:list3){
						String brandId=CommonString.getFormatPara(brandd.get("id"));
						String whereStr=" 1=1 ";
							if(!"".equals(brandId)){
								whereStr += " and factoryid ="+brandId ;
							}
							String order_sql = "select top 10 id,province,city,name,factoryname,cataname,product_name,add_date,datediff( minute, add_date, GETDATE()) as limitDate  from pro_product_form where "+whereStr+" order by add_date desc";
							List <Map> order_list= dbHelper.getMapList(order_sql);
								if(order_list != null && order_list.size() > 0){
									root.put("list",order_list);
									freemarkerUtils.generate("products_page/products_list_order.htm",root,realPath+"include/products_page/products_list_order/products_list_order_"+brandId+"_0.htm");
									resule="true";
								}
							}
						}
				
					
				sql2= "select  catanum as num,factoryid as id  from pro_product_form where CONVERT(varchar(100), add_date, 23)=CONVERT(varchar(100), GETDATE(), 23) order by id desc";//品牌
				list2= dbHelper.getMapList(sql2);
					for(Map brand:list2){
						String brands=CommonString.getFormatPara(brand.get("id"));//品牌号
						String catalogw=CommonString.getFormatPara(brand.get("num"));//品牌号
						String whereStr = " 1=1 " ;
						if(!"".equals(catalogw)){
							whereStr += " and catanum like '"+catalogw+"%'" ;
						}
						if(!"".equals(brands)){
							whereStr += " and factoryid ='"+brands+"'" ;
						}
						sql1 = "select top 10 id,province,city,name,factoryname,cataname,product_name,add_date,datediff( minute, add_date, GETDATE()) as limitDate  from pro_product_form where "+whereStr+" order by add_date desc";
						list1= dbHelper.getMapList(sql1);
							if(list1 != null && list1.size() > 0){
								root.put("list",list1);
								freemarkerUtils.generate("products_page/products_list_order.htm",root,realPath+"include/products_page/products_list_order/products_list_order_"+brands+"_"+catalogw+".htm");
								resule="true";
							}
				    	}
				  
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>