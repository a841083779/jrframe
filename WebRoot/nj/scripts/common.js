jQuery(document).ready(function() {
    try{
	    $(".b_top .b_Links li").hover(function() {
	        $(this).toggleClass("hover")
	    },function(){
			$(this).removeClass("hover")
			});
		$(".b_share li").hover(function() {
	        $(this).toggleClass("hover")
	    },function(){
			$(this).removeClass("hover")
			});	
		$(".b_Links_around li").hover(function() {
	        $(this).toggleClass("b_cur")
	    },function(){
			$(this).removeClass("b_cur")
			});
		jQuery('.nav1 li a').hover(function(){
			jQuery(this).stop(true,false).animate({top:'-45px'},{queue:false,duration:300});
		}, function() {
			jQuery(this).stop(true,false).animate({top:'0px'},{queue:false,duration:300});
		});
	}catch(e){}
});

jQuery(function(){
	jQuery(".b_rlist06 li").hover(function(){
		jQuery(".b_rlist06 li").removeClass("hover");
		jQuery(this).addClass("hover");
	});
});

//搜索框鼠标焦点的效果
function clearText(){
	jQuery("#searchText").val("");
}
function addText(keyword){
	if(keyword=="请输入搜索内容"){
		if(jQuery("#searchText").val()==""){
			jQuery("#searchText").val("请输入搜索内容");
		}else{
			var str=jQuery("#searchText").val();
			jQuery("#searchText").val(str);
		}
	}else{
		if(jQuery("#searchText").val()==""){
			jQuery("#searchText").val(keyword);
		}else{
			var str=jQuery("#searchText").val();
			jQuery("#searchText").val(str);
		}
	}
}

function pageDecoration(){
	window.location.href="/infocenter/dress.jsp";
}