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
	Map keyParamMap = (Map) application.getAttribute("keyParamMap");
	Map paramListMap = (Map) application.getAttribute("paramListMap");
	Map salePolicyListMap = (Map) application.getAttribute("salePolicyListMap");
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		List <Map>list = null;
		List <Map>list1 = null;
		List <Map>list2 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
				
			Map<String,String> postMap = new HashMap<String,String>();
			list = dbHelper.getMapList(" select  id,catalognum,param  from pro_products  where id not in (select pro_id  from pro_main_param ) and is_show=1 and param is not null and DATALENGTH(param)>20   ");
			//list = dbHelper.getMapList(" select top 1000  id,catalognum,param  from pro_products  where param is not null and DATALENGTH(param)>20 and id not in (select top 14000  id from pro_products where  param is not null and DATALENGTH(param)>20 order by id desc) order by id desc  ");
			for(Map model:list){
			String catalognum = CommonString.getFormatPara(model.get("catalognum")) ;
            String param=CommonString.getFormatPara(model.get("param")) ;
            String id=CommonString.getFormatPara(model.get("id")) ;

             System.out.println("1233");
			//主要参数
			List <Map> categoryKeyList= dbHelper.getMapList(" select  id,name from pro_catalog_param  where  is_key=1 and parent_no='"+catalognum+"'  ");
			if(categoryKeyList==null&&catalognum.length()>6){
				categoryKeyList= dbHelper.getMapList(" select  id,name from pro_catalog_param where   parent_no='"+catalognum.substring(0,6)+"'  ");
			}
			if(categoryKeyList==null&&catalognum.length()>3){
				categoryKeyList= dbHelper.getMapList(" select  id,name from pro_catalog_param where  parent_no='"+catalognum.substring(0,3)+"'  ");
			}
			 System.out.println(categoryKeyList.size());
			
			//插入数据
			if(!param.equals("[]")&&!param.equals("")){
				
			JSONArray keyParaAry = new JSONArray(param); //关键参数列表
          		if(keyParaAry!=null && keyParaAry.length()>0){
					 String param_product_no="",param_id="",param_name="",param_type="",param_order_no="",param_enum_no="",param_value="";
					 int paramCount=1;
					 
				    for(int j=0;j<keyParaAry.length();j++){
						//System.out.println("44");
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
							 if(paramCount<=3&&!param_value.equals("")){
								 if(null != categoryKeyList && categoryKeyList.size()>0){
									 for(Map oneMap:categoryKeyList){
										if(CommonString.getFormatPara(oneMap.get("id")).equals(param_id)){
												String upt_sql = "insert into  pro_main_param (pro_id,param_name,param_id,param_value) values (?,?,?,?)" ;
		                                        dbHelper.execute(upt_sql,new Object[]{id,param_name,param_id,param_value}) ;
								                paramCount++;		
										 }
									 }
								 }
							 }
		
						}
					}
			}


				
			
		    }	
			out.println(list.size());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	%>