<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,com.jerehnet.util.common.CommonString,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.regex.*" pageEncoding="UTF-8"%>
<%
String agent_palce =CommonString.getFormatPara(request.getParameter("agent_area"));
    
	   
%>
<div class="top clearfix">
  <div class="content wrap">
	<div class="logo"><a href="http://product.21-sun.com/" target="_blank"><img src='images/logo.gif'/></a></div>
    <div class="img mr30"> <a href="/tuan/" target="_blank"><img src='images/ymt.gif'/></a></div>
   <div class="city">
    	<span id="allAplace">
		<%
		if(!agent_palce.equals("")){
		%>
		<%=agent_palce%>
		<%}else{%>
		全国
		<%}%>
		</span>
        <ul class="j_Address address">
        <li> <b code="320000">华东地区</b> <span> <a code="320100" href="index.jsp?agent_area=山东"  onclick="changePlace('山东');" >山东</a> <a code="320200" href="index.jsp?agent_area=江苏" onclick="changePlace('江苏');">江苏</a> <a code="320300" href="index.jsp?agent_area=安徽" onclick="changePlace('安徽');">安徽</a> <a code="320400" href="index.jsp?agent_area=浙江" onclick="changePlace('浙江');">浙江</a> <a code="320500" href="index.jsp?agent_area=福建" onclick="changePlace('福建');">福建</a> <a code="320600" href="index.jsp?agent_area=江西" onclick="changePlace('江西');">江西</a> <a code="320700" href="index.jsp?agent_area=上海" onclick="changePlace('上海');">上海</a>  </span> </li>
        <li> <b code="310000">华南地区</b> <span> <a code="310100" href="index.jsp?agent_area=广东" onclick="changePlace('广东');" >广东</a> <a code="310100" href="index.jsp?agent_area=广西"  onclick="changePlace('广西');">广西</a><a code="310100" href="index.jsp?agent_area=海南" onclick="changePlace('海南');">海南</a></span> </li>
        <li> <b code="330000">华中地区</b> <span> <a code="330100" href="index.jsp?agent_area=湖北" onclick="changePlace('湖北');">湖北</a> <a code="330200" href="index.jsp?agent_area=湖南" onclick="changePlace('湖南');">湖南</a> <a code="330300" href="index.jsp?agent_area=河南" onclick="changePlace('河南');">河南</a> </span> </li>
        <li> <b code="440000">华北地区</b> <span> <a code="440100" href="index.jsp?agent_area=北京" onclick="changePlace('北京');">北京</a> <a code="440200" href="index.jsp?agent_area=天津" onclick="changePlace('天津');">天津</a> <a code="440300" href="index.jsp?agent_area=河北" onclick="changePlace('河北');">河北</a> <a code="440400" href="index.jsp?agent_area=山西" onclick="changePlace('山西');">山西</a> <a code="440500" href="index.jsp?agent_area=内蒙古" onclick="changePlace('内蒙古');">内蒙古</a> </span> </li>
        <li> <b code="110000">西北地区</b> <span> <a code="110100" href="index.jsp?agent_area=宁夏" onclick="changePlace('宁夏');">宁夏</a><a code="110100" href="index.jsp?agent_area=新疆" onclick="changePlace('新疆');">新疆</a><a code="110100" href="index.jsp?agent_area=青海" onclick="changePlace('青海');">青海</a><a code="110100" href="index.jsp?agent_area=陕西" onclick="changePlace('陕西');">陕西</a> <a code="110100" href="index.jsp?agent_area=甘肃" onclick="changePlace('甘肃');">甘肃</a> </span> </li>
        <li> <b code="120000">西南地区</b> <span> <a code="120100" href="index.jsp?agent_area=四川" onclick="changePlace('四川');">四川</a> <a code="120100" href="index.jsp?agent_area=云南"  onclick="changePlace('云南');">云南</a><a code="120100" href="index.jsp?agent_area=贵州" onclick="changePlace('贵州');">贵州</a><a code="120100" href="index.jsp?agent_area=西藏" onclick="changePlace('西藏');">西藏</a><a code="120100" href="index.jsp?agent_area=重庆" onclick="changePlace('重庆');"> 重庆</a></span> </li>
		<li> <b code="120000">东北地区</b> <span> <a code="120100" href="index.jsp?agent_area=辽宁" onclick="changePlace('辽宁');">辽宁</a><a code="120100" href="index.jsp?agent_area=吉林" onclick="changePlace('吉林');">吉林</a><a code="120100" href="index.jsp?agent_area=黑龙江" onclick="changePlace('黑龙江');">黑龙江</a> </span> </li>
		<li> <b code="120000">台港澳地区</b> <span> <a code="120100" href="index.jsp?agent_area=台湾" onclick="changePlace('台湾');">台湾</a> <a code="120100" href="index.jsp?agent_area=香港" onclick="changePlace('香港');">香港</a><a code="120100" href="index.jsp?agent_area=澳门" onclick="changePlace('澳门');">澳门</a></span> </li>
      </ul>
    </div>
    <div class="search">
    	<input name="keyword" id="keyword" type="text" class="txt" onKeyDown="tj2();"/>
        <input type="button" class="btn" onclick="tj3();"/>
    </div>
	<script>
		  function tj2(){
		  if((event.ctrlKey&&window.event.keyCode==13)||window.event.keyCode==13) {
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/search/"+keyword+"_0_0_0.htm","target");
		  }
		  }
		  
		  		  		  function tj3(){
		
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/search/"+keyword+"_0_0_0.htm","target");
		 
		  }
	</script>
	<script>
	function changePlace(a){;
	$('#allAplace').val(a);
	}
	</script>
    <div class="tel">
    	<img src='images/tel.gif'/>
    </div>
  </div>
</div>
<div class="nav">
	<ul class="wrap">
		<li><a href="index.jsp">首页</a></li>
        <li><a href="index.jsp?catalog=101001">挖掘机</a></li>
        <li><a href="index.jsp?catalog=101002">装载机</a></li>
        <li><a href="part.jsp">配件</a></li>
        <li><a href="index.jsp?catalog=113001">破碎锤</a></li>
        <li><a href="index.jsp?catalog=other">其他设备</a></li>
        <li><a href="http://koubei.21-sun.com" target="blank">铁臂口碑</a></li>
        <li><a href="activity.jsp">专题活动</a></li>
    </ul>
</div>
<div style="display:none"><script src="http://s6.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> </div>