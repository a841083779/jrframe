<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
// 生成所有的品牌详显页
	String usern = CommonString.getFormatPara(request.getParameter("usern")) ;
	String flag = request.getParameter("flag") ;
if(!"".equals(usern)  ){
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = new HashMap() ;
	List<Map> allbrandMap = dbHelper.getMapList("select usern from pro_agent_factory where flag = 1  ") ;
	root.put("usern",usern) ;
    freemarkerUtils.generate("brand/detail.htm",root,realPath+"/brand/"+usern+"/index.htm") ;  // 生成所有的品牌详显页
	out.println("ok") ;
    return  ;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
    	<script type="text/javascript" src="/scripts/jquery.form.js"></script></head>
	<body>
		<form method="post" action="" name="theform" id="theform">
			<input type="text" name="usern" id="usern"  maxlength="20" value="代理商简称"/>
			<input type="button" name="mysubmit" value="生成" id="mysubmit" onclick="doSubmit();" />
			<input type="hidden" name="flag" id="flag" value="can_do" />
		</form>
		<script type="text/javascript">
			jQuery("#usern").focus(function(){
				jQuery(this).val('') ;
			}) ;
			function doSubmit(){
			var inputusern = jQuery.trim(jQuery("#usern").val()) ;
				if(''==inputusern || inputusern=='代理商简称'){
					alert("请输入代理商简称") ;
					jQuery("#usern").focus() ;
				}else{
					jQuery("#theform").ajaxSubmit({
						type:"post" ,
						url:"create_one_brand_detail.jsp" ,
						success:function(msg){
							if(jQuery.trim(msg)=='ok'){
								alert("生成成功") ;
							}
						}
					}) ;
				}
			}
		</script>
	</body>
</html>