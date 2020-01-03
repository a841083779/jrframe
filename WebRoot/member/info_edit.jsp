<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%  
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
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/plugin/date/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/scripts/citys.js"></script> 
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
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
      <a href="/member/"><img width="30" height="30" src="<%= CommonString.getFormatPara(user_info.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" class="b_faceimg"></a> 
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
        <img width="175" height="175" src="<%= CommonString.getFormatPara(user_info.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);">
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
      <li><a  href="/member/koubei.jsp"><span class="n"><img src="images/menu_ico01.png">我的口碑</span></a></li>
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
        <li><a href="info.jsp" class="selected"><span style="color:white">个人资料</span></a></li>
        <li style="display:none"><a href="touxiang.jsp">修改头像</a></li>
        <li style="display:none"><a href="#">手机绑定</a></li>
        <li style="display:none"><a href="#">地址管理</a></li>
      </ul>
    </div>
 <form action="/action/crud.jsp" method="post" id="theform" name="theform">
    <div class="n_mem_info">
      <ul class="ziliao">
      	<div class="title b_rtitle">
         </div>
        <li>
          <h3>基本信息</h3>
		  
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
			
		 <tr>
          <th width="10%">头像</th>
          <td width="90%"><div name="touxiang" id="touxiang"><img  width="80" height="80" src="<%= CommonString.getFormatPara(user_info.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);"/></div> <a id="addImgs">选择</a></td>
        </tr>
			
              <tr>
                <th width="10%">昵称</th>
                <td width="90%"><input type="text"  value="<%=CommonString.getFormatPara(user_info.get("nickname")).equals("")?CommonString.getFormatPara(user_info.get("username")):CommonString.getFormatPara(user_info.get("nickname")) %>" class="b_input" id="zd_nickname" name="zd_nickname" ></td>
              </tr>
              <tr>
                <th>姓名</th>
                <td><input type="text" value="<%=CommonString.getFormatPara(user_info.get("real_name")) %>" class="b_input" id="zd_real_name" name="zd_real_name"></td>
              </tr>
              <tr>
                <th width="10%">生日</th>
                <td width="90%"><input style="width:27%" type="text" value="<%=CommonString.getFormatPara(user_info.get("birthday")) %>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',startDate:'<%=CommonDate.getToday("yyyy-MM-dd")%>'});" class="b_input Wdate" id="zd_birthday" name="zd_birthday"></td>
              </tr>
              <tr>
                <th>性别</th>
                <td>
                	<input type="radio" <%if(CommonString.getFormatPara(user_info.get("sex")).equals("1")){%>checked="checked"<%}%> class="b_radio" value="1" id="radio" name="zd_sex"> 男 &nbsp;
              		<input type="radio" <%if(CommonString.getFormatPara(user_info.get("sex")).equals("0")){%>checked="checked"<%}%> class="b_radio" value="0" id="radio2" name="zd_sex">女 
              	</td>
              </tr>
			  
			  			  
		 <tr>
         <th>所在地区</th>
         <td>
		 <select name="zd_province" id="zd_province" onChange="set_my_city(this);"  style="width:100px;">
		        <%if(CommonString.getFormatPara(user_info.get("province")).equals("")){%>
		        <option value="">选择省份</option>
				<%}else{%>
			    <option value="<%=CommonString.getFormatPara(user_info.get("province"))%>"><%=CommonString.getFormatPara(user_info.get("province"))%></option>
				<%}%>
         		<option value="山东" area_id="100110">山东</option><option value="安徽" area_id="101800">安徽</option><option value="江西" area_id="103100">江西</option><option value="浙江" area_id="104200">浙江</option><option value="上海" area_id="105290">上海</option><option value="北京" area_id="105499">北京</option><option value="天津" area_id="105689">天津</option><option value="重庆" area_id="105879">重庆</option><option value="河北" area_id="106400">河北</option><option value="山西" area_id="108300">山西</option><option value="内蒙古" area_id="109700">内蒙古</option><option value="江苏" area_id="110900">江苏</option><option value="广西" area_id="113000">广西</option><option value="西藏" area_id="115000">西藏</option><option value="宁夏" area_id="116000">宁夏</option><option value="新疆" area_id="117000">新疆</option><option value="吉林" area_id="119000">吉林</option><option value="辽宁" area_id="120000">辽宁</option><option value="黑龙江" area_id="122000">黑龙江</option><option value="湖北" area_id="124000">湖北</option><option value="湖南" area_id="126000">湖南</option><option value="广东" area_id="128000">广东</option><option value="河南" area_id="130000">河南</option><option value="贵州" area_id="132000">贵州</option><option value="青海" area_id="133000">青海</option><option value="甘肃" area_id="134000">甘肃</option><option value="陕西" area_id="135500">陕西</option><option value="云南" area_id="137000">云南</option><option value="四川" area_id="139000">四川</option><option value="海南" area_id="141500">海南</option><option value="福建" area_id="142000">福建</option>
          </select>
          <select name="zd_city" id="zd_city"  style="width:150px;">
		  		<%if(CommonString.getFormatPara(user_info.get("city")).equals("")){%>
		        <option value="">选择城市</option>
				<%}else{%>
			    <option value="<%=CommonString.getFormatPara(user_info.get("city"))%>"><%=CommonString.getFormatPara(user_info.get("city"))%></option>
				<%}%>
          </select>
          </td>          
		  </tr>

          
			  
			  <tr>
                <th>街道地址</th>
                <td><textarea class="b_textarea01" rows="5" cols="45" id="zd_address" name="zd_address"><%=CommonString.getFormatPara(user_info.get("address")) %></textarea></td>
              </tr>
			  
			  <tr>
                <th>邮政编码</th>
                <td><input type="text" value="<%=CommonString.getFormatPara(user_info.get("post_code")) %>" class="b_input" id="zd_post_code" name="zd_post_code"></td>
              </tr>
			  
              <tr>
                <th>个性签名</th>
                <td><textarea class="b_textarea01" rows="5" cols="45" id="zd_sign" name="zd_sign"><%=CommonString.getFormatPara(user_info.get("sign")) %></textarea></td>
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
                <td width="90%"><input type="text"  value="<%=CommonString.getFormatPara(user_info.get("email")) %>" class="b_input" id="zd_email" name="zd_email"></td>
              </tr>
              <tr>
                <th>手机</th>
                <td><input type="text" value="<%=CommonString.getFormatPara(user_info.get("telephone")) %>" class="b_input" id="zd_telephone" name="zd_telephone"></td>
              </tr>
              <tr>
                <th>QQ</th>
                <td>
                	<input type="text" value="<%=CommonString.getFormatPara(user_info.get("qq")) %>" class="b_input" id="zd_qq" name="zd_qq">
                </td>
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
                <td width="90%">
                	<input type="text" value="<%=CommonString.getFormatPara(user_info.get("company")) %>"  id="zd_company" class="b_input" name="zd_company">
                </td>
              </tr>
              <tr>
                <th>职业</th>
                <td>
	                   <input type="text" value="<%=CommonString.getFormatPara(user_info.get("job")) %>" class="b_input" id="zd_job" name="zd_job">
		       </td>
              </tr>
            </tbody>
          </table>
        </li>
       

      </ul>
      <div class="btn"><a title="保存" onclick="tj()"><img src="images/edit_btn02.png" alt="保存" /></a></div>
    </div>
	
	<input type="hidden" name="tableName" id="tableName" value="pro_member">
   <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(user_info.get("id")) %>">
   <input type="hidden" name="zd_image" id="zd_image" value="<%=CommonString.getFormatPara(user_info.get("image")) %>"">

