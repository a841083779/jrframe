<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalognum")) ; 
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	if(!"".equals(factoryid) || (!"".equals(offset)&&!"0".equals(offset))){
		return ;
	}
	String whereStr = "" ;
	if(!"".equals(catalog)){
		whereStr += " and is_rec=1 and catalognum like '"+catalog+"%'" ;
	}
	String sel_sql = " select top 2 * from pro_products where 1=1" +whereStr ;
	List<Map> recProductsList = new ArrayList() ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	recProductsList = dbHelper.getMapList(sel_sql) ;
	if (recProductsList != null && recProductsList.size() > 0) {
			for (Map oneMap : recProductsList) {
%>
<li>
	<a href="/proDetail/<%=oneMap.get("file_name")%>"
		target="_blank"> <img
			src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"
			onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"
			width="130" height="90" class="plimg"
			alt="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
			+ (String) oneMap.get("catalogname"))%>"
			title="<%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
			+ (String) oneMap.get("catalogname"))%>" />
	</a>
	<div class="w618 r">
		<h2>
			<a href="/proDetail/<%=oneMap.get("file_name")%>"
				target="_blank"><%=CommonString.getFormatPara((String) oneMap.get("factoryname") + (String) oneMap.get("name")
			+ (String) oneMap.get("catalogname"))%></a>
		</h2>
		<span class="info"> <a
			href="?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneMap.get("catalognum")).length() >= 6 ? CommonString
	.getFormatPara(oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))%>"><%=CommonString.getFormatPara((String) oneMap.get("factoryname"))
	+ CommonString.getFormatPara(catalogMap.get((((String) oneMap.get("catalognum")).length() >= 6) ? CommonString.getFormatPara(
			oneMap.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(oneMap.get("catalognum"))))%></a>
			<em>|</em> <a
			href="/inquiry/?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneMap.get("catalognum"))%>"
			target='_blank'>订单</a> <em>|</em> <a
			href="/photo/list.jsp?factoryid=<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>&catalogid=<%=CommonString.getFormatPara(catalog)%>"
			target="_balnk">图片</a> <a href="javascript:;"
			onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')"
			class="plbtn">询价</a> </span>
		<div class="plInfo"><%=CommonString.substringByte(CommonHtml.filterHTML((String) oneMap.get("introduce")), 180) + "..."%><b><a
				href="/proDetail/<%=oneMap.get("file_name")%>"
				target="_blank">[查看详情]</a> </b>
		</div>
	</div>
</li>
<%
	}
	}
%>
