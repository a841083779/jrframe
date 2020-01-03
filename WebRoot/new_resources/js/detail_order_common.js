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
$('.imgEff').find('img').hover(function(){
	$(this).stop(1,1).animate({opacity:0.7},160);
},function(){
	$(this).stop(1,1).animate({opacity:1},160);
});

//全部分类
$("a.CloseAllBtn").click(function(){
	$(".nav_proCate").removeClass("bigBtnCur");
	return false;
});

$(".nav_proCate").children('.n').click(function(){
	   var par = $(this).parent();
	   var cls = par.attr("class");
	   if(cls.indexOf("bigBtnCur")!=-1){
		   par.removeClass("bigBtnCur");
	   }else{
		   par.addClass("bigBtnCur");
	   }
 });

 
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
			
		//大数据相关事件
		if (window.jereiReceiver) { 
        var _jrTracker= jereiReceiver.getTracker("GWD-100002"); 
        //_jrTracker.track(); 
		 _jrTracker.trackFmTry("详细页询价单",pro_id,"省市",$("#zd_province").val()+$("#zd_city").val()) ;
        }	
});


$('.city_close').click(function(e) {
	$('.citybox').hide();
	$('.cityboxbtn').removeClass('cityboxbtn_on');
});

//置顶
$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});



