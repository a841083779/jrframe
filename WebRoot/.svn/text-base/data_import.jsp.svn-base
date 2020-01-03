<%@ page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.jerehnet.util.getproducts.ProductsDataImportAction"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.jerehnet.action.DataManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%
	PoolManager pool = new PoolManager();
	Connection conn = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	if (request.getParameter("sltFactoryDataBase") != null || request.getParameter("sltFactoryWebSite") != null) {
		String factory_id = "";
		String isDevelop = "";
		if (request.getParameter("sltFactoryDataBase") != null) {
			factory_id = request.getParameter("sltFactoryDataBase");
			isDevelop = "yes";
		} else {
			factory_id = request.getParameter("sltFactoryWebSite");
			isDevelop = "no";
		}
		new ProductsDataImportAction().getFactoryProductData(request, CommonDate.getToday("yyyy-MM-dd"), isDevelop, factory_id);
		PrintWriter pw = response.getWriter();
		pw.write("抓取完成");
		pw.flush();
		pw.close();
	} else {
		try {
			conn = pool.getConnection();
			String sql = "select id, factoryname,is_develop from ipt_product_factory where flag=1 and is_develop='yes'";
			rs = DataManager.executeQuery(conn, sql);
			sql = "select id, factoryname,is_develop from ipt_product_factory where flag=1 and is_develop='no'";
			rs2 = DataManager.executeQuery(conn, sql);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>产品中心数据导入</title>
		<script type="text/javascript">
	function submit_form(flag){
		if(flag==1){
			document.getElementById("btnBeginDataBase").disabled =true;
			document.getElementById("msg").innerText="正在导入，请稍后……";
			document.forms[0].submit();
		} else if (flag==2){
			document.getElementById("btnBeginWebSite").disabled =true;
			document.getElementById("msg").innerText="正在导入，请稍后……";
			document.forms[1].submit();
		}
	}
	</script>
	</head>
	<body>
		<form id="theform" name="theform" action="" method="post">
			<fieldset>
				<legend>
					从数据库抓取厂家产品数据
				</legend>
				<div>
					为方便测试，可选择单个厂家进行抓取：
					<select id="sltFactoryDataBase" name="sltFactoryDataBase">
						<option value="0">
							所有厂家
						</option>
						<%
							while (rs != null && rs.next()) {
										String isdevelpe = rs.getString("is_develop");
										if (isdevelpe.equals("yes")) {
											String factoryid = rs.getString("id");
											String factoryname = rs.getString("factoryname");
						%>
						<option value="<%=factoryid%>"><%=factoryname%></option>
						<%
							}
									}
						%>
					</select>
					<input id="btnBeginDataBase" name="btnBeginDataBase" type="button"
						value="开始" onclick="submit_form(1);" />
				</div>
			</fieldset>
		</form>
		<form id="theform2" name="theform2" action="" method="post">
			<fieldset>
				<legend>
					从网站抓取厂家产品数据
				</legend>
				<div>
					为方便测试，可选择单个厂家进行抓取：
					<select id="sltFactoryWebSite" name="sltFactoryWebSite">
						<option value="0">
							所有厂家
						</option>
						<%
							while (rs2 != null && rs2.next()) {
										String isdevelpe = rs2.getString("is_develop");
										if (isdevelpe.equals("no")) {
											String factoryid = rs2.getString("id");
											String factoryname = rs2.getString("factoryname");
						%>
						<option value="<%=factoryid%>"><%=factoryname%></option>
						<%
							}
									}
						%>
					</select>
					<input id="btnBeginWebSite" name="btnBeginWebSite" type="button"
						value="开始" onclick="submit_form(2);" />
				</div>
			</fieldset>
		</form>
		<span id="msg"></span>
		<br />
	</body>
</html>
<%
	} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			pool.freeConnection(conn);
			rs = null;
		}
	}
%>