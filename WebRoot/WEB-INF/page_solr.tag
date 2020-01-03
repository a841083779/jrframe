<%@ tag body-content="empty" import="java.util.*,java.sql.*,com.jerehnet.util.common.*" pageEncoding="UTF-8" %>
<%@ attribute name="url" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="nowPage" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="total" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="totalPage" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="tonandmeter" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="factoryid" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="catalog" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="factoryids" required="false" rtexprvalue="true" type="java.lang.String" %>

<%
	
	Integer pageSize=1;
	Integer pageSizes=15;
	Integer prevInt = (nowPage - 1) == 0 ? 1 : (nowPage - 1);
	url = CommonString.getFormatPara(url) ;
    Integer preInt = (nowPage - 1) == 0 ? 1 : (nowPage - 1);
	Integer nextInt = (nowPage + 1) == totalPage? totalPage: (nowPage + 1);
	
    String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	if("".equals(offset) || Integer.parseInt(offset)<0){
		offset = "0" ;
	}
    if(!"".equals(offset)){
        //pageBean.setNowPage(Integer.parseInt(offset)/pageBean.getPageSize()+1) ;
        nowPage = Integer.parseInt(offset)/pageSizes+1 ;
    }
	
	url = CommonString.getFormatPara(url) ;
	
	//2014.11.26修改
	String add_url="&catalog="+catalog;
	if(factoryid.trim().equals("")||factoryid==null){
	   add_url+="";
	}else{
	   add_url+="&factory="+factoryid;
	}
	if(tonandmeter.trim().equals("")||tonandmeter==null){
	   add_url+="";
	}else{
	   add_url+="&tonandmeter="+tonandmeter;
	}
   	if(factoryids.trim().equals("")||factoryids==null){
	   add_url+="";
	}else{
	   add_url+="&factoryids="+factoryids;
	}
	add_url+="#main";
    
	StringBuffer pageBar = new StringBuffer();
	pageBar.append("<div class='paging page' id='pagination'>");
	if(total > 0 && totalPage>1){ // 2012年12月26日13:23:35 改
		if(nowPage==1 ){
			pageBar.append("<a class='pre noPre' title='上一页' href='javascript:;'></a>") ;
		}else{
			pageBar.append("<a class='pre noPre' title='上一页' href='"+url+"?offset=" + ((preInt-1)*pageSizes) + add_url+"'></a>") ;
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
				    if(i==0){
					    if(add_url.indexOf("&")>=0){
						    pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url.substring(1,add_url.length())+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
						}else{
							pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
						}
					}else{
					    pageBar.append("<a class=\"num\" href=\""+url+"?offset="+(i*pageSizes)+add_url+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
					}
				}
			}
			if(middle==5){
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((5)*pageSizes)+add_url+"\">&nbsp;"+6+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((6)*pageSizes)+add_url+"\">&nbsp;"+7+"&nbsp;</a>");
			}
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((totalPage-2)*pageSizes)+add_url+"\">&nbsp;"+(totalPage-1)+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((totalPage-1)*pageSizes)+add_url+"\">&nbsp;"+(totalPage)+"&nbsp;</a>");
		}else if( middle > 5 && middle > rightCount){
			if(add_url.indexOf("&")>=0){
				pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url.substring(1,add_url.length())+"\">&nbsp;"+1+"&nbsp;</a>");
			}else{
				pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url+"\">&nbsp;"+1+"&nbsp;</a>");
			}
			pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((2-1)*pageSizes)+add_url+"\">&nbsp;"+2+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			if(middle==(rightCount+1)){
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((middle-2-1)*pageSizes)+add_url+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((middle-1-1)*pageSizes)+add_url+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
			}
			for(int i = rightCount;i<(totalPage);i++){
					if((i+1)==nowPage){
						pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
					}else{
						pageBar.append("<a class=\"num\" href=\""+url+"?offset="+(i*pageSizes)+add_url+"\" onclick=\"getAgentList("+(i+1)+",\"search\");\">&nbsp;"+(i+1)+"&nbsp;</a>");
					}
				}
			} else {
				if(add_url.indexOf("&")>=0){
				    pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url.substring(1,add_url.length())+"\">&nbsp;"+1+"&nbsp;</a>");
			    }else{
				    pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url+"\">&nbsp;"+1+"&nbsp;</a>");
			    }
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((2-1)*pageSizes)+add_url+"\">&nbsp;"+2+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((middle-3)*pageSizes)+add_url+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((middle-2)*pageSizes)+add_url+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
				pageBar.append("<span class=\"current\"><b>&nbsp;"+middle+"&nbsp;</b></span>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((middle)*pageSizes)+add_url+"\">&nbsp;"+(middle+1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((middle+1)*pageSizes)+add_url+"\">&nbsp;"+(middle+2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((totalPage-2)*pageSizes)+add_url+"\">&nbsp;"+(totalPage-1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+"?offset="+((totalPage-1)*pageSizes)+add_url+"\">&nbsp;"+(totalPage)+"&nbsp;</a>");
		}
	}else{
		left = 0;
		right = totalPage;
		for(int i=left;i<right;i++){
			if((i+1)==nowPage){
				pageBar.append("<span class=\"current\" style=\"cursor: default;border:none;color:#000;\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
			}else{
				if(i==0){
				    if(add_url.indexOf("&")>=0){
				   	pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url.substring(1,add_url.length())+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
					}else{
					pageBar.append("<a class=\"num\" href=\""+url+"?"+add_url+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
					}
				}else{
					pageBar.append("<a class=\"num\" href=\""+url+"?offset="+(i*pageSizes)+add_url+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
				}		
			}
		}
	}
	if (nowPage <= (totalPage-1)) {
	    if(nextInt==2){nextInt=1;}
	     pageBar.append("<a href='"+url+"?offset=" + ((nextInt-1)*(pageSizes)+15) + add_url+"' class='next'></a>");
	} else {
		 pageBar.append(" ");
	}
	pageBar.append("</div>") ;
	out.print(pageBar.toString());%>