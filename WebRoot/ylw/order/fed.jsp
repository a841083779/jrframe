<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,jereh.system.*,java.text.*,jereh.database.*,jereh.user.*" errorPage=""%>
<%@ include file="../sysconfig/config.jsp"%>
<%
ConnManager pool = (ConnManager)application.getAttribute("poolAPP");
	if(pool==null){
		pool = new ConnManager();
	}
	//=====页面属性======
String pagename="fed.jsp";
String titlename="产品订购";
String tablename="web_orders";
SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//================
Connection conn = pool.getConnection();
String sql="";
ResultSet rs ;
String email="";
try{
	sql="select email from web_emailset where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products03'";
	rs=DataManager.executeQuery(conn,sql);
	if(rs!=null&&rs.next()){
		email=rs.getString("email");
	}else{
		email="";
	}
//=============================保存数据开始=====================================
if (request.getParameter("flag_save")!=null) {
switch(CommonFunction.dataOpt(request,request.getParameter("flag_save"),pool,tablename)) {
	case -2: 
		out.println("<script>alert('数据重复,添加失败!');history.go(-1);</script>");
		break;
	case -1: 
		out.println("<script>alert('数据格式不正确,操作失败!');history.go(-1);</script>");
		break;
	case 1: 
		 if(email!=null&&!email.equals("")){
		 	SendMail sendMail = new SendMail();
		  	sendMail.setMailServer("smtp.126.com");
		  	sendMail.setUserName("my_zlj");
		 	sendMail.setPassW("123456");
		  	sendMail.setFrom("my_zlj@126.com");
		  	String zd_name=(request.getParameter("zd_name"));
	  	    String zd_company=(request.getParameter("zd_company"));
		  	String zd_contact_tel=(request.getParameter("zd_contact_tel"));
		  	String zd_contact_address=(request.getParameter("zd_contact_address"));
		  	String zd_product_name=(request.getParameter("zd_product_name"));
		  	String zd_email=(request.getParameter("zd_email"));
		  	String zd_message=(request.getParameter("zd_message"));
		  	String zd_add_date=(request.getParameter("zd_add_date"));
		  	String mess = "";
		  	mess+="订购时间："+zd_add_date+"<br>";
		  	mess+="公司/个人名称："+zd_company+"<br>";
		  	mess+="具体地址："+zd_contact_address+"<br>";
		    mess+="电话号码："+zd_contact_tel+"<br>";
		  	mess+="联 系 人："+zd_name+"<br>";
		  	mess+="Email："+zd_email+"<br>";
		  	mess+="订购产品："+zd_product_name+"<br>";
		 	mess+="其他意见和要求："+zd_message+"<br>";
		 	mess+="<br>";
		 	mess+="<font style='size:10px;'>(此邮件为用户提交订单时系统发送的邮件，请不要直接回复！)</font>";
		  	sendMail.setSubject(web_name+"- 在线订购 - 订购联系人："+zd_name);
		  	sendMail.setMessageText(mess);
		    sendMail.setTo(email);
		   	sendMail.sendMail();  
		 }
         out.println("<script>alert('您的订单已经成功提交,感谢您选择我们的产品,我们会尽快与您联系。');window.location.href='"+pagename+"';</script>");
		break;
	default:
		break;
   }
 }
//=============================保存数据结束=====================================
%>
<html>
<head>
<style>
<!--
TD
{
	color: #333333;
	font-family: Verdana, Arial, 宋体;
	font-size: 9pt;
	line-height: 150%;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

-->
</style>
<script type="text/javascript">
function form_submit(id,delid)
 {var str="";
   if(id==0)
   {
   	  var message=document.getElementById("zd_message").value;
   	  if(message=='请填写您的留言,谢谢!'){
   	  	document.getElementById("zd_message").value='';
   	  }
   	  document.theform.action="./<%=pagename%>?flag_save=1";
      document.theform.method="post";
      document.theform.submit();
  }
  //=====关闭========
   if(id==3)
   {parent.parent.document.location.reload();
   }
}
</script>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT language=JavaScript src="../scripts/validator.js" type=text/javascript></SCRIPT>
</head>
<body>
<form name="theform" id="theform">
  <div align="center">
    <table class="p93" id="table60" width="97%" border="0" cellpadding="0">
      <tr vAlign="center">
        <td class="unnamed2" align="right" width="19%" height="25"  ><font color="#565656"> 
		公司/个人名称：</font></td>
        <td class="unnamed2" width="457" height="25"  ><p style="margin-left: 15px"><b><font color="blue">
            <input name="zd_company" type="text" id="zd_company" size="25" datatype="Require" msg="请输入公司/个人名称!"/><span style="color: red;">*</span>
            </font></b></td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" align="right" width="19%" height="25"   bordercolor="#E6E6E6"><font color="#565656">
		具体地址：</font></td>
        <td class="unnamed2" align="right" width="457" height="25"   bordercolor="#E6E6E6"><p align="left" style="margin-left: 15px"><b><font color="blue">
            <input size="40" name="zd_contact_address" type="text" id="zd_contact_address"/>
            </font></b></td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" align="right" width="19%" height="25" bordercolor="#E6E6E6"  ><font color="#565656">
		电话号码：</font></td>
        <td class="unnamed2" align="left" width="457" height="25" bordercolor="#E6E6E6"  ><p style="margin-left: 15px"> <b><font color="blue">
            <input size="31" name="zd_contact_tel" type="text" id="zd_contact_tel" datatype="Custom" regexp="(^(\d{3,4}-)?\d{7,8})$|(^(\d{3,4}-)?(1[358][0-9]{9}))" msg="电话号码格式不正确!"/><span style="color: red;">*</span>
            </font></b></td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" align="right" width="19%" height="25"  ><font color="#565656">
		联 系 人：</font></td>
        <td class="unnamed2" align="left" width="457" height="25"  ><p style="margin-left: 15px"> <b><font color="blue">
            <input name="zd_name" type="text" id="zd_name" size="20" datatype="Require" msg="请输入联系人!"/><span style="color: red;">*</span>
            </font></b></td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" align="right" width="19%" height="25"><font color="#565656">
		电子邮箱地址：</font></td>
        <td class="unnamed2" align="left" width="457" height="25"><p style="margin-left: 15px"> <b><font color="blue">
            <input name="zd_email" type="text" id="zd_email"  size="35" datatype="Email" msg="请输入正确的邮箱地址!"/><span style="color: red;">*</span>
            </font></b></td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" align="right" width="19%" height="25"  > 　</td>
        <td class="unnamed2" align="left" width="457" height="25"  ><p style="margin-left: 15px"> <font color="#808080"> 
		我们将会回复发送到您输入<span lang="zh-cn">的</span>电子邮箱，希望您准确输入邮箱地址 </font></td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" align="right" width="19%" height="25"  ><font color="#565656">
		订购产品：</font></td>
        <td class="unnamed2" align="left" width="457" height="25"  ><p style="margin-left: 15px"> <b><font color="blue">
            <input size="32" name="zd_product_name" type="text" id="zd_product_name" dataType="Require" msg="请输入订购产品!"/><span style="color: red;">*</span>
            </font></b></td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" vAlign="top" width="19%" height="75"><p align="right"><font color="#565656"> 
		其他意见和要求：</font></td>
        <td class="unnamed2" width="457" height="75"><p style="margin-left: 15px">
            <textarea class="p92" name="zd_message" id="zd_message" rows="3" cols="48" dataType="LimitB" min="3" max="600"  msg="请输入内容!" onpropertychange="if((this.value).length>600){this.value=(this.value).substr(0,600);alert('内容不能超过600。');}" onFocus="javascript:if(this.innerHTML=='请填写您的留言,谢谢!'){this.innerHTML ='';}">请填写您的留言,谢谢!</textarea><span style="color: red;">*</span>
        </td>
      </tr>
      <tr vAlign="center">
        <td class="unnamed2" vAlign="top" height="5" colspan="2"></td>
      </tr>
    </table>
  </div>
  <div align="center">
    <table id="table61" cellSpacing="0" cellPadding="0" width="100%" border="0">
      <tr>
        <td vAlign="bottom" width="100%" height="25" style="color: #333333; font-family: Verdana, Arial, 宋体; font-size: 9pt; line-height: 150%" align="center"><p>
            <input style="color: #666666; background-image:url(../images/104.gif); width:66; height:23; padding-left:4px; padding-right:4px; padding-top:1px; padding-bottom:1px" onClick="javaScript:if(Validator.Validate(document.getElementById('theform'),1)){form_submit(0,0);}" type="button" value="发送" name="发送">&nbsp;&nbsp;&nbsp;&nbsp;
            <input style="color: #666666; background-image:url(../images/104.gif); width:66; height:23; padding-left:4px; padding-right:4px; padding-top:1px; padding-bottom:1px" type="reset" value="取消" name="取消">
        </td>
      </tr>
    </table>
  </div>
 	<input name="zd_id" type="hidden" id="zd_id" value="0" />
	<input name="zd_web_no" type="hidden" id="zd_web_no" value='<%=web_no%>' />
	<input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value='products03' />
	<input name="zd_language_version" type="hidden" id="zd_language_version" value='<%=language_version%>' />
	<input name="zd_add_user" type="hidden" id="zd_add_user" value='customers' />
	<input name="zd_add_ip" type="hidden" id="zd_add_ip" value='<%=request.getRemoteHost()%>' />
	<input name="zd_add_date" type="hidden" id="zd_add_date" value='<%=dateformat.format(Calendar.getInstance().getTime())%>' />
	<input name="zd_sort_no" type="hidden" id="zd_sort_no" value='0' />
	<input name="zd_state" type="hidden" id="zd_state" value='0' />
</form>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
	finally{pool.freeConnection(conn);}	
%>