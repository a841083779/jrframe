<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*,org.json.*" %>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	
try{
		connection = dbHelper.getConnection();
		List<Map> areas = dbHelper.getMapList(" SELECT area_id,area_name FROM comm_area WHERE parent_area_id = 0 ",connection);
		List<Map> rili = dbHelper.getMapList(" SELECT factoryid,factoryname,id,name,catalognum,catalogname FROM pro_products  where factoryid=184 and is_show=1",connection);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>日立建机</title>
<meta name="keywords" content="日立,日立挖掘机" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="scripts/sele.css"/>
<link rel="stylesheet" type="text/css" href="style/style.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/scripts/citys.js"></script> 
</head>
<body>
<div class="top">
  <div class="wrap fix">
    <h1 class="l"><a href="http://www.hitachicm.com.cn/index.html" title=""><img src="images/logo.png" width="203" height="84" alt=""></a></h1>
    <div class="r"><a href="http://www.hitachicm.com.cn/index.html"><img src="images/right.png"  width="136" height="84" alt="" /></a></div>
  </div>
</div>
<form action="/action/order_save_rili.jsp" method="post" name="theform" id="theform" >
  <div class="xj">
    <h3 class="title">在线询价</h3>
    <input type="text" value="输入您的姓名" class="text inputholder" name="zd_name" id="zd_name"/>
    <div class="l sele"> 
      <div class="_val"><b class="r"></b><span>选择您所在省</span></div>
      <div class="_option" style="display: none;">
				<%  
         			if(null!=areas&&areas.size()>0){
         				for(Map m : areas){
         					%>
						 <a area_id="<%=CommonString.getFormatPara(m.get("area_id")) %>"  onclick="set_my_city('<%=CommonString.getFormatPara(m.get("area_id")) %>','<%=CommonString.getFormatPara(m.get("area_name")) %>');" ><%=CommonString.getFormatPara(m.get("area_name")) %></a>							
						
							<%
         				}
         			}
         		%>
	   </div>
    </div>
    
    <div class="l sele" style="margin-left:5px; display:inline"> 
      <div class="_val"><b class="r"></b><span id="thecity">选择您所在市</span></div>
      <div class="_option" style="display: none;" id="citys">
	  </div>
	  </div>
	  
	  <div class="l sele"> 
      <div class="_val"><b class="r"></b><span id="cata">选择类别</span></div>
      <div class="_option" style="display: none;">
		  <a onclick="set_my_cata('挖掘机')">挖掘机</a><a onclick="set_my_cata('装载机')">装载机</a>
	   </div>
    </div>
	 
	 
	 
	 <div class="l sele" style="margin-left:5px; display: block;" id="hidden3"> 
      <div class="_val"><b class="r"></b><span id="theproduct3">选择产品型号</span></div>
      <div class="_option" style="display: none;" id="product3">
       </div>
	  </div>
	  
	 <div class="l sele" style="margin-left:5px; display: none;" id="hidden1"> 
      <div class="_val"><b class="r"></b><span id="theproduct1">选择产品型号</span></div>
      <div class="_option" style="display: none;" id="product1">
        <a onclick="set_my_name('113','ZX120','挖掘机','101001001');">ZX120</a>
		<a onclick="set_my_name('7501','ZX130H','挖掘机','101001001');">ZX130H</a>
		<a onclick="set_my_name('20953','ZX60-5G','挖掘机','101001001');">ZX60-5G</a>
		<a onclick="set_my_name('20954','ZX70-5G','挖掘机','101001001');">ZX70-5G</a>
		<a onclick="set_my_name('20956','ZX200-5G','挖掘机','101001001');">ZX200-5G</a>
		<a onclick="set_my_name('20958','ZX210H-5G','挖掘机','101001001');">ZX210H-5G</a>
		<a onclick="set_my_name('20957','ZX210LC-5G','挖掘机','101001001');">ZX210LC-5G</a>
		<a onclick="set_my_name('20960','ZX330-5G ','挖掘机','101001001');">ZX330-5G</a>
		<a onclick="set_my_name('20962','ZX360H-5G','挖掘机','101001001');">ZX360H-5G</a>
		<a onclick="set_my_name('20963','ZX470LCH-5G','挖掘机','101001001');">ZX470LCH-5G</a>
		<a onclick="set_my_name('7505','ZX240-3G','挖掘机','101001001');">ZX240-3G</a>
		<a onclick="set_my_name('7506','ZX250H-3G','挖掘机','101001001');">ZX250H-3G</a>
		<a onclick="set_my_name('7507','ZX250LC-3G ','挖掘机','101001001');">ZX250LC-3G</a>
		<a onclick="set_my_name('10160','ZX260LCH-3G ','挖掘机','101001001');">ZX260LCH-3G</a>
		<a onclick="set_my_name('181','ZX870H-3','挖掘机','101001001');">ZX870H-3</a>
	  </div>
	  </div>
	  <div class="l sele" style="margin-left:5px; display: none;" id="hidden2"> 
      <div class="_val"><b class="r"></b><span id="theproduct2">选择产品型号</span></div>
      <div class="_option" style="display: none;" id="product2">
      <a onclick="set_my_name('624','ZW180','轮式装载机','101002007');">ZW180</a>
		<a onclick="set_my_name('627','ZW220','轮式装载机','101002007');">ZW220</a>
		<a onclick="set_my_name('630','ZW250','轮式装载机','101002007');">ZW250</a>
		<a onclick="set_my_name('633','ZW310','轮式装载机','101002007');">ZW310</a>
		<a onclick="set_my_name('10162','ZW330','轮式装载机','101002007');">ZW330</a>
		<a onclick="set_my_name('10163','ZW370-G','轮式装载机','101002007');">ZW370-G</a>
		<a onclick="set_my_name('10164','ZW550-G','轮式装载机','101002007');">ZW550-G</a>
	  </div>
	  </div>   
	  
	  
	    
    <input type="text" value="输入您的联系电话" name="zd_mobile_phone" id="zd_mobile_phone" class="text inputholder"/>
    <input type="button"  value="立即询价" onclick="doSub()" class="btn" />
		 <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
		 <input type="hidden" name="zd_city" id="zd_city" />
		 <input type="hidden" name="zd_province" id="zd_province" />
		 <input type="hidden" name="zd_catanum" id="zd_catanum" />
		 <input type="hidden" name="zd_cataname" id="zd_cataname"  />
		 <input type="hidden" name="zd_product_id" id="zd_product_id" />
		 <input type="hidden" name="zd_product_name" id="zd_product_name" />
		 <input type="hidden" name="zd_factoryid" id="zd_factoryid"  value="184"/>
		 <input type="hidden" name="zd_factoryname" id="zd_factoryname" value="日立" />
		 <input type="hidden" name="zd_contact_address" id="zd_contact_address" />
		 <textarea class="input03" name="zd_message" cols="77" rows="5" style="display:none;"  id="zd_message" ></textarea>
  </div>
 </form>
<div class="footer"> 日立建机官方网站 <a target="_blank" href="http://www.hitachicm.com.cn/index.html " class="n">点 击 进 入</a> </div>
</body>
</html>
						
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
<script type="text/javascript" src="scripts/sele.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
<script type="text/javascript">
function doSub(){
		var rs =1;
		var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 
		if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0 || jQuery("#zd_name").val()=='输入您的姓名' ) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		rs=0;
		return;
	}
	if (jQuery("#zd_email").val()=='输入您的电子邮箱' ) {
		jQuery("#zd_email").val(" ");
	}
	
	if (null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0 || jQuery("#zd_mobile_phone").val()=='输入您的联系电话') {
		jQuery.jBox.tip("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		rs=0;
		return;
	}
		if(jQuery("#zd_province").val()==''|| jQuery("#zd_province").val()=='选择您所在省'){
			jQuery.jBox.tip("选择省份") ;
			jQuery("#zd_city").focus() ;
		    rs=0;
		    return;
	}
	
	
	if(jQuery("#zd_product_name").val()=='' || jQuery("#cata").html()=='选择类别'){
			//jQuery("#theproduct3").html("选择产品型号")
			jQuery.jBox.tip("请先选择产品类别再选产品型号");
			rs=0;
			return; 
	
	}
	jQuery("#zd_city").val(  document.getElementById("thecity").innerHTML ) ;
		if(jQuery("#zd_city").val()==''|| jQuery("#zd_city").val()=='选择您所在市'){
			jQuery.jBox.tip("选择市区") ;
			jQuery("#zd_city").focus() ;
		    rs=0;
		    return;
	}
		
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		jQuery.jBox.tip("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		rs=0;
		return;
	}
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) 
		if(rs==1){
		jQuery("#theform").ajaxSubmit({
				type : 'POST',
				async : false ,
				success : function(data) {
					if (data) {
						alert("提交成功！");
					window.location.reload();
					} else{
					alert("提交失败！");
					}
				}
			});	
		}
	}
	
		
	function set_my_name(o,b,c,d){
		var id = o;
		var name=b;
		var cataname=c;
		var catanum=d;
		var address=name+cataname;
		 jQuery("#zd_product_id").val(id) ;
		 jQuery("#zd_product_name").val(name) ;
	 	 jQuery("#zd_cataname").val(cataname) ;
		 jQuery("#zd_catanum").val(catanum) ;
		 jQuery("#zd_message").text("您好，我对日立"+address+"感兴趣，想要咨询，请您给我回复，谢谢。");
	}
		function set_my_city(o,b){
		var area_id = o;
		 jQuery("#zd_province").val(b) ;
		jQuery.ajax({
			url : '/tools/ajax.jsp',
			async : false,
			type : 'post',
			data : {
				flag : 'get_city_new',
				p : area_id
			},
			success : function(data){
                 $("#citys").html(data);
				//var zd_city = document.getElementById("citys");
				//zd_city.html(data);
			}
		});
	}
	
	function set_my_cata(cata){
	var a=$("#hidden1");
	var b=$("#hidden2");
	if(cata=='挖掘机'){
		a.show() ;
		b.hide();
		$("#hidden3").hide();
	
	}else if(cata=='装载机'){
		b.show();
		a.hide();
		$("#hidden3").hide();
	}else{
		b.hide();
		a.hide();
		$("#hidden3").show();
	}
	}
	

 $('.sele').each(function() {
    $(this).sele({
     max:99,                   // 页面内select效果最大个数，z-index层级即从此开始递减
     act:"click",              // 触发下拉动作，可选click | mouseenter
     callback:function(a, b){} // 点击下拉a标签回调，@param(_val, _text)
   })
});

$.fn.inputholder=function(){
	var dval=$(this).val();
	$(this).focus(function(){
		$(this).val('').addClass('focus');
		}).blur(function(){
		if($(this).val()==''){
			$(this).val(dval).removeClass('focus');
			}
		});
	};
	var inputholder=$('.inputholder');
	if(inputholder.length){
		inputholder.each(function() {
		  $(this).inputholder()
	   })
	};
</script>