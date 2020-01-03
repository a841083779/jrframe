<%@ tag body-content="empty" import="java.util.*,java.sql.*,com.jerehnet.util.common.*" pageEncoding="UTF-8" %><%@ attribute name="pageBean" required="true" rtexprvalue="true" type="com.jerehnet.util.dbutil.PageBean" %><%@ attribute name="url" required="false" rtexprvalue="true" type="java.lang.String" %><%
	Integer prevInt = (pageBean.getNowPage() - 1) == 0 ? 2 : (pageBean.getNowPage() - 1);
    String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	if(factoryid.equals("")){factoryid="0";}
	if("".equals(offset) || Integer.parseInt(offset)<0){
		offset = "1" ;
	}
    if(!"".equals(offset)){
        pageBean.setNowPage(Integer.parseInt(offset)/pageBean.getPageSize()+1) ;
    }
	url = "/pro_" + factoryid+"_";
    Integer preInt = (pageBean.getNowPage() - 1) == 0 ? 2 : (pageBean.getNowPage() - 1);

	Integer nextInt = (pageBean.getNowPage() + 1) == pageBean.getTotal() ? pageBean.getTotal(): (pageBean.getNowPage() + 1);
	StringBuffer pageBar = new StringBuffer();
	pageBar.append("<div class='paging page' id='pagination'>");
	if(pageBean.getTotal() > 0 && pageBean.getPageCount()>1){ // 2012年12月26日13:23:35 改
		if(pageBean.getNowPage()==1 ){
			pageBar.append("<a class='pre noPre' title='上一页' href='javascript:;'></a>") ;
		}else{
			pageBar.append("<a class='pre noPre' title='上一页' href='"+url+"" + ((preInt-1)*pageBean.getPageSize()==0?1:(preInt-1)*pageBean.getPageSize()) + ".htm"+"'></a>") ;
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
					pageBar.append("<a class=\"num\" href=\""+url+""+(i*pageBean.getPageSize()== 0 ? 1 : i*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
				}
			}
			if(middle==5){
				pageBar.append("<a class=\"num\" href=\""+url+""+((5)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+6+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((6)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+7+"&nbsp;</a>");
			}
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			pageBar.append("<a class=\"num\" href=\""+url+""+((pageBean.getPageCount()-2)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(pageBean.getPageCount()-1)+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\""+url+""+((pageBean.getPageCount()-1)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(pageBean.getPageCount())+"&nbsp;</a>");
		}else if( middle > 5 && middle > rightCount){
			pageBar.append("<a class=\"num\" href=\""+url+""+"1"+".htm"+"\">&nbsp;"+1+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\""+url+""+((2-1)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+2+"&nbsp;</a>");
			pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
			if(middle==(rightCount+1)){
				pageBar.append("<a class=\"num\" href=\""+url+""+((middle-2-1)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((middle-1-1)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
			}
			for(int i = rightCount;i<(pageBean.getPageCount());i++){
					if((i+1)==pageBean.getNowPage()){
						pageBar.append("<span class=\"current\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
					}else{
						pageBar.append("<a class=\"num\" href=\""+url+""+(i*pageBean.getPageSize())+".htm"+"\" onclick=\"getAgentList("+(i+1)+",\"search\");\">&nbsp;"+(i+1)+"&nbsp;</a>");
					}
				}
			} else {
				pageBar.append("<a class=\"num\" href=\""+url+""+"1"+".htm"+"\">&nbsp;"+1+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((2-1)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+2+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((middle-3)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(middle-2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((middle-2)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(middle-1)+"&nbsp;</a>");
				pageBar.append("<span class=\"current\"><b>&nbsp;"+middle+"&nbsp;</b></span>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((middle)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(middle+1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((middle+1)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(middle+2)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\"javascript:void(0);\" style=\"cursor: default;border:none;color:#000;\">...</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((pageBean.getPageCount()-2)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(pageBean.getPageCount()-1)+"&nbsp;</a>");
				pageBar.append("<a class=\"num\" href=\""+url+""+((pageBean.getPageCount()-1)*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(pageBean.getPageCount())+"&nbsp;</a>");
		}
	}else{
		left = 0;
		right = pageBean.getPageCount();
		for(int i=left;i<right;i++){
			if((i+1)==pageBean.getNowPage()){
				pageBar.append("<span class=\"current\" style=\"cursor: default;border:none;color:#000;\"><b>&nbsp;"+(i+1)+"&nbsp;</b></span>");
			}else{
				pageBar.append("<a class=\"num\" href=\""+url+""+(i*pageBean.getPageSize()== 0 ? 1 : i*pageBean.getPageSize())+".htm"+"\">&nbsp;"+(i+1)+"&nbsp;</a>");
			}
		}
	}
	if (pageBean.getNowPage() <= (pageBean.getPageCount()-1)) {
			pageBar.append("<a href='"+url+"" + ((nextInt-1)*pageBean.getPageSize()) + ".htm"+"' class='next'></a>");
	} else {
		pageBar.append(" ");
	}
	pageBar.append("</div>") ;
	out.print(pageBar.toString());%>