$(".m_nav li").mouseenter(function(){
	$(this).addClass("hover");
}).mouseleave(function(){
	$(this).removeClass("hover");
})

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