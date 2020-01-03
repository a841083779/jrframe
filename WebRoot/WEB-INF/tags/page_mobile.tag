<%@ tag body-content="empty" import="java.util.*,java.sql.*,com.jerehnet.util.common.*" pageEncoding="UTF-8" %><%@ attribute name="pageBean" required="true" rtexprvalue="true" type="com.jerehnet.util.dbutil.PageBean" %><%@ attribute name="url" required="false" rtexprvalue="true" type="java.lang.String" %><%
	Integer prevInt = (pageBean.getNowPage() - 1) == 0 ? 1 : (pageBean.getNowPage() - 1);
    String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	if("".equals(offset) || Integer.parseInt(offset)<0){
		offset = "0" ;
	}
    if(!"".equals(offset)){
        pageBean.setNowPage(Integer.parseInt(offset)/pageBean.getPageSize()+1) ;
    }
	url = CommonString.getFormatPara(url) ;
    Integer preInt = (pageBean.getNowPage() - 1) == 0 ? 1 : (pageBean.getNowPage() - 1);
	Integer nextInt = (pageBean.getNowPage() + 1) == pageBean.getTotal() ? pageBean.getTotal(): (pageBean.getNowPage() + 1);
	StringBuffer pageBar = new StringBuffer();
	pageBar.append("");
	
	if(pageBean.getTotal() > 0 && pageBean.getPageCount()>1){ // 2012年12月26日13:23:35 改
		if(pageBean.getNowPage()==1 ){
			pageBar.append(" <a href='javascript:;' class='first'>上一页</a>") ;
		}else{
			pageBar.append("<a href='"+url+"?offset=" + ((preInt-1)*pageBean.getPageSize()) + pageBean.getParams()+"'>上一页</a>");

		}
	}
	
	
	
	

	if(pageBean.getPageCount() > 1){

				pageBar.append("<a  href=\""+url+"?offset="+((5)*pageBean.getPageSize())+pageBean.getParams()+"\">&nbsp;"+pageBean.getNowPage()+"/"+pageBean.getPageCount()+"&nbsp;</a>");

	}else{
					pageBar.append("<a  href=\""+url+"?offset="+((5)*pageBean.getPageSize())+pageBean.getParams()+"\">&nbsp;"+1/1+"&nbsp;</a>");

	}
	
	
	
	
	
	
	if (pageBean.getNowPage() <= (pageBean.getPageCount()-1)) {
				pageBar.append("<a href='"+url+"?offset=" + ((nextInt-1)*pageBean.getPageSize()) + pageBean.getParams()+"'>下一页</a>");
	} else {
		pageBar.append("<a href='javascript:;' class='first'>下一页</a>");
	}
	pageBar.append("") ;
	out.print(pageBar.toString());%>