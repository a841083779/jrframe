$(function() {
	
	var pro_id = jQuery('#zd_product_id').val();
	
	/**
	 *name : topbar.js
	 *author : ht
	 *date : 2016-12-20
	 */
	$(document).ready(function() {
		var viewHeight = $('body').height();
		$('.active-bg').height(viewHeight - 30);
	});

	/**
	 * 20180822 top搜索
	 */
	function tj3() {
		if(jQuery('#keyword').val() == '') {
			alert("请输入您要搜索的关键词");
			jQuery('#keyword').focus();
			return false;
		}
		var keyword = jQuery('#keyword').val();
		window.open("http://product.21-sun.com/search/" + keyword + "_0_0_0.htm");
	}
	$('#keyword').on('keydown', function(e) {
		if(e.keyCode == 13) {
			tj3();
		}
	})


	/**
	 * 头部漂浮
	 */
	console.log($('.pro_top_hd').length==0)
	if($('.pro_top_hd').length){
		var _top = $('.pro_top_hd').offset().top;
		$(window).scroll(function() {
			var scrolls = $(this).scrollTop();
			if(scrolls > _top) {
				$('.pro_top_hd').addClass('smartfloat');
			} else {
				$('.pro_top_hd').removeClass('smartfloat');
			};
		});
	}


	//询价城市选择
	$.fn.tab=function(){
		var $key=$(this).find('.city_key'),
		$val=$(this).find('.city_val');
		$key.first().addClass('cur');
		$val.first().show();
		$key.each(function(index){
			$(this).click(function(event){
				event.preventDefault();
				$(this).addClass('cur').siblings().removeClass('cur');
				$val.hide().eq(index).show();
				})
			})
		};
	$('.citybox_tab').each(function() { $(this).tab()});
	
	$('.cityboxbtn').click(function(e) {
		$(this).addClass('cityboxbtn_on');
		$('.citybox').show();
	});
	
	$('.city_val_01 .cityshow span').click(function(e) {
		var pro_id=jQuery("#zd_product_id").val();
		var prov = $(this).data('province');
		var prov_noe=prov.split('***');
		var area_id=prov_noe[1];
		$('#zd_province').val(prov_noe[0]);/*省份*/
		$('.city_key_01').html(prov_noe[0]);
		$('.city_key_01').removeClass('cur');
		$('.city_key_02').addClass('cur');
		$('.city_val_01').hide();
		$('.city_val_02').show();
		jQuery.ajax({
					url : '/tools/ajax_city.jsp',
					async : false,
					type : 'post',
					data : {
						flag : 'get_city_new',
						p : area_id
					},
					success : function(data){
						$("#zd_citys").html($.trim(data));	
						$('#zd_citys span').click(function(e) {
								var city = $(this).data('city');
								$('#zd_city').val(city);/*城市*/
								$('.city_key_02').html(city);
								var prov = $('.city_key_01').html();
								$('.city_key_02').removeClass('cur');
								$('.city_key_01').addClass('cur');
								$('.city_val_02').hide();
								$('.city_val_01').show();
								$('.cityboxbtn .tadd_p').html(prov);
								$('.cityboxbtn .tadd_c').html(city);
								$('.citybox').hide();
								$('.cityboxbtn').removeClass('cityboxbtn_on');
						});
					}
				});
	});
	
	$('.city_close').click(function(e) {
		$('.citybox').hide();
		$('.cityboxbtn').removeClass('cityboxbtn_on');
	});
	
	/**
	 * 头部购机导航
	 */
	$('.pro-nav .has-list').after($('#topCataPro'));
   //弹出询价单

	$('.ask_price_form').on('click',function(){
		var pid = $(this).attr('data-value');
		var factoryid ='';
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
	})
	   //弹出二手询价单

	$('.find_second').on('click',function(){
		var pid = $(this).attr('data-value');
		var factoryid ='';
    jQuery.jBox("iframe:/include/products/product_order_e.jsp?productid="+pid+"&factoryid="+factoryid, {
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
	})
	var thisurl=window.location.href;
	if(thisurl.indexOf('/proDetail/')>=0){
	//详细页询价表单
		jQuery.ajax({
					url : '/tools/ajax.jsp?flag=getProvinceCity',
					async : false,
					type : 'post',
					success : function(data){
	                    var area=new Array();
	                    area=data.split(",");
	                    province=area[0];
	                    city=area[1];	
						//zeng临时
	                    document.getElementById("the_city").innerHTML=city;
	                    document.getElementById("the_province").innerHTML=province;
	                    document.getElementById("zd_province").value=province;
	                    document.getElementById("zd_city").value=city;
	    

	                    $('.city_val_01').find('span').each(function(){
		                    if($(this).find('a').text()==$('#the_province').text().trim()){
			                    $(this).click();
 		                    }
	                    }).after(function(){
 		                    $('.city_val_02').find('span').each(function(){
 			                    if($(this).find('a').text()==$('#the_city').text().trim()){
				                    $(this).click();
	 		                    }
		                    })
	                    })
	                    $('.city_key_02').click();			
					}
		});
   //询价列表
	jQuery.ajax({
		url:"/action/ajax.jsp",
		type:"post",
		data:{"id":pro_id,"flag":"inquiry_list"},
		success:function(data){
			jQuery("#inquiry_list").html(data);
		}
	});

	}
	
	
})