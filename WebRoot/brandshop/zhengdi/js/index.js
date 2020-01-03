$(function() {
	var cat_select='',type_num='';
	//初始化口碑
	$.ajax({
				url: 'action/ajax.jsp',
				data: {
					flag: 'orderList'
				},
				success: function(data) {
					//console.log($.trim(data));
					var total=$.trim(data).split('@_@')[0];
					var html=$.trim(data).split('@_@')[1];
					//$('.list_total').html('询价总数：'+total);
					$('.list_area').append(html);
				}
	});


	$('.filter-box.cat_box').selectFilter({

		callBack: function(val) {
			//console.log(val + '-是返回的值')
			var cat=val;
			cat_select=val;
			$.ajax({
				url: 'action/ajax.jsp',
				data: {
					flag: 'getModel',
					cat:cat
				},
				success: function(data) {
					//console.log($.trim(data));
					$('#type_num').html($.trim(data));
					$('.filter-box.num_box').find('ul').remove();
					$('.filter-box.num_box').off('click', '.filter-text');
					$('.num_box .filter-title').val('');
					$('.filter-box.num_box').selectFilter({
					callBack: function(val) {
						//console.log(val + '-是返回的值')
						type_num=val;
					}
				});
				}
			});
			
		}
	});

	
	$('.search_btn').on('click', function(){
		console.log(cat_select+'and'+type_num);
		if(cat_select!=''){
			if(type_num!=''){
				window.open("http://product.21-sun.com/proDetail/"+type_num,"_blank");    
			}else{
				window.open("list.jsp?cat="+cat_select,"_blank"); 
			}
		}else{
			window.open("list.jsp","_blank");    
		}

	})
})