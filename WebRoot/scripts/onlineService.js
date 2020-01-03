(function() {
var jQueryonlineService = jQuery('<div class="onlineService"></div>').appendTo(jQuery("body")).click(function(){jQuery(this).hide();jQuery(".box_os").show();});
jQuery(".os_x").click(function(){jQuery(".box_os").hide();jQuery(".onlineService").show();});
jQueryboxOsFun = function(){var st=jQuery(document).scrollTop();if (!window.XMLHttpRequest) {jQuery(".box_os").css("top",st+192);jQuery(".onlineService").css("top",st+192);}};
jQuery(window).bind("scroll", jQueryboxOsFun);
jQueryboxOsFun();

    if ( jQuery(window).width()<1200 || screen.width<1200) 
    { 
    	jQuery('.hydp950,.w_950,.sdmain,.main').css('overflow','hidden');
		jQuery(".top_bg").css({'overflow':'hidden','width':'950px','margin':'0 auto'});
		jQuery('.db_bg2').addClass('db_bg2_s');
		jQuery('.jstd_c .bg_l,.jstd_c .bg_r').css('display','none');
		jQuery('#js_play .prev').css('left','0');
		jQuery('#js_play .next').css('right','0');
    }else{
    	jQuery('.hydp950,.w_950,.sdmain,.main').removeAttr('style');
		jQuery('.top_bg').css({'overflow':'visible','width':'100%','margin':'0'});
		jQuery('.db_bg2').removeClass('db_bg2_s');
		jQuery('.jstd_c .bg_l,.jstd_c .bg_r').css('display','block');
		jQuery('#js_play .prev').css('left','-8px');
		jQuery('#js_play .next').css('right','-8px');
    }
     
    jQuery(window).resize(function(){  
        if (jQuery(window).width()<1200) 
	    {
	   		jQuery('.hydp950,.w_950,.sdmain,.main').css('overflow','hidden');
			jQuery(".top_bg").css({'overflow':'hidden','width':'950px','margin':'0 auto'});
			jQuery('.db_bg2').addClass('db_bg2_s');
			jQuery('.jstd_c .bg_l,.jstd_c .bg_r').css('display','none');
			jQuery('#js_play .prev').css('left','0');
			jQuery('#js_play .next').css('right','0');
	    }else{
	    	jQuery('.hydp950,.w_950,.sdmain,.main').removeAttr('style');
			jQuery('.top_bg').css({'overflow':'visible','width':'100%','margin':'0'});
			jQuery('.db_bg2').removeClass('db_bg2_s');
			jQuery('.jstd_c .bg_l,.jstd_c .bg_r').css('display','block');
			jQuery('#js_play .prev').css('left','-8px');
			jQuery('#js_play .next').css('right','-8px');
	    } 
    });
})();








