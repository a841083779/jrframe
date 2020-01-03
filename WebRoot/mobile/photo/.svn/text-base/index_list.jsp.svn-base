<%@ page language="java" import="java.sql.Connection,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*,com.jerehnet.util.common.*"  contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
    <%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
  	
  	DBHelper dbHelper = DBHelper.getInstance() ;
	String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	Connection connection = null;
	
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	String typeName="";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
	//产品图片
	
	List<Map> proList = null ;
	
	String whereStr=" and is_show=1 "; 
	if(!catalog.equals("")){
	   whereStr+=whereStr+"and sort_num like '%"+catalog+"%'";
	}
	
	
	try{
	connection = dbHelper.getConnection();
	PageBean pageBean = new PageBean(); // 分页程序
	Integer nowPage = 1; 
	pageBean.setPageSize(6); // 每页显示条数

	if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
	if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	
    pageBean.setCondition(whereStr);
	pageBean.setNowPage(nowPage);
	pageBean.setFields("id,title,add_user,image,vote_count,add_date,contents");
	pageBean.setTableName(" pro_photo_group");
	//pageBean.setOrderBy(" add_date desc"); 

	proList =  pageBean.getDatas(connection);
	
	
	//所有类别
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList") ;
    if(catalog.equals("107002")){typeName="产品图片";}  if(catalog.equals("107001")){typeName="行业图片";} 
    if(catalog.equals("107003")){typeName="施工图片";}  if(catalog.equals("107004")){typeName="维修图片";} 
    if(catalog.equals("107005")){typeName="展会图片";}  if(catalog.equals("107006")){typeName="趣味图片";}



	String toptitle="9要随手拍——上传"+typeName+"即有奖- 铁臂图库";
	String keywords="工程机械图片库,工程机械"+typeName;
	String description="铁臂图库9要随手拍——就要出风头摄影大赛活动，参与并上传"+typeName+"就有机会获得大奖。买工程机械产品，就上铁臂商城。";

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title><%=toptitle %></title>
<meta name="keywords" content="<%=keywords %>" />
<meta name="description" content="<%=description %>" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="apple-mobile-web-app-title" content="Web Starter Kit">
<link rel="apple-touch-icon" href="/img/apple-touch-icon.png" />
<link rel="apple-touch-startup-image" href="/img/screen.png" />
<meta name="format-detection" content="telephone=no">
<meta name="author" content="design by www.21-sun.com">
<link href="./web/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/activity/tuku/scripts/comm.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="scripts/comm.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="http://www.21-sun.com/00css/new_21sun_include.css" type="text/css" />


</head>
<body>
<!-- 

<div class="kba_top">
  <a class="goback" onclick="backs()" href="javascript:;"><img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/goback.png"> 返回</a>
  <a href="/"><h2 class="logo">铁臂图库</h2></a>
  <a class="login" href="/mobile/photo/web_login_activity.jsp">登录</a>
  <a class="reg" href="/mobile/photo/web_reg.jsp">注册</a>
</div>



-->


<div class="kba_top">
<%if(memberInfo==null){ %>
  <a class="goback" onclick="backs()" href="javascript:;"><img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/goback.png"> 返回</a>
  <a href="/"><h2 class="logo">铁臂图库</h2></a>
  <a class="login" href="/mobile/photo/web_login_activity.jsp">登录</a>
  <a class="reg" href="/mobile/photo/web_reg.jsp">注册</a>
     
  <%}else{ %>
   
   
   <form>
   <a class="goback" onclick="backs()" href="javascript:;"><img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/goback.png"> 返回</a>
  <a href="/"><h2 class="logo">铁臂图库</h2></a>
  <a class="login" ><%=CommonString.getFormatPara(memberInfo.get("username")) %>&nbsp;</a>
  <a class="reg" href="javascript:;" onclick="loginOut();">退出</a>

   </form>
   
   
   
   
 <%}%>
</div>




<div class="c_banner">
<img src="./web/img/temp_banner.jpg" width="640" height="319" >
</div>
<div class="act_menu">
  <div class="flex-row">
    <div class="flex-1"><a href="#" class="cur">首页</a></div>
    <div class="flex-1"><a href="#p1">奖项设置</a></div>
    <div class="flex-1"><a href="#p2">大赛规则</a></div>
    <div class="upload"><a  <%if(username.equals("")){%> href="/mobile/photo/web_login_activity.jsp" <%}else{%> href="javascript:void(0)"  onclick="uploadPic();"<%}%>><img src="./web/img/up_btn.png" width="201" height="53" alt="上传作品" ></a></div>
  </div>
</div>





<div class="works">
  <div class="gt"><img src="./web/img/ico01.png">全部作品</div>
  <div class="work_c fix"  id="piclist">
  <ul>
    <%	
				    if(proList!=null && proList.size()>0){
				    for(Map m:proList){
              		String image = CommonString.getFormatPara(m.get("image"));
					if(image.indexOf("resource.21-sun.com")==-1){
					  image="http://product.21-sun.com/uploadfiles/"+image;
					}
					String id=CommonString.getFormatPara(m.get("id"));
					String contents=CommonString.getFormatPara(m.get("contents"));
					String title=CommonString.getFormatPara(m.get("title"));
					String add_user=CommonString.getFormatPara(m.get("add_user"));
					if(contents.length()>14){contents=contents.substring(0,14)+"...";}
					if(contents.equals("")){contents="无";}
				%>
                	<li>
                    	<a href='http://photo.21-sun.com/ndetail_for_<%=id %>.htm' class='img'><img onerror="showImgDelay(this,'/uploadfiles/no_big.jpg',2);" src='<%=image%>'></a><div class='info'><a href='http://photo.21-sun.com/ndetail_for_<%=id %>.htm'><%=title%><br>拍摄者：<%=add_user%><br>描述：<%=contents%></a>
                       
                    </li>
               <%}}%>    
                    
                </ul>
               
  </div>
            <tags:page pageBean="<%=pageBean%>" />  
 
  
</div>
<div class="act_rules" id="p2">
  <div class="gt"><img src="./web/img/ico03.png">参赛规则</div>
  <div class="act_rules_c">
    <div class="act_tip">
      <div class="tip_tt"><img src="web/img/tip_t01.png"></div>
      <div class="c">
        <strong class="n">会员登录</strong>
        <div class="text">登录活动页面，注册成为铁臂商城会员</div>
      </div>
    </div>
    <div class="act_tip">
      <div class="tip_tt"><img src="web/img/tip_t02.png"></div>
      <div class="c">
        <strong class="n">选择上传照片分类，按要求填写标题</strong>
        <div class="text">标题拟格式：产品品牌+产品型号+其他描述（例如：卡特320D挖鱼塘或 柳工CLG856 1000小时），上传成功，返回继续上传。</div>
      </div>
    </div>
    <div class="rules_d">
      <strong class="n">活动规则：</strong>
      <div class="text">
        1. 本次大赛面向中国大陆（含港、澳）广泛征集，凡铁臂商城注册会员均可参加。<br>
        2. 作品的版权需具有原创性，参赛作品内容必须合法，不涉及著作权、肖像权等侵权现象，作品不能危害国家安全和社会稳定，不得涉及诽谤、色情、暴力。因上述侵权而产生的一切法律责任及造成的一切损失均由参赛作者本人承担。<br>
        3. 凡数码照片均可参赛，并接受手机拍摄的作品。请保留底稿。参赛作品仅可做亮度、对比度、色彩饱和度的适度调整，不得做合成、添加、大幅度改变色彩等技术处理，不接受电脑创意和改变原始影像的作品。<br>
        4.数码电子作品单个文件大小在2M—8M之间， 会员参赛作品数量不限。<br>
        5. 每位参赛者作品投稿后，即被视为已同意大赛主办者及其被许可人拥有参赛者作品的使用权（著作权仍由作者拥有），不另付稿酬。<br>
        6. 参赛者同意铁臂商城拥有本活动规则的最终解释权。凡投稿的作者，均视为同意并遵守以上各条规定，凡不符合征稿要求的作品一经发现一律取消参评资格。<br><br>
        <span class="yellow">拍摄主题：以工程机械为拍摄对象进行拍摄</span><br>
        一、整机美图（整机外观图、街拍、设备摆拍、人机合影）<br>
        二、整机部件（驾驶室拍摄、底盘拍摄、发动机液压系统等部件拍摄）<br>
        三、第一现场（交机现场、不同工况施工现场、维修现场、服务现场、新机发布现场、展会现场、厂家活动现场）
      </div>
    </div>
  </div>
</div>
</body>
<script src="./modules/seajs/sea.js" id="seanode" ></script>
<script src="./web/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('app/index.js')
	
	
	function loginOut(){
	$.post("/action/ajax_mobile.jsp",{message:"exit"},function(data){
		if($.trim(data)=="loginOut"){
			 location.reload();
		}
	});
}
	
	
	//图片切换
	function picChange(obj){
	
	   jQuery("#picArea li").removeClass("cur");
	   if(obj.indexOf("107001") >= 0){
		   jQuery("#107001").addClass("cur");	
	   }else if(obj.indexOf("107002") >= 0){
		   jQuery("#107002").addClass("cur");	
	   }else if(obj.indexOf("107003") >= 0){
		  jQuery("#107003").addClass("cur");	
	   }else if(obj.indexOf("107004") >= 0){
		  jQuery("#107004").addClass("cur");	
	   }else if(obj.indexOf("107005") >= 0){
		  jQuery("#107005").addClass("cur");	
	   }else if(obj.indexOf("107006") >= 0){
		  jQuery("#107006").addClass("cur");	
	   }
	
	
	    jQuery.ajax({
			async : false,
			type : 'post',
			url:'/action/ajax_activity.jsp',
			data:{sort_num:obj} ,			
			success:function(data){
				//alert("data:"+data);
				$("#piclist").html(data);
			}
		});
	     
	}
	//上传图片
	function uploadPic(){
	   window.location.href="/mobile/photo/upload.jsp";
	   //window.open("/mobile/photo/upload.jsp");
	}
	
	
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>