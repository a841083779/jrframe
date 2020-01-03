<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.net.*"%>
<%
String path = request.getRealPath("/");
String filename = (request.getParameter("filename"));
if(filename==null) filename="";
filename=filename.replace("..","");
String title = (request.getParameter("title"));		
if(title==null) title="";
if(filename.length()>4){
	if(filename.indexOf(".")!=-1){
		title = title + filename.substring(filename.lastIndexOf("."));
	}else{
		title = title + filename.substring(filename.length() - 3);
	}
}

filename=path+filename;



java.io.File ff=null;
try{ 
ff=new java.io.File(filename); 
if(!ff.exists()){
out.print("<font color='#FF0000' style='font-size:58px'>error!</font>");
return;
}
} 
catch(Exception e){ 
out.print("<font color='#FF0000' style='font-size:58px'>error!!</font>");
return;
} 

try{
if (ff!=null&&ff.exists()&&ff.isFile()) 
{ 
long filelength = ff.length(); 
InputStream inStream=new FileInputStream(filename); 

response.reset(); 
response.setContentType("charset=utf-8");
response.setContentType("application/x-msdownload");
response.setContentLength((int)filelength); 

response.addHeader("Content-Disposition","attachment; filename=\"" +URLEncoder.encode(title, "UTF-8") + "\""); 
byte[] b = new byte[100]; 
int len; 
while((len=inStream.read(b)) >0) 
response.getOutputStream().write(b,0,len); 
inStream.close(); 
}
}

catch(Exception e){ 
out.print("<font color='#FF0000' style='font-size:58px'>error!!!!</font>");
} 
finally{
//====清除getOutputStream错误===
out.clear();
out = pageContext.pushBody();
}

%>