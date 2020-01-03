<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	// 无参数的数据，把从表中的查询出来，导入到paras
	DBHelper dbHelper = DBHelper.getInstance() ;
    Connection connection = null;
    List<Map> sub = null;
	StringBuffer paras = null;
	try{
		connection = dbHelper.getConnection();
		List<Map> list = dbHelper.getMapList(" select id,name from pro_products where is_show = 1 and factoryid = '174' and name like '%320D 320D L%'  ") ;
		ArrayList <Map>tempArr = new ArrayList<Map>();
		if(null != list && list.size()>0){
			for(Map model:list){
				
				//查询从表语句
				String subSql = "select num,name,unit,para_value from pro_product_parameter_name,pro_product_parameter where "+
				"pro_product_parameter_name.id=pro_product_parameter.para_name_id and pro_product_parameter.product_id= "+model.get("id")+" group by num,name,unit,para_value order by num";				 
				Common.println(subSql);
				sub = dbHelper.getMapList(subSql,connection);
				String tpNum = "";
				for(int i = 0; sub!=null && i<sub.size();++i){
					if ((sub.get(i).get("num").toString().length() > 3)
							&& ((CommonString.getFormatPara(sub.get(i).get("para_value")).equals("")))) {
						continue;
					}
					if ((i > 0) && ((sub.get(i).get("num").toString().length() == 3)
							&& (tpNum.length() == 3))) {
						tempArr.remove(tempArr.size() - 1);
						tpNum = sub.get(i).get("num").toString();
					} else {
						tpNum = sub.get(i).get("num").toString();
					}

					tempArr.add(sub.get(i));
				}
				paras = new StringBuffer();
				paras.append("<table width=\"97%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"table17\" style=\"margin:0 auto 7px;\" ><tr><td style=\"padding:2px;border:1px solid #D4D4D4\"><table cellSpacing=\"0\" cellPadding=\"3\" width=\"100%\" border=\"0\" id=\"table18\">");
				for(int i = 0; tempArr!=null && i<tempArr.size();i++){
					if(tempArr.get(i).get("num").toString().length() == 3){
						paras.append("<tr bgColor=\"#e6e6e6\"><td align=\"left\" nowrap=\"nowrap\" style=\"text-indent:25px\"><b>"+tempArr.get(i).get("name").toString()+"</b></td><td align=\"left\">　</td></tr>");
					}else{
						paras.append("<tr bgColor=\"#f7f7f7\"><td align=\"left\" nowrap=\"nowrap\" style=\"text-indent:25px\">"+tempArr.get(i).get("name").toString()+"</td><td align=\"left\">"+tempArr.get(i).get("para_value").toString()+"</td></tr>");
					}
				}
				paras.append("</table></td></tr></table>");
				Common.println(paras.append(paras).toString());
				//执行更新语句
			    String updateSql = " update pro_products set paras = '"+paras.toString()+"' where id = '"+model.get("id")+"' ";
				//dbHelper.execute(updateSql, connection);
				
				paras = null;
			}
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	out.println("ok") ;
%>
