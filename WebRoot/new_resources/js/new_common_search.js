
$('.txd_shaixuan dl').each(function(index, element) {
	var tsx_h = $(this).find('.tsx_ddheight').height();
	if(tsx_h<=38){
		$(this).find('.tsx_more').hide();
	}
});

$('.txd_shaixuan dl .tsx_more').click(function(){
    var na = $(this).parent().find('dd'); 
    na.toggleClass('txd_sx_auto'); 
    if( na.hasClass('txd_sx_auto') ){ 
	
        $(this).html('收起');
		$(this).addClass('tsx_more_close');
    }else{ 
        $(this).html('更多'); 
		$(this).removeClass('tsx_more_close');
	} 
});
