<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="org.apache.solr.common.SolrDocumentList"%>
<%@ page import="org.apache.solr.common.SolrDocument"%>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@ page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * * */3 *">
<%
DBHelper dbHelper = DBHelper.getInstance() ;
%>
<%
String catalognum = CommonString.getFormatInt(request.getParameter("catalognum")).toString();
catalognum = CommonString.getFilterStr(catalognum);
if(catalognum.equals("0")){
	catalognum = "101001";
}
List<Map> recommend_brands = null;
//String[] catalognumarr = {"101001","101002","102","101003","103","106001","101005","105003","113001","104001"};
String[] catalognumarr = {"101001","101002","102","101003","103","106001","105003","113001","104001"};

%>
<div class="comBox01">
      <div class="hd">
        <ul class="idTabs">
          <li><a href="#area101001" class="selected" >挖掘机</a></li>
          <li><a href="#area101002" >装载机</a></li>
          <li><a href="#area102" >起重机</a></li>
          <li><a href="#area101003" >推土机</a></li>
          <li><a href="#area103">混凝土</a></li>
          <li><a href="#area106001" >压路机</a></li>
		  <!-- 
          <li><a href="#area101005" >平地机</a></li>
		  -->
          <li><a href="#area105003" >旋挖钻</a></li>
          <li><a href="#area113001" >破碎锤</a></li>
          <li><a href="#area104001" >摊铺机</a></li>
        </ul>
      </div>
      <div class="bd">
      
      <%
      for (int j=0;j<catalognumarr.length;j++){
	 	 recommend_brands = dbHelper.getMapList("select factoryid,factoryname,catalogname,catalognum from pro_catalog_factory "+
	 		 	"where id in ("+
	 		 	"select min(id) from pro_catalog_factory group by factoryid) and catalognum like '%"+ catalognumarr[j] +"%'");
	 	 %>
      
        <div class="allcity fix" id="area<%=catalognumarr[j]%>">
          <ul class="ConditionBottom fix">
            <script type="text/javascript">
	  jQuery(document).ready(function() {
		  jQuery(".pbtn").click(function(){
			  jQuery(this).next("div").slideToggle(0)
			  .siblings(".plmore:visible").slideUp(0);
			  jQuery(this).toggleClass("pbon");
			  jQuery(this).siblings(".pbon").removeClass("pbon");
		  });	
	  });
	  </script>
            <li class="cblist">
              <dt> 品牌 </dt>
                        <dd>
<%
		if (null != recommend_brands && recommend_brands.size() > 0) {
			%>
            <span class="pl" style="height:20px; overflow:hidden;">
			<%
			for (int i = 0; i<recommend_brands.size();i++) {
				if(i==10){break;}
%>  
     <a href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(recommend_brands.get(i).get("factoryid"))%>&catalog=<%=catalognumarr[j]%>" title="<%=CommonString.getFormatPara(recommend_brands.get(i).get("factoryname"))%>" ><%=CommonString.getFormatPara(recommend_brands.get(i).get("factoryname"))%></a>
<%
			}
%>
             </span>
            <div style="cursor: pointer; position: absolute; right: 10px; top: 16px; height: 16px; margin-top: 0px; width: 86px;">
			<span class="more"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=<%=catalognumarr[j]%>" title="更多品牌">更多 &gt;&gt;</a></span>
			</div>

<%
	}
%>
          </dd>
            </li>
          </ul>
        </div>
        
        <%} %>
        
      </div>
    </div>       
  </cache:cache>	
