<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
		String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
		//List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		//List <Map> catalogList = null;
		List <Map> relateList = null;
		List <Map> brandList = null;
		String actionPath="";
		String agentId = CommonString.getFormatPara(request.getParameter("id"));
		String agentName = CommonString.getFormatPara(request.getParameter("name"));
		int num=0;
		int rId1=0;String brandId1="",brandName1="",catalogNum1="",catalogName1="";
		int rId2=0;String brandId2="",brandName2="",catalogNum2="",catalogName2="";
		int rId3=0;String brandId3="",brandName3="",catalogNum3="",catalogName3="";
		int rId4=0;String brandId4="",brandName4="",catalogNum4="",catalogName4="";
		int rId5=0;String brandId5="",brandName5="",catalogNum5="",catalogName5="";
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
				brandList = dbHelper.getMapList(" select id,name,upper_index from pro_agent_factory where flag = 1 and is_show=1 order by upper_index asc ",connection);
				//catalogList = dbHelper.getMapList(" select num,name from pro_catalog where parentid <> 0 ",connection);
				relateList = dbHelper.getMapList(" select * from pro_agent_relate_product where agent_id = ? ",new Object[]{agentId},connection);
				
				if(relateList!=null && relateList.size()>0){
					actionPath="updateAgentProductForm";
				}else{
					actionPath="insertAgentProductForm";
				}
				
				if(relateList!=null && relateList.size()>0){
					for(Map m:relateList){
						num++;
						if(num==1){
							rId1=CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")));
							brandId1=CommonString.getFormatPara(m.get("brand_id"));
							brandName1=CommonString.getFormatPara(m.get("brand_name"));
							catalogNum1=CommonString.getFormatPara(m.get("catalog_num"));
							catalogName1=CommonString.getFormatPara(m.get("catalog_name"));
						}
						if(num==2){
							rId2=CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")));
							brandId2=CommonString.getFormatPara(m.get("brand_id"));
							brandName2=CommonString.getFormatPara(m.get("brand_name"));
							catalogNum2=CommonString.getFormatPara(m.get("catalog_num"));
							catalogName2=CommonString.getFormatPara(m.get("catalog_name"));
						}
						if(num==3){
							rId3=CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")));
							brandId3=CommonString.getFormatPara(m.get("brand_id"));
							brandName3=CommonString.getFormatPara(m.get("brand_name"));
							catalogNum3=CommonString.getFormatPara(m.get("catalog_num"));
							catalogName3=CommonString.getFormatPara(m.get("catalog_name"));
						}
						if(num==4){
							rId4=CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")));
							brandId4=CommonString.getFormatPara(m.get("brand_id"));
							brandName4=CommonString.getFormatPara(m.get("brand_name"));
							catalogNum4=CommonString.getFormatPara(m.get("catalog_num"));
							catalogName4=CommonString.getFormatPara(m.get("catalog_name"));
						}
						if(num==5){
							rId5=CommonString.getFormatInt(CommonString.getFormatPara(m.get("id")));
							brandId5=CommonString.getFormatPara(m.get("brand_id"));
							brandName5=CommonString.getFormatPara(m.get("brand_name"));
							catalogNum5=CommonString.getFormatPara(m.get("catalog_num"));
							catalogName5=CommonString.getFormatPara(m.get("catalog_name"));
						}
					}
				}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<!--<link href="http://www.ligerui.com/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />-->
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    </style>
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />

