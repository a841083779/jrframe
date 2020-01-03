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
		file = table+"_edit.jsp";
	}
	String [] name = request.getParameterValues("name");
	String [] type = request.getParameterValues("type");
	String [] display_name = request.getParameterValues("display_name");
	String [] validator = request.getParameterValues("validator");
	String [] validator_txt = request.getParameterValues("validator_txt");
	Map root = new HashMap();
	root.put("table",table);
	root.put("name",name);
	root.put("type",type);
	root.put("display_name",display_name);
	root.put("title_name",table+"编辑页");
	root.put("validator",validator);
	root.put("validator_txt",validator_txt);
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(application.getRealPath(""));
	String outPath = application.getRealPath("/backend/"+folder)+"/";
	File outFile = new File(outPath);
	if(!outFile.exists()){
		outFile.mkdir();
	}
	outFile = new File(outPath+file);
	if(!outFile.exists()){
		freemarkerUtils.generate("/backend/template/edit.jsp",root,outPath+file,request);
	}
	out.print("ok");
%>