function showinquery(pid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order_s.jsp?productid="+pid+"&factoryid="+factoryid, {
	title: "在线询价",
	width: 769,
	height: 480,
	top: '10%',	
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px",top:"-20px",right:"-20px"});
}
	//加入对比
	$('.add_compare').on('click', function(event) {	 
        var id=$(this).data('val');
	    var count = $("#cmpContent li").length;
	    if(count>=4){
		    jQuery.jBox.tip("只能四款机型进行对比！");
	    }else{
		    addShowNew(id);
		    addCookie(id);
			showCookies();
			jQuery('.sb_layer_duibi .check_box').find('.fn').html($('#cmpContent').find("input[name='db_subBox']:checked").length+1);
			jQuery('.sb_layer_duibi .check_box').find('.all').html($('#cmpContent').find("input[name='db_subBox']").length+1);
	    } 
	});
	$('.add_compare_param').on('click', function(event) {	 
        var id=$(this).data('val');
	    var count = $("#cmpContent li").length;
	    if(count>=4){
		    jQuery.jBox.tip("只能四款机型进行对比！");
	    }else{
		    addShowNew(id);
		    addCookie(id);
			showCookies();
			jQuery('.sb_layer_duibi .check_box').find('.fn').html($('#cmpContent').find("input[name='db_subBox']:checked").length+1);
			jQuery('.sb_layer_duibi .check_box').find('.all').html($('#cmpContent').find("input[name='db_subBox']").length+1);
	    } 
	});
	showCookie();
	showCookies();
	function showCookie(){
	var compareStr = $.cookies.get('compareArr');
	if(typeof(compareStr)!="undefined" && compareStr!="undefined" && compareStr!=null && compareStr!="null" && compareStr.length>1){
		//openCompare();//展开对比框
		var arr = compareStr.split(",");
		var length = arr.length>4?5:arr.length;
		for(var i=1;i<length;i++){
			addShow(arr[i]);
		}
	}
    }
	function showCookies(){
	var compareStr = $.cookies.get('compareArr');
	if(typeof(compareStr)!="undefined" && compareStr!="undefined" && compareStr!=null && compareStr!="null" && compareStr.length>1){
		var arr = compareStr.split(",");
		var length = arr.length>4?5:arr.length;
		$("#jxdb").html(length-1);
       
	}else{
		$("#jxdb").html(0);
	}
    }
    function addShow(id){
	var url = "/action/ajax.jsp";
	jQuery.ajax({
			url : url,
			data : {
				flag : 'compareShowList',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#cmpContent").append(data);
							jQuery('.sb_layer_duibi .check_box').find('.fn').html($('#cmpContent').find("input[name='db_subBox']:checked").length);
					}
			}
		});
    }
    function removeOne(id){
	    removeShow(id); 
	    delCookie(id);
		showCookies();
		jQuery('.sb_layer_duibi .check_box').find('.fn').html($('#cmpContent').find("input[name='db_subBox']:checked").length);
		jQuery('.sb_layer_duibi .check_box').find('.all').html($('#cmpContent').find("input[name='db_subBox']").length);

    }
    function removeShow(id){
	   $("#comp_"+id).remove();
    }
	function delCookie(id){
	var compareStr = $.cookies.get('compareArr');
	compareStr = compareStr.replace(","+id,"");	
	$.cookies.set('compareArr',compareStr);
	   //showCookie();
    }
	function addCookie(id){
	var compareStr = $.cookies.get('compareArr');
	$.cookies.set("compareOpenFlag", "open");//设置flag

	if(typeof(compareStr)!=undefined && compareStr!=null  && compareStr!="null" && compareStr.length>2){
		if(compareStr.indexOf(id)<0){
			compareStr +=","+id;
		}
	}else{
		compareStr =","+id;	
	}
	$.cookies.set('compareArr',compareStr);
    }
	function addShowNew(id){
	var compareStr = $.cookies.get('compareArr');
	if(typeof(compareStr)!=undefined && compareStr!=null  && compareStr!="null"){
	if(compareStr.indexOf(id)<0){
	var url = "/action/ajax.jsp";
	jQuery.ajax({
			url : url,
			data : {
				flag : 'compareShowList',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#cmpContent").append(data);
						//alert("添加对比成功！");
						jQuery.jBox.tip("您好，已加入【机型对比】，别忘记点击右侧的进行机型对比哦") ;
					}
			}
		});
	}
	}else{
		var url = "/action/ajax.jsp";
	    jQuery.ajax({
			url : url,
			data : {
				flag : 'compareShowList',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#cmpContent").append(data);
						//alert("对比添加成功,您可以在右侧进行批量对比！");
						jQuery.jBox.tip("您好，已加入【机型对比】，别忘记点击右侧的进行机型对比哦") ;
					}
			}
		});
	}
 }
 //加入询价
	$('.add_inquiry').on('click', function(event) {	 
        var id=$(this).data('val');
	    var count = $("#xunjiaContent li").length;
	    if(count>=4){
		    jQuery.jBox.tip("最多只能四款机型进行询价！");
	    }else{
		    addShowNew1(id);
		    addCookie1(id);
			showCookie11();
			$('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length+1);
			$('.sb_layer_xunjia .check_box').find('.all').html($('#xunjiaContent').find("input[name='xj_subBox']").length+1);
	    } 
	});
	showCookie1();
	showCookie11();
	function showCookie1(){
	var compareStr = $.cookies.get('compareArr1');
	if(typeof(compareStr)!="undefined" && compareStr!="undefined" && compareStr!=null && compareStr!="null" && compareStr.length>1){
		//openCompare();//展开对比框
		var arr = compareStr.split(",");
		var length = arr.length>4?5:arr.length;
		for(var i=1;i<length;i++){
			addShow1(arr[i]);
		}
	}
    }
	function showCookie11(){
	var compareStr = $.cookies.get('compareArr1');
	if(typeof(compareStr)!="undefined" && compareStr!="undefined" && compareStr!=null && compareStr!="null" && compareStr.length>1){
		var arr = compareStr.split(",");
		var length = arr.length>4?5:arr.length;
		$("#plxj").html(length-1);
	}else{
		$("#plxj").html(0);
	}
    }
    function addShow1(id){
	var url = "/action/ajax.jsp";
	jQuery.ajax({
			url : url,
			data : {
				flag : 'inquiryShowList',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#xunjiaContent").append(data);
						jQuery('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length);

					}
			}
		});
    }
    function removeOne1(id){
	    removeShow1(id); 
	    delCookie1(id);
		showCookie11();
		$('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length);
		$('.sb_layer_xunjia .check_box').find('.all').html($('#xunjiaContent').find("input[name='xj_subBox']").length);
    }
    function removeShow1(id){
	   $("#comps_"+id).remove();
    }
	function delCookie1(id){
	var compareStr = $.cookies.get('compareArr1');
	compareStr = compareStr.replace(","+id,"");	
	$.cookies.set('compareArr1',compareStr);
	   //showCookie1();
    }
	function addCookie1(id){
	var compareStr = $.cookies.get('compareArr1');
	$.cookies.set("compareOpenFlag1", "open");//设置flag

	if(typeof(compareStr)!=undefined && compareStr!=null  && compareStr!="null" && compareStr.length>2){
		if(compareStr.indexOf(id)<0){
			compareStr +=","+id;
		}
	}else{
		compareStr =","+id;	
	}
	$.cookies.set('compareArr1',compareStr);
    }
	function addShowNew1(id){
	var compareStr = $.cookies.get('compareArr1');
	if(typeof(compareStr)!=undefined && compareStr!=null  && compareStr!="null"){
	if(compareStr.indexOf(id)<0){
	var url = "/action/ajax.jsp";
	jQuery.ajax({
			url : url,
			data : {
				flag : 'inquiryShowList',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#xunjiaContent").append(data);
						//alert("询价添加成功,您可以在右侧进行批量询价！");
						jQuery.jBox.tip("您好，已加入【批量询价】，别忘记点击右侧的进行批量询价哦") ;
					}
			}
		});
	}
	}else{
		var url = "/action/ajax.jsp";
	    jQuery.ajax({
			url : url,
			data : {
				flag : 'inquiryShowList',
				equiId : id
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#xunjiaContent").append(data);
						//alert("添加询价成功！");
						jQuery.jBox.tip("您好，已加入【批量询价】，别忘记点击右侧的进行批量询价哦") ;
					}
			}
		});
	}
 }
 //选择省份
 function set_my_city(obj){
	    var a=obj.value;
		var b=(obj.options[obj.selectedIndex].text);
	    $('#province').val(b);
	    jQuery.ajax({
			url : '/action/ajax.jsp',
			data : {
				flag : 'get_city',
				area_id : a
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#city_lists").html(data);
					}
			}
		});
 }
 //选择城市
  function set_area(obj){
		var b=(obj.options[obj.selectedIndex].text);
		$('#city').val(b);
		
		//大数据相关事件
		if (window.jereiReceiver) { 
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		 _jrTracker.trackFmTry("详细页询价单",'',"省市",$("#province").val()+b) ;
        }
  }
    //右侧开始对比
	$('#ksdb').on('click', function(event) {
        var compareids="";		
         var dbCheck = $('input[class="compare"]');
		 $.each(dbCheck, function(i, item){   
               if(dbCheck[i].checked){		 
				  compareids+=dbCheck[i].value+",";
			   }				  
          }); 
		  if(compareids==''){
			jQuery.jBox.tip("请选择需要对比的产品");  
		  }else{
			compareids=compareids.substring(0,compareids.length-1);
		    window.open("http://product.21-sun.com/compares/index.jsp?pids="+compareids);
		  }
	});
	 //右侧立即询价
	$('#ljxj').on('click', function(event) {	 
        var compareids="";		
         var dbCheck = $('input[class="inquiry"]');
		 $.each(dbCheck, function(i, item){   
               if(dbCheck[i].checked){		 
				  compareids+=dbCheck[i].value+",";
			   }				  
          }); 
		  if(compareids==''){
			jQuery.jBox.tip("请选择需要询价的产品");  
		  }else{
			  compareids=compareids.substring(0,compareids.length-1);
              var uname = $('#uname').val();
              var phone = $('#phone').val();
              var province = $('#province').val();
              var city = $('#city').val();
              var buy_time = $('#buy_time').val();	
              var buy_type = $('#buy_type').val();
			  if(uname==''){ alert("请输入姓名！"); return; }
			  if(phone==''){ alert("请输入电话！"); return; }
			  if(province==''){ alert("请选择省份！"); return; }
			  if(city==''){ alert("请选择城市！"); return; }
			  //if(buy_time==''){ alert("请选择购买时间！"); return; }
			  //if(buy_type==''){ alert("请选择购买方式！"); return; }
	          jQuery.ajax({
			   url : '/action/ajax.jsp',
			   data : {
				    flag : 'inquiryOrders',
				    compareids : compareids,
					uname : uname,
					phone : phone,
					province : province,
					city : city,
					buy_time : buy_time,
					buy_type : buy_type					
			   },
		    	success : function(data) {
					if($.trim(data)=="success"){
						jQuery.jBox.tip("批量询单成功") ;
						$('#xunjiaContent').html('');
						$('#inquiryCount').html('0');
						$('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length);

						
					}else{
						jQuery.jBox.tip("批量询单失败") ;
					}
			    }
		        });			  
		  }
	});
	
	
function showEnquiry(){

	var url = '/include/products/enquiry.jsp?1=1';
	var uname= jQuery("#uname").val();
	var uphone= jQuery("#uphone").val();
	var compare_ids=jQuery("#compare_ids").val();
	var province=jQuery("#uprovince").val();
	var city=jQuery("#ucity").val();
	
	
	if(uname!=''){
		url += "&uname="+uname;
	}
	if(uphone!=''){
		url += "&uphone="+uphone;
	}
	if(compare_ids!=''){
		url += "&compare_ids="+compare_ids;
	}
	if(province!=''){
		url += "&province="+province;
	}
	if(city!=''){
		url += "&city="+city;
	}
	

		jQuery.jBox("iframe:"+url,{
			title : "在线询价",
			width : 550,
			height : 210,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
  
}

function inquiryMul(){
	var uname= jQuery("#uname").val();
	var uphone= jQuery("#uphone").val();
	var compare_ids=jQuery("#compare_ids").val();
	var province=jQuery("#uprovince").val();
	var city=jQuery("#ucity").val();
	if(uname==''){
		alert("请输入您的姓名！");
		return;
	}
    if(uphone==''){
		alert("请输入您的电话！");
		return;
	}
	jQuery.ajax({
			url : '/action/ajax.jsp',
			data : {
				flag : 'inquiryMul',
				uname : uname,
				uphone : uphone,
				province : province,
				city : city,
				compare_ids:compare_ids
			},
			success : function(data) {
					alert("询价成功！");
					setTimeout("window.location.reload()",1000);
			}
	});
}