<script src="/plugin/jquery/jquery-1.9.0.min.js" type="text/javascript"></script> 
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
    <script src="/plugin/ui/ligerUI/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="/plugin/ui/ligerUI/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
    <script src="/plugin/ui/ligerUI/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="/plugin/ui/ligerUI/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function ()
        {

            var combo1 = $("#catalog_num1").ligerComboBox({
                width: 300,
                selectBoxWidth: 300,
                selectBoxHeight: 110, valueField: 'id',textField: 'id',
                tree: { url: 'tree/json.txt', ajaxType: 'get', idFieldName: 'id' }
            });


            var combo2 = $("#catalog_num2").ligerComboBox({
                width: 300,
                selectBoxWidth: 300,
                selectBoxHeight: 110, valueField: 'id',textField: 'id',
                tree: { url: 'tree/json.txt', ajaxType: 'get', idFieldName: 'id' }
            });
            var combo3 = $("#catalog_num3").ligerComboBox({
                width: 300,
                selectBoxWidth: 300,
                selectBoxHeight: 110, valueField: 'id',textField: 'id',
                tree: { url: 'tree/json.txt', ajaxType: 'get', idFieldName: 'id' }
            });
			var combo4 = $("#catalog_num4").ligerComboBox({
                width: 300,
                selectBoxWidth: 300,
                selectBoxHeight: 110, valueField: 'id',textField: 'id',
                tree: { url: 'tree/json.txt', ajaxType: 'get', idFieldName: 'id' }
            });
			var combo5 = $("#catalog_num5").ligerComboBox({
                width: 300,
                selectBoxWidth: 300,
                selectBoxHeight: 110, valueField: 'id',textField: 'id',
                tree: { url: 'tree/json.txt', ajaxType: 'get', idFieldName: 'id' }
            });

			<%
			if(!"".equals(catalogNum1)){
			%>
			combo1.selectValue("<%=catalogNum1%>");
			<%
			}
			%>
			<%
			if(!"".equals(catalogNum2)){
			%>
			combo2.selectValue("<%=catalogNum2%>");
			<%
			}
			%>
			<%
			if(!"".equals(catalogNum3)){
			%>
			combo3.selectValue("<%=catalogNum3%>");
			<%
			}
			%>
			<%
			if(!"".equals(catalogNum4)){
			%>
			combo4.selectValue("<%=catalogNum4%>");
			<%
			}
			%>
			<%
			if(!"".equals(catalogNum5)){
			%>
			combo5.selectValue("<%=catalogNum5%>");
			<%
			}
			%>
        });


    </script>
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
<form name="theform" id="theform" action="/backend/action/after_own.jsp">
  <div class="formDiv">
    <div class="group"> <span> <img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif" /> </span> <span class="groupTitle">代理品牌</span> </div>
    <!--第一个-->
	
    <div class="formLeft" style="width:60px;"> 代理品牌1 </div>
    <div class="formRight" style="width:140px; ">
      <select name="select_brand1" id="select_brand1" class="jr_select" style="width: 140px;" onchange="changeBrand1();">
        <option value="">-请选择-</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(brandId1.equals(CommonString.getFormatPara(m.get("id")))){ out.print("selected"); }%>><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 0px">
	  <input style="width: 0px" type="hidden"  class="jr_text" name="brand_id1" id="brand_id1" value="<%=brandId1%>" />
      <input style="width: 0px" type="hidden"  class="jr_text" name="brand_name1" id="brand_name1" value="<%=brandName1%>" />
    </div>
	<div class="formLeft"  style="width:60px;"> 代理类别</div>
    <div class="formRight" style="width: 200px">
      <input type="text"  class="jr_text" name="catalog_num1" id="catalog_num1" value="<%=catalogNum1%>" />
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 300px">
	  <input name="relate_id1" id="relate_id1" type="hidden" value="<%=rId1%>"/>
	  
    </div>
	<div style="clear: left;"></div>
	<!--第二个-->
    <div class="formLeft" style="width:60px;"> 代理品牌2 </div>
    <div class="formRight" style="width:140px; ">
      <select name="select_brand2" id="select_brand2" class="jr_select" style="width: 140px;" onchange="changeBrand2();">
        <option value="">-请选择-</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(brandId2.equals(CommonString.getFormatPara(m.get("id")))){ out.print("selected"); }%>><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 0px">
	  <input style="width: 0px" type="hidden"  class="jr_text" name="brand_id2" id="brand_id2" value="<%=brandId2%>" />
      <input style="width: 0px" type="hidden"  class="jr_text" name="brand_name2" id="brand_name2" value="<%=brandName2%>" />
    </div>
	<div class="formLeft"  style="width:60px;"> 代理类别</div>
    <div class="formRight" style="width: 200px">
      <input type="text"  class="jr_text" name="catalog_num2" id="catalog_num2" value="<%=catalogNum2%>" />
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 300px">
	  <input name="relate_id2" id="relate_id2" type="hidden" value="<%=rId2%>"/>
	  
    </div>
	<div style="clear: left;"></div>
	<!--第三个-->
    <div class="formLeft" style="width:60px;"> 代理品牌3 </div>
    <div class="formRight" style="width:140px; ">
      <select name="select_brand3" id="select_brand3" class="jr_select" style="width: 140px;" onchange="changeBrand3();">
        <option value="">-请选择-</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(brandId3.equals(CommonString.getFormatPara(m.get("id")))){ out.print("selected"); }%>><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 0px">
	  <input style="width: 0px" type="hidden"  class="jr_text" name="brand_id3" id="brand_id3" value="<%=brandId3%>" />
      <input style="width: 0px" type="hidden"  class="jr_text" name="brand_name3" id="brand_name3" value="<%=brandName3%>" />
    </div>
	<div class="formLeft"  style="width:60px;"> 代理类别</div>
    <div class="formRight" style="width: 200px">
	<input type="text"  class="jr_text" name="catalog_num3" id="catalog_num3" value="<%=catalogNum3%>" />
     
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 300px">
	  <input name="relate_id3" id="relate_id3" type="hidden" value="<%=rId3%>"/>
	   
    </div>
	<div style="clear: left;"></div>
	<!--第四个-->
    <div class="formLeft" style="width:60px;"> 代理品牌4 </div>
    <div class="formRight" style="width:140px; ">
      <select name="select_brand4" id="select_brand4" class="jr_select" style="width: 140px;" onchange="changeBrand4();">
        <option value="">-请选择-</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(brandId4.equals(CommonString.getFormatPara(m.get("id")))){ out.print("selected"); }%>><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 0px">
	  <input style="width: 0px" type="hidden"  class="jr_text" name="brand_id4" id="brand_id4" value="<%=brandId4%>" />
      <input style="width: 0px" type="hidden"  class="jr_text" name="brand_name4" id="brand_name4" value="<%=brandName4%>" />
    </div>
	<div class="formLeft"  style="width:60px;"> 代理类别</div>
    <div class="formRight" style="width: 200px">
      <input type="text"  class="jr_text" name="catalog_num4" id="catalog_num4" value="<%=catalogNum4%>" />
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 300px">
	  <input name="relate_id4" id="relate_id4" type="hidden" value="<%=rId4%>"/>
	  
    </div>
	<div style="clear: left;"></div>
	<!--第五个-->
    <div class="formLeft" style="width:60px;"> 代理品牌5 </div>
    <div class="formRight" style="width:140px; ">
      <select name="select_brand5" id="select_brand5" class="jr_select" style="width: 140px;" onchange="changeBrand5();">
        <option value="">-请选择-</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" <%if(brandId5.equals(CommonString.getFormatPara(m.get("id")))){ out.print("selected"); }%>><%=CnToFullSpell.getFullSpell(CommonString.getFormatPara(m.get("name")).substring(0,1)).toUpperCase().substring(0,1)%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 0px">
	  <input style="width: 0px" type="hidden"  class="jr_text" name="brand_id5" id="brand_id5" value="<%=brandId5%>" />
      <input style="width: 0px" type="hidden"  class="jr_text" name="brand_name5" id="brand_name5" value="<%=brandName5%>" />
    </div>
	<div class="formLeft"  style="width:60px;"> 代理类别</div>
    <div class="formRight" style="width: 200px">
      <input type="text"  class="jr_text" name="catalog_num5" id="catalog_num5" value="<%=catalogNum5%>" />
    </div>
    <div class="formLeft" style="width:5px;"> </div>
    <div class="formRight" style="width: 300px">
	  <input name="relate_id5" id="relate_id5" type="hidden" value="<%=rId5%>"/>
	  
    </div>

	
	
  </div>
  <input name="agent_id" id="agent_id" type="hidden" value="<%=agentId%>"/>
  <input name="agent_name" id="agent_name" type="hidden" value="<%=agentName%>"/>
  <input type="hidden" name="eventAfter" id="eventAfter" value="<%=actionPath%>" />
  <input type="hidden" name="tableName" id="tableName" value="pro_agent_relate_product" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>

