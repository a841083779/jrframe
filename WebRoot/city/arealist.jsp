<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="org.apache.solr.common.SolrDocumentList"%>
<%@ page import="org.apache.solr.common.SolrDocument"%>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@ page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * * */1 *">

<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	//获取地区参数,用的是地区的拼音
	String[] pinyin_indexArr = {"A","B","C","D","E","F","G","H","I","G","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
	List<Map> hotcitypyList1 = (List<Map>)dbHelper.getMapList("select SUBSTRING(dbo.getPinYin(a.name),0,2)as pinyin_index,a.name,a.num,"+
	"a.parent_num,a.areapy,b.areapy as parent_areapy "+
	"from pro_agent_province_city a left join pro_agent_province_city b "+
	"on a.parent_num = b.num "+
	"order by SUBSTRING(dbo.getPinYin(a.name),0,2) asc") ;
	
	String citys2 = "'北京','天津','山东','河北','山西','内蒙古'";
	String sqlnei2 = "select num from pro_agent_province_city where name in("+citys2+")";
	List<Map> hotproviencepyList2 = (List<Map>)dbHelper.getMapList("select name,num,parent_num,areapy from pro_agent_province_city where parent_num = '0' and num in("+sqlnei2+")") ;
//	List<Map> hotcitypyList2 = (List<Map>)dbHelper.getMapList("select name,num,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei2+")") ;
	List<Map> hotcitypyList2 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei2+")") ;
	
	String citys3 = "'上海','江苏','浙江','安徽'";
	String sqlnei3 = "select num from pro_agent_province_city where name in("+citys3+")";
	List<Map> hotproviencepyList3 = (List<Map>)dbHelper.getMapList("select name,num,parent_num,areapy from pro_agent_province_city where parent_num = '0' and num in("+sqlnei3+") ") ;
//	List<Map> hotcitypyList3 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei3+") ") ;
	List<Map> hotcitypyList3 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei3+") ") ;
	
	String citys4 = "'广东','福建','广西','江西','海南'";
	String sqlnei4 = "select num from pro_agent_province_city where name in("+citys4+")";
	List<Map> hotproviencepyList4 = (List<Map>)dbHelper.getMapList("select name,num,parent_num,areapy from pro_agent_province_city where parent_num = '0' and num in("+sqlnei4+") ") ;
//	List<Map> hotcitypyList4 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei4+")") ;
	List<Map> hotcitypyList4 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei4+")") ;
	
	String citys5 = "'河南','湖北','湖南'";
	String sqlnei5 = "select num from pro_agent_province_city where name in("+citys5+")";
	List<Map> hotproviencepyList5 = (List<Map>)dbHelper.getMapList("select name,num,parent_num,areapy from pro_agent_province_city where parent_num = '0' and num in("+sqlnei5+") ") ;
//	List<Map> hotcitypyList5 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei5+")") ;
	List<Map> hotcitypyList5 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei5+")") ;
	
	String citys6 = "'辽宁','吉林','黑龙江'";
	String sqlnei6 = "select num from pro_agent_province_city where name in("+citys6+")";
	List<Map> hotproviencepyList6 = (List<Map>)dbHelper.getMapList("select name,num,parent_num,areapy from pro_agent_province_city where parent_num = '0' and num in("+sqlnei6+") ") ;
//	List<Map> hotcitypyList6 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei6+")") ;
	List<Map> hotcitypyList6 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and parent_num in("+sqlnei6+")") ;
	
	String citys7 = "'重庆','四川','贵州','云南','西藏'";
	String sqlnei7 = "select num from pro_agent_province_city where name in("+citys7+")";
	List<Map> hotproviencepyList7 = (List<Map>)dbHelper.getMapList("select name,num,parent_num,areapy from pro_agent_province_city where parent_num = '0' and num in("+sqlnei7+") ") ;
//	List<Map> hotcitypyList7 = (List<Map>)dbHelper.getMapList("select name,num,parent_num from pro_agent_province_city where parent_num <> '0' and num in("+sqlnei7+") or parent_num in("+sqlnei7+")") ;
	List<Map> hotcitypyList7 = (List<Map>)dbHelper.getMapList("select name,num,parent_num from pro_agent_province_city where parent_num <> '0' and num in("+sqlnei7+") or parent_num in("+sqlnei7+")") ;
	
	String citys8 = "'陕西','甘肃','青海','宁夏','新疆'";
	String sqlnei8 = "select num from pro_agent_province_city where name in("+citys8+")";
	List<Map> hotproviencepyList8 = (List<Map>)dbHelper.getMapList("select name,num,parent_num,areapy from pro_agent_province_city where parent_num = '0' and num in("+sqlnei8+") ") ;
