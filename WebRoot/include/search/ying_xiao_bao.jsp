<%@ page language="java" import="java.util.*,com.jerehnet.pool.*,java.sql.Connection,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String keywords = CommonString.getFormatPara(request.getParameter("keywords"));
	try{
		connection =  dbHelper.getConnection();
		String sql = " ";
		Object [] pArr = WEBServiceUtil.executeDynamic("Area","getMyProvinceAndCity",new Object [] {
				Common.getIp(request)
			});
		String city = "";
		String objStr = (String)pArr[0];
		JSONObject obj = new JSONObject(objStr);
		if(null!=obj&&obj.length()>0){
			city = CommonString.getFormatPara(obj.getString("city"));
		}
		if(!"".equals(city)){
						
			sql += " SELECT TOP 3 a.factoryid,a.factoryname,a.catalognum,a.catalogname,a.name,a.file_name,";
			sql += " a.introduce as intro,a.id,a.img2 ";
			sql += " FROM pro_products a ";
			sql += " WHERE id IN( ";
			sql += " SELECT pp.id ";
			sql += " FROM pro_agent_ad_position paap ";
			sql += " INNER JOIN pro_products pp ON pp.id = paap.product_id AND (pp.factoryname+pp.name+pp.catalogname) LIKE '%"+keywords+"%' ";
			sql += " INNER JOIN pro_agent_factory paf ON paap.agent_id = paf.id AND paf.is_shop = 3 and paf.flag = 2 ";
			sql += " INNER JOIN pro_agent_factory_and_area pafaa ON pafaa.agent_id = paf.id ";
			sql += " INNER JOIN comm_area ca ON pafaa.area_id = ca.area_id AND ca.area_name LIKE '%"+city+"%' ";
			sql += " WHERE paap.position = 0 ";
			sql += " UNION ";
			sql += " SELECT pp.id ";
			sql += " FROM pro_agent_ad_position paap ";
			sql += " INNER JOIN pro_products pp ON pp.id = paap.product_id AND (pp.factoryname+pp.name+pp.catalogname) LIKE '%"+keywords+"%' ";
			sql += " INNER JOIN pro_agent_factory paf ON paap.agent_id = paf.id AND paf.is_shop = 3 and paf.flag = 1 ";
			sql += " WHERE paap.position = 0 ";
			sql += " ) ";
			sql += " ORDER BY newid() ";
			
			List<Map> adList = dbHelper.getMapList(sql,connection);
			if(null!=adList){
				%>

				<%
				String title = "";
				String showTitle="";
				String url = "";
				String intro = "";
				String fileName = "";
				String img = "";
				String picFileName = "";
				String orderFileName = "";
				for(Map m : adList){
					title = CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"));
					showTitle=title;
					title = title.replaceAll(keywords,"<span class='red'>"+keywords+"</span>");
					intro = CommonString.substringByte(CommonString.getFormatPara(m.get("intro")),160,true)+"...";
					fileName = "http://product.21-sun.com/proDetail/"+CommonString.getFormatPara(m.get("file_name"));
					img = "http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(m.get("img2"));
					picFileName = fileName.replaceAll(".shtm","_pic.shtm");
					orderFileName = fileName.replaceAll(".shtm","_order.shtm");
					%>
					
	  <li class=  "pro">
          <div class="proimg"> <a target="_blank" href="<%=fileName%>" title="<%=showTitle%>"> <img title="<%=showTitle%>" alt="<%=showTitle%>" onerror="this.src='/uploadfiles/no_big.gif'" src="<%=img%>" width="131" height="90"> </a> </div>
          <div class="prointro">
            <h3><a title="<%=showTitle%>" target="_blank" href="<%=fileName%>" ><%=title%></a> <span class="proLinks">【<a title="<%=title%>参数" target="_blank" href="<%=fileName.replace(".shtm","")%>_parameter.shtm" >参数</a>】【<a title="<%=title%>图片" target="_blank" href="<%=fileName.replace(".shtm","")%>_pic.shtm" >图片</a>】【<a target="_blank" title="<%=title%>询价" href="<%=fileName.replace(".shtm","")%>_order.shtm"><font>询价</font></a>】</span></h3>
            <span class="sc"><%=intro%></span>
            <div class="site"> <a target="_blank" href="<%=fileName%>" style="color: #4D9724;"><%=fileName%></a> </div>
          </div>
        </li>			
					

					<%
				}
				%>

				<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>