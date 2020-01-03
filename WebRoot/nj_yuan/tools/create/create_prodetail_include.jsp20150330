<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.*"%>


<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	// 生成有更新的产品引入页面
	String realPath = Common.getAbsolutePath(request) ;
	String absPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"template/") ; 
	String today=CommonDate.getToday("yyyy-MM-dd");
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	//更新订单的产品
	List<Map> order_list = dbHelper.getMapList("select  product_id from pro_product_form where  is_deleted=0 and product_id!='' and add_date>='"+today+"' group by product_id") ;
   	//更新评论的产品
	List<Map> comment_list = dbHelper.getMapList("select  product_id from pro_comments where   is_show=1 and product_id!='' and add_date>='"+today+"'   group by product_id") ;
	//遍历订单
	if(null != order_list && order_list.size()>0){
	    root = new HashMap();	
		for(Map oneMap:order_list){
			String sql=" select * from pro_products  where id="+CommonString.getFormatPara(oneMap.get("product_id"));
			Map proMap = dbHelper.getMap(sql) ;
			if(null != proMap){
				root.put("pro_id",CommonString.getFormatPara(proMap.get("id"))) ;
			    root.put("factoryname",CommonString.getFormatPara(proMap.get("factoryname"))) ;
			    root.put("proname",CommonString.getFormatPara(proMap.get("name"))) ;
			    root.put("catalogname",CommonString.getFormatPara(proMap.get("catalogname"))) ;
			    freemarkerUtils.generate("proDetail/include_order_list.shtm",root,realPath+"/include/prodetail_order/order_list_"+CommonString.getFormatPara(proMap.get("id"))+".htm") ;
			}
		}
	}
	//遍历评论
	if(null != comment_list && comment_list.size()>0){
	root = new HashMap();
		for(Map oneMap:comment_list){
			String sql=" select * from pro_products  where id="+CommonString.getFormatPara(oneMap.get("product_id"));
			Map proMap = dbHelper.getMap(sql) ;
			if(null != proMap){
				root.put("pro_id",CommonString.getFormatPara(proMap.get("id"))) ;
			    root.put("factoryname",CommonString.getFormatPara(proMap.get("factoryname"))) ;
			    root.put("proname",CommonString.getFormatPara(proMap.get("name"))) ;
			    root.put("catalogname",CommonString.getFormatPara(proMap.get("catalogname"))) ;
			    freemarkerUtils.generate("proDetail/include_comment_list.shtm",root,realPath+"/include/prodetail_comment/comment_list_"+CommonString.getFormatPara(proMap.get("id"))+".htm") ;
			}
		}
	}
	out.println("ok") ;
%>
