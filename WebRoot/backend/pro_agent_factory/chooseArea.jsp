<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%><%

	String id = CommonString.getFormatPara(request.getParameter("id")); 
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	
try{   
    connection = dbHelper.getConnection();
	String tableName=" pro_agent_factory";
	Map model = new HashMap();
    String area_sql = "select level_id,area_name,area_id,parent_area_id from comm_area where level_id in('1','2','3') order by  area_id asc" ;
	List<Map> areaList = null ;
	areaList = dbHelper.getMapList(area_sql) ;
		
	if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where id = ? ",new Object [] {id} , connection);
    }
    if(null==model||"".equals(model)){
       model = new HashMap(); 
    }
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>

<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/activity/tuku/scripts/comm.js"></script>
<style type="text/css">

.city ul li {float:left;list-style:none;}
.province ul li{list-style:none;}
</style>
</head>
<body>
<form name="theform" id="theform" action="/backend/action/after.jsp">
<div style="float: right">
<!-- <a id="SelectAll" href="javascript:;" onclick="selectAll();">全选</a> <a href="#">取消</a> -->
<a href="javascript:;" onClick="allSelect();">全选</a> 
<a href="javascript:;" onClick="noneSelect();">全不选</a> 
<a href="javascript:;" onClick="oppositeSelect();">反选</a> 
</div>
<div class="province">
<ul >
<%
Map areaMap=new HashMap();
for(int i=0;i<areaList.size();i++){
Map oneMap = (HashMap)areaList.get(i);
if(CommonString.getFormatPara(oneMap.get("level_id")).equals("1")){
%>
<li ><div style="clear:left;"></div><%=CommonString.getFormatPara(oneMap.get("area_name")) %><input style="margin-top:10px;margin-bottom:10px" onclick="checkeds()" type="checkbox" id="<%="area_name_"+CommonString.getFormatPara(oneMap.get("area_id")) %>" name="area_name" value="<%=CommonString.getFormatPara(oneMap.get("area_id")) %>"/></li>

<% 
}else if(CommonString.getFormatPara(oneMap.get("level_id")).equals("2")||CommonString.getFormatPara(oneMap.get("parent_area_id")).equals("105499")||CommonString.getFormatPara(oneMap.get("parent_area_id")).equals("105689")||CommonString.getFormatPara(oneMap.get("parent_area_id")).equals("105879")||CommonString.getFormatPara(oneMap.get("parent_area_id")).equals("105290")){
%>
<li>
<div class="city">
<ul >
<li><%=CommonString.getFormatPara(oneMap.get("area_name")) %><input  onclick="checkeds_city()" type="checkbox" id="<%="area_name_"+CommonString.getFormatPara(oneMap.get("area_id")) %>" name="area_name" value="<%=CommonString.getFormatPara(oneMap.get("area_id")) %>"/></li>
</ul>
</div>

</li>
<%
}else{

}
}
%>

</ul>
</div>
<input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
<input type="hidden" name="zd_id" id="zd_id"  value="<%=CommonString.getFormatPara(model.get("id")) %>"/>
<input type="hidden" name="zd_city_num" id="zd_city_num" value="<%=CommonString.getFormatPara(model.get("city_num")) %>"/>
<input type="hidden" name="zd_area_names" id="zd_area_names" value="<%=CommonString.getFormatPara(model.get("city")) %>"/>
<input type="hidden" name="zd_agent_id" id="zd_agent_id" value="<%=id %>"/>
<input type="hidden" name="eventAfter" id="eventAfter" value="update_agent_city"/>


</form>
</body>
</html>
<script type="text/javascript">
 jQuery(function(){
        var arr=new Array();
        var str=$("#zd_city_num").val();
        arr=str.split(',');
        for(var i=0;i<arr.length;i++)
        {
           //$("#area_name_"+arr[i]).attr("checked", true);
           var nodestr="#area_name_"+jQuery.trim(arr[i]);
           $(nodestr).attr("checked", true);
        }
	});


	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					if (rs > 0) {
						jrSuccess("保存成功！");
						<%
					if("".equals(id)){
						%>
					window.location.reload();
						<%
					}
						%>
					} 
				}
			});
		}
	}
	
/*获得ids*/	
function checkeds(){
     
        var parent_area_id = "";          
        $('input[name="area_name"]:checked').each(function() {  
            parent_area_id += $(this).val()+",";  
        });
        //alert("parent_area_id:"+parent_area_id);
        var arr=new Array();
        var str=parent_area_id;
        arr=str.split(',');       
        for(var i=0;i<arr.length-1;i++)
        {                  
            //alert("arr[i]:"+arr[i]);
            jQuery.ajax({
			async : false,
			type : 'post',
			url:'/backend/action/ajax_getSubareas.jsp',
			data:{parent_area_id:arr[i]} ,			
			success:function(data){
				var arr=new Array();
                var str=data;
                arr=str.split(',');
                for(var j=0;j<arr.length;j++)
                {                  
                     var nodestr="#area_name_"+jQuery.trim(arr[j]);
                     $(nodestr).attr("checked", true);
                }
				
			}
		});
        }
        
        
        
        
        
        var ids = "";  
        $('input[name="area_name"]:checked').each(function() {  
            ids += $(this).val() + ',';  
        });
        var texts = "";  
        $('input[name="area_name"]:checked').each(function() {  
            texts += $(this).parent().text() + ',';  
        });
        var str = ids.substring(0, ids.lastIndexOf(","));  
        var textStr = texts.substring(0, ids.lastIndexOf(","));  
        //var textUtf = encodeURI(encodeURI(textStr));  
        $("#zd_city_num").val(str);
        $("#zd_area_names").val(textStr);
} 


function checkeds_city(){
        /* var chk_value =[];//定义一个数组
           var chk_Str="";   //定义一个字符串   
         $('input:checkbox[name="zd_area_name"]:checked').each(function() //zd_area_name checkbox的name  
        {  
           chk_value.push($(this).val());//将选中的值添加到数组chk_value中   
        });
         $.each(chk_value, function(i,val){      
            chk_Str+=val+","
        });*/ 
        
        var ids = "";  
        $('input[name="area_name"]:checked').each(function() {  
            ids += $(this).val() + ',';  
        });
        var texts = "";  
        $('input[name="area_name"]:checked').each(function() {  
            texts += $(this).parent().text() + ',';  
        });
        var str = ids.substring(0, ids.lastIndexOf(","));  
        var textStr = texts.substring(0, ids.lastIndexOf(","));  
        //var textUtf = encodeURI(encodeURI(textStr));  
        $("#zd_city_num").val(str);
        $("#zd_area_names").val(textStr);
} 




var area_name = $("input[name='area_name']");  
function allSelect(){
    for(i=0; i<area_name.length; i++){  
        if(area_name[i].type="checkbox"){  
            area_name[i].checked = true;  
        }  
    } 
   checkeds_city();	
}  
  
function noneSelect(){  
    for(i=0; i<area_name.length; i++){  
        if(area_name[i].type="checkbox"){  
            area_name[i].checked = false;  
        }  
    }  
}  
  
function oppositeSelect(){  
    for(i=0; i<area_name.length; i++){  
        if(area_name[i].type="checkbox"){  
            area_name[i].checked = (area_name[i].checked)?false:true;  
        }  
    }  
}  

</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>