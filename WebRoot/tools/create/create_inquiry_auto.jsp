<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String absPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"template/") ; 
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
    String strIds="";
     try{
    	 List<Map> list = dbHelper.getMapList(" select top 100  * from pro_product_form where  is_create!=1 or  is_create is null order by id desc ") ;			
 		if(null != list && list.size()>0){
 			for(Map model:list){
 				root = new HashMap();
 				root.put("model", model);
 				Map proMap=new HashMap();
 				if(!CommonString.getFormatPara(model.get("product_id")).equals("")){
 				  proMap= dbHelper.getMap(" select file_name,img2,introduce from pro_products where id= "+CommonString.getFormatPara(model.get("product_id")) ) ;
                	}
 				if(proMap==null){	proMap=new HashMap();}
                 root.put("proMap", proMap);
 				String createName = absPath+"inquiry/detail_for_"+CommonString.getFormatPara(model.get("id"))+".htm";
 				freemarkerUtils.generate("/inquriy/detail.htm", root, createName ,request);
 			     strIds+=CommonString.getFormatPara(model.get("id"))+",";

 				
 			}
 		   if(!strIds.equals("")){
 		     strIds=strIds.substring(0,strIds.length()-1);
 		     dbHelper.execute("update   pro_product_form set is_create=1 where id in("+strIds+")");
 	        }
 	        
 		}
     }catch(Exception e){
    	 e.printStackTrace();
     }
	out.println("ok") ;
%>
