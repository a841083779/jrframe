<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	response.setContentType("text/html;charset=utf-8");
	PageBean pageBean = new PageBean();
	String isShowSql = CommonString.getFormatPara(request.getParameter("isShowSql"));
	//是否打印SQL语句
	//isShowSql = "true";
	pageBean.setTableName(CommonString.getFormatPara(request.getParameter("tableName")));
	pageBean.setCondition(CommonString.getFormatPara(request.getParameter("whereStr")));
	pageBean.setOrderBy(CommonString.getFormatPara(request.getParameter("orderBy")));
	String pageSize = CommonString.getFormatPara(request.getParameter("pagesize"));
	String nowPage = CommonString.getFormatPara(request.getParameter("page"));
	String fields = CommonString.getFormatPara(request.getParameter("fields"));
	String main = CommonString.getFormatPara(request.getParameter("main"));
	String sortname = CommonString.getFormatPara(request.getParameter("sortname"));
	String sortorder = CommonString.getFormatPara(request.getParameter("sortorder"));
	if (!"".equals(main)) {
		pageBean.setMain(main);
	}
	if (!"".equals(fields)) {
		pageBean.setFields(fields);
	}
	if (!"".equals(isShowSql)) {
		pageBean.setIsShowSql(true);
	}
	if (!"".equals(pageSize)) {
		pageBean.setPageSize(Integer.parseInt(pageSize));
	}
	if (!"".equals(nowPage)) {
		pageBean.setNowPage(nowPage);
	}
	if(!"".equals(sortname)){
		pageBean.setOrderBy(sortname + " "+sortorder);
	}
	out.print(pageBean.getJson());
%>