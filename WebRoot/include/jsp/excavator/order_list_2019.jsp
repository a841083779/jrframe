<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.manage.*,com.jerehnet.util.common.CommonString" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
//接收参数
String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
DBHelper dbHelper = DBHelper.getInstance();
Connection connection = null;
List<Map> orderList = null;
int index = 1;
try{
	connection = PoolManager.getConnection(DBType.WEB21SUN);
	String orderSql = "SELECT TOP 4 pro_product_form.id,pro_product_form.factoryname,pro_product_form.cataname,pro_product_form.product_name,CONVERT(varchar(100), pro_product_form.add_date, 120) AS add_date,pro_products.img2,contact_address FROM pro_product_form LEFT JOIN pro_products ON pro_product_form.product_id = pro_products.id WHERE is_deleted=0 AND catanum ='101001001' ORDER BY pro_product_form.add_date desc";
	orderList = dbHelper.getMapList(orderSql,connection);
	if(orderList!=null && orderList.size()>0){	
		for(Map m:orderList){
			String id =  CommonString.getFormatPara(m.get("id"));
			String factoryName =  CommonString.getFormatPara(m.get("factoryname"));
			String productName =  CommonString.getFormatPara(m.get("product_name"));
			productName = productName.replace("^r","®").replace("^R","®");
			String cataName =  CommonString.getFormatPara(m.get("cataname"));
			String addDate = CommonString.getFormatPara(m.get("add_date"));
			String img = CommonString.getFormatPara(m.get("img2"));
			String contact_address = CommonString.getFormatPara(m.get("contact_address"));
	        String reg = "(\\d{4})(\\d{2})(\\d{2})(\\d{2})(\\d{2})(\\d{2})";
	        addDate = addDate.replace("-","").replace(" ","").replace(":","").replaceAll(reg, "$2.$3  $4:$5");

			if(index==1){
%>
			<a title="<%=factoryName %><%=productName %><%=cataName %>" target="_blank" href="http://product.21-sun.com/inquiry/detail_for_<%=id %>.htm" class="item top">
				<div class="datetime"><%=addDate %></div>
				<div class="area"><%=contact_address %></div>
				<div class="machine"><%=factoryName %><%=productName %><%=cataName %></div>
				<img src="http://product.21-sun.com/uploadfiles<%= img%>" alt="<%=factoryName %><%=productName %><%=cataName %>" class="pic">
			</a>
<%			
			}else{
%>
			<a title="<%=factoryName %><%=productName %><%=cataName %>" target="_blank" href="http://product.21-sun.com/inquiry/detail_for_<%=id %>.htm" class="item">
				<div class="datetime"><%=addDate %></div>
				<div class="desc">
					<span class="area"><%=contact_address %></span> <span class="machine"><%=factoryName %><%=productName %><%=cataName %></span>
				</div>
			</a>
<%
			}
   			index++;
		}
  	} 
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBHelper.freeConnection(connection);
}
%>