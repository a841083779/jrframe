<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page session="false" %>
<%
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String img = CommonString.getFormatPara(request.getParameter("img"));
	String sql = " select name,img_name from pro_product_pic where product_id = ? ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{id});
%>
<div class="wfull l" id="myTab2_ContentA2"> 
  <script type="text/javascript" src="/scripts/upscroll.js"></script> 
  <script type="text/javascript">
	jQuery(document).ready(function(){
        jQuery(".pdil").Scroll({line:1,speed:500,up:"pdilup",down:"pdildown"});
	});
	jQuery(function () {
		jQuery(".pdil a").click(function () {
			jQuery("#BigImage").fadeTo(0, 0);
			jQuery("#BigImage").attr("src", jQuery(this).attr("href"));
			jQuery("#BigImage").fadeTo(300, 1);
			jQuery(".pdil a").removeClass("picur");
			jQuery(this).addClass("picur");
			return false;
		})
	})
	</script>
  <div class="pdbigImg"><img src="/uploadfiles/<%=img%>" width="582" height="442" id="BigImage" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" /></div>
  <div class="pdImgList">
    <div class="pdimgBtn_up"><img src="/images/picbtn_up.gif" width="130" height="25" id="pdildown" /></div>
    <div class="pdil">
      <ul>
        <li><a href="/uploadfiles/<%=img%>" class="picur"><img src="/uploadfiles/<%=img%>" width="124" height="91" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"/></a></li>
        <%
			if(list != null && list.size() > 0){
				for(Map m : list){
					
		%>
        <li><a href="<%=CommonString.getFormatPara(m.get("img_name")).indexOf("uploadfiles")>0?CommonString.getFormatPara(m.get("img_name")):"/uploadfiles/"+CommonString.getFormatPara(m.get("img_name"))%>"><img src="<%=CommonString.getFormatPara(m.get("img_name")).indexOf("uploadfiles")>0?CommonString.getFormatPara(m.get("img_name")):"/uploadfiles/"+CommonString.getFormatPara(m.get("img_name"))%>" width="124" height="91" /></a></li>
        <%
				}
			}
		%>
      </ul>
    </div>
    <div class="pdimgBtn_down"><img src="/images/picbtn_down.gif" width="130" height="25" id="pdilup" /></div>
  </div>
</div>