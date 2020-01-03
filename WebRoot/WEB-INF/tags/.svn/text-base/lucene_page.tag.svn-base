<%@ tag body-content="empty" import="java.net.URLDecoder,java.util.*,java.sql.*,com.jerehnet.util.common.*" pageEncoding="UTF-8" %><%@ attribute name="lucenePage" required="true" rtexprvalue="true" type="com.jerehnet.webservice.LucenePage" %><%@ attribute name="param" required="false" rtexprvalue="true" type="java.lang.String" %><%
	param = CommonString.getFormatPara(param);
	Integer nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	Integer total = lucenePage.getTotal();
	Integer allPage = ((Double)Math.ceil(1d*total/lucenePage.getPageSize()*1d)).intValue();
	if(nowPage<=1){
		nowPage = 1;
	}else if(nowPage>=total){
		nowPage = total;
	}
%>
<div class="paging">
<a title="上一页" class="pre noPre" href="?nowPage=<%=nowPage-1 %><%=param %>"></a><%
	int left = 0;
	int right = 0;
	int middle = lucenePage.getNowPage();
	if (middle > 6) {
		left = middle - 6;
		if (middle >= (lucenePage.getPageCount() - 6)) {
			right = lucenePage.getPageCount();
		} else {
			right = middle + 5;
		}
	} else if (middle <= 6 && lucenePage.getPageCount() > 11) {
		right = 11;
	} else {
		right = lucenePage.getPageCount();
	}
	for(int i=left;i<right;i++){
		if((i+1)==nowPage){
			out.print("<span class='current'><b>"+(i+1)+"</b></span>");
		}else{
			out.print("<a class='num' href='?nowPage="+(i+1)+param+"'>"+(i+1)+"</a>");
		}
	}
if(nowPage>=allPage){
%>
<a class="next" href="?nowPage=<%=allPage %><%=param %>"></a>
<%
}else{
%>
<a class="next" href="?nowPage=<%=nowPage+1 %><%=param %>"></a>
<%
}
%>
</div>