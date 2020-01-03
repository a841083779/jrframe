<%@ page language="java" import="java.util.Date,java.io.File,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.JSONObject,org.apache.commons.io.FileUtils" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	Map catalogMap=(Map)application.getAttribute("catalogMap");

	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		
		//产品详细页面评论列表
		if("commentList".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
			String catalogname = CommonString.getFormatPara(request.getParameter("catalogname"));
			String sql = " select * from pro_comments where product_id = ? order by add_date desc,id desc ";	
			List <Map>list = dbHelper.getMapList(sql,new Object [] {id},connection);
			if(list != null && list.size() > 0){
				for(Map m : list){
					%>

<li> <strong class="l"><%=CommonString.getFormatPara(m.get("name"))%> 对 <%=factoryname%><%=name%><%=catalogname%> 的评论：</strong> <span class="r"><%=CommonString.getFormatPara(m.get("add_date")).length() >= 16?CommonString.getFormatPara(m.get("add_date")).substring(0,16):CommonString.getFormatPara(m.get("add_date"))%></span>
  <div class="clc"> <%=CommonString.getFormatPara(m.get("content"))%> </div>
</li>
<%	
				}
			}else{
			%>
			<div align="center"><strong>暂无评论</strong></div>
			<%
			}
		}
		
		//产品详细页面评论列表
		if("commentListNew".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
			String catalogname = CommonString.getFormatPara(request.getParameter("catalogname"));
			String sql = " select top 5 * from pro_comments where product_id = ? order by add_date desc,id desc ";	
			List <Map>list = dbHelper.getMapList(sql,new Object [] {id},connection);
			if(list != null && list.size() > 0){
				for(Map m : list){
					%>

<li> <strong class="l"><%=CommonString.getFormatPara(m.get("name"))%> 对 <%=factoryname%><%=name%><%=catalogname%> 的评论：</strong> <span class="r"><%=CommonString.getFormatPara(m.get("add_date")).length() >= 16?CommonString.getFormatPara(m.get("add_date")).substring(0,16):CommonString.getFormatPara(m.get("add_date"))%></span>
  <div class="clc"> <%=CommonString.getFormatPara(m.get("content"))%> </div>
</li>
<%	
				}
			}else{
			%>
			<div align="center"><strong>暂无评论</strong></div>
			<%
			}
		}
		
		
		//询价页面评论列表
		if("commentInquiryList".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String place = CommonString.getFormatPara(request.getParameter("place"));
			String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
			String catalogname = CommonString.getFormatPara(request.getParameter("catalogname"));
			String sql = " select top 5 name,add_date,content from pro_comments where product_id = ? and name like '%"+place+"%' order by add_date desc,id desc ";	
			List <Map>list = dbHelper.getMapList(sql,new Object [] {id},connection);
			if(list != null && list.size() > 0){
				for(Map m : list){
					%>

<li> <strong class="l"><%=CommonString.getFormatPara(m.get("name"))%> 对 <%=factoryname%><%=name%><%=catalogname%> 的评论：</strong> <span class="r"><%=CommonString.getFormatPara(m.get("add_date")).length() >= 16?CommonString.getFormatPara(m.get("add_date")).substring(0,16):CommonString.getFormatPara(m.get("add_date"))%></span>
  <div class="clc"> <%=CommonString.getFormatPara(m.get("content"))%> </div>
</li>
<%	
				}
			}
			else{%>
			暂无评论!
			<%
			}
		}
		
		//产品列表页左侧同类产品排行
		if("proSubLeft".equals(flag)){
			int catalog = CommonString.getFormatInt(request.getParameter("catalog"));
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String sql = " select top 4 file_name,name,factoryname,catalogname,img2,view_count from pro_products where catalognum like '"+catalog+"%' and (factoryname+name+catalogname like '%"+keyword+"%') and is_show = 1 order by view_count desc ";

			String cacheKey = "proSubLeft_"+catalog+keyword;
	%>
    <cache:cache key="<%=cacheKey%>" cron="* * */1 * *">
    <%
			List <Map>list = dbHelper.getMapList(sql,connection);
			for(int i = 0;list != null && i < list.size();i++){
					%>

<li>
  <a target="_blank" title='<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>' href="/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2")).toLowerCase()%>" width="80" height="70" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
  <h3><a title='<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>' target="_blank" href="/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></a><span style="color:#999999"> (<%=CommonString.getFormatPara(list.get(i).get("view_count"))%>)</span></h3>
