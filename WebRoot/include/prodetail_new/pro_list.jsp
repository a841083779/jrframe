<%@ page language="java" import="java.sql.Connection,com.jerehnet.util.dbutil.*,java.util.*,com.jerehnet.util.common.*,org.json.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */1 * *">
<%  
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
    String tonand = CommonString.getFormatPara(request.getParameter("tonand"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	if(tonandmeter.indexOf(".")>=0){
		tonandmeter=tonandmeter.substring(0,tonandmeter.indexOf("."));
	}
    String model= CommonString.getFormatPara(request.getParameter("model"));
	Map brandMap = (Map) application.getAttribute("brandMap");
	Map catalogMap = (Map) application.getAttribute("catalogMap");
   
	DBHelper dbHelper = DBHelper.getInstance() ;
    List<Map> proList= null ;
	String whereStr="";	
	if(!tonandmeter.equals("")&&!tonandmeter.equals("0")){
		whereStr=whereStr+" and tonandmeter<="+(Integer.parseInt(tonandmeter)+Integer.parseInt(tonandmeter)*0.1)+" and tonandmeter> "+(Integer.parseInt(tonandmeter)-Integer.parseInt(tonandmeter)*0.1);
	}
	proList = dbHelper.getMapList(" select top 6 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1 and   catalognum like  '"+catalognum+"%'  and img2 is not null and img2 != ''  "+whereStr+"  order by newid() ") ;
%>
        <div class="txd_plant fix">
          <div class="tpl_title"><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=model%>同类产品</div>
		   <a href="javascript:void(0)"   onClick="doFresh('<%=factoryid%>','<%=catalognum%>','<%=tonand%>','<%=tonandmeter%>');"  style="  display: block;float: right;line-height: 20px;margin-top: 4px;margin-right: 5px;">换一批</a>
        </div>
        <div class="prodt_rec">
          <ul id="other_people_see"> 
		    <%
	        if(proList!=null&&proList.size()>0){
		    for(Map oneMap:proList){
				String img="/"+CommonString.getFormatPara(oneMap.get("img2"));
				if(img.indexOf("uploadfiles")<0){img="/uploadfiles/"+img;}
	         %>
            <li><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>"> <img onerror="this.src='/uploadfiles/no_big.gif'" src="http://product.21-sun.com/<%=img%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" class="_img"></a>
              <div class="_text"> <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>">
                <div class="_t"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%> </div>
                </a>
                <div class="_btn"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")%>_parameter.shtm#position">参数</a><em>|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")%>_intro.shtm#position">性能</a><em>|</em><a href="javascript:void(0)">加入对比</a></div>
              </div>
            </li>
           <%}}%>
          </ul>
        </div>
<script>
	function doFresh(a,b,c,d){
	jQuery.ajax({
		url:"/action/ajax.jsp",
		type:"post",
		data:{"factoryid":"<%=factoryid%>","catalognum":"<%=catalognum%>","tonand":"<%=tonand%>","tonandmeter":<%=tonandmeter%>,"flag":"doFresh"},
		success:function(data){
			jQuery("#other_people_see").html(data);
		}
	});
	}
</script>
</cache:cache>