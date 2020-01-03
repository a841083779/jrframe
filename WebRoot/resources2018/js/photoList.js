$(function(){
	
	$('.allCates .acn').after($('.acLayer'));
	$('.allCates').mouseover(function(){
		$(this).find('.acLayer').show();
	}).mouseleave(function(){
		$(this).find('.acLayer').hide();
	});
	$('.acLayer .acb').mouseenter(function(){
		$(this).addClass('acb_hover');
	}).mouseleave(function(){
		$(this).removeClass('acb_hover');
	});
	$('.acLayer').children('.acb:last').addClass('last')

	/*更多品牌展开*/
	$('.line_brand').on('click','.height',function(){
		if($('.line_brand .brand_box').hasClass('all')){
			$('.line_brand .brand_box').removeClass('all');
			$('.te').text('更多');
		}else{
			$('.line_brand .brand_box').addClass('all');
			$('.te').text('收起');
		}
	})

	
 
	
	
		
	//搜索国内品牌
	$('#gn').click(function(){
		    var brand=$('#brand').val();
			var catalog=$('#catalog').val();
            $.ajax({
		        url:"/photo_domain/ajax_new.jsp",
		        type:"post",
		        data:{"flag":"searchInnerBrand","keyword":brand,"catalog":catalog},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        });  
    });
	//搜索国外品牌
	$('#gw').click(function(){
		    var brand=$('#brand').val();
			var catalog=$('#catalog').val();
            $.ajax({
		        url:"/photo_domain/ajax_new.jsp",
		        type:"post",
		        data:{"flag":"searchOutBrand","keyword":brand,"catalog":catalog},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        });  
    });
	//搜索国外品牌
	$('#sy').click(function(){
		    var brand=$('#brand').val();
			var catalog=$('#catalog').val();
            $.ajax({
		        url:"/photo_domain/ajax_new.jsp",
		        type:"post",
		        data:{"flag":"searchAllBrand","keyword":brand,"catalog":catalog},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        });  
    });	
	
 
		
	$('#letters a').click(function(){
		var a=$(this).data('val');
		var catalog=$('#catalog').val();
		     $.ajax({
		        url:"/photo_domain/ajax_new.jsp",
		        type:"post",
		        data:{"flag":"searchByLetter","letter":a,"catalog":catalog},
		        success:function(data){
		              $("#brand_list").html($.trim(data));
		        }
	        }); 
  			$('#letters a').removeClass('cur');
			$(this).addClass('cur');
	});	
	
	
	
})