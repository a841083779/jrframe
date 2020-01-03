<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.codec.binary.StringUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.jerehnet.util.business.OrderBusiness"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Random"%>

<%
  
    List<Map> otherProducts=null;
	String productid = CommonString.getFormatPara(request.getParameter("productid")) ;
	String rand = CommonString.getFormatPara(request.getParameter("rand")) ;
	String username = CommonString.getFormatPara(request.getParameter("name")) ;
	String telephone = CommonString.getFormatPara(request.getParameter("telephone")) ;
	String contact_address = CommonString.getFormatPara(request.getParameter("zd_contact_address")) ;
	contact_address = URLDecoder.decode(contact_address,"utf-8");
	String province = CommonString.getFormatPara(request.getParameter("province")) ;  // 省份
	province = URLDecoder.decode(province,"utf-8");
	String city = CommonString.getFormatPara(request.getParameter("city")) ;
	city = URLDecoder.decode(city,"utf-8");
	String buy_time = CommonString.getFormatPara(request.getParameter("buy_time")) ;  // 预计购买时间
	String ifgroup = CommonString.getFormatPara(request.getParameter("ifgroup")) ; // 公司或个人
	String company = CommonString.getFormatPara(request.getParameter("company")) ; // 公司名字
	String source = CommonString.getFormatPara(request.getParameter("source"));
	String uuids = "" ;
	for(int i=0;i<5;i++){
		uuids += CommonString.getUUID() +",";
	}
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map oneproduct  = null ;
	if(!"".equals(productid)){
	 	oneproduct = dbHelper.getMap(" select brand_id as factoryid, brand_name as factoryname,catalog_name as catalogname,name,file_name, catalog_num as catalognum from pro_machine_products where id='"+productid+"' ") ;
	}

	if(null == oneproduct || oneproduct.size()==0){
%>
<script type="text/javascript">  parent.window.jBox.close() ; </script>
<%
          return ;
	}
	

 


		String sql = "";
		sql += " select top 4  id,img as img2,brand_id as factoryid, brand_name as factoryname,catalog_name as catalogname,name,file_name, catalog_num as catalognum from pro_machine_products where catalog_num like '%"+CommonString.getFormatPara(oneproduct.get("catalog_num"))+"%'  order by newid()";

		otherProducts = dbHelper.getMapList(sql) ;

	if(null == otherProducts){
		otherProducts = new ArrayList() ;
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线询价</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body { padding: 5px 10px; font-family: 'Microsoft Yahei' }
.top_t { color: #4e5762; font-size: 18px; border-bottom: 1px solid #dfdfdf; padding-bottom: 7px; }
.top_t1 { font-size: 18px; height: 85px; line-height: 85px; font-weight: bold; border-bottom: 1px dashed #f1f1f2 }
.top_t1 .img { vertical-align: middle; margin-right: 10px; }
.list_t { font-size: 16px; font-weight: bold; margin-bottom: 10px; }
.list_t span { color: #fe6000 }
.tj li { float: left; width: 50%; margin-bottom: 1px; }
.tj li span { display: block; margin-bottom: 5px; }
.tj li span.n { color: #990000 }
.tj li input[type=checkbox] { vertical-align: middle; margin-right: 5px; }
.orderbg{ padding-bottom:5px; border-bottom:1px solid #dfdfdf; margin-bottom:5px;}
.orderbg .img { position: absolute; right: 20px; bottom: 50px; width: 210px; height: 45px; }
.xj_btn { width: 267px; height: 61px; background: url(/include/products/images/xunjia.png) no-repeat; border: 0; cursor: pointer }
.STYLE1 { color: #FF0000 }
.jbox-close{ display:none !importent}
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css">
</link>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script type="text/javascript">
  function closeAll(){
   $(".chk_list").attr("checked",false);
parent.window.jBox.close();
		
	}
  function closethiswindow(){
  window.close() ;
  }
 
 
  function inquery(flag){
   var products_ids ="";
   jQuery("input:checkbox:checked").each(function(){
    products_ids += jQuery(this).val() +","; 
   }) ;
   if(products_ids.length>0){
     products_ids = products_ids.substring(0,products_ids.length-1) ;
   }
   jQuery.post("/nj/action/order_save.jsp",{
  	 	if_tag:"fourorders",
  	 	username:"<%=username%>",
  	 	telephone:"<%=telephone%>",
  	 	contact_address:"<%=contact_address%>",
  	 	pro_ids:products_ids,
  	 	contact_addr:"<%=contact_address%>",
  	 	uuids:"<%=uuids%>",
  	 	province:"<%=province%>",
  	 	city:"<%=city%>",

  	 },function(msg){
		  parent.jQuery.jBox.tip("询价成功！") ;
		 setTimeout("parent.window.jBox.close()",1000) ;
   });
   }
   $(function(){$("body",parent.document).find('.jbox-close').hide()})

</script>
</head>
<body>
<h3 class="top_t">询价成功</h3>
<div class="top_t1"><img src="/include/products/images/succ1.png" width="74" height="77" class="img">您在<span style="color:red"><a style="color:red" href="http://product.21-sun.com/" target="_blank">铁臂商城</a></span>的询价已提交，<span ><a style="color:red" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneproduct.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(oneproduct.get("catalognum"))%>#main" target="_blank"><%=CommonString.getFormatPara(oneproduct.get("factoryname"))%></a></span>将及时联系您进行报价！</div>
<div class="orderbg fix"> <!--<img src="/images/xj_tel.png" alt="客服热线" class="img" />-->
  <p class="list_t">您可以对以下机型同时询价，获得更多的价格参考</p>
  <div class="l" style=" width:58%">
    <ul class="fix tj">
	                        <%
								Map imgs = null ;
			                    int i=0;
								String model_name="";String factory_ids="";String catalog_nums="";String catalog_names="";
								for(Map oneMap:otherProducts){
								model_name=CommonString.getFormatPara(oneMap.get("name"));
								catalog_nums=CommonString.getFormatPara(oneMap.get("catalognum"));
								factory_ids=CommonString.getFormatPara(oneMap.get("factoryid"));
								catalog_names=CommonString.getFormatPara(oneMap.get("catalog_name"));
								if(model_name.length()>8){model_name=model_name.substring(0,8)+"...";}
							%>
      <li><img src="http://product.21-sun.com//uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="103" height="84" class="l"><span id="brand_name">品牌：<%=CommonString.getFormatPara(oneMap.get("factoryname")) %></span>
	  <span>型号：<%=model_name %></span>
	  <span class="n"><input type="checkbox" name="chk_list" class="chk_list" id="input_<%=i%>" rel="<%=factory_ids%>:<%=catalog_nums%>" value="<%=CommonString.getFormatPara(oneMap.get("id")) %>" >
        请点击选择</span></li>
      <%i++;}%>
    </ul>
  </div>
  <div class="r" style="width:40%; border-left:1px solid #e6e6e6; text-align:center">
  <img src="/include/products/images/erwei.png" width="96" height="96">  &nbsp; 
  <p style=" width:136px; margin:0 auto; text-align:center;line-height: 20px;">铁臂商城手机版<br>随时随地询价<br>QQ群:250469589</p>
  </div>
</div>
<div style="width:60%; text-align:center"><input class="xj_btn" name="Submit" type="button" value="" onClick="inquery();"/><a href="javascript:void(0)" onclick="closeAll()">【暂不询价】</a></div>
</div>
</body>
</html>

