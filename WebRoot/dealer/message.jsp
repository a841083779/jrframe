<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
		if(usern.equals("hfxy")){
%>
    <script>
	window.location.href="http://product.21-sun.com/agentstore/hfxy/";
	</script>
<%	
	}
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		Integer is_shop = CommonString.getFormatInt(map.get("is_qijiandian"));
		/*
		if(is_shop.equals(1)){
			Common.do302(response,"/agentshop/"+CommonString.getFormatPara(map.get("usern"))+"/");
			return;
		}
		*/
	// 预计购买时间
	LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
	String ip  = Common.getIp(request);
	String jsonStr = Tools.getMyProvinceAndCity(ip);
	String city = "";
	String province = "";
	if(!CommonString.getFormatPara(jsonStr).equals("")){
		JSONObject obj = new JSONObject(jsonStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
	}
	//代理品牌
	String dali_brand="";
	//代理产品
    String dali_pro="";
    String factoryid="";
	String agent_fac_id_list=CommonString.getFormatPara(map.get("agent_fac"));
    String fac_ids_list[]=agent_fac_id_list.split(",");
	if(fac_ids_list.length>0){
	    for(int i=0;i<fac_ids_list.length;i++){
		    if(!fac_ids_list[i].equals("")){	
			Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids_list[i],connection);
			if(facInfo!=null){factoryid=fac_ids_list[i];}
			   //dali_brand+=CommonString.getFormatPara(facInfo.get("name"));
			     //  List<Map> proInfo = dbHelper.getMapList("select catalognum,catalogname from pro_agent_product_vi where agentid = '"+CommonString.getFormatPara(map.get("id"))+"' and factoryid = '"+fac_ids_list[i]+"'  group by catalognum,catalogname order by catalognum",connection);
                            // for(Map oneMap : proInfo){
							  //dali_pro+=CommonString.getFormatPara(facInfo.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"));
							// }
			}				 
	 }
   }
   
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=CommonString.getFormatPara(map.get("full_name"))%>留言反馈 – 铁臂商城代理商平台</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("full_name"))%>留言反馈" />
<meta name="description" content="铁臂商城代理商平台提供<%=CommonString.getFormatPara(map.get("full_name"))%>留言反馈频道，欢迎您留言并提出改善建议。" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" />
<link href="http://product.21-sun.com/dealer/style/style.css" rel="stylesheet" />
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.form.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="http://product.21-sun.com/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript">
//导航选中状态
var jrChannel='0#0'
//店铺导航选中状态
var jrChannel_shop='0#0'
</script>
</head>
<body class="shop02">
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->
<div class="shop_con">
  <div class="shop_top01">
    <div class="contain980 fix">
      <h1 class="logo"><%=CommonString.getFormatPara(map.get("full_name"))%>
        <strong class="site"><a title="http://dealer.21-sun.com/<%=usern%>/" href="http://dealer.21-sun.com/<%=usern%>/" target="_blank">http://dealer.21-sun.com/<%=usern%>/</a></strong>
      </h1>
      <div class="mark"><img src="http://product.21-sun.com/dealer/images/mark.png" width="109" height="34" onclick="addShop();return false;"></div>
      <script type="text/javascript">
      function addShop(){
          try{
             window.external.addFavorite('http://dealer.21-sun.com/<%=usern%>/', '<%=CommonString.getFormatPara(map.get("full_name"))%>');
         }catch (e){
             try{
                 window.sidebar.addPanel('<%=CommonString.getFormatPara(map.get("full_name"))%>','http://dealer.21-sun.com/<%=usern%>/',"");
             }catch (e){
                 alert("加入收藏失败，请使用Ctrl+D进行添加");
             }
         }
      }
      </script>
    </div>
  </div>
  <div class="shop_top02">
    <div class="contain980 fix">
      <ul class="shopNav fix">
        <li><a href="/<%=usern%>/">商铺首页</a></li>
        <li><a href="/<%=usern%>/introduce.shtm">公司介绍</a></li>
        <li><a href="/<%=usern%>/agent_products.shtm">产品展示</a></li>
        <li><a href="/<%=usern%>/message.shtm">留言反馈</a></li>
        <li><a href="/<%=usern%>/contact.shtm">联系我们</a></li>
      </ul>
    </div>
  </div>
  
  <div class="shopBanner">
    <img src="http://product.21-sun.com/dealer/images/temp/shop_banner.jpg" width="978" height="188">
  </div>
  
  <div class="contain980 mb10 clearfix">
  <h3 class="breadCrumbs l"><a href="/">铁臂商城代理商平台</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name"))%> &gt;&gt; 留言反馈</h3>