</li>
<%	
			}
			%>
            </cache:cache>
            <%
		}
		
		//产品列表页左侧同类品牌排行
		if("brandSubLeft".equals(flag)){
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String sql = " select top 7 a.factoryid,a.factoryname,b.view_count,b.usern as usern from pro_products as a left join pro_agent_factory as b on a.factoryid = b.id where a.catalognum like '"+catalog+"%' and (a.factoryname+a.name+a.catalogname like '%"+keyword+"%') and a.is_show = 1 and a.factoryname<>'' and a.factoryname is not null group by a.factoryid,a.factoryname,b.view_count,b.usern order by b.view_count desc ";
			String cacheKey = "brandSubLeft_"+catalog+keyword;
	%>
    <%--<cache:cache key="<%=cacheKey%>" cron="*/1 * * * *">--%>
    <%
			List <Map>list = dbHelper.getMapList(sql,connection);
			for(int i = 0;list != null && i < list.size();i++){
					%>

<li <%if(i<=2){%> class="top3"<%}%>>
<em><%=i+1%></em><h4><a title='<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%>' target="_blank" href="/brand/<%=CommonString.getFormatPara(list.get(i).get("usern"))%>/"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%></a></h4></li>
<%	
			}
			%>
            <%--</cache:cache>--%>
            <%
		}
		
		//首页代理商查询区
		if("indexAgent".equals(flag)){
			List <Map>list = new ArrayList<Map>();
			String sql = "";
			String []areaArr = Common.getAreaInfoList(Common.getIp(request,1));//119.180.98.134
			if(areaArr == null || areaArr[0] == null || areaArr[1] == null){
				areaArr = Common.getAreaInfoList("119.180.98.134");	
			}
			String cacheKey = Common.getIp(request,1);
			%>
            <cache:cache key="<%=cacheKey%>" cron="* * * */1 *">
            <%			
			String area = "";
			if(areaArr != null && areaArr.length >= 2){
				area = areaArr[1];
				Integer agentCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory where flag = 2 and is_show = 1 and (city like '%"+area+"%' or address like '%"+area+"%') ");
				if(agentCount >= 9){
					sql = " select top 9 usern,agent_fac_name,full_name,telphone,address from pro_agent_factory where flag = 2 and is_show = 1 and (city like '%"+area+"%' or address like '%"+area+"%')  order by order_no,id desc ";
					list = dbHelper.getMapList(sql,connection); 	
				}else{
					area = areaArr[0];
					agentCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_factory where flag = 2 and is_show = 1 and (city like '%"+area+"%' or address like '%"+area+"%') ");
					if(agentCount >= 9){
						sql = " select top 9 usern,agent_fac_name,full_name,telphone,address from pro_agent_factory where flag = 2 and is_show = 1 and (city like '%"+area+"%' or address like '%"+area+"%')  order by order_no,id desc ";
						list = dbHelper.getMapList(sql,connection); 	
					}else{
						sql = " select top 9 usern,agent_fac_name,full_name,telphone,address from pro_agent_factory where flag = 2 and is_show = 1 and (city like '%"+area+"%' or address like '%"+area+"%')  order by order_no,id desc ";
						list = dbHelper.getMapList(sql,connection); 		
					}
				}
			}
%>
	<div class="title02">
      <h2>代理商查询</h2>
      <span><%if(!area.equals("")){%>您目前所在的 <font><%=area%></font> 地区代理商如下，<%}%><a target="_blank" style="cursor:pointer" onclick="window.open('/agent/list.jsp?city='+encodeURIComponent('<%=area%>'))"><b>点击查看更多！</b></a></span> </div>
    <ul class="list02">
    <%
		for(int i = 0;list != null && i < list.size();i++){
	%>
      <li class="lbg1">
        <div class="l1"><a href="/agent/<%=CommonString.getFormatPara(list.get(i).get("usern"))%>/" target="_blank">【<%=CommonString.getFormatPara(list.get(i).get("agent_fac_name"))%>代理商】</a></div>
        <div class="l2"><a href="/agent/<%=CommonString.getFormatPara(list.get(i).get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(list.get(i).get("full_name"))%></a></div>
        <div class="l3"><a href="/agent/<%=CommonString.getFormatPara(list.get(i).get("usern"))%>/" target="_blank">地址：<%=CommonString.getFormatPara(list.get(i).get("address"))%></a></div>
      </li>
     <%
		}
	 %> 
    </ul>
    </cache:cache>
<%
		}
				//代理商详细页面左侧-主营品牌(新)
		if("brandAgentCatalogListNew".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
			//查出代理商
			Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {agentid},connection);
			usern = CommonString.getFormatPara(agentMap.get("usern"));
			//如果代理商是办事处，则查询办事处上级
			if(!"".equals(CommonString.getFormatPara(agentMap.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(agentMap.get("parent_id")))){
				agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {CommonString.getFormatPara(agentMap.get("parent_id"))},connection);
				agentid = CommonString.getFormatPara(agentMap.get("id"));
			}
			String agent_fac = CommonString.getFormatPara(agentMap.get("agent_fac"));
			String[] agent_facs = null;
			if(!"".equals(agent_fac)){
				if(agent_fac.indexOf(",") > 0){
					agent_facs = agent_fac.split(",") ;
				}else{
					agent_facs = new String [] {agent_fac};
				}
			}

			
			//获得品牌信息
			Map map = null ;
			String sel_map = "select id,usern,name,logo from pro_agent_factory where id =?" ;
			List<Map> agentList = new ArrayList() ;
			if(null!=agent_facs && agent_facs.length>0){
				for(int i=0;i<agent_facs.length;i++){
					 if(agent_facs[i].trim()!=""){
						  map = dbHelper.getMap(sel_map,new Object[]{agent_facs[i]},connection);
					 }
					 agentList.add(map) ;
				}
			}
			String sql = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+agent_fac+"'  group by catalognum,catalogname order by catalognum ";
			List<Map> list = new ArrayList();
			if(null!=agentList&&agentList.size()>0){
				%>
				<div class="title11">
				  <h3>主营品牌</h3>
				</div> 
				<%
					if(null!=map&&!"".equals(CommonString.getFormatPara(map.get("logo")))){
						%><div class="agentLogo l"><img src="/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>" width="80" height="30" /></div><%
					}else{
						%><div class="agentLogo l"><img src="/images/nopic.gif" width="80" height="30" /></div><%
					} 
				%>
				<ul class="agentBrandTree">
				  <%
				  	if(agentList!=null && agentList.size()>0){
				  		for(Map oneMap : agentList){
				  			%>
				  			  <li><a target="_blank" href="/brand/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/"><%=CommonString.getFormatPara(oneMap.get("name"))%></a>
				  			<%
				  			String id = CommonString.getFormatPara(oneMap.get("id")) ; // id
				  			String sql2 = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+id+"'  group by catalognum,catalogname order by catalognum ";
				  			List<Map> list2 = null;
				  			list2 = dbHelper.getMapList(sql2) ;
				  			if(null!=list2 && list2.size()>0){
				  				%>
				  				<ul> 
				  				<%
				  				for(Map towMap:list2){
				  					%>
				  					 <li><a target="_blank" href="/products/prolist.jsp?catalog=<%=CommonString.getFormatPara(towMap.get("catalognum"))%>"><%=CommonString.getFormatPara(towMap.get("catalogname"))%></a></li>
				  					<%
				  				}
				  				%>
				  				</ul>
				  				<%
				  			}
				  		}
				  	}
				  %>
				</ul>
				<%
			}
		}
		//代理商详细页面左侧-主营品牌
		if("brandAgentCatalogList".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
			//查出代理商
			Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {agentid},connection);
			usern = CommonString.getFormatPara(agentMap.get("usern"));
			//如果代理商是办事处，则查询办事处上级
			if(!"".equals(CommonString.getFormatPara(agentMap.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(agentMap.get("parent_id")))){
				agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {CommonString.getFormatPara(agentMap.get("parent_id"))},connection);
				agentid = CommonString.getFormatPara(agentMap.get("id"));
			}
			String agent_fac = CommonString.getFormatPara(agentMap.get("agent_fac"));
			String[] agent_facs = null;
			if(!"".equals(agent_fac)){
				if(agent_fac.indexOf(",") > 0){
					agent_facs = agent_fac.split(",") ;
				}else{
					agent_facs = new String [] {agent_fac};
				}
			}

			
			//获得品牌信息
			Map map = null ;
			String sel_map = "select id,usern,name,logo from pro_agent_factory where id =?" ;
			List<Map> agentList = new ArrayList() ;
			if(null!=agent_facs && agent_facs.length>0){
				for(int i=0;i<agent_facs.length;i++){
					 if(agent_facs[i].trim()!=""){
						  map = dbHelper.getMap(sel_map,new Object[]{agent_facs[i]},connection);
					 }
					 agentList.add(map) ;
				}
			}
			String sql = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+agent_fac+"'  group by catalognum,catalogname order by catalognum ";
			List<Map> list = new ArrayList();
			if(null!=agentList&&agentList.size()>0){
				%>
				<div class="title11">
				  <h3>主营品牌</h3>
				</div> 
				<div class="agentLogo l">
				<%
				if(agentList!=null && agentList.size()>0){
			  		for(Map oneMap : agentList){
			  			String logo = CommonString.getFormatPara(oneMap.get("logo"));
						if(null!=logo&&!"".equals(logo)){
							%><img src="/uploadfiles/<%=logo%>" width="80" height="30" /><%
						}else{
							%><img src="/images/nopic.gif" width="80" height="30" /><%
						}
			  		}}
				%>
				</div>
				<ul class="agentBrandTree">
				  <%
				  	if(agentList!=null && agentList.size()>0){
				  		for(Map oneMap : agentList){
						    String id = CommonString.getFormatPara(oneMap.get("id")) ; // id
				  			%>
							  <li><a  href="/agent/agent_products.jsp?usern=<%=usern%>&factory=<%=id%>"><%=CommonString.getFormatPara(oneMap.get("name"))%></a>
				  			<%
				  			
				  			String sql2 = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+id+"'  group by catalognum,catalogname order by catalognum ";
				  			List<Map> list2 = null;
				  			list2 = dbHelper.getMapList(sql2) ;
				  			if(null!=list2 && list2.size()>0){
				  				%>
				  				<ul> 
				  				<%
				  				for(Map towMap:list2){
				  					%>
				  					 <li><a href="/agent/agent_products.jsp?usern=<%=usern%>&catalognum=<%=CommonString.getFormatPara(towMap.get("catalognum"))%>&factory=<%=id%>"><%=CommonString.getFormatPara(towMap.get("catalogname"))%></a></li>
				  					<%
				  				}
				  				%>
				  				</ul>
				  				<%
				  			}
				  		}
				  	}
				  %>
				</ul>
				<%
			}
		}
		//代理商详细页面左侧-主营品牌20150519
		if("brandAgentCatalogList_news".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
			//查出代理商
			Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {agentid},connection);
			usern = CommonString.getFormatPara(agentMap.get("usern"));
			//如果代理商是办事处，则查询办事处上级
			if(!"".equals(CommonString.getFormatPara(agentMap.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(agentMap.get("parent_id")))){
				agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {CommonString.getFormatPara(agentMap.get("parent_id"))},connection);
				agentid = CommonString.getFormatPara(agentMap.get("id"));
			}
			String agent_fac = CommonString.getFormatPara(agentMap.get("agent_fac"));
			String[] agent_facs = null;
			if(!"".equals(agent_fac)){
				if(agent_fac.indexOf(",") > 0){
					agent_facs = agent_fac.split(",") ;
				}else{
					agent_facs = new String [] {agent_fac};
				}
			}

			//获得品牌信息
			Map map = null ;
			String sel_map = "select id,usern,name,logo from pro_agent_factory where id =?" ;
			List<Map> agentList = new ArrayList() ;
			if(null!=agent_facs && agent_facs.length>0){
				for(int i=0;i<agent_facs.length;i++){
					 if(agent_facs[i].trim()!=""){
						  map = dbHelper.getMap(sel_map,new Object[]{agent_facs[i]},connection);
					 }
					 agentList.add(map) ;
				}
			}
			String sql = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+agent_fac+"'  group by catalognum,catalogname order by catalognum ";
			List<Map> list = new ArrayList();
			if(null!=agentList&&agentList.size()>0){
				%>
				<h3>
				<%
				if(agentList!=null && agentList.size()>0){
			  		for(Map oneMap : agentList){
			  			String logo = CommonString.getFormatPara(oneMap.get("logo"));
						if(null!=logo&&!"".equals(logo)){
							%><img src="/uploadfiles/<%=logo%>" width="80" height="30" /><%
						}else{
							%><img src="/images/nopic.gif" width="80" height="30" /><%
						}
			  		}}
				%>
				</h3>
				<ul class="agentBrandTree">
				  <%
				  	if(agentList!=null && agentList.size()>0){
				  		for(Map oneMap : agentList){
						    String id = CommonString.getFormatPara(oneMap.get("id")) ; // id
				  			%>
							  <li><a  href="/agent/agent_products.jsp?usern=<%=usern%>&factory=<%=id%>"><%=CommonString.getFormatPara(oneMap.get("name"))%></a>
				  			<%
				  			
				  			String sql2 = " select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid = '"+id+"'  group by catalognum,catalogname order by catalognum ";
				  			List<Map> list2 = null;
				  			list2 = dbHelper.getMapList(sql2) ;
				  			if(null!=list2 && list2.size()>0){
				  				%>
				  				<ul> 
				  				<%
				  				for(Map towMap:list2){
				  					%>
				  					 <li><a href="/agent/agent_products.jsp?usern=<%=usern%>&catalognum=<%=CommonString.getFormatPara(towMap.get("catalognum"))%>&factory=<%=id%>"><%=CommonString.getFormatPara(towMap.get("catalogname"))%></a></li>
				  					<%
				  				}
				  				%>
				  				</ul>
				  				<%
				  			}
				  		}
				  	}
				  %>
				</ul>
				<%
			}
		}
		//代理商旗舰店一详细页面左侧-代理产品
		if("brandAgentCatalogListShop".equals(flag)){ 
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			int agentid = CommonString.getFormatInt(request.getParameter("agentid"));
			String agent_fac = CommonString.getFormatPara(request.getParameter("agent_fac"));
			String agent_fac_name = CommonString.getFormatPara(request.getParameter("agent_fac_name"));
			if(agent_fac.indexOf(",") > 0){
				//agent_fac = agent_fac.substring(0,agent_fac.indexOf(","));
			}
			if(agent_fac_name.indexOf(",") > 0){
				agent_fac_name = agent_fac_name.substring(0,agent_fac_name.indexOf(","));
			}
			String []agent_fac_arr = agent_fac.split(",");
			
			for(int i = 0; agent_fac_arr != null && i < agent_fac_arr.length;i++){
			//获得品牌信息
			Map map = dbHelper.getMap("select usern,name,logo from pro_agent_factory where id = '"+agent_fac_arr[i]+"'",connection);
			if(null==map){
				map = new HashMap() ;
			}
			
			%>
<h3><img src='http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>' onerror="this.src='http://product.21-sun.com/uploadfiles/no_small.gif'" width='80' height='30'/></h3>
<ul class="agentBrandTree">
  <li><a target="_blank" href="/brand/<%=CommonString.getFormatPara(map.get("usern"))%>/"><%=CommonString.getFormatPara(map.get("name"))%></a>
    <ul>
      <%
	  	String sql = " select catalognum,catalogname from pro_agent_product_vi where catalogname is not null and catalogname<>'' and agentid = '"+agentid+"' and factoryid = '"+agent_fac_arr[i]+"'  group by catalognum,catalogname order by catalognum ";
		List <Map>list = dbHelper.getMapList(sql,connection);
  		String file_jsp = "agent_products.jsp" ; 
  		String refer = CommonString.getFormatPara(request.getHeader("referer")) ;
  		if(refer.indexOf(".product.21-sun.com")!=-1){
  			file_jsp = "agent_products.htm" ;
  		}
	  	if(list != null && list.size() > 0){
			for(Map m : list){
	  %>
      <li><a target="_blank" href="/agentshop/<%=file_jsp %>?usern=<%=usern%>&catalognum=<%=CommonString.getFormatPara(m.get("catalognum"))%>"><%=CommonString.getFormatPara(m.get("catalogname"))%></a></li>
      <%	
			}
		}
	  %>
    </ul>
  </li>
</ul>
<%
			}
		}
		//代理商旗舰店二详细页面左侧-代理产品
		if("brandAgentCatalogListShop2".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			int agentid = CommonString.getFormatInt(request.getParameter("agentid"));
			String agent_fac = CommonString.getFormatPara(request.getParameter("agent_fac"));
			String agent_fac_name = CommonString.getFormatPara(request.getParameter("agent_fac_name"));
			String shop_url = CommonString.getFormatPara(request.getParameter("shop_url")) ;
			if(agent_fac.indexOf(",") > 0){
				//agent_fac = agent_fac.substring(0,agent_fac.indexOf(","));
			}
			if(agent_fac_name.indexOf(",") > 0){
				agent_fac_name = agent_fac_name.substring(0,agent_fac_name.indexOf(","));
			}
			String []agent_fac_arr = agent_fac.split(",");
			
			for(int i = 0; agent_fac_arr != null && i < agent_fac_arr.length;i++){
			//获得品牌信息
			Map map = dbHelper.getMap("select usern,name,logo from pro_agent_factory where id = '"+agent_fac_arr[i]+"'",connection);
			if(null==map){ 
				map = new HashMap() ;
			}
			%>
<h3><img src="/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>" onerror="this.src='/uploadfiles/no_small.gif'" width="80" height="30"/></h3>
<ul class="agentBrandTree">
  <li><a href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(map.get("usern"))%>/"><%=CommonString.getFormatPara(map.get("name"))%></a>
    <ul>
      <% 
	  	String sql = "select catalognum from pro_products where id in( select id from pro_agent_product_vi where catalogname is not null and catalogname<>'' and agentid = '"+agentid+"' and factoryid = '"+agent_fac_arr[i]+"' )  group by catalognum  ";
		List <Map>list = dbHelper.getMapList(sql,connection);
	  	if(list != null && list.size() > 0){
			for(Map m : list){
	  %>
      <li><a target="_blank" href="/<%=shop_url %>/agent_products.jsp?usern=<%=usern%>&catalognum=<%=CommonString.getFormatPara(m.get("catalognum"))%>&factory=<%=agent_fac_arr[i] %>"><%=CommonString.getFormatPara(catalogMap.get(CommonString.getFormatPara(m.get("catalognum")))) %></a></li>
      <%	
			}
		}
	  %>
    </ul>
  </li>
</ul>
<%
			}
		}

		//代理商三级店铺一详细页面左侧-代理产品
		if("brandAgentCatalogListShop3".equals(flag)){ 
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
			String agent_fac = CommonString.getFormatPara(request.getParameter("agent_fac"));
			String agent_fac_name = CommonString.getFormatPara(request.getParameter("agent_fac_name"));
			if(agent_fac.indexOf(",") > 0){
				//agent_fac = agent_fac.substring(0,agent_fac.indexOf(","));
			}
			if(agent_fac_name.indexOf(",") > 0){
				agent_fac_name = agent_fac_name.substring(0,agent_fac_name.indexOf(","));
			}
			String []agent_fac_arr = agent_fac.split(",");
			
			for(int i = 0; agent_fac_arr != null && i < agent_fac_arr.length;i++){
			//获得品牌信息
			Map map = dbHelper.getMap("select usern,name,logo from pro_agent_factory where id = '"+agent_fac_arr[i]+"'",connection);
			if(null==map){
				map = new HashMap() ;
			}
			
			%>
<h3><img src='http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>' onerror="this.src='http://product.21-sun.com/uploadfiles/no_small.gif'" width='80' height='30'/></h3>
<ul class="agentBrandTree">
  <li><a target="_blank" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(map.get("usern"))%>/"><%=CommonString.getFormatPara(map.get("name"))%></a>
    <ul>
      <%
	  	String sql = " select catalognum,catalogname from pro_agent_product_vi where catalogname is not null and catalogname<>'' and agentid = '"+agentid+"' and factoryid = '"+agent_fac_arr[i]+"'  group by catalognum,catalogname order by catalognum ";
		List <Map>list = dbHelper.getMapList(sql,connection);
  		String file_jsp = "agent_products.htm" ; 
	  	if(list != null && list.size() > 0){
			for(Map m : list){
	  %>
      <li><a href="<%=file_jsp %>?usern=<%=usern%>&catalognum=<%=CommonString.getFormatPara(m.get("catalognum"))%>"><%=CommonString.getFormatPara(m.get("catalogname"))%></a></li>
      <%	
			}
		}
	  %>
    </ul>
  </li>
</ul>
<%
			}
		}
			//二手机显示
		if("usedListShop2".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			int agentid = CommonString.getFormatInt(request.getParameter("agentid"));
			String agent_fac = CommonString.getFormatPara(request.getParameter("agent_fac"));
			String agent_fac_name = CommonString.getFormatPara(request.getParameter("agent_fac_name"));
			String shop_url = CommonString.getFormatPara(request.getParameter("shop_url")) ;
			if(agent_fac.indexOf(",") > 0){
				//agent_fac = agent_fac.substring(0,agent_fac.indexOf(","));
			}
			if(agent_fac_name.indexOf(",") > 0){
				agent_fac_name = agent_fac_name.substring(0,agent_fac_name.indexOf(","));
			}
			String []agent_fac_arr = agent_fac.split(",");
			
			for(int i = 0; agent_fac_arr != null && i < agent_fac_arr.length;i++){
			//获得品牌信息
			Map map = dbHelper.getMap("select usern,name,logo from pro_agent_factory where id = '"+agent_fac_arr[i]+"'",connection);
			if(null==map){ 
				map = new HashMap() ;
			}
			%>
<h3><img src="/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>" onerror="this.src='/uploadfiles/no_small.gif'" width="80" height="30"/></h3>
<ul class="agentBrandTree">
  <li><a target="_blank" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(map.get("usern"))%>/"><%=CommonString.getFormatPara(map.get("name"))%></a>
    <ul>
      <% 
	  	String sql = " select count(*) as num,catalognum,catalogname from pro_products_used where catalogname is not null and catalogname<>'' and agentid = '"+agentid+"' and is_show=1 and factoryid = '"+agent_fac_arr[i]+"'  group by catalognum,catalogname order by catalognum ";
		List <Map>list = dbHelper.getMapList(sql,connection);
	  	if(list != null && list.size() > 0){
			for(Map m : list){
				 String catalogename= CommonString.getFormatPara(m.get("catalognum")).equals("101001001")?"履带式挖掘机":CommonString.getFormatPara(m.get("catalogname"));
	  %>
      <li><a target="_blank" href="/<%=shop_url %>/used_agent_products.jsp?usern=<%=usern%>&catalognum=<%=CommonString.getFormatPara(m.get("catalognum"))%>"><%=catalogename%>(<%=CommonString.getFormatPara(m.get("num"))%>)</a></li>
      <%	
			}
		}
	  %>
    </ul>
  </li>
</ul>



<%
			}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>