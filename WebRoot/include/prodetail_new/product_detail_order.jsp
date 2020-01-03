<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*" %>		
<%
    String factoryid=CommonString.getFormatPara(request.getParameter("factoryid"));
	String productid=CommonString.getFormatPara(request.getParameter("productid"));
	String factoryname=CommonString.getFormatPara(request.getParameter("factoryname"));
	String name=CommonString.getFormatPara(request.getParameter("name")).replace(" ","");
	String cataname=CommonString.getFormatPara(request.getParameter("cataname"));
	String catalognum=CommonString.getFormatPara(request.getParameter("catalognum"));
	//String agentName=CommonString.getFormatPara(request.getParameter("agentName"));
	//String agentName=CommonString.getFormatPara(request.getParameter("agentName"));
	//String agentName=CommonString.getFormatPara(request.getParameter("agentName"));
	//String agentName=CommonString.getFormatPara(request.getParameter("agentName"));
%>
		<div class="_form">
            <form action="/action/detail_order_save.jsp" method="post" name="theform" id="theform"  >
              <table cellpadding="0" cellspacing="0" border="0" width="100%">
			                  <tr>
                  <th align="right">您在什么地方：</th>
                  <td><div class="txd_address"> <a href="javascript:void(0);" class="cityboxbtn"> <span class="tadd_p" id="the_province"></span><span class="tadd_c" id="the_city"></span> </a>
                      <div class="citybox citybox_tab">
                        <ul class="city_keylist fix">
                          <li class="city_key city_key_01">请选择省份</li>
                          <li class="city_key city_key_02">请选择城市</li>
                        </ul>
                        <div class="city_val city_val_01 hide">
                          <div class="cityshow fix"> <span data-province="山东***100110"><a href="javascript:void(0)">山东</a></span> <span data-province="安徽***101800"><a href="javascript:void(0)">安徽</a></span> <span data-province="江西***103100"><a href="javascript:void(0)">江西</a></span> <span data-province="浙江***104200"><a href="javascript:void(0)">浙江</a></span> <span data-province="上海***105290"><a href="javascript:void(0)">上海</a></span> <span data-province="北京***105499"><a href="javascript:void(0)">北京</a></span> <span data-province="天津***105689"><a href="javascript:void(0)">天津</a></span> <span data-province="重庆***105879"><a href="javascript:void(0)">重庆</a></span> <span data-province="河北***106400"><a href="javascript:void(0)">河北</a></span> <span data-province="山西***108300"><a href="javascript:void(0)">山西</a></span> <span data-province="内蒙古***109700"><a href="javascript:void(0)">内蒙古</a></span> <span data-province="江苏***110900"><a href="javascript:void(0)">江苏</a></span> <span data-province="广西***113000"><a href="javascript:void(0)">广西</a></span> <span data-province="西藏***115000"><a href="javascript:void(0)">西藏</a></span> <span data-province="宁夏***116000"><a href="javascript:void(0)">宁夏</a></span> <span data-province="新疆***117000"><a href="javascript:void(0)">新疆</a></span> <span data-province="吉林***119000"><a href="javascript:void(0)">吉林</a></span> <span data-province="辽宁***120000"><a href="javascript:void(0)">辽宁</a></span> <span data-province="黑龙江***122000"><a href="javascript:void(0)">黑龙江</a></span> <span data-province="湖北***124000"><a href="javascript:void(0)">湖北</a></span> <span data-province="湖南***126000"><a href="javascript:void(0)">湖南</a></span> <span data-province="广东***128000"><a href="javascript:void(0)">广东</a></span> <span data-province="河南***130000"><a href="javascript:void(0)">河南</a></span> <span data-province="贵州***132000"><a href="javascript:void(0)">贵州</a></span> <span data-province="青海***133000"><a href="javascript:void(0)">青海</a></span> <span data-province="甘肃***134000"><a href="javascript:void(0)">甘肃</a></span> <span data-province="陕西***135500"><a href="javascript:void(0)">陕西</a></span> <span data-province="云南***137000"><a href="javascript:void(0)">云南</a></span> <span data-province="四川***139000"><a href="javascript:void(0)">四川</a></span> <span data-province="海南***141500"><a href="javascript:void(0)">海南</a></span> <span data-province="福建***142000"><a href="javascript:void(0)">福建</a></span> </div>
                        </div>
                        <div class="city_val city_val_02 hide">
                          <div class="cityshow fix" id="zd_citys" ></div>
                        </div>
                        <span class="city_close"></span> </div>
                      <input type="hidden"  name="zd_province"  id="zd_province"  />
                      <input type="hidden"  name="zd_city"  id="zd_city"    />
                    </div></td>
                </tr>
                <tr>
                  <th align="right">您怎么称呼：</th>
                  <td><input class="txj_inp" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
                    </td>
                </tr>
                <tr>
                  <th align="right">您的电话号：</th>
                  <td><input class="txj_inp" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" placeholder="请填写正确手机号，获取最低价短信" /></td>
                </tr>

  
                <tr>
                  <th>&nbsp;</th>
                  <td height="30" colspan="2"><input class="btn02 hover" onClick="submitYN();" type="button"></td>
                  <td height="22" style="padding-top:5px; padding-left:10px;"></td>
                </tr>
              </table>
              <input name="tag" type="hidden" id="tag" value="3" />
              <input name="zd_factoryid" type="hidden" id="zd_factoryid" value="<%=factoryid%>" />
              <input name="zd_product_id" type="hidden" id="zd_product_id" value="<%=productid%>"/>
              <input name="zd_factoryname" type="hidden" id="zd_factoryname" value="<%=factoryname%>"/>
              <input name="zd_product_name" type="hidden" id="zd_product_name" value="<%=name%>"/>
              <input name="zd_message" type="hidden" id="zd_message" value="您好，我对<%=factoryname+name+cataname%>感兴趣，想要咨询，请您给我回复，谢谢。" />
              <input type="hidden" name="zd_contact_address" id="zd_contact_address"/>
              <input type="hidden" name="zd_cataname" id="zd_cataname" value="<%=cataname%>" />
              <input type="hidden" name="zd_catanum" id="zd_catanum" value="<%=catalognum%>"/>
              <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
              <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
              <input type="hidden" name="zd_is_first" id="zd_is_first" value="1"/>
              <input type="hidden" name="zd_other_message" id="zd_other_message" value=""/>
            </form>
          </div>