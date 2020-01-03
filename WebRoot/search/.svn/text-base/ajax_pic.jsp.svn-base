<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%
	String keyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	Integer nowPage = CommonString.getFormatInt(CommonString.getFormatPara(request.getParameter("nowPage")));
	if(nowPage<1){
		nowPage = 1;
	}
	LucenePage lucenePage = new LucenePage(20,nowPage,"Web21ProductSearchPhoto");
	JSONArray jsonArray =  lucenePage.doSearch(keyword);
	JSONObject obj = null;
	String param = "&keyword="+keyword;
%><%
  if(jsonArray != null && jsonArray.length() > 0){
	for(int i = 0;i<jsonArray.length();i++){
		obj = jsonArray.getJSONObject(i);
%><div class="cell"><a id="thumb1" class="highslide" onclick='return openDiv(this);' url="<%=CommonString.getFormatPara(obj.getString("url")).replace("http://product.21-sun.com","http://product.21-sun.com")%>" href="http://product.21-sun.com/<%=CommonString.getFormatPara(obj.getString("img"))%>"><img src="http://product.21-sun.com/<%=CommonString.getFormatPara(obj.getString("img"))%>" /></a><p><%=CommonString.getFormatPara(obj.getString("title"))%></p><div class="highslide-caption"><%=CommonString.getFormatPara(obj.getString("title"))%></div></div><%
	}
}
%>
