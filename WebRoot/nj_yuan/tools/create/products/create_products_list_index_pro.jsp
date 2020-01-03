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
	String resule="false";
	String sql="";
	String sql1="";
	try{
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
		     sql1= "select  num from pro_catalog where is_show=1 and num in (101001,101002,101003,102,103,107,106001,105003) order by id desc";
			 list1 = dbHelper.getMapList(sql1);
			 for(Map catalogNum:list1){
			 String catalognum=CommonString.getFormatPara(catalogNum.get("num"));
			
			//产品列表首页热门机型
			sql = "select top 8 id,factoryname,catalogname,name,img2,file_name from pro_products where is_show=1  and catalognum like '"+catalognum+"%' order by hot_num desc,view_count desc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("products_page/products_list_index_pro.htm",root,realPath+"include/products_page/products_list_product/products_list_index_hot_"+catalognum+".htm");
				resule="true";
			}
            //产品列表首页新品展示
			sql = "select top 4 id,factoryname,catalogname,name,img2,file_name from pro_products where is_show=1   and catalognum like '"+catalognum+"%' order by new_num desc,view_count desc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("products_page/products_list_index_pro.htm",root,realPath+"include/products_page/products_list_product/products_list_index_new_"+catalognum+".htm");
				resule="true";
			}	
        }

              //产品列表首页优惠购机
			sql = "select top 8  num,name from pro_catalog where num in(select  SUBSTRING(pro_catanum, 0, 7) as num from pro_ymt_activity group by SUBSTRING(pro_catanum, 0, 7) )";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("products_page/products_list_index_ymt_pro.htm",root,realPath+"include/products_page/products_list_product/products_list_index_ymt_pro.htm");
				resule="true";
			}		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>