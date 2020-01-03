<%@ tag body-content="empty" import="java.util.*,java.sql.*,com.jerehnet.util.common.*" pageEncoding="UTF-8" %>
<%@ attribute name="totalCount" required="false" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="pageSize" required="false" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="nowPage" required="false" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="url" required="false" rtexprvalue="true" type="java.lang.String" %>
<%
	int pageCount = totalCount / pageSize + (totalCount % pageSize > 0 ? 1 : 0);
	Integer prevInt = (nowPage - 1) == 0 ? 1 : (nowPage - 1);
	url = CommonString.getFormatPara(url) ;
    Integer preInt = (nowPage - 1) == 0 ? 1 : (nowPage - 1);
	Integer nextInt = (nowPage + 1) == totalCount ? totalCount: (nowPage + 1);
	StringBuffer pageBar = new StringBuffer();
	pageBar.append("<div class='paging page' id='pagination'>");
	if(totalCount > 0 && pageCount>1){
		if(nowPage==1 ){
			pageBar.append("<a class='pre noPre' title='上一页' href='javascript:;'></a>") ;
		}else{
			pageBar.append("<a class='pre noPre' title='上一页' href='"+url + preInt + ".htm"+"'></a>") ;
		}
	}
	if (nowPage > 1) {
	} else {
		pageBar.append(" ");
	}
	int left = 0;
	int right = 0;
	int middle = nowPage;
	int rightCount = 0; 
	if(pageCount > 10){
		rightCount = pageCount - 5;
		if (middle <= 5 && middle < rightCount) {
			for(int i=0;i<5;i++){
				if((i+1)==nowPage){
					pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
				}else{
					pageBar.append("<a class=\"num\" href=\""+url+(i+1)+".htm"+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
				}
			}
			if(middle==5){
				pageBar.append("<a class=\"num\" href=\""+url+"6.htm"+"\">&nbsp;"+6+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"7.htm"+"\">&nbsp;"+7+"&nbsp;</a>");
			}
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			pageBar.append("<a class=\"num\" href=\""+url+(pageCount-1)+".htm"+"\">&nbsp;"+(pageCount-1)+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\""+url+pageCount+".htm"+"\">&nbsp;"+(pageCount)+"&nbsp;</a>");
		}else if( middle > 5 && middle > rightCount){
			pageBar.append("<a class=\"num\" href=\""+url+"1.htm"+"\">&nbsp;"+1+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\""+url+"2.htm"+"\">&nbsp;"+2+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			if(middle==(rightCount+1)){
				pageBar.append("<a class=\"num\" href=\""+url+(middle-2)+".htm"+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+(middle-1)+".htm"+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
			}
			for(int i = rightCount;i<(pageCount);i++){
					if((i+1)==nowPage){
						pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
					}else{
						pageBar.append("<a class=\"num\" href=\""+url+(i+1)+".htm"+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
					}
				}
			} else {
				pageBar.append("<a class=\"num\" href=\""+url+"1.htm"+"\">&nbsp;"+1+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"2.htm"+"\">&nbsp;"+2+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+(middle-2)+".htm"+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+(middle-1)+".htm"+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
				pageBar.append("<span class=\"current\"><b>&nbsp;"+middle+"&nbsp;</b></span>");
				pageBar.append("<a class=\"num\" href=\""+url+(middle+1)+".htm"+"\">&nbsp;"+(middle+1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+(middle+2)+".htm"+"\">&nbsp;"+(middle+2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+(pageCount-1)+".htm"+"\">&nbsp;"+(pageCount-1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+(pageCount)+".htm"+"\">&nbsp;"+(pageCount)+"&nbsp;</a>");
		}
	}else{
		left = 0;
		right = pageCount;
		for(int i=left;i<right;i++){
			if((i+1)==nowPage){
				pageBar.append("<span class=\"current\" style=\"cursor: default;border:none;color:#000;\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
			}else{
				pageBar.append("<a class=\"num\" href=\""+url+(i+1)+".htm"+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
			}
		}
	}
	if (nowPage <= (pageCount-1)) {
			pageBar.append("<a href='"+url + nextInt + ".htm"+"' class='next'></a>");
	} else {
		pageBar.append("");
	}
	pageBar.append("</div>") ;
	out.print(pageBar.toString());%>