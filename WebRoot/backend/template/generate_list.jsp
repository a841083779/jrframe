<%@ page language="java" import="java.util.*,java.io.File,com.jerehnet.util.freemarker.FreemarkerUtils" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String table = request.getParameter("table");
	String folder = request.getParameter("folder");
	String file = request.getParameter("file");
	if(null==folder||"".equals(folder)){
		folder = table;
	}
	if(null==file||"".equals(file)){
		file = table+"_list.jsp";
	}
	String [] name = request.getParameterValues("name");
	String [] type = request.getParameterValues("type");
	String [] text_align = request.getParameterValues("text_align");
	String [] display_name = request.getParameterValues("display_name");
	String [] column_width = request.getParameterValues("column_width");
	String [] search = request.getParameterValues("search");
	Boolean haveSearchForm = false;
	if(null!=search&&search.length>0){
		for(int i=0;i<search.length;i++){
			if(search[i]!=""){
				haveSearchForm = true;
				break;
			}
		}
	}
	Map root = new HashMap();
	root.put("table",table);
	root.put("name",name);
	root.put("type",type);
	root.put("text_align",text_align);
	root.put("display_name",display_name);
	root.put("column_width",column_width);
	root.put("search",search);
	root.put("haveSearchForm",haveSearchForm);
	root.put("title_name",table+"列表页");
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(application.getRealPath(""));
	String outPath = application.getRealPath("/backend/"+folder)+"/";
	File outFile = new File(outPath);
	if(!outFile.exists()){
		outFile.mkdir();
	}
	outFile = new File(outPath+file);
	if(!outFile.exists()){
		freemarkerUtils.generate("/backend/template/list.jsp",root,outPath+file,request);
	}
	out.print("ok");
%>