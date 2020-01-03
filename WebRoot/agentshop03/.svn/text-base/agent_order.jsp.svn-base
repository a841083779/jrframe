<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String factoryid = "" ;
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		if(map != null && !CommonString.getFormatPara(map.get("is_qijiandian")).equals("3")){ // 使用模板三
			Common.do302(response,"/agent/"+CommonString.getFormatPara(request.getParameter("usern"))+"/");
			return;	
		}
	String agentid =CommonString.getFormatPara(map.get("id")) ;  // 代理商的品牌
%>
      <div class="sRightPart">
        <div class="sTitle">
          <h2>在线询价</h2>
        </div>
        <div class="sContent"> 
          <script type="text/javascript">
        jQuery(function(){
            jQuery(".inquiry .btn02").hover(function(){
                jQuery(this).toggleClass("hover");
            },function(){
                jQuery(this).removeClass("hover");
            });
        jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'<%=agentid%>'} ,
    	success:function(msg){
    	}
    }) ;
        })
        </script>
          <form action="/action/order_save.jsp" method="post" name="theform" id="theform" onsubmit="return submitYN(this);">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="inquiry">
              <tr>
                <th width="13%" style="padding:5px 0px;">姓名：</th>
                <td width="87%"><input class="input01" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">手机/固话：</th>
                <td><input class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">地区：</th>
                <td><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:79px;"  dataType="Require"  msg="请选择省份">
                    <option value="安徽">安徽</option>
                    <option value="北京">北京</option>
                    <option value="重庆">重庆</option>
                    <option value="福建">福建</option>
                    <option value="甘肃">甘肃</option>
                    <option value="广东">广东</option>
                    <option value="广西">广西</option>
                    <option value="贵州">贵州</option>
                    <option value="海南">海南</option>
                    <option value="河北">河北</option>
                    <option value="黑龙江">黑龙江</option>
                    <option value="河南">河南</option>
                    <option value="湖北">湖北</option>
                    <option value="湖南">湖南</option>
                    <option value="内蒙古">内蒙古</option>
                    <option value="江苏">江苏</option>
                    <option value="江西">江西</option>
                    <option value="吉林">吉林</option>
                    <option value="辽宁">辽宁</option>
                    <option value="宁夏">宁夏</option>
                    <option value="青海">青海</option>
                    <option value="山西">山西</option>
                    <option value="山东">山东</option>
                    <option value="上海">上海</option>
                    <option value="四川">四川</option>
                    <option value="天津">天津</option>
                    <option value="西藏">西藏</option>
                    <option value="新疆">新疆</option>
                    <option value="云南">云南</option>
                    <option value="浙江">浙江</option>
                    <option value="陕西">陕西</option>
                    <option value="台湾">台湾</option>
                    <option value="香港">香港</option>
                    <option value="澳门">澳门</option>
                    <option value="海外">海外</option>
                  </select>
                  <select  name="zd_city" id="zd_city"  style="width:100px;" dataType="Require"  msg="请选择城市">
                    <option value="">选择城市</option>
                  </select>
                  *</td>
              </tr>
              <tr>
                <th width="13%" style="padding:5px 0px;">采购性质：</th>
                <td width="87%"><input name="zd_ifgroup" type="radio" checked value="个人" />
                  <font color="#434343">个人</font>
                  <input  name="zd_ifgroup" type="radio"  value="公司" />
                  <font color="#434343">公司</font>
                  <input type="text" value="公司名字" id="zd_company" name="zd_company" style="display:none;" />
                  *</td>
              </tr>
              <tr>
                <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px">预计购买时间：</th>
                <td nowrap="nowrap" class="list_cell_bg"><select name="zd_buy_time" id="zd_buy_time" >
                    <option value='102001'>1个月内</option>
                    <option value='102002'>1—3个月</option>
                    <option value='102003'>4—6个月</option>
                    <option value='102004'>7—12个月</option>
                    <option value='102005'>1年后</option>
                    <option value='102006'>不确定</option>
                  </select>
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">留言内容：</th>
                <td><textarea class="textarea01" name="zd_message" cols="45" rows="5"  id="zd_message"></textarea></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><input type="submit" name="button2" id="button2" value="提交" class="btn02" /></td>
              </tr>
            </table>
            <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
            <input type="hidden" name="zd_contact_address" id="zd_contact_address" />
            <input type="hidden" name="zd_agentid" id="zd_agentid" value="<%=CommonString.getFormatPara(map.get("id")) %>"/>
            <input type="hidden" name="zd_agentname" id="zd_agentname" value="<%=CommonString.getFormatPara(map.get("name")) %>"/>
            <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
            <!-- 属于公司或个人 -->
          </form>
        </div>
      </div>
      <script type="text/javascript">
      	jQuery(function(){
		jQuery("#zd_province option").each(function(){
			jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
		}) ;
	}) ;
      </script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>