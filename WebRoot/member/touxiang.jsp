<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	String uid="1234";
	String modelImg = "/uploadfiles/image/" + CommonDate.getToday("yyyy") + "/" + CommonDate.getToday("MM") +"/"+ uid + "_middle.jpg";
	String bigImg = "/uploadfiles/image/" + CommonDate.getToday("yyyy") + "/" + CommonDate.getToday("MM") +"/"+ uid + "_big.jpg";
	String smallImg = "/uploadfiles/image/" + CommonDate.getToday("yyyy") + "/" + CommonDate.getToday("MM") +"/"+ uid + "_small.jpg";
	Map memberInfo = (Map)session.getAttribute("memberInfo");
    if(memberInfo==null){
		    Common.do302(response,"http://koubei.21-sun.com/");
			return;
	}
    String uuid=CommonString.getFormatPara(memberInfo.get("uuid"));
	String sql = " select * from pro_member where uuid= '"+uuid+"'" ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map user_info = null ;
	if(!"".equals(uuid)){
		user_info = dbHelper.getMap(sql) ;
	}
	if(null==user_info || user_info.size()<=0){
		//response.sendRedirect("http://koubei.21-sun.com/") ;
	}
	String usern= CommonString.getFormatPara(memberInfo.get("username"));
	String nickname= CommonString.getFormatPara(memberInfo.get("nickname"));
	if(nickname.equals("")){nickname=usern;}	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<title>个人中心</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>

<script type="text/javascript" src="http://www.wajueji.com//scripts_new/common.js"></script>
<script type="text/javascript" src="http://www.wajueji.com//scripts_new/common1.js?date=20131031"></script>

</head>
<body>
<!--top-->
<div class="m_newTop">
  <div class="wrapper">
    <h2 class="l"><a href="index.jsp"><img width="219" height="40" src="images/mem_logo.png" alt="铁臂商城购物中心"></a></h2>
    <ul class="m_nav">
      <li><a href="#" class="n">网站<i></i></a>
        <div class="box">
          <a href="#">网站首页</a>
          <a href="#">铁臂商城</a>
          <a href="#">铁臂兄弟连</a>
          <a href="#">铁臂口碑</a>
          <a href="#">铁臂图库</a>
          <a href="#">铁臂维修</a>
          <a href="#">铁臂视频</a>
          <a href="#">铁臂资讯</a>
        </div>
      </li>
      <li><a href="#" class="n">应用<i></i></a>
        <div class="box">
          <a href="koubei.jsp">我的口碑</a>
          <a href="#">我上传的图片</a>
          <a href="#">我的维修知识</a>
          <a href="#">我上传的视频</a>
        </div>
      </li>
    </ul>
    <div class="top_search">
      <input type="text" name="top_input" id="top_input" value="请输入搜索内容" onfocus="if(this.value == '请输入搜索内容'){this.value=''}" onblur="if(this.value == ''){this.value='请输入搜索内容'}" class="top_input">
      <li class="select_box"> <span>帖子</span>
        <ul style="display: none;" class="son_ul">
          <li value="0">帖子</li>
          <li value="1">用户</li>
        </ul>
      </li>
      <input type="hidden" id="top_select" value="0">
      <a class="top_btn" href="javascript:void(0);" onclick="goSearch()"></a> 
      <script type="text/javascript">
	  /*
          $(document).ready(function(){
             $('.son_ul').hide(); //初始ul隐藏
             $('.select_box span').hover(function(){ //鼠标移动函数
                $(this).parent().find('ul.son_ul').slideDown(200);  //找到ul.son_ul显示
                $(this).parent().find('li').hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')}); //li的hover效果
                $(this).parent().hover(function(){},
                                       function(){
                                           $(this).parent().find("ul.son_ul").slideUp(200); 
                                           }
                                       );
                },function(){}
                );
            $('ul.son_ul li').click(function(){
              $("#top_select").val($(this).attr('value'));
              $(this).parents('li').find('span').html($(this).html());
              $(this).parents('li').find('ul').slideUp(200);
            });
          });
		  */
          function goSearch(){
              var tar = $("#top_select").val();
              var str = $("#top_input").val();
              if($.trim(str) == ''){
                  $.jBox.tip('请输入搜索内容');
              }
              if(tar == 0){
                   window.location.href='/service/searchList.jsp?keyWord='+str;
              }else{
                  window.location.href='/newMember.jsp?keyWord='+str;
              }
          }
      </script> 
    </div>
    <div class="mtl m_set"><a class="m_Ico"><em></em></a></div>
    <div class="b_nav_member" style="background: none;width: auto;">
      <a href="/infocenter/index.jsp"><img width="30" height="30" src="images/noface.png" class="b_faceimg"></a> 
      <span class="b_name" style="width: auto;">
        <a href="/infocenter/index.jsp" style="color: #FFF;"><%=nickname%></a>
        <a href="/tools/exit.jsp" style="color:#fff;">[退出]</a>
      </span>
    </div>
  </div>
