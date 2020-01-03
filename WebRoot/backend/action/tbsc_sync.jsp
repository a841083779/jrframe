<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%
	String event = CommonString.getFormatPara(request.getParameter("eventAfter"));
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String [] eventArr = event.split(",");
	List<String> eventList =Arrays.asList(eventArr);
	DBHelper dbHelper = DBHelper.getInstance();
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Connection connection = null;
	Map model = null;
	List <Map>list = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		
		//参数
		List <Map> categoryKeyList=dbHelper.getMapList(" select id,name   from pro_catalog_param where is_key=1 "); //参数再分类别
		Map parmaMainMap = new HashMap();
        String paramIds="";
			String param="[{'product_no':'107011' ,'no':'296' , 'name':'总长度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'107011' ,'no':'297' , 'name':'总宽度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'1225'},{'product_no':'107011' ,'no':'298' , 'name':'总高度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''},{'product_no':'107011' ,'no':'299' , 'name':'整机重量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'4270'},{'product_no':'107011' ,'no':'300' , 'name':'载荷中心距' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'500'},{'product_no':'107011' ,'no':'301' , 'name':'额定起重量' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'3000'},{'product_no':'107011' ,'no':'302' , 'name':'起升高度' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':'3000'},{'product_no':'107011' ,'no':'303' , 'name':'最小转弯半径' , 'type':'1', 'order_no':'0' , 'enum_no':'0' ,'value':''}]" ;
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
							 if(paramCount<=6){
								 if(null != categoryKeyList && categoryKeyList.size()>0){
									 for(Map oneMap:categoryKeyList){
										if(CommonString.getFormatPara(oneMap.get("id")).equals(param_id)){
											    if(param_value.equals("")){param_value="--";}
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
			for(Map m:paramList){
				if(!"".equals(CommonString.getFormatPara(m.get("param_value")))){
					int i=dbHelper.execute(" insert into param_import(param_id,param_value,goods_id,temp_param_name) values ('"+CommonString.getFormatPara(m.get("param_id"))+"','"+CommonString.getFormatPara(m.get("param_value"))+"',119570,'"+CommonString.getFormatPara(m.get("param_name"))+"') ");
				}
			}
			
			
			
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	request.getRequestDispatcher("/backend/action/after_own.jsp").forward(request,response);
%>
