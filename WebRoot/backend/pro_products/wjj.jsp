<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String tablePrefix = Env.getInstance().getProperty("table_prefix");
        String uuid ="";
		String b1=""; String b2=""; String b3=""; String b4=""; String b5=""; String b6=""; String b7=""; String b8=""; String b9=""; String b10=""; String b11=""; String b12=""; String b13=""; String b14=""; String b15="";
		String p1=""; String p2=""; String p3=""; String p4=""; String p5=""; String p6=""; String p7=""; String p8=""; String p9=""; String p10=""; String p11=""; String p12=""; String p13=""; String p14=""; String p15="";
		String pname1=""; String pname2=""; String pname3=""; String pname4=""; String pname5=""; String pname6=""; String pname7=""; String pname8=""; String pname9=""; String pname10=""; String pname11=""; String pname12=""; String pname13=""; String pname14=""; String pname15="";
		try {
				Map model = null;
		        connection = dbHelper.getConnection();
				List<Map> brandList=(ArrayList)(dbHelper.getMapList(" select id,name from pro_agent_factory where  is_show=1 and flag =1 and id in(select distinct(factoryid)  from pro_products where is_show =1 and catalognum in('101001001','101001004','101001007') ) order by view_count desc",connection));
                Map formMap=new HashMap();
		     	List<Map> proList = (ArrayList)application.getAttribute("brandList") ;
				proList=new ArrayList();

				List <Map>plist=(List <Map>)(dbHelper.getMapList(" select top 15 id,name,factoryid from pro_products where  is_show=1 and  catalognum in('101001001','101001004','101001007')  order by orderno desc,view_count desc",connection));
			 
				b1=CommonString.getFormatPara(plist.get(0).get("factoryid"));
				p1=CommonString.getFormatPara(plist.get(0).get("id"));
				pname1=CommonString.getFormatPara(plist.get(0).get("name"));

				b2=CommonString.getFormatPara(plist.get(1).get("factoryid"));
				p2=CommonString.getFormatPara(plist.get(1).get("id"));
				pname2=CommonString.getFormatPara(plist.get(1).get("name"));

				b3=CommonString.getFormatPara(plist.get(2).get("factoryid"));
				p3=CommonString.getFormatPara(plist.get(2).get("id"));
				pname3=CommonString.getFormatPara(plist.get(2).get("name"));

				b4=CommonString.getFormatPara(plist.get(3).get("factoryid"));
				p4=CommonString.getFormatPara(plist.get(3).get("id"));
				pname4=CommonString.getFormatPara(plist.get(3).get("name"));

				b5=CommonString.getFormatPara(plist.get(4).get("factoryid"));
				p5=CommonString.getFormatPara(plist.get(4).get("id"));
				pname5=CommonString.getFormatPara(plist.get(4).get("name"));

				b6=CommonString.getFormatPara(plist.get(5).get("factoryid"));
				p6=CommonString.getFormatPara(plist.get(5).get("id"));
				pname6=CommonString.getFormatPara(plist.get(5).get("name"));

				b7=CommonString.getFormatPara(plist.get(6).get("factoryid"));
				p7=CommonString.getFormatPara(plist.get(6).get("id"));
				pname7=CommonString.getFormatPara(plist.get(6).get("name"));

				b8=CommonString.getFormatPara(plist.get(7).get("factoryid"));
				p8=CommonString.getFormatPara(plist.get(7).get("id"));
				pname8=CommonString.getFormatPara(plist.get(7).get("name"));

				b9=CommonString.getFormatPara(plist.get(8).get("factoryid"));
				p9=CommonString.getFormatPara(plist.get(8).get("id"));
				pname9=CommonString.getFormatPara(plist.get(8).get("name"));

				b10=CommonString.getFormatPara(plist.get(9).get("factoryid"));
				p10=CommonString.getFormatPara(plist.get(9).get("id"));
				pname10=CommonString.getFormatPara(plist.get(9).get("name"));

				b11=CommonString.getFormatPara(plist.get(10).get("factoryid"));
				p11=CommonString.getFormatPara(plist.get(10).get("id"));
				pname11=CommonString.getFormatPara(plist.get(10).get("name"));

				b12=CommonString.getFormatPara(plist.get(11).get("factoryid"));
				p12=CommonString.getFormatPara(plist.get(11).get("id"));
				pname12=CommonString.getFormatPara(plist.get(11).get("name"));

				b13=CommonString.getFormatPara(plist.get(12).get("factoryid"));
				p13=CommonString.getFormatPara(plist.get(12).get("id"));
				pname13=CommonString.getFormatPara(plist.get(12).get("name"));

				b14=CommonString.getFormatPara(plist.get(13).get("factoryid"));
				p14=CommonString.getFormatPara(plist.get(13).get("id"));
				pname14=CommonString.getFormatPara(plist.get(13).get("name"));

				b15=CommonString.getFormatPara(plist.get(14).get("factoryid"));
				p15=CommonString.getFormatPara(plist.get(14).get("id"));
				pname15=CommonString.getFormatPara(plist.get(14).get("name"));	
 			
	 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
<form name="theform" id="theform" action="/backend/action/after_own.jsp">
  <div class="formDiv">
     <!--第一个-->
    <div class="formLeft"  style="width:60px;"> 厂家1 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id" id="brand_id" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% if(brandList != null){for(Map m : brandList){ %>
        <option value="<%=m.get("id")%>" <%if(b1.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id" id="pro_id" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p1%>"   selected="selected"  ><%=pname1%></option>
      </select>
    </div>
    <div style="clear: left;"></div>
    <!--第二个-->
    <div class="formLeft"  style="width:60px;"> 厂家2 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id2" id="brand_id2" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <%  if(brandList != null){for(Map m : brandList){  %>
        <option value="<%=m.get("id")%>" <%if(b2.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id2" id="pro_id2" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <option value="<%=p2%>"   selected="selected"  ><%=pname2%></option>
      </select>
    </div>
    <div style="clear: left;"></div>
	<!--第三个-->
    <div class="formLeft"  style="width:60px;"> 厂家3 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id3" id="brand_id3" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <% if(brandList != null){for(Map m : brandList){  %>
        <option value="<%=m.get("id")%>" <%if(b3.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id3" id="pro_id3" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p3%>"   selected="selected"  ><%=pname3%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
    
	<!--第四个-->
    <div class="formLeft"  style="width:60px;"> 厂家4 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id4" id="brand_id4" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <%  if(brandList != null){for(Map m : brandList){  %>
        <option value="<%=m.get("id")%>" <%if(b4.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id4" id="pro_id4" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p4%>"   selected="selected"  ><%=pname4%></option>
      </select>
    </div>
    <div style="clear: left;"></div>
    
	<!--第五个-->
    <div class="formLeft"  style="width:60px;"> 厂家5 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id5" id="brand_id5" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <%  if(brandList != null){for(Map m : brandList){  %>
        <option value="<%=m.get("id")%>" <%if(b5.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id5" id="pro_id5" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <option value="<%=p5%>"   selected="selected"  ><%=pname5%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
    
    <!--第六个-->
    <div class="formLeft"  style="width:60px;"> 厂家6 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id6" id="brand_id6" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
				%>
        <option value="<%=m.get("id")%>" <%if(b6.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id6" id="pro_id6" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <option value="<%=p6%>"   selected="selected"  ><%=pname6%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
    
    <!--第七个-->
    <div class="formLeft"  style="width:60px;"> 厂家7 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id7" id="brand_id7" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
				%>
        <option value="<%=m.get("id")%>" <%if(b7.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id7" id="pro_id7" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p7%>"   selected="selected"  ><%=pname7%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
    
	<!--第八个-->
    <div class="formLeft"  style="width:60px;"> 厂家8 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id8" id="brand_id8" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
				%>
        <option value="<%=m.get("id")%>" <%if(b8.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id8" id="pro_id8" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <option value="<%=p8%>"   selected="selected"  ><%=pname8%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
    
  
    <div class="formLeft"  style="width:60px;"> 厂家9 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id9" id="brand_id9" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(b9.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id9" id="pro_id9" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <option value="<%=p9%>"   selected="selected"  ><%=pname9%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
	
	
	  <!--额外-->

	
	  
    <div class="formLeft"  style="width:60px;"> 厂家10 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id10" id="brand_id10" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(b10.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id10" id="pro_id10" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p10%>"   selected="selected"  ><%=pname10%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
	
	  
    <div class="formLeft"  style="width:60px;"> 厂家11 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id11" id="brand_id11" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(b11.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id11" id="pro_id11" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <option value="<%=p11%>"   selected="selected"  ><%=pname11%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
	
	  
    <div class="formLeft"  style="width:60px;"> 厂家12 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id12" id="brand_id12" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(b12.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id12" id="pro_id12" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p12%>"   selected="selected"  ><%=pname12%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
	
	
	<div class="formLeft"  style="width:60px;"> 厂家13 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id13" id="brand_id13" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(b13.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id13" id="pro_id13" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p13%>"   selected="selected"  ><%=pname13%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
	  
	  
    <div class="formLeft"  style="width:60px;"> 厂家14 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id14" id="brand_id14" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(b14.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id14" id="pro_id14" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <option value="<%=p14%>"   selected="selected"  ><%=pname14%></option>

      </select>
    </div>
    <div style="clear: left;"></div>
	
	  
    <div class="formLeft"  style="width:60px;"> 厂家15 </div>
    <div class="formRight" style="width: 100px">
       <select name="brand_id15" id="brand_id15" class="jr_select" style="width: 100px;"  >
        <option value="">-请选择-</option>
        <% 
				if(brandList != null){for(Map m : brandList){ 
		%>
        <option value="<%=m.get("id")%>" <%if(b15.equals(Integer.toString((Integer)m.get("id")))){%> selected="selected" <%}%> ><%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formLeft" style="width:60px;"> 产品型号 </div>
    <div class="formRight" style="width: 100px">
       <select name="pro_id15" id="pro_id15" class="jr_select" style="width: 100px;" >
        <option value="">-请选择-</option>
        <option value="<%=p15%>"   selected="selected"  ><%=pname15%></option>

      </select>
    </div>
    <div style="clear: left;"></div>

  </div>
  <input type="hidden" name="pro_uuid" id="pro_uuid" value="<%=uuid %>" />
  <input type="hidden" name="eventAfter" id="eventAfter" value="wjjOrder" />
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function doSub(){
		//var rs = Validator.Validate(document.getElementById("theform"),1);
		var rs=1;
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
						jrSuccess("保存成功！");			
				}
			});
		}
	}
</script>
<script type="text/javascript" language="javascript">
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id").html(jQuery.trim(data));
			 });
		});
	});
	
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id2").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id2").html(jQuery.trim(data));
			 });
		});
	});
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id3").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id3").html(jQuery.trim(data));
			 });
		});
	});
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id4").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id4").html(jQuery.trim(data));
			 });
		});
	});
	
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id5").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id5").html(jQuery.trim(data));

			 });
		});
	});
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id6").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id6").html(jQuery.trim(data));

			 });
		});
	});
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id7").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id7").html(jQuery.trim(data));

			 });
		});
	});
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id8").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id8").html(jQuery.trim(data));

			 });
		});
	});
	
	
 
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id9").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id9").html(jQuery.trim(data));
			 });
		});
	});
	
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id10").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id10").html(jQuery.trim(data));
			 });
		});
	});
	
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id11").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id11").html(jQuery.trim(data));
			 });
		});
	});
	
	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id12").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id12").html(jQuery.trim(data));
			 });
		});
	});

	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id13").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id13").html(jQuery.trim(data));
			 });
		});
	});	
	

	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id14").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id14").html(jQuery.trim(data));
			 });
		});
	});	

	//选择品牌加载该品牌的产品
	jQuery(function(){
		jQuery("#brand_id15").change(function(){
		     var brandId=this.value;
			 jQuery.post("/backend/action/ajax_r.jsp",{'brandId':brandId,'flag':'getProWjj'},function(data){
				$("#pro_id15").html(jQuery.trim(data));
			 });
		});
	});		
    </script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>