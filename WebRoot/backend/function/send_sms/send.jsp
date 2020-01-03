<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	try {
		Map model = null;
		connection = dbHelper.getConnection();
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
		String order_id = CommonString.getFormatPara(request.getParameter("order_id"));
		String province = CommonString.getFormatPara(request.getParameter("province")) ;  // 代理地区
		String city = CommonString.getFormatPara(request.getParameter("city")) ;
		String productId = CommonString.getFormatPara(request.getParameter("productid")) ; // 产品　ｉｄ　
	// 浙江成峰 特殊情况
		if("133".equals(factoryid)){
			model = dbHelper.getMap(" select top 1 city_tel as tel_sms from pro_agent_factory where city_tel is not null and city_tel <> '' and agent_fac like '%"+factoryid+"%' and city like '%"+province+"%' ") ;
		}
		if (null != factoryid && !"".equals(factoryid) && model==null) {  
			model = dbHelper.getMap(" select tel_sms,name from pro_agent_factory where id = ? ", new Object[] { factoryid }, connection);
		}
		// 如果厂家电话为空，则查询该地区代理商的电话
		if("".equals(CommonString.getFormatPara(model.get("tel_sms")))){
			model = dbHelper.getMap(" select top 1 city_tel as tel_sms from pro_agent_factory where city_tel is not null and city_tel <> '' and (agent_fac like '%"+factoryid+",%' or  agent_fac like '%,"+factoryid+",%' or agent_fac='"+factoryid+"')and city like '%"+province+"%' ") ;
		}
		// 厂家 id 
		String sql = "" ;
		if(!"".equals(productId)){
			sql = " SELECT paf.city_tel ";
			sql += "FROM pro_agent_products pap , pro_products pp , pro_agent_factory paf";
			sql += " WHERE pap.product_id = pp.id AND pap.agent_id = paf.id ";
			sql += " AND paf.city_tel!='' and paf.flag = 2 AND ( paf.parent_id IS NULL OR paf.parent_id = 0 ) ";
			sql += " AND pap.product_id = "+productId; 
			sql += " AND paf.id IN ( "; 
			sql += " SELECT agent_id FROM "; 
			sql += " pro_agent_factory_and_area ";
			sql += " WHERE  factory_id="+factoryid+" AND area_id = ( ";
			sql += " SELECT TOP 1 area_id FROM ";
			sql += " comm_area ";
			sql += " WHERE area_name LIKE '%"+city+"%' ";
			sql += " AND level_id=2 ) ";
			sql += " GROUP BY agent_id "; 
			sql += ") "; 
		}else if(!"".equals(factoryid)){
			sql = " SELECT TOP 10 city_tel FROM ";
			sql += " pro_agent_factory ";
			sql += " WHERE city_tel!='' and flag = 2  AND ( parent_id IS NULL OR parent_id = 0 ) ";
			sql += " AND id IN ( SELECT agent_id FROM pro_agent_products WHERE factory_id = "+factoryid+" ) ";
			sql += " AND id IN ( ";
			sql += " SELECT agent_id FROM ";
			sql += " pro_agent_factory_and_area ";
			sql += " WHERE factory_id="+factoryid+" AND  area_id = ( ";
			sql += " SELECT TOP 1 area_id FROM ";
			sql += " comm_area ";
			sql += " WHERE area_name LIKE '%"+city+"%' and level_id=2 ";
			sql += " ) ";
			sql += " GROUP BY agent_id ";
			sql += ") ";
		}
		String city_tel = "" ;
		Map cityMap = dbHelper.getMap(sql) ;
		if(null!=cityMap){
			city_tel = CommonString.getFormatPara(cityMap.get("city_tel")) ;
		}
		if(model == null){
			model = new HashMap();
		}
		String content = CommonString.getFormatPara(request.getParameter("param"));
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=Env.getInstance().getProperty("project_name")%></title>
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css"
			rel="stylesheet" type="text/css" />
		<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css"
			rel="stylesheet" type="text/css" />
		<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
		<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
	</head>
	<body style="margin: 0; padding: 0; overflow-x: hidden;">
		<form name="theform" id="theform"
			action="/backend/action/ajax_cud.jsp?flag=sendSms">
			<input type="hidden" id="order_id" name="order_id"
				value="<%=order_id%>" />
			<div class="formDiv">
				<div class="group">
					<span> <img
							src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" />
					</span>
					<span class="groupTitle">短信发送</span>
				</div>
				<div class="formLeft">
					短信内容
				</div>
				<div class="formRight" style="width: 450px; height: 85px;">
					<textarea style="width: 450px; height: 80px;" class="jr_textarea"
						name="content" id="content"><%=CommonString.getFormatPara(content)%></textarea>
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft"></div>
				<div class="formRight"
					style="width: 450px; text-align: right; margin: -3px 0px 0px 0px; color: #999">
					<span id="info1"></span><span id="info"></span>个字符
				</div>
				<div style="clear: left;"></div>
				<div class="formLeft">
					手机号
				</div>
				<div class="formRight" style="width: 300px">
					<input style="width: 300px" type="text" class="jr_text" name="tel_sms" id="tel_sms" value="<%=CommonString.getFormatPara(model.get("tel_sms"))%>" />
				</div>
			</div>
		    <div class="formRight">
			  <a href="javascript:;" id="getAgentTel" name="getAgentTel" class="link" style="float:left;font-weight:bold;text-align:center;">给代理商发短信</a>
			</div>
			</div>
		</form>
	</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = jQuery.trim(data);
					if (rs == "ok" ) {
						jrSuccess("发送成功！");
						<%
						if("".equals(factoryid)){
							%>
						window.location.close();
							<%
						}
						%>
					} else {
						jrSuccess("发送失败，短信接口异常或手机号不正确。");	
					}
				}
			});
		}
	}
</script>
<script type="text/javascript" language="javascript">
        jQuery(function() {
            jQuery("#content").keyup(check);
            //jQuery("#content").onpaste(check);
            if(''=='<%=city_tel%>'){
               jQuery("#getAgentTel").hide() ;
            }else{
            	 jQuery("#getAgentTel").css("color","green") ;
            }
            
        });
        function check() {
            var str = jQuery("#content").val();
            var len = strlen(str);
            var info = 55 - len;
            info = info + "";
            if (info.indexOf('.') > 0)
                info = info.substring(0, info.indexOf('.'));
            if (len <= 69) {
                jQuery("#info1").html("还能输入");
                jQuery("#info").css('color', 'gray');
                jQuery("#info").html(info);
            } else {
                info = info.substr(1)
                jQuery("#info1").html("超出");
                jQuery("#info").css('color', 'red');
                jQuery("#info").html(info);
            }
        }

        function trim(str) {
            return (str + '').replace(/(\s+)$/g, '').replace(/^\s+/g, '');
        }

        function strlen(str) {
            var str = trim(str);
            var len = 0;
            for (var i = 0; i < str.length; i++) {
                len += str.charCodeAt(i) > 0 && str.charCodeAt(i) < 255 ? 1 : 1;
            }
            return len;
        }
		check();
		var old_tel = jQuery("#tel_sms").val() ;
		var old_html = jQuery("#getAgentTel").html() ;
		jQuery("#getAgentTel").toggle(function(){
			jQuery(this).html("给厂家发短信") ;
			jQuery("#tel_sms").val("<%=city_tel%>") ;
		},function(){
		    jQuery(this).html(old_html) ;
			jQuery("#tel_sms").val(old_tel) ;
		}
		) ;
    </script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>