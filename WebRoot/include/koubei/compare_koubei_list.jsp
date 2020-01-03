<%@ page language="java" import="java.sql.Connection,com.jerehnet.util.dbutil.*,java.util.*,com.jerehnet.util.common.*,org.json.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String id = CommonString.getFormatPara(request.getParameter("id"));
	try{
		connection = dbHelper.getConnection();
%>
<cache:cache cron="* * */2 * *">
<%		
	    List<Map> commentListFirst = dbHelper.getMapList(" select top 3 id,name,content,good,bad,score1,score2,score3,score4,add_date from pro_comments where  product_id="+id+" order by id desc",connection);
%>
<link href="/plugin/tip/yitip/css/jquery.yitip.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<script type="text/javascript" src="/plugin/area/city/citys.js"></script>
      <%
	   if(commentListFirst.size()>0){
	   		int i=0;

			for(Map oneMap:commentListFirst){
			int score=Integer.parseInt(CommonString.getFormatPara(oneMap.get("score1")))+Integer.parseInt(CommonString.getFormatPara(oneMap.get("score2")))+Integer.parseInt(CommonString.getFormatPara(oneMap.get("score3")))+Integer.parseInt(CommonString.getFormatPara(oneMap.get("score4")));
		    score=score/4;
	 %>
         <li>
                  <div class="cd_user_inf np_fix">
                    <div class="cd_user_name l"><%=CommonString.getFormatPara(oneMap.get("name"))%></div>
                    <div class="l cd_user_star" id="pro_<%=CommonString.getFormatPara(oneMap.get("id"))%>"></div>
                    <div class="cd_user_score l"><%=score%>分</div>
                    <div class="cd_user_time r"><%= CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(oneMap.get("add_date")))%></div>
                  </div>
                  <div class="np_fix cd_user_future"> <span>优点：</span>
                    <p><%=CommonString.getFormatPara(oneMap.get("good")).equals("")?"暂无":CommonString.getFormatPara(oneMap.get("good"))%></p>
                  </div>
                  <div class="np_fix cd_user_future"> <span>缺点：</span>
                    <p><%=CommonString.getFormatPara(oneMap.get("bad")).equals("")?"暂无":CommonString.getFormatPara(oneMap.get("bad"))%></p>
                  </div>
                  <div class="np_fix cd_user_future"> <span>建议：</span>
                    <p><%=CommonString.getFormatPara(oneMap.get("content")).length()>100?CommonString.getFormatPara(oneMap.get("content")).substring(0,100)+"...":CommonString.getFormatPara(oneMap.get("content"))%></p>
                  </div>
        </li>
		<script type="text/javascript">
        function getAllCommentOther_<%=CommonString.getFormatPara(oneMap.get("id"))%>(){
		var id=<%=CommonString.getFormatPara(oneMap.get("id"))%>;
			jQuery("#pro_"+id).raty({
				half : true ,
			    readOnly : true,
				score : <%=score/20%>
			});
	 }
	 getAllCommentOther_<%=CommonString.getFormatPara(oneMap.get("id"))%>();
        </script>
      <%}}else{%>
	    暂无相关产品评论！
	  <%}%>


</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>