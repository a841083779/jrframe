<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%
    DBHelper dbHelper = DBHelper.getInstance() ;
    String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
	String  catalogNames="";
	if(catalog.equals("101")){catalogNames="罐车产品";}
	if(catalog.equals("102")){catalogNames="环卫产品";}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>中集凌宇旗舰店-中国工程机械商贸网</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/lingyu.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
</head>
<body class="fy_body">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end--> 
<!--main-->

  <div class="wrap ly_fav fav_list fix">
   <h1 class="l"><a href="/brandshop/lingyu/"><img src="images/logo.png" width="308" height="75" alt="凌宇汽车" /></a></h1>
  联系电话：0379-65937600<span onclick="addShop()" style="cursor:pointer">收藏本店</span>
  </div>
  <div class="ly_nav list_nav">
    <div class="wrap fix ly_mu list_mu">     
      <ul class="fix">
        
		<li <% if(catalog.equals("")){%>class="f"<%}%>><a href="/brandshop/lingyu/" <% if(catalog.equals("")){%>class="cur"<%}%> title="首页">首页</a></li>
        <li <% if(catalog.equals("101")){%>class="f"<%}%>><a href="/brandshop/lingyu/list.jsp?catalog=101"  <% if(catalog.equals("101")){%>class="cur"<%}%> title="罐车产品">罐车产品</a></li>
		<li <% if(catalog.equals("102")){%>class="f"<%}%>><a href="/brandshop/lingyu/list.jsp?catalog=102"  <% if(catalog.equals("102")){%>class="cur"<%}%> title="环卫产品">环卫产品</a></li>
		
      </ul>
    </div>
  </div>

<div class="list_content wrap fix">
<div class="l lcleft">
<h2 class="lf_title">所有产品分类>></h2>
<ul class="lf_cg">
<li><a href="/brandshop/lingyu/list.jsp?catalog=101"  <% if(catalog.equals("101")){%>class="selected"<%}%> title="罐车产品">罐车产品</a></li>
<li><a href="/brandshop/lingyu/list.jsp?catalog=102"  <% if(catalog.equals("102")){%>class="selected"<%}%> title="环卫产品">环卫产品</a></li>
</ul>
<div class="lf_about">
<h2>店铺介绍</h2>
<p>洛阳中集凌宇汽车有限公司位于有着“千年帝都，牡丹花城”美誉的九朝古都洛阳，是一家具有40余年汽车生产历史的企业，是中集车辆（集团)有限公司（简称：中集车辆集团）的骨干成员企业之一。</p>
</div>
</div>
<div class="r lcright">
<h2><%=catalogNames%></h2>
<!--list-->
<div class="hot">
<ul class="fix lcright_mu">
	<%		String fullName=null;
			String imgSrc=null;
			String catalogName=null;
			String name=null;
			String file_name=null;	
			String id =null;
			String offset = CommonString.getFormatPara(request.getParameter("offset"));
       		List<Map> orderList = null ;
       		PageBean pageBean = new  PageBean() ;
       		pageBean.setPageSize(9) ;
			Integer nowPage = 1;
			if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
			}
			if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
			}
      		 pageBean.setTableName("pro_products") ;
      		 pageBean.setFields("id,name,file_name,img2,catalogname_spe,catalognum,zoomlion_hot_pic ,catalogname,zoomlion_hot,order_no") ;
      		 pageBean.setCondition("and factoryid=767 and is_show=1 and catalognum_spe like '"+catalog+"%' ") ;
      		 pageBean.setNowPage(nowPage) ;
       		pageBean.setOrderBy("order_no desc") ;
      		 pageBean.setParams("#to_order") ;
       		orderList = pageBean.getDatas();
	    	if(null!=orderList && orderList.size()>0){
		 	 int k = orderList.size()>9?9:orderList.size() ;
      	 	Map oneMap = null ;
	  	 	for(int i=0;i<k;i++){
	  	 	oneMap=orderList.get(i) ;
			catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));					  
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  String catalogName_name=catalogName+name;
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
	    		  %>		   
  <li>  
		  <a href="http://product.21-sun.com/proDetail/<%=file_name %>" alt="<%=name%>" target="_blank"> 
		  <img  title="<%=name%>" width="225" height="162" src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"   onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>		
		</a>
        <div class="pro_info fix">
          <div class="l fix">
          <div class="l">
		  <a title="<%=catalogName+fullName%>"href="/proDetail/<%=file_name %>" target="_blank">
		  <strong><%=catalogName_name.length()>20?catalogName_name.substring(0, 20)+"..":catalogName_name%>
           </strong>
		   </a>
			<a target="_blank" class="cs" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a>|
		
        <a  target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" class="pj">评论</a></div>
        <div class="r"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','144')">立即询价</a></div>
		   </div>          
        </div>
      </li>
	  <%} }%>
      
</ul>
</div>
<!--page-->
 <div>
    
	<div class="page paging" style="margin-left:215px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
	</div>
		
        </div>
  </div>

</div>
</div>

<!--main end--> 
<!--foot-->
<div class="">
  <jsp:include page="/include/foot.jsp"/>
</div>
<!--foot end--> 
<script type="text/javascript">
function addShop(){ // 收藏店铺
    var url = 'http://product.21-sun.com/brandshop/lingyu/';
	try{
       window.external.addFavorite(url, '中集凌宇汽车');
   }catch (e){
       try{
           window.sidebar.addPanel('中集凌宇汽车',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script>
</body>
</html>