</div>
  <div class="contain980 fix">
    <!--left-->
    <div class="shopLeft">
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>产品分类</h3>
        </div>
        <div class="bd fix">
          <div class="comList" id="brandId">
		    <jsp:include page="/include/agent_new/agent_catalog.jsp" flush="true">
               <jsp:param name="agentid" value='<%=CommonString.getFormatPara(map.get("id"))%>'></jsp:param>
			   <jsp:param name="usern" value='<%=usern%>'></jsp:param>
            </jsp:include>
          </div>
        </div>
      </div>
      <div class="comBox03 mb10 shop_contacts">
        <div class="hd fix">
          <h3>联系方式</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
		      <%if(!CommonString.getFormatPara(map.get("concatus")).equals("")){%><li> 联系人：<%=CommonString.getFormatPara(map.get("concatus"))%></li><%}%>
		      <%if(!CommonString.getFormatPara(map.get("city")).equals("")){%><li> 代理地区：<%=CommonString.getFormatPara(map.get("city"))%></li><%}%>
			  <%if(!CommonString.getFormatPara(map.get("address")).equals("")){%><li>地址：<%=CommonString.getFormatPara(map.get("address"))%></li><%}%>
               <%if(!CommonString.getFormatPara(map.get("email")).equals("")){%><li>邮箱：<%=CommonString.getFormatPara(map.get("email"))%></li><%}%>
          </div>
        </div>
      </div>
      
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>其他该地域代理商</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
		    <jsp:include page="/include/agent_new/other_agent.jsp" flush="true">
			   <jsp:param name="area" value='<%=CommonString.getFormatPara(map.get("city"))%>'></jsp:param>
            </jsp:include>
          </div>
        </div>
      </div>
    <%if(!factoryid.equals("")){%>  
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>更多品牌代理商</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
		    <jsp:include page="/include/agent_new/other_agent.jsp" flush="true">
			   <jsp:param name="agent_fac" value='<%=factoryid%>'></jsp:param>
            </jsp:include>
          </div>
        </div>
      </div>
     <%}%>
    </div>
    <!--left end-->
    <!--right-->
      <div class="shopRight">
      <div class="shop_crumbs">留言反馈&gt;&gt;</div>
      <div class="shop_message">
	  <form method="post" action="/crud.jsp" name="theform" id="theform">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <th><font>*</font>您的称呼：</th>
            <td><input type="text" name="zd_username" id="zd_username" class="ip" type="required"></td>
          </tr>
          <tr>
            <th><font>*</font>联系方式：</th>
            <td><input type="text" name="zd_contact" id="zd_contact" class="ip"></td>
          </tr>
          <tr>
            <th><font></font>Email：</th>
            <td><input type="text" name="zd_email" id="zd_email" class="ip"></td>
          </tr>
          <tr>
            <th><font></font>企业名称：</th>
            <td><input type="text" name="zd_company" id="zd_company" class="ip">
              如果是个人，请填写“个人”</td>
          </tr>
          <tr>
            <th><font></font>公司地址：</th>
            <td><input type="text" name="zd_address" id="zd_address" class="ip"></td>
          </tr>
          <tr>
            <th><font>*</font>发表提问内容：</th>
            <td><textarea name="zd_content" id="zd_content" class="textarea" type="required"></textarea>
            <br>
            </td>
          </tr>
		  <!--
          <tr style="display:none">
            <th><font>*</font>验证码：</th>
            <td><input type="text" name="textfield6" id="textfield6" class="yzm">
			<img src="/webadmin/authImgServlet" id="authImg" width="77" height="25" style="vertical-align:middle;"/><a href="javascript:void(0);" onclick="refresh();">看不清？换一张</a></td>
          </tr>
		  -->
          <tr>
            <th onMouseOver="">&nbsp;</th>
            <td><input type="button" name="button2" id="button2" value="提交" class="btn" onclick="tj()"></td>
          </tr>
        </table>
			<input type="hidden" name="tableName" id="tableName" value="pro_agent_online_message">
			<input type="hidden" name="zd_province" id="zd_province" value="<%=province%>">
			<input type="hidden" name="zd_city" id="zd_city" value="<%=city%>">
			<input type="hidden" name="zd_agentid" id="zd_agentid" value="<%=CommonString.getFormatPara(map.get("id"))%>">

		</form>
        <div class="mess_list">
          <h3>在线咨询</h3>
          <div class="mess_box">
            <ul>
             <jsp:include page="/include/agent_new/online_message.jsp" flush="true">
			   <jsp:param name="agentid" value='<%=CommonString.getFormatPara(map.get("id"))%>'></jsp:param>
            </jsp:include>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <!--right end-->
  </div>
</div>
<!--foot-->
<div class="foot_box">
<jsp:include page="/include/foot.jsp" flush="true" />
</div>
<!--foot end-->
<div style="display:none">     <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5953941'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/stat.php%3Fid%3D5953941' type='text/javascript'%3E%3C/script%3E"));</script> </div>
</body>
<script type="text/javascript" src="http://product.21-sun.com/dealer/scripts/common.js"></script>
<script type="text/javascript">
function SetFontSize(size){
   document.getElementById('mainDetail').style.fontSize=size+'px';
}

function refresh(){
	document.getElementById("authImg").src='/webadmin/authImgServlet?now=' + new Date();
}

function tj(){
if(jQuery.trim(jQuery("#zd_username").val()).length == 0)
{
   alert("请输入您的称呼！");
   return false;
}
if(jQuery.trim(jQuery("#zd_contact").val()).length == 0)
{
   alert("请输入您的联系方式！");
   return false;
}
if(jQuery.trim(jQuery("#zd_content").val()).length == 0)
{
   alert("请输入您要提问的内容");
   return false;
}
 $("#theform").ajaxSubmit(function (data) {
 			if($.trim(data)=="1"){
				jQuery.jBox.tip("提交成功！");
				$("form")[0].reset();
			}else if($.trim(data)=="0"){
				jQuery.jBox.tip("提交失败！");
			}
 });
}
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>