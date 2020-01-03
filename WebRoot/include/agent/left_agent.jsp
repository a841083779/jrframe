<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String factoryid  = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalog")) ;
    if(catalognum.equals("0")){catalognum="";}
	String province = CommonString.getFormatPara(request.getParameter("province"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
	String cacheKey = "left"+factoryid+catalognum+province+city;
	String url = "";
%><script type="text/javascript" src="/scripts/letter_tree_agent.js"></script>
<script type="text/javascript" src="/scripts/idTabs.js"></script>
<style type="text/css">
.smartFloat { width:210px;}
.w210 .sfocus { position:fixed; top:0px; z-index: 20;}
.w210 .sfocus_bottom { position:fixed; top:auto; bottom:150px;*bottom:160px; z-index: 20;}
* html,* html body {background-image:url(about:blank);background-attachment:fixed}
* html  .sfocus {position:absolute; top:expression(eval(document.documentElement.scrollTop));}
* html  .sfocus_bottom {position:absolute; top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))-130)}
.treev1 { max-height:none; _height:none;}
</style>
<div class="w210 l">
	<!-- sfocus --> 
  <div class="smartFloat" id="smartFloat">
    <div class="leftTab">
    <ul class="idTabs">
      <li><a href="#agent_tab01" class="selected">品牌</a></li>
      <li><a href="#agent_tab02">类型</a></li>

    </ul>
  </div>
<cache:cache key="<%=cacheKey %>" cron="* * * */1 *">
  <div class="w208 border01 l leftPart" id="agent_tab01">
  <%
      DBHelper dbHelper = DBHelper.getInstance();
      Connection connection = null;
      try{
          connection = dbHelper.getConnection();
          connection.setAutoCommit(false);
          
          String sql1 = " select paf.upper_index as upper_index from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id ";
          if(!catalognum.equals("")){
              sql1 += "and pp.catalognum like '"+catalognum+"%' ";
          }
          sql1 += " group by paf.upper_index order by paf.upper_index ";
          String hasLetters = "";
          List <Map>list1 = dbHelper.getMapList(sql1,connection);
          if(list1 != null && list1.size() > 0){
              for(Map m : list1){
                  hasLetters += m.get("upper_index").toString().toUpperCase()+",";
              }
          }
          
          List<String> letters = new ArrayList<String>(0);
          letters.add("A");letters.add("B");letters.add("C");letters.add("D");letters.add("E");letters.add("F");letters.add("G");letters.add("H");
          letters.add("I");letters.add("J");letters.add("K");letters.add("L");letters.add("M");letters.add("N");letters.add("O");letters.add("P");
          letters.add("Q");letters.add("R");letters.add("S");letters.add("T");letters.add("U");letters.add("V");letters.add("W");letters.add("X");
          letters.add("Y");letters.add("Z");
          String sql2 = "select paf.id,paf.upper_index,paf.name,paf.usern from pro_products pp ,pro_agent_factory paf where pp.factoryid = paf.id ";
          if(!catalognum.equals("")){
              sql2 += " and pp.catalognum like '"+catalognum+"%' ";
          }
          sql2 += " group by paf.upper_index,paf.name,paf.usern,paf.id order by paf.upper_index,paf.name ";	
          List <Map>list2 = dbHelper.getMapList(sql2,connection);	
          List<Map> catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 3 ",connection);
  %>
    <!--字母检索--> 

    <div class="treeSubNavv1">
      <ul id="tree_letter">
        <%	
          int k = 0;
          for(int i = 0; letters != null && i < letters.size();i++){
      %>
        <%
          if(hasLetters.indexOf(letters.get(i).toString().toUpperCase()) >= 0){
              k++;
      %>
        <li><a href="javascript:void(0);" onclick="treeHref(<%=k%>);return false;"><%=letters.get(i)%></a></li>
        <%
          }else{
      %>
        <li class="none"><%=letters.get(i)%></li>
        <%
          }
          }
       %>
      </ul>
    </div>
    <div class="treev1" id="treev1" style="height: 551px;*height:551px; max-height: none;">
      <ul>
        <%
          String upLetter = "";
          String letter = "";
          int n = 0;
          for(int i = 0; list2 != null && i < list2.size();i++){
              letter = list2.get(i).get("upper_index").toString().toUpperCase();
      %>
        <%
          if(!upLetter.equals("") && !letter.equals(upLetter)){
      %>
      </ul>
      </li>
      <%
          }
      %>
      <%
          if(!letter.equals(upLetter)){
              n++;
      %>
      <li class="root" id="letter<%=n%>"><b><%=letter%></b>
        <ul>
          <%
          }

      %>
          <li id="<%=list2.get(i).get("id").toString()%>" title="<%=list2.get(i).get("name").toString()%>">
              <a href="/agent/<%=(province.equals("")?"0":province)%>_<%=(city.equals("")?"0":city)%>_<%=list2.get(i).get("id").toString()%>_<%=catalognum.equals("")?"0":catalognum%>.shtm" class="mainBrand"><big><%=list2.get(i).get("name").toString()%></big></a>
              <ul id="<%=list2.get(i).get("id").toString()%>_sub"></ul>
          </li>
          <%
          upLetter = letter;
        }
      %>
        </ul>
         <div style="height: 200px;">&nbsp;</div>
    </div>
    <!--字母检索结束--> 
  </div>
    <div class="w208 border01 l leftPart mb10" id="agent_tab02" style="display:none; height:487px;*height:453px; overflow-x:hidden;overflow-y: scroll;">
    <ul>
    	<%
    		List<Map> sub_catalogs = null;
    		for(Map m : catalogs){
    			sub_catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 6 and num like '"+m.get("num")+"%' ",connection);
    			%><li><h3 class="agent_tab_name"><%=m.get("name") %></h3>
    				<%
    					if(null!=sub_catalogs&&sub_catalogs.size()>0){
    						%><ul><%
    						for(Map m1 : sub_catalogs){
    					      	
    							%><li><a href="/agent/0_0_0_<%=m1.get("num")%>.shtm"><%=m1.get("name") %></a></li><%
    						}
    						%></ul><%
    					}
    				%>
    			</li><%
    		}
    	%>
    </ul>
  </div>
<%
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>
<script language="javascript" type="text/javascript">
	//获得当前偏移并展开对应品牌
	var treeBox = document.getElementById("treev1");
	if(jQuery("#<%=factoryid%>") != undefined && "<%=factoryid%>" != "" && jQuery("#<%=factoryid%>").offset() != undefined){
		treeBox.scrollTop = jQuery("#<%=factoryid%>").offset().top-450;
	}
	jQuery("#<%=factoryid%>").addClass("rootCur");
</script>
  </div>
<script type="text/javascript"> jQuery(".idTabs").idTabs("!mouseover");</script>  
</div>