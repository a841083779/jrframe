<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.io.*,com.jerehnet.util.*"%>
<%

	String websiteId = CommonString.getFormatPara(request.getParameter("website_id"));

	String base = application.getRealPath("");

	int i = 0;
	List<Map> linkList = null;
	Connection conn = null;
	
	try {
		String sql = "select link_name,link_addr from link_list where website_id='" + websiteId + "'";
		linkList = WEBDBHelper.getMapList(sql, "Web21sunDBHelper");
		String fileOutPutSteam = "<link href=\"/style/friendly_link.css\" rel=\"stylesheet\" type=\"text/css\" />"
				+ "\n"
				+ "<div class=\"friend_link clearfix\"><ul class=\"link_left\"><li><a href=\"#\">友情链接：</a></li></ul><ul class=\"link_right\">"
				+ "\n";
		if(null!=linkList && linkList.size()>0){
			for(Map m:linkList){
				fileOutPutSteam += "<li class=\"m1\"><a href=\""
						+ CommonString.getFormatPara(m.get("link_addr").toString())
						+ "\" target=\"_blank\">"
								+ CommonString.getFormatPara(m.get("link_name").toString())
						+ "</a></li>" + "\n";
			}
		}
		fileOutPutSteam += "</ul></div>";
		string2File(fileOutPutSteam, base + "/include/index/" + "friendlink_top.htm");
		i = 1;
	} catch (Exception e) {
		e.printStackTrace();
		i = -1;
	} finally {
	}
	if (i == 1) {
%>
<script>
	alert("更新静态页成功！");
	try{
	  window.close();
	}catch(e){}
</script>
<%
	} else if (i == -1) {
%>
<script>
	alert("更新静态页失败！");
	try{
	  window.close();
	}catch(e){}	
</script>
<%
	}
%>
<%!private void string2File(String content, String file) {
		BufferedWriter bwriter = null;
		try {
			bwriter = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "UTF-8"));
			bwriter.write(content);
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				bwriter.flush();
				bwriter.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}
	public static String getFormatInt(String str) {
		String formatStr = "0";
		try {
			if (str == null)
				str = "";
			if (str.indexOf(".") > -1)
				str = str.substring(0, str.indexOf("."));
			formatStr = String.valueOf(Integer.parseInt(str));
		} catch (Exception e) {
			;
		}
		return formatStr;
	}
%>