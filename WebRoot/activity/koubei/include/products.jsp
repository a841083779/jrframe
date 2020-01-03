<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String v = CommonString.getFormatPara(request.getParameter("v")) ;
	String c = CommonString.getFormatPara(request.getParameter("c")) ;
	String whereStr = "";
	if(c!=null&&!c.equals("")){
		whereStr += " and catalognum like '"+c+"%' ";
	}
	if(v!=null&&!v.equals("")){
		whereStr += " and factoryid ='"+v+"' ";
	}
	DBHelper dbHelper = DBHelper.getInstance() ;
	String proSql = "SELECT id,name from pro_products WHERE is_show=1 "+whereStr+"  order by name ";
	List<Map> productsList = dbHelper.getMapList(proSql);

	String proStr = "<option value=''>请选择产品</option>";
	if(productsList!=null && productsList.size()>0){
		for(Map p:productsList){
			String id = CommonString.getFormatPara(p.get("id"));
			String name = CommonString.getFormatPara(p.get("name"));
			proStr += "<option value='"+id+"'>"+name+"</option>";
		}
	}else{
		proStr = "<option value=''>暂无产品</option>";
	}
	
	out.println(proStr);
%>