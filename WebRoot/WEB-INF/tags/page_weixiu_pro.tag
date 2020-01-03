<%@ tag body-content="empty" import="java.util.*,java.sql.*,com.jerehnet.util.common.*" pageEncoding="UTF-8" %><%@ attribute name="pageBean" required="true" rtexprvalue="true" type="com.jerehnet.util.dbutil.PageBean" %><%@ attribute name="url" required="false" rtexprvalue="true" type="java.lang.String" %><%
	Integer prevInt = (pageBean.getNowPage() - 1) == 0 ? 1 : (pageBean.getNowPage() - 1);
	int catalog = CommonString.getFormatInt(request.getParameter("catalog"));
	int factory = CommonString.getFormatInt(request.getParameter("factory"));
    int offset = CommonString.getFormatInt(request.getParameter("offset")) ;
    
    if(offset > 0){
        pageBean.setNowPage(offset/pageBean.getPageSize()+1) ;
    }
    Integer preInt = (pageBean.getNowPage() - 1) == 0 ? 1 : (pageBean.getNowPage() - 1);
	Integer nextInt = (pageBean.getNowPage() + 1) == pageBean.getTotal() ? pageBean.getTotal(): (pageBean.getNowPage() + 1);
	StringBuffer pageBar = new StringBuffer();
	pageBar.append("<div class='paging page' id='pagination'>");
	if(pageBean.getTotal() > 0 && pageBean.getPageCount()>1){ // 2012年12月26日13:23:35 改
		if(pageBean.getNowPage()==1 ){
			pageBar.append("<a class='pre noPre' title='上一页' href='javascript:;'></a>") ;
		}else{
			pageBar.append("<a class='pre noPre' title='上一页' href='/" + "plist-"+catalog + "-" + ((preInt-1)*pageBean.getPageSize()) +"-"+factory +".htm'></a>") ;
		}
	}
	if (pageBean.getNowPage() > 1) {
	} else {
		pageBar.append(" ");
	}
	int left = 0;
	int right = 0;
	int middle = pageBean.getNowPage();
	int rightCount = 0; 
	if(pageBean.getPageCount() > 10){
		rightCount = pageBean.getPageCount() - 5;
		if (middle <= 5 && middle < rightCount) {
			for(int i=0;i<5;i++){
				if((i+1)==pageBean.getNowPage()){
					pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
				}else{
					pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ (i*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(i+1)+"&nbsp;</a>");
				}
			}
			if(middle==5){
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog +"-"+ ((5)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+6+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog +"-"+ ((6)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+7+"&nbsp;</a>");
			}
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((pageBean.getPageCount()-2)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(pageBean.getPageCount()-1)+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((pageBean.getPageCount()-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(pageBean.getPageCount())+"&nbsp;</a>");
		}else if( middle > 5 && middle > rightCount){
			pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((1-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+1+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((2-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+2+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			if(middle==(rightCount+1)){
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((middle-2-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((middle-1-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(middle-1)+"&nbsp;</a>");
			}
			for(int i = rightCount;i<(pageBean.getPageCount());i++){
					if((i+1)==pageBean.getNowPage()){
						pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
					}else{
						pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog +  "-"+ (i*pageBean.getPageSize()) + "-"+factory +".htm\"  \">&nbsp;"+(i+1)+"&nbsp;</a>");
					}
				}
			} else {
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((1-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+1+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((2-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+2+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((middle-3)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((middle-2)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(middle-1)+"&nbsp;</a>");
				pageBar.append("<span class=\"current\"><b>&nbsp;"+middle+"&nbsp;</b></span>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((middle)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(middle+1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ ((middle+1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(middle+2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog +"-"+ ((pageBean.getPageCount()-2)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(pageBean.getPageCount()-1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog +"-"+ ((pageBean.getPageCount()-1)*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(pageBean.getPageCount())+"&nbsp;</a>");
		}
	}else{
		left = 0;
		right = pageBean.getPageCount();
		for(int i=left;i<right;i++){
			if((i+1)==pageBean.getNowPage()){
				pageBar.append("<span class=\"current\" style=\"cursor: default;border:none;color:#000;\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
			}else{
				pageBar.append("<a class=\"num\" href=\"/" + "plist-"+catalog + "-"+ (i*pageBean.getPageSize()) + "-"+factory +".htm\">&nbsp;"+(i+1)+"&nbsp;</a>");
			}
		}
	}
	if (pageBean.getNowPage() <= (pageBean.getPageCount()-1)) {
			pageBar.append("<a href='/" + "plist-"+catalog +"-"+ ((nextInt-1)*pageBean.getPageSize()) + "-"+factory +".htm' class='next'></a>");
	} else {
		pageBar.append(" ");
	}
	pageBar.append("</div>") ;
	out.print(pageBar.toString());%>