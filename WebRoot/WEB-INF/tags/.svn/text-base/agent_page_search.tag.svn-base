<%@ tag body-content="empty" import="java.util.*,java.sql.*,com.jerehnet.util.common.*" pageEncoding="UTF-8" %>
<%@ attribute name="keyword" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="factory" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="catalog" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="url" required="false" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="nowPage" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="total" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="totalPage" required="true" rtexprvalue="true" type="java.lang.Integer" %>


<%  
    String province = CommonString.getFormatPara(request.getParameter("province")) ;
	String city = CommonString.getFormatPara(request.getParameter("city")) ;
	if(province.equals("")){province="0";} if(city.equals("")){city="0";}
    Integer pageSize=1;
	Integer pageSizes=15;
	Integer prevInt = (nowPage - 1) == 0 ? 1 : (nowPage - 1);
	url = CommonString.getFormatPara(url) ;
    Integer preInt = (nowPage - 1) == 0 ? 1 : (nowPage - 1);
	Integer nextInt = (nowPage + 1) == totalPage? totalPage: (nowPage + 1);
	StringBuffer pageBar = new StringBuffer();
	pageBar.append("<div class='paging page' id='pagination'>");
	if(total> 0 && totalPage>1){ // 2012年12月26日13:23:35 改
		if(nowPage==1 ){
			pageBar.append("<a class='pre noPre' title='上一页' href='javascript:;'></a>") ;
		}else{
			pageBar.append("<a class='pre noPre' title='上一页' href='/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+preInt+".htm'></a>") ;
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
	if(totalPage > 10){
		rightCount = totalPage - 5;
		if (middle <= 5 && middle < rightCount) {
			for(int i=0;i<5;i++){
				if((i+1)==nowPage){
					pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
				}else{
					pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+(i+1)+".htm"+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
				}
			}
			if(middle==5){
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((5)+1)+".htm"+"\">&nbsp;"+6+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((6)+1)+".htm"+"\">&nbsp;"+7+"&nbsp;</a>");
			}
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((totalPage-2)+1)+".htm"+"\">&nbsp;"+(totalPage-1)+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((totalPage-1)+1)+".htm"+"\">&nbsp;"+(totalPage)+"&nbsp;</a>");
		}else if( middle > 5 && middle > rightCount){
			pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((1-1)+1)+".htm"+"\">&nbsp;"+1+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((2-1)+1)+".htm"+"\">&nbsp;"+2+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			if(middle==(rightCount+1)){
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((middle-2-1)+1)+".htm"+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((middle-1-1)+1)+".htm"+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
			}
			for(int i = rightCount;i<(totalPage);i++){
					if((i+1)==nowPage){
						pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
					}else{
						//pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+(i+1)+".htm"+"\" onclick=\"getAgentList("+(i+1)+",\"search\");\">&nbsp;"+(i+1)+"&nbsp;</a>");
					}
				}
			} else {
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((1-1)+1)+".htm"+"\">&nbsp;"+1+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((2-1)+1)+".htm"+"\">&nbsp;"+2+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((middle-3)+1)+".htm"+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((middle-2)+1)+".htm"+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
				pageBar.append("<span class=\"current\"><b>&nbsp;"+middle+"&nbsp;</b></span>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((middle)+1)+".htm"+"\">&nbsp;"+(middle+1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((middle+1)+1)+".htm"+"\">&nbsp;"+(middle+2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((totalPage-2)+1)+".htm"+"\">&nbsp;"+(totalPage-1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((totalPage-1)+1)+".htm"+"\">&nbsp;"+(totalPage)+"&nbsp;</a>");
		}
	}else{
		left = 0;
		right = totalPage;
		for(int i=left;i<right;i++){
			if((i+1)==nowPage){
				pageBar.append("<span class=\"current\" style=\"cursor: default;border:none;color:#000;\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
			}else{
				pageBar.append("<a class=\"num\" href=\""+url+"/"+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+(i+1)+".htm"+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
			}
		}
	}
	if (nowPage <= (totalPage-1)) {
			pageBar.append("<a href='/"+url+keyword+"_"+province+"_"+city+"_" +factory+"_"+catalog+"_"+((nextInt-1)+1)+".htm' class='next'></a>");
	} else {
		pageBar.append(" ");
	}
	pageBar.append("</div>") ;
	out.print(pageBar.toString());%>