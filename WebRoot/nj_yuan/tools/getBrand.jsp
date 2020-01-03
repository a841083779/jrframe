<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String sql = "";
	List<Map> list=null;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String frist_catalog="";
	    if(catalog.equals("1")){frist_catalog="101";
		}else if(catalog.equals("32")){frist_catalog="102";
		}else if(catalog.equals("59")){frist_catalog="103";
		}else if(catalog.equals("104")){frist_catalog="104";
		}else if(catalog.equals("136")){frist_catalog="105";
		}else if(catalog.equals("150")){frist_catalog="106";
		}else if(catalog.equals("160")){frist_catalog="107";
		}else if(catalog.equals("186")){frist_catalog="109";
		}else if(catalog.equals("192")){frist_catalog="110";
		}else if(catalog.equals("199")){frist_catalog="111";
		}else if(catalog.equals("233")){frist_catalog="113";
		}else if(catalog.equals("365")){frist_catalog="118";
		}else if(catalog.equals("425")){frist_catalog="119";
		}else if(catalog.equals("430")){frist_catalog="120";
		}else if(catalog.equals("433")){frist_catalog="121";
		}
	try{
		connection = dbHelper.getConnection();
		 	sql= " select  name,num from pro_catalog where parentid!=0 and is_show=1  and  num in (select  catalognum from pro_products where len(catalognum)>3 and catalognum like '"+frist_catalog+"%' and factoryid="+factoryid+" and is_show=1  GROUP BY catalognum )";
			    list = dbHelper.getMapList(sql);
				if(list != null && list.size() > 0){
				%>
					<a href="javascript:void(0); return false;" data-val="">请选择产品类别</a>
				<%
				for(Map pro:list){
					String  num=CommonString.getFormatPara(pro.get("num"));
					String  name=CommonString.getFormatPara(pro.get("name"));
					%>
					<a href="javascript:void(0); return false;" data-val="<%=num%>"><%=name%></a>
					<%
					}
				}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>