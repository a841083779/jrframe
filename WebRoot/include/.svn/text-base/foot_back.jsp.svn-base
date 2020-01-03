<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" errorPage="" %>
<%@ page session="false" %>
<%@page import="com.jerehnet.util.common.CommonString"%>
<div style="width:980px; margin:0 auto; clear:both;" class="proFoot">
<%
	HttpClient httpClient = new HttpClient();
	GetMethod getMethod = new GetMethod("http://www.21-sun.com/include/foot.htm");
	httpClient.executeMethod(getMethod);
	String outStr = new String(getMethod.getResponseBody(),"utf-8");
	out.print(outStr);
%>
</div>
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://product.21-sun.com', "");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script>
<script type="text/javascript">
<%
	String refer = CommonString.getFormatPara(request.getHeader("referer")) ;
	if(refer.indexOf("/brand/")==-1){    
	%>
	if(jQuery(".shop_topbg").offset() != null){
    	jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
	}
	<%
	}
%>
</script>