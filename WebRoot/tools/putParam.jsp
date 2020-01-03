<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
DBHelper dbHelper = DBHelper.getInstance();
Connection conn = null;
Map proParamMap = (Map) application.getAttribute("proParamMap");
if(proParamMap==null){proParamMap=new HashMap();}

try{
	conn = dbHelper.getConnection();
	List<Map> list =dbHelper.getMapList(" select top 1000 id from pro_products where  factoryid=18936 ",conn);//is_create_mobile=0 and
	if(list!=null&&list.size()>0){
		for(Map m:list){
			String paramStr="";
			List <Map> paramList=(List<Map>)(proParamMap.get(CommonString.getFormatPara(m.get("id"))));
			if(paramList != null && paramList.size() > 0) {
				int num=0;
				for(Map param:paramList){

						num++;
						if(num<4){
							if(num<3){
								paramStr+=CommonString.getFormatPara(param.get("param_name"))+"："+CommonString.getFormatPara(param.get("param_value"))+";";
							}else{
								paramStr+=CommonString.getFormatPara(param.get("param_name"))+"："+CommonString.getFormatPara(param.get("param_value"));
							}
						}
					
					
					
					
					
					
				}
			}else{
				paramStr="暂无详细参数";
			}
			//dbHelper.execute(" update pro_products set part_param=?,is_create_mobile=1 where id=? ",new Object[]{paramStr,CommonString.getFormatPara(m.get("id"))},conn);
			out.print(CommonString.getFormatPara(m.get("id"))+";");
		}
	}
	
} catch (Exception ex) {
	ex.printStackTrace();
} finally {
	dbHelper.freeConnection(conn);
}
   
%>