<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function changeBrand1(){
		$('#brand_id1').val($('#select_brand1').val());
		$('#brand_name1').val($('#select_brand1').find('option:selected').text().substring($('#select_brand1').find('option:selected').text().indexOf('-')+1));
		
	}

	function changeBrand2(){
		$('#brand_id2').val($('#select_brand2').val());
		$('#brand_name2').val($('#select_brand2').find('option:selected').text().substring($('#select_brand2').find('option:selected').text().indexOf('-')+1));
		
	}

	function changeBrand3(){
		$('#brand_id3').val($('#select_brand3').val());
		$('#brand_name3').val($('#select_brand3').find('option:selected').text().substring($('#select_brand3').find('option:selected').text().indexOf('-')+1));
		
	}

	function changeBrand4(){
		$('#brand_id4').val($('#select_brand4').val());
		$('#brand_name4').val($('#select_brand4').find('option:selected').text().substring($('#select_brand4').find('option:selected').text().indexOf('-')+1));
		
	}

	function changeBrand5(){
		$('#brand_id5').val($('#select_brand5').val());
		$('#brand_name5').val($('#select_brand5').find('option:selected').text().substring($('#select_brand5').find('option:selected').text().indexOf('-')+1));
		
	}

	function doSub(){

		var rs=1;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
						jrSuccess("操作成功！");			
				}
			});
		}
	}
</script>
<script type="text/javascript" language="javascript">
   
	

    </script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>