//	List<Map> hotcitypyList8 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and num in("+sqlnei8+") or parent_num in("+sqlnei8+")") ;
	List<Map> hotcitypyList8 = (List<Map>)dbHelper.getMapList("select name,num,areapy,parent_num from pro_agent_province_city where parent_num <> '0' and num in("+sqlnei8+") or parent_num in("+sqlnei8+")") ;
%>

  <div class="comBox01">
    <div class="hd">
      <ul class="idTabs">
        <li><a href="#area01" class="selected">全国</a></li>
        <li><a href="#area02">华北地区</a></li>
        <li><a href="#area03">华东地区</a></li>
        <li><a href="#area04">华南地区</a></li>
        <li><a href="#area05">华中地区</a></li>
        <li><a href="#area06">东北地区</a></li>
        <li><a href="#area07">西南地区</a></li>
        <li><a href="#area08">西北地区</a></li>
      </ul>
    </div>
    <div class="bd">
      <div class="allcity" id="area01">
            <div class="letterGuide">
          <div class="city_zimu">
            <ul class="zimu">
              <li><a href="#A">A</a></li>
              <li><a href="#B">B</a></li>
              <li><a href="#C">C</a></li>
              <li><a href="#D">D</a></li>
              <li><a href="#E">E</a></li>
              <li><a href="#F">F</a></li>
              <li><a href="#G">G</a></li>
              <li><a href="#H">H</a></li>
              <li>I</li>
              <li><a href="#J">J</a></li>
              <li><a href="#K">K</a></li>
              <li><a href="#L">L</a></li>
              <li><a href="#M">M</a></li>
              <li><a href="#N">N</a></li>
              <li><a href="#O">O</a></li>
              <li><a href="#P">P</a></li>
              <li><a href="#Q">Q</a></li>
              <li><a href="#R">R</a></li>
              <li><a href="#S">S</a></li>
              <li><a href="#T">T</a></li>
              <li>U</li>
              <li>V</li>
              <li><a href="#W">W</a></li>
              <li><a href="#X">X</a></li>
              <li><a href="#Y">Y</a></li>
              <li><a href="#Z">Z</a></li>
            </ul>
          </div>
        </div>
        <div class="zimucity">
        <%for(int j=0 ;j<pinyin_indexArr.length;j++){ %>
          <dl>
            <dt>
              <label id="<%=pinyin_indexArr[j]%>"><%=pinyin_indexArr[j]%></label>
            </dt>
            <dd>
              <ul>
		<%
		if (null != hotcitypyList1 && hotcitypyList1.size() > 0) {
			for (int i=0;i<hotcitypyList1.size();i++) {
				String pinyin_index = CommonString.getFormatPara(hotcitypyList1.get(i).get("pinyin_index"));
				String name = CommonString.getFormatPara(hotcitypyList1.get(i).get("name"));
				String num = CommonString.getFormatPara(hotcitypyList1.get(i).get("num"));
				String parent_num = CommonString.getFormatPara(hotcitypyList1.get(i).get("parent_num"));
				String areapy = CommonString.getFormatPara(hotcitypyList1.get(i).get("areapy"));
				String parent_areapy = CommonString.getFormatPara(hotcitypyList1.get(i).get("parent_areapy"));
				if(parent_areapy == null){
					parent_areapy = areapy;
				}
				if(pinyin_index.equals(pinyin_indexArr[j]) ){
		%>
				<li><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></li>
		<%}}}%>
              </ul>
            </dd>
          </dl>
    <%}%>    
          
        </div>
      </div>
	  
	  
      <div class="areabox" id="area02" >
		<%
		if (null != hotproviencepyList2 && hotproviencepyList2.size() > 0) {
			for (Map m:hotproviencepyList2) {
				String name = CommonString.getFormatPara(m.get("name"));
				String num = CommonString.getFormatPara(m.get("num"));
				String provience_parent_areapy = CommonString.getFormatPara(m.get("areapy"));
				String provience_parent_num = CommonString.getFormatPara(m.get("parent_num"));
		%>
       <div class="onearea lastarea">
		<%if (provience_parent_num.equals("0")) { %>
        <h5><span><a href="http://city.21-sun.com/<%=provience_parent_areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></span><i></i></h5>
		<%} %>
		<dl>
        <%
		if (null != hotcitypyList2 && hotcitypyList2.size() > 0) {
			for (Map n:hotcitypyList2) {
				String cityname = CommonString.getFormatPara(n.get("name"));
				String citynum = CommonString.getFormatPara(n.get("num"));
				String parent_num = CommonString.getFormatPara(n.get("parent_num"));
				String areapy = CommonString.getFormatPara(n.get("areapy"));
			if (parent_num.equals(num)) {
        	citynum = parent_num;
        %>
			<dt><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=cityname%>"><%=cityname%></a></dt>
        <%}}}%>	
        </dl>
        </div>
		<%}}%>	
      </div>
      
	  
 <div class="areabox" id="area03" >
		<%
		if (null != hotproviencepyList3 && hotproviencepyList3.size() > 0) {
			for (Map m:hotproviencepyList3) {
				String name = CommonString.getFormatPara(m.get("name"));
				String num = CommonString.getFormatPara(m.get("num"));
				String provience_parent_num = CommonString.getFormatPara(m.get("parent_num"));
				String provience_parent_areapy = CommonString.getFormatPara(m.get("areapy"));
		%>
       <div class="onearea lastarea">
		<%if (provience_parent_num.equals("0")) { %>
        <h5><span><a href="http://city.21-sun.com/<%=provience_parent_areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></span><i></i></h5>
		<%} %>
		<dl>
        <%
		if (null != hotcitypyList3 && hotcitypyList3.size() > 0) {
			for (Map n:hotcitypyList3) {
				String cityname = CommonString.getFormatPara(n.get("name"));
				String citynum = CommonString.getFormatPara(n.get("num"));
				String parent_num = CommonString.getFormatPara(n.get("parent_num"));
				String areapy = CommonString.getFormatPara(n.get("areapy"));
			if (parent_num.equals(num)) {
        	citynum = parent_num;
        %>
			<dt><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=cityname%>"><%=cityname%></a></dt>
        <%}}}%>	
        </dl>
        </div>
		<%}}%>	
      </div>
      
 	  
      <div class="areabox" id="area04" >
		<%
		if (null != hotproviencepyList4 && hotproviencepyList4.size() > 0) {
			for (Map m:hotproviencepyList4) {
				String name = CommonString.getFormatPara(m.get("name"));
				String num = CommonString.getFormatPara(m.get("num"));
				String provience_parent_num = CommonString.getFormatPara(m.get("parent_num"));
				String provience_parent_areapy = CommonString.getFormatPara(m.get("areapy"));
		%>
       <div class="onearea lastarea">
		<%if (provience_parent_num.equals("0")) { %>
        <h5><span><a href="http://city.21-sun.com/<%=provience_parent_areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></span><i></i></h5>
		<%} %>
		<dl>
        <%
		if (null != hotcitypyList4 && hotcitypyList4.size() > 0) {
			for (Map n:hotcitypyList4) {
				String cityname = CommonString.getFormatPara(n.get("name"));
				String citynum = CommonString.getFormatPara(n.get("num"));
				String parent_num = CommonString.getFormatPara(n.get("parent_num"));
				String areapy = CommonString.getFormatPara(n.get("areapy"));
			if (parent_num.equals(num)) {
        	citynum = parent_num;
        %>
			<dt><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=cityname%>"><%=cityname%></a></dt>
        <%}}}%>	
        </dl>
        </div>
		<%}}%>	
      </div>
      
 	  
       <div class="areabox" id="area05" >
		<%
		if (null != hotproviencepyList5 && hotproviencepyList5.size() > 0) {
			for (Map m:hotproviencepyList5) {
				String name = CommonString.getFormatPara(m.get("name"));
				String num = CommonString.getFormatPara(m.get("num"));
				String provience_parent_areapy = CommonString.getFormatPara(m.get("areapy"));
				String provience_parent_num = CommonString.getFormatPara(m.get("parent_num"));
		%>
       <div class="onearea lastarea">
		<%if (provience_parent_num.equals("0")) { %>
        <h5><span><a href="http://city.21-sun.com/<%=provience_parent_areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></span><i></i></h5>
		<%} %>
		<dl>
        <%
		if (null != hotcitypyList5 && hotcitypyList5.size() > 0) {
			for (Map n:hotcitypyList5) {
				String cityname = CommonString.getFormatPara(n.get("name"));
				String citynum = CommonString.getFormatPara(n.get("num"));
				String parent_num = CommonString.getFormatPara(n.get("parent_num"));
				String areapy = CommonString.getFormatPara(n.get("areapy"));
			if (parent_num.equals(num)) {
        	citynum = parent_num;
        %>
			<dt><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=cityname%>"><%=cityname%></a></dt>
        <%}}}%>	
        </dl>
        </div>
		<%}}%>	
      </div>
   
 	  
      <div class="areabox" id="area06" >
		<%
		if (null != hotproviencepyList6 && hotproviencepyList6.size() > 0) {
			for (Map m:hotproviencepyList6) {
				String name = CommonString.getFormatPara(m.get("name"));
				String num = CommonString.getFormatPara(m.get("num"));
				String provience_parent_areapy = CommonString.getFormatPara(m.get("areapy"));
				String provience_parent_num = CommonString.getFormatPara(m.get("parent_num"));
		%>
       <div class="onearea lastarea">
		<%if (provience_parent_num.equals("0")) { %>
        <h5><span><a href="http://city.21-sun.com/<%=provience_parent_areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></span><i></i></h5>
		<%} %>
		<dl>
        <%
		if (null != hotcitypyList6 && hotcitypyList6.size() > 0) {
			for (Map n:hotcitypyList6) {
				String cityname = CommonString.getFormatPara(n.get("name"));
				String citynum = CommonString.getFormatPara(n.get("num"));
				String parent_num = CommonString.getFormatPara(n.get("parent_num"));
				String areapy = CommonString.getFormatPara(n.get("areapy"));
			if (parent_num.equals(num)) {
        	citynum = parent_num;
        %>
			<dt><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=cityname%>"><%=cityname%></a></dt>
        <%}}}%>	
        </dl>
        </div>
		<%}}%>	
      </div>
      
 	  
      <div class="areabox" id="area07" >
		<%
		if (null != hotproviencepyList7 && hotproviencepyList7.size() > 0) {
			for (Map m:hotproviencepyList7) {
				String name = CommonString.getFormatPara(m.get("name"));
				String num = CommonString.getFormatPara(m.get("num"));
				String provience_parent_num = CommonString.getFormatPara(m.get("parent_num"));
				String provience_parent_areapy = CommonString.getFormatPara(m.get("areapy"));
		%>
       <div class="onearea lastarea">
		<%if (provience_parent_num.equals("0")) { %>
        <h5><span><a href="http://city.21-sun.com/<%=provience_parent_areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></span><i></i></h5>
		<%} %>
		<dl>
        <%
		if (null != hotcitypyList7 && hotcitypyList7.size() > 0) {
			for (Map n:hotcitypyList7) {
				String cityname = CommonString.getFormatPara(n.get("name"));
				String citynum = CommonString.getFormatPara(n.get("num"));
				String parent_num = CommonString.getFormatPara(n.get("parent_num"));
				String areapy = CommonString.getFormatPara(n.get("areapy"));
			if (parent_num.equals(num)) {
        	citynum = parent_num;
        %>
			<dt><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=cityname%>"><%=cityname%></a></dt>
        <%}}}%>	
        </dl>
        </div>
		<%}}%>	
      </div>
 	  
      <div class="areabox" id="area08" >
		<%
		if (null != hotproviencepyList8 && hotproviencepyList8.size() > 0) {
			for (Map m:hotproviencepyList8) {
				String name = CommonString.getFormatPara(m.get("name"));
				String num = CommonString.getFormatPara(m.get("num"));
				String provience_parent_num = CommonString.getFormatPara(m.get("parent_num"));
				String provience_parent_areapy = CommonString.getFormatPara(m.get("areapy"));
		%>
       <div class="onearea lastarea">
		<%if (provience_parent_num.equals("0")) { %>
        <h5><span><a href="http://city.21-sun.com/<%=provience_parent_areapy%>/" target="_blank" title="<%=name%>"><%=name%></a></span><i></i></h5>
		<%} %>
		<dl>
        <%
		if (null != hotcitypyList8 && hotcitypyList8.size() > 0) {
			for (Map n:hotcitypyList8) {
				String cityname = CommonString.getFormatPara(n.get("name"));
				String citynum = CommonString.getFormatPara(n.get("num"));
				String parent_num = CommonString.getFormatPara(n.get("parent_num"));
				String areapy = CommonString.getFormatPara(n.get("areapy"));
			if (parent_num.equals(num)) {
        	citynum = parent_num;
        %>
			<dt><a href="http://city.21-sun.com/<%=areapy%>/" target="_blank" title="<%=cityname%>"><%=cityname%></a></dt>
        <%}}}%>	
        </dl>
        </div>
		<%}}%>	
      </div>     
 
	  </div>
  </div>
    </cache:cache>