</form>
  </div>
  <!--right end-->
</div>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>

<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>

<script>
function tj(){
 $("#theform").ajaxSubmit(function (data) {
 			if($.trim(data)=="1"){
				jQuery.jBox.tip("修改成功！");
			}else if($.trim(data)=="0"){
				jQuery.jBox.tip("修改失败！");
			}
 });
}

/*
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	jQuery("#zd_province option:contains("+province+")").attr("selected",true);
	jQuery("#zd_province").change();
	set_my_city(document.getElementById("zd_province"),city);
	// jQuery("#zd_contact_address").val(province+city) ;
}) ;
*/

	jQuery(function(){
		jQuery("#addImgs").JrUpload({
			remotUrl : "http://resource.21-sun.com/upload.jsp",
			folder : "product/koubei" ,
			sizeLimit:10*1024*1024, //10M
			multi : false,
			beforeCallback : "beforeCallback",
			callback : "setImgs" ,
			style : "width:98px;height:30px;",
			buttonImg : "<%=Common.getDomain(request) %>/activity/koubei/images/1_22.jpg" ,
			buttonImgWidth : 77 ,
			buttonImgHeight : 30
		});
	});
	function beforeCallback(){
		$.jBox.tip("图片上传中，请稍后。。。", "loading");
	}	
	
	function setImgs(data){
		var imgs = data.split(",");
		var htm = '';
		var f = 'http://resource.21-sun.com';
		for(var i=0;i<imgs.length;i++){
			htm = '<img id="touxiang" src="'+f+imgs[i]+'" width="80" height="80" />';
			jQuery("#zd_image").val(f+imgs[i]);
		}
	   //jQuery("#addImgs_show").append(htm);
		jQuery("#touxiang").html(htm);


	   //jQuery("#touxiang").append('');
      // jQuery("#touxiang").append(htm);

		//regEvent();
		$.jBox.closeTip();
	}
		function set_my_city(o,cked){
		var area_id = o.options[o.selectedIndex].getAttribute("area_id");
		if(area_id!=''&&area_id!=null){
		jQuery.ajax({
			url : '/tools/ajax.jsp',
			async : false,
			type : 'post',
			data : {
				flag : 'get_city',
				p : area_id
			},
			success : function(data){
				var arr = eval(data);
				var zd_city = document.getElementById("zd_city");
				zd_city.length = 1;
				zd_city
				var opt;
				var aname;
				var hname;
				for(var i=0;i<arr.length;i++){
					aname = arr[i].area_name;
					hname = aname;
					//aname = codefans_net_CC2PY(aname).substring(0,1)+"-"+aname;
					opt = new Option(aname,hname);
					if(aname.indexOf(cked)!=-1){
						opt.selected = true;
					}
					zd_city.options.add(opt);
				}
			}
		});
		}
		
	}
	

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
