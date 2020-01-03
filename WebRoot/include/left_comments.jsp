<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String factoryid  = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String url = CommonString.getFormatPara(request.getParameter("url")) ;
	String urlOne = CommonString.getFormatPara(request.getParameter("url")) ;
	String cacheKey = "left"+factoryid+catalognum+url;
%>
<cache:cache key="<%=cacheKey%>" cron="* * * */1 *">
<div class="leftTab">
  <ul>
    <li <%if(url.equals("/products/procomments.jsp")){%>class="ltcur"<%}%>><a href="/products/procomments.jsp">产品</a></li>
    <li <%if(url.equals("/photo/list.jsp")){%>class="ltcur"<%}%>><a href="/photo/">图片</a></li>
    <li <%if(url.equals("/inquiry/")){%>class="ltcur"<%}%>><a href="/inquiry/">订单</a></li>
  </ul>
</div>
<div class="w208 border01 l leftPart mb10">
  <h2>热门品牌</h2>
  <div class="hbr">
    <ul>
      <li><a target="_blank" href="/brand/sany/">三一</a></li>
      <li><a target="_blank" href="/brand/komatsu/">小松</a></li>
      <li><a target="_blank" href="/brand/hitachi/">日立</a></li>
      <li><a target="_blank" href="/brand/kobelco/">神钢</a></li>
      <li><a target="_blank" href="/brand/volvo/">沃尔沃</a></li>
      <li><a target="_blank" href="/brand/doosan/">斗山</a></li>
    </ul>
  </div>
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
		
%>
  <!--字母检索--> 
  <script type="text/javascript" src="/scripts/letter_tree.js"></script>
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
  <div class="treev1" id="treev1">
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
		if(url.equals("/photo/list.jsp")){
			url += "?factoryid="+list2.get(i).get("id").toString();	
		}else{
			url += "?factory="+list2.get(i).get("id").toString();	
		}
	%>
        <li id="<%=list2.get(i).get("id").toString()%>" title="<%=list2.get(i).get("name").toString()%>" url="<%=urlOne%>"> <a href="<%=url%>" class="mainBrand"><big><%=list2.get(i).get("name").toString()%></big></a>
        	<ul id="<%=list2.get(i).get("id").toString()%>_sub"></ul>
        </li>
        <%
		upLetter = letter;
		url = urlOne;
      }
    %>
      </ul>
  </div>
  <!--字母检索结束--> 
</div>
<%
connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
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
	openLeftSub(jQuery("#<%=factoryid%>").attr("id"),jQuery("#<%=factoryid%>").attr("title"),jQuery("#<%=factoryid%>").attr("url"));//厂家ID;厂家名称
</script>