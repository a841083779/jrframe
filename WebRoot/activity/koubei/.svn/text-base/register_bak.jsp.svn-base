<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>铁臂口碑活动——分享真实用机感受 - 铁臂口碑</title>
<meta name="keywords" content="工程机械口碑" />
<meta name="description" content="铁臂口碑第一季活动——分享您的真实用机感受，就有机会获得大奖。买工程机械产品，就上铁臂商城。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />

<div class="wrapper loginContainer mb25">
    
      <!--left-->
      <div class="loginLeft">
      	<form name="contact_form" id="contact_form" action="/action/crudz.jsp" method="post">
        <ul class="registContent">
          <li class="rcl">
            <dl class="rcd">
            	<dt>手机号/邮箱：</dt>
              <dd>
                <input type="text" name="zd_username" id="zd_username" class="email required bri" onblur="checkUserName(this);">
              </dd>
            </dl>
            <div class="rfRight"><img src="images/reg_error.png" class="imgError"><span></span></div>
          </li>
          <li class="rcl">
            <dl class="rcd">
            	<dt>昵称：</dt>
              <dd>
                <input type="text" name="zd_nickname" id="zd_nickname" class="nickName required bri" onblur="checkNickName(this);">
              </dd>
            </dl>
            <div class="rfRight"><img src="images/reg_error.png" class="imgError"><span></span></div>
          </li>
          <li class="rcl">
            <dl class="rcd">
            	<dt>密码：</dt>
              <dd>
                <input type="password" name="zd_password" id="zd_password" class="Pass required bri">
              </dd>
            </dl>
            <div class="rfRight"><img src="images/reg_error.png" class="imgError"><span></span></div>
          </li>  
          <li class="rcl">
            <dl class="rcd">
              <dt>性别：</dt>
              <dd class="radio">
                <input name="zd_sex" type="radio" value="1" checked="checked" style="margin-left: 28px;">
                男
                <input type="radio" name="zd_sex" value="0">
                女 
              </dd>
            </dl>
            <div class="rfRight"><img src="images/reg_error.png" class="imgError"><span></span></div>
          </li>  
          <li class="rcl">
            <dl class="rcd">
              <dt>职业：</dt>
              <dd class="select">
                <select name="select" id="jobSelect" class="job_required">
                  <option value="">请选择</option>
                  
              			<option value="1">机手</option>
              		
              			<option value="2">车主</option>
              		
              			<option value="3">维修工程师</option>
              		
              			<option value="4">工程管理相关</option>
              		
              			<option value="9">设备运输相关</option>
              		
              			<option value="5">销售人员</option>
              		
              			<option value="6">行业名人</option>
              		
              			<option value="7">学(生)徒</option>
              		
              			<option value="8">其他</option>
              		
                </select>
              </dd>
            </dl>
            <div class="rfRight"><img src="images/reg_error.png" class="imgError"><span></span></div>
          	<input type="hidden" name="jobId" id="jobId" value="">
          </li>  
           <li class="rcl">
            <dl class="rcd">
              <dt>所在地：</dt>
              <dd class="select_area">
                <select name="pro_id" id="ProSelect" class="area_required" style="margin-left: 20px;">
                  <option value="">省份</option>
                  
			                <option value="2100110">山东省</option>
			        
			                <option value="2101800">安徽省</option>
			        
			                <option value="2103100">江西省</option>
			        
			                <option value="2104200">浙江省</option>
			        
			                <option value="2105290">上海市</option>
			        
			                <option value="2105499">北京市</option>
			        
			                <option value="2105689">天津市</option>
			        
			                <option value="2105879">重庆市</option>
			        
			                <option value="2106400">河北省</option>
			        
			                <option value="2108300">山西省</option>
			        
			                <option value="2109700">内蒙古自治区</option>
			        
			                <option value="2110900">江苏省</option>
			        
			                <option value="2113000">广西省</option>
			        
			                <option value="2115000">西藏自治区</option>
			        
			                <option value="2116000">宁夏自治区</option>
			        
			                <option value="2117000">新疆自治区</option>
			        
			                <option value="2119000">吉林省</option>
			        
			                <option value="2120000">辽宁省</option>
			        
			                <option value="2122000">黑龙江省</option>
			        
			                <option value="2124000">湖北省</option>
			        
			                <option value="2126000">湖南省</option>
			        
			                <option value="2128000">广东省</option>
			        
			                <option value="2130000">河南省</option>
			        
			                <option value="2132000">贵州省</option>
			        
			                <option value="2133000">青海省</option>
			        
			                <option value="2134000">甘肃省</option>
			        
			                <option value="2135500">陕西省</option>
			        
			                <option value="2137000">云南省</option>
			        
			                <option value="2139000">四川省</option>
			        
			                <option value="2141500">海南省</option>
			        
			                <option value="2142000">福建省</option>
			        
			                <option value="5000380">国外</option>
			        
			                <option value="5000400">台湾省</option>
			        
			                <option value="5000401">香港特区</option>
			        
			                <option value="5000402">澳门特区</option>
			        
                </select>
                <select name="city_id" id="CitySelect" class="area_required">
                  <option>请选择城市</option>
                </select>
                <select name="area_id" id="AreaSelect" class="area_required">
                  <option>请选择区域</option>
                </select>
                <input type="hidden" id="zd_area_id" name="zd_area_id">
              </dd>
            </dl>
            <div class="rfRight"><img src="images/reg_error.png" class="imgError"><span></span></div>
          </li>
          <li class="rcl">
            <dl class="rcd yanzhengma">
            	<dt>验证码：</dt>
              <dd class="select" style="width: 130px;">
                <input type="text" name="yanzheng" id="yanzheng" class="bri yanzheng" maxlength="4">
              </dd>
            </dl>
            <dl class="yanzhengmaImg">
              <img src="/webadmin/authImgServlet" id="authImg" width="85" height="36" align="absmiddle"> <a href="javascript:void(0);" onclick="refresh();" style="color:red;">换一张</a>
            </dl>
            <div class="rfRight" style="width: 125px;float: left;"><img src="images/reg_error.png" class="imgError"><span></span></div>
          </li> 
          <li class="xieyi" style="padding-left: 92px; width: 76%;padding-bottom: 0px;line-height: 36px">
            <input type="checkbox" name="checkbox" id="checkbox" class="isRead " value="1">
          <span id="checkBoxText">我已经阅读并同意遵守</span><a href="#" target="_blank" style="color:red;">《用户协议》</a>
          <div class="rfRight" style="width: 190px;"><img src="images/reg_error.png" class="imgError"><span></span></div>
          </li> 
          <li class="b_btn" style="padding:70px 0px 30px 92px;width: 50%;"><input type="submit" class="b_lb" value="立即注册" style="cursor: pointer;border:0px;"></li>
        </ul>
        
        <input value="0" type="hidden" name="visitId">
        </form>
      </div>
      <!--left end-->
      <!--right-->
      <div class="loginRight">
        <div class="mb20" style="margin-top: 100px;font-weight:bold;">
          已有帐号？<br>
          <a href="javascript:void(0);" onclick="loginOrRegister_for_return('#')" class="b_lb2  mt15">立即登录</a>
        </div>
      </div>
      <!--right end-->
    <div class="clear"></div>  
    </div>

<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<script type="text/javascript" src="scripts/scroll-row.js"></script>
</body>
</html>