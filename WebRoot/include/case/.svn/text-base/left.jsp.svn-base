<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* */1 * * *"> 
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String order_sql = " select top 7 id,factoryname , cataname,name,product_name,contact_address,add_date from pro_product_form order by add_date desc" ;  // 查询出最新的7条订单
	String products_sql = " select top 5 factoryname,name,catalogname,view_count,img2,file_name from pro_products order by view_count desc" ;// 产品观注度
	List<Map> orderList = null ;
	List<Map> productsList = null ;
	orderList = dbHelper.getMapList(order_sql) ;
    productsList = dbHelper.getMapList(products_sql) ;
%>
 <div class="caseLeft">
      <div class="newxunjia">
        <div class="casetitle01">
          <h3>最新询价单</h3>
          <span class="more"><a href="/inquiry/" target="_blank">更多&gt;</a></span> 
        </div>
        <div class="caselist01">
          <ul>
          <%
          	if(orderList!=null && orderList.size()>0){
          		for(Map oneMap:orderList){
          			%>
          			 <li> <span class="ltitle"><%=CommonString.getFormatPara(oneMap.get("contact_address")).toLowerCase().replace("null","") %>的 <%=CommonString.getFormatPara(oneMap.get("name")).length()>0?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"**":"王**" %> 询：</span> <span class="r"><%=CommonDate.getFormatDate("MM-dd",oneMap.get("add_date")) %></span> <span class="linfo"> <a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><font title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("product_name")) +CommonString.getFormatPara(oneMap.get("cataname"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("product_name")) +CommonString.getFormatPara(oneMap.get("cataname"))%></font>的价格</a></span> </li>
          			<%
          		}
          	}
          %>
          </ul>
        </div>
      </div>
      <div class="border02 l leftPart02 mb10">
        <div class="casetitle01">
          <h3>产品关注排行</h3>
          <span class="more"><a href="/top_list/" target="_blank">更多&gt;</a></span> 
        </div>
        <ul class="list03" id="proSubLeftId">
        <%
        	if(null!=productsList && productsList.size()>0){
        		for(Map oneMap:productsList){
        			%>
		        	<li> <a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"><img width="80" height="70" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a>
		            <h3><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a><span style="color:#999999"> (<%=CommonString.getFormatPara(oneMap.get("view_count")) %>)</span></h3>
		            </li>
        			<%
        		}
        	}
        %>
        </ul>
      </div>
    </div>
    </cache:cache>