</div>
<!--top end-->

<div class="wrapper m_contain mb20 fix">
  <!--left-->
  <div class="m_leftPart">
    <div class="mem-con">
      <div class="mem-face">
        <img width="175" height="175" src="images/noface.png">
      </div>
      <ul style="display:none" class="mem-info">
        <li><strong>780</strong><br>
          粉丝</li>
        <li style="border:none;"><strong>895</strong><br>
          关注</li>
      </ul>
	  <ul align="center" class="mem-info">
	     <span ><%=nickname%></span>
      </ul>
    </div>
    
    <h3 class="mt">我发布的</h3>
    <ul class="m_leftMenu">
      <li><a  href="koubei.jsp"><span class="n"><img src="images/menu_ico01.png">我的口碑</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico02.png">我上传的图片</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico03.png">我的维修知识</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico04.png">我的上传视频</span></a></li>
    </ul>
    <div class="m_line"></div>
    
  </div>
  <!--left end-->
  <!--right-->
  <div class="m_rightPart">
    <div class="mr_menu">
      <ul class="fix">
        <li><a href="index.jsp">首页</a></li>
        <li><a href="info.jsp">个人资料</a></li>
        <li><a href="touxiang.jsp" class="selected">修改头像</a></li>
        <li style="display:none"><a href="#">手机绑定</a></li>
        <li style="display:none"><a href="#">地址管理</a></li>
      </ul>
    </div>
    <div>
      <div class="PCface-con">
      
      <div class="tip">您可以上传JPG、JFEG、BMP文件，文件最大为400KB。</div>
      
          <div class="PCface-left">
            <ul class="faceList" id="faceList1">
          	<script type="text/javascript" src="/scripts/camera/common.js?B6k"></script>
			<script type="text/javascript">document.write(AC_FL_RunContent("width","450","height","253","scale","exactfit","src","/scripts/camera/camera.swf?nt=1&amp;inajax=1&amp;appid=1&amp;input=pic<%=uid%>&amp;uploadSize=2000&amp;ucapi=/action/upload.jsp&amp;avatartype=virtual&amp;agent=f76e1da45697f2bea834d3cc529b10fb","id","mycamera","name","mycamera","quality","high","bgcolor","#ffffff","wmode","transparent","menu","false","swLiveConnect","true","allowScriptAccess","always"));</script>
            </ul>
          </div>
          <div class="PCface-right">
            <ul class="faceYL">
              <li class="big"><img width="180" height="180" id="bigImg" src="/member/images/noface.png">
            <span>大尺寸头像，180 X 180 像素</span></li>
            <li class="mid"><img width="50" height="50" id="middleImg" src="/member/images/noface.png">
            <span>中尺寸头像<br>50 X 50 像素<br>(自动生成)</span></li>
            <li class="small"><img width="30" height="30" id="smallImg" src="/member/images/noface.png">
            <span>中尺寸头像<br>30 X 30 像素<br>(自动生成)</span></li>
            <input type="hidden" value="" id="updateFaceSmall" name="updateFaceSmall">
            <input type="hidden" value="" id="updateFaceMedium" name="updateFaceMedium">
            <input type="hidden" value="" id="updateFaceOriginal" name="updateFaceOriginal">
            </ul>
          </div>
        </div>
    </div>
  </div>
<script type="text/javascript" src="/scripts/uploadify/swfobject.js"></script>
<script type="text/javascript" src="/scripts/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script>

	//上传完成后的回调函数
	function updateavatar(){
		jQuery("#bigImg").attr("src","<%=bigImg %>");
		jQuery("#middleImg").attr("src","<%=modelImg %>");
		jQuery("#smallImg").attr("src","<%=smallImg %>");
		jQuery(".b_faceimg").attr("src","<%=smallImg %>");
		jQuery.ajax({
			url:'/tools/face_temp_event.jsp',
			dataType:'json',
			success:function(data){
				score_tips("上传成功",data);
			}
		});
	}
</script>
  <!--right end-->
</div>
<!--foot-->
<div class="foot">
  <a href="#">广告服务</a>|<a href="#">联系方式</a>|<a href="#">关于我们</a>|<a href="#">本网动态</a>|<a href="#">法律声明</a>|<a href="#">网站导航</a>|<a href="#">联系客服</a><br />
  产品询价专线：4006-521-526<br />
  <a href="http://www.21-sun.com/" target="_blank">中国工程机械商贸网</a> Copyright &copy; 2000-2014
</div>
<!--foot end-->
</body>


</html>
