<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%  
    DBHelper dbHelper = DBHelper.getInstance();
	Map memberInfo = (Map)session.getAttribute("memberInfo");
    if(memberInfo==null){
		    Common.do302(response,"http://koubei.21-sun.com/");
			return;
	}
    String uuid=CommonString.getFormatPara(memberInfo.get("uuid"));
	String sql = " select * from pro_member where uuid= '"+uuid+"'" ;	
	Map user_info = null ;
	if(!"".equals(uuid)){
		user_info = dbHelper.getMap(sql) ;
	}
	if(null==user_info){
			Common.do302(response,"http://koubei.21-sun.com/");
			return;
	}
	String usern= CommonString.getFormatPara(user_info.get("username"));
	String nickname= CommonString.getFormatPara(user_info.get("nickname"));
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
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
</head>
<body>
<!--top-->
<div class="m_newTop">
  <div class="wrapper">
    <h2 class="l"><a href="index.jsp"><img width="219" height="40" src="images/mem_logo.png" alt="铁臂商城购物中心"></a></h2>
    <ul class="m_nav">
      <li><a href="#" class="n">网站<i></i></a>
        <div class="box">
          <a href="http://www.21-sun.com/" target="_blank">网站首页</a>
          <a href="http://product.21-sun.com/" target="_blank">铁臂商城</a>
          <a href="http://www.wajueji.com/" target="_blank">铁臂兄弟连</a>
          <a href="http://koubei.21-sun.com/" target="_blank">铁臂口碑</a>
          <a href="http://photo.21-sun.com/" target="_blank">铁臂图库</a>
          <a href="http://weixiu.21-sun.com/" target="_blank">铁臂维修</a>
          <a href="http://video.21-sun.com/" target="_blank">铁臂视频</a>
          <a href="http://news.21-sun.com/" target="_blank">铁臂资讯</a>
        </div>
      </li>
      <li><a href="#" class="n">应用<i></i></a>
        <div class="box">
          <a href="/member/koubei.jsp">我的口碑</a>
          <a href="/member/photo.jsp">我上传的图片</a>
          <a href="/member/weixiu.jsp">我的维修知识</a>
          <a href="#">我上传的视频</a>
        </div>
      </li>
    </ul>
    <div class="top_search" style="display:none">
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
    <div class="mtl m_set"><a class="m_Ico" href="info_edit.jsp"><em></em></a></div>
    <div class="b_nav_member" style="background: none;width: auto;">
      <a href="/member/"><img width="30" height="30" src="<%= CommonString.getFormatPara(user_info.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" class="b_faceimg" /></a> 
      <span class="b_name" style="width: auto;">
        <a href="/member/" style="color: #FFF;"><%=nickname%></a>
        <a href="javascript:void(0)" onclick="loginOut();"  style="color:#fff;">[退出]</a>
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
        <img width="175" height="175" src="<%= CommonString.getFormatPara(user_info.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);"  />
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
      <li><a href="/member/photo.jsp"><span class="n"><img src="images/menu_ico02.png">我上传的图片</span></a></li>
      <li><a href="/member/weixiu.jsp"><span class="n"><img src="images/menu_ico03.png">我的维修知识</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico04.png">我的上传视频</span></a></li>
    </ul>
    <div class="m_line"></div>
    
  </div>
  <!--left end-->
  <!--right-->
  <div class="m_rightPart">
    <div class="mr_menu">
      <ul class="fix">
        <li><a href="index.jsp"><span style="color:#898989">首页</span></a></li>
        <li><a href="info_edit.jsp" class="selected"><span style="color:white">个人资料</span></a></li>
        <li style="display:none"><a href="touxiang.jsp">修改头像</a></li>
        <li style="display:none"><a href="#">手机绑定</a></li>
        <li style="display:none"><a href="#">地址管理</a></li>
      </ul>
    </div>
    <div class="n_mem_info">
      <ul class="ziliao">
        <li>
          <h3>基本信息</h3>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
			
			
			  <tr>
                <th width="10%">头像</th>
                <td width="90%"><img width="80" height="80" src="<%=CommonString.getFormatPara(user_info.get("image")) %>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_small.gif',2);"/></td>
              </tr>
			
              <tr>
                <th width="10%">昵称</th>
                <td width="90%"><%=CommonString.getFormatPara(user_info.get("nickname")).equals("")?CommonString.getFormatPara(user_info.get("username")):CommonString.getFormatPara(user_info.get("nickname")) %></td>
              </tr>
              <tr>
                <th>姓名</th>
                <td><%=CommonString.getFormatPara(user_info.get("real_name")) %></td>
              </tr>
              <tr>
                <th>生日</th>
                <td><%=CommonString.getFormatPara(user_info.get("birthday")) %></td>
              </tr>
              <tr>
                <th>性别</th>
                <td><%if(CommonString.getFormatPara(user_info.get("sex")).equals("1")){%>男<%}%><%if(CommonString.getFormatPara(user_info.get("sex")).equals("0")){%>女<%}%></td>
              </tr>
              <tr>
                <th>所在地区</th>
                <td><%=CommonString.getFormatPara(user_info.get("province")) %><%=CommonString.getFormatPara(user_info.get("city")) %></td>
              </tr>
			  <tr>
                <th>街道地址</th>
                <td><%=CommonString.getFormatPara(user_info.get("address")) %></td>
              </tr>
			  
			  <tr>
                <th>邮政编码</th>
                <td><%=CommonString.getFormatPara(user_info.get("post_code")) %></td>
              </tr>
              <tr>
                <th>个性签名</th>
                <td><%=CommonString.getFormatPara(user_info.get("sign")) %></td>
              </tr>
            </tbody>
          </table>
        </li>
        <li>
          <h3>联系方式</h3>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
              <tr>
                <th width="10%">邮箱</th>
                <td width="90%"><%=CommonString.getFormatPara(user_info.get("email")) %></td>
              </tr>
              <tr>
                <th>手机</th>
                <td><%=CommonString.getFormatPara(user_info.get("telephone")) %></td>
              </tr>
              <tr>
                <th>QQ</th>
                <td><%=CommonString.getFormatPara(user_info.get("qq")) %></td>
              </tr>
            </tbody>
          </table>
        </li>
        <li>
          <h3>工作信息</h3>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
              <tr>
                <th width="10%">工作单位</th>
                <td width="90%"><%=CommonString.getFormatPara(user_info.get("company")) %></td>
              </tr>
              <tr>
                <th>职业</th>
                <td><%=CommonString.getFormatPara(user_info.get("job")) %></td>
              </tr>
            </tbody>
          </table>
        </li>
        
        <li style="display:none">
          <h3>收货地址</h3>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
              <tr>
                <th width="10%">邮寄地址</th>
                <td width="90%">未填写</td>
              </tr>
              <tr>
                <th>邮政编码</th>
                <td>未填写</td>
              </tr>
              <tr>
                <th>联系人</th>
                <td>未填写</td>
              </tr>
              <tr>
                <th>联系方式</th>
                <td>未填写</td>
              </tr>
            </tbody>
          </table>
        </li>
      </ul>
      <div class="btn"><a href="info_edit.jsp" title="修改"><img src="images/edit_btn01.png" alt="修改" /></a></div>
    </div>
  </div>
  <!--right end-->
</div>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>

<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
<script>
function loginOut(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout',
		async:false,
		cache:false,
		success:function(data){
				jQuery.jBox.tip("退出成功！");
				setTimeout("window.location.reload()",1000);
		}
	});
}
</script>
</html>
