<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*,org.json.*" %><% 

	String city="青岛";
	String province=CommonString.getFormatPara(request.getParameter("province"));
	String pro_id = CommonString.getFormatPara(request.getParameter("pro_id")) ;
	
	DBHelper dbHelper = DBHelper.getInstance() ;

	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
	   Map one_more = new HashMap() ;
	    //代理商推荐
		  String where="";
		  String whereed="";
			if(!city.equals("")){
			where=" and (full_name like '%"+city+"%'  or address like '%"+city+"%') order by view_count desc ";
		   }
		   

		one_more = dbHelper.getMap(" select top 1 full_name,name,address from pro_agent_factory where agent_fac='"+pro_id+"'"+where,connection) ;
		System.out.println("select top 1 full_name,name,address from pro_agent_factory where agent_fac='"+pro_id+"'"+where);
		
		if(one_more==null){
		whereed=" and (city like '%"+province+"%'  or address like '%"+province+"%') order by view_count desc ";
		one_more = dbHelper.getMap(" select top 1 full_name,name,address from pro_agent_factory where agent_fac='"+pro_id+"'"+whereed,connection) ;
		}
		System.out.println("select top 1 full_name,name,address from pro_agent_factory where agent_fac='"+pro_id+"'"+whereed);
%>
<%
   if(one_more!=null){
   String full_name=CommonString.getFormatPara(one_more.get("full_name"));
  if(full_name.equals("")){full_name=CommonString.getFormatPara(one_more.get("name"));}
   %>
 
    <div class="t_hd">您可以选择代理商进行询价：</div>
    <div class="t_bd">
      <ul>
        <li>
          <input type="checkbox" name="checkbox" id="checkbox" class="checkbox"  value="<%=full_name%>"/>
          <div class="box">
            <div class="bo1"><font color="red"><%=full_name%></font> <span class="tip">(提交询价后会立即收到最低价短信)</span></div>
            <div class="bo2">地址：<%=CommonString.getFormatPara(one_more.get("address"))%></div>
          </div>
        </li>
      </ul>
    </div>
 
<%}%>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>