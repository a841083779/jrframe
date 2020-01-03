/*
* name: index.js
* version: v1.0.0
* update: no
* date: 2016-07-18
*/
;
(function($,document,window,undefined){
	
	
	//citySelect
	$('#citySelect').citySelect({
		//nodata:'none',
		prov:remote_ip_info.province,
		city:remote_ip_info.city,
		required:false
		}); 
	
	//询价
	function orderShow(){
		$('.pro-list').find('.order-btn').on('click',function(){
			var index=$(this).parent().parent().index();
			$(this).parent().parent().append($('.form-box'));
			$('.form-box').fadeIn();
			
			//返回表单值
			var flag=$(this).attr("id").substr(6,($(this).attr("id").length));
			var proId=0;
			if(flag==0){
				$("#proType").find("option[data-value='SSR200AC-8']").attr("selected",true);
				proId=28996;
			}else if(flag==1){
				$("#proType").find("option[data-value='SSR220AC-8']").attr("selected",true);
				proId=28997;
			}
			$.ajax({
					url:'/activity/ymt_sy/tools/return_form.jsp?id='+proId,
					async:false,
					cache:false,
					dataType: "xml", 
					success:function(data){
							$('#zd_agentid').val(data.getElementsByTagName("factoryid")[0].childNodes[0].nodeValue);
							$('#zd_factoryid').val(data.getElementsByTagName("factoryid")[0].childNodes[0].nodeValue);
							$('#zd_factoryname').val(data.getElementsByTagName("factoryname")[0].childNodes[0].nodeValue);
							$('#zd_product_id').val(data.getElementsByTagName("product_id")[0].childNodes[0].nodeValue);
							$('#zd_product_name').val(data.getElementsByTagName("product_name")[0].childNodes[0].nodeValue);
							$('#zd_cataname').val(data.getElementsByTagName("cataname")[0].childNodes[0].nodeValue);
							$('#zd_catanum').val(data.getElementsByTagName("catanum")[0].childNodes[0].nodeValue);
							jQuery("#zd_message").val("您好，我对"+data.getElementsByTagName("factoryname")[0].childNodes[0].nodeValue+data.getElementsByTagName("product_name")[0].childNodes[0].nodeValue+data.getElementsByTagName("cataname")[0].childNodes[0].nodeValue+"感兴趣，想要咨询，请您给我回复，谢谢。");
						}
				});
			
			//初始化机型
			//typeSelect(index);
			});
		}
	//机型选择
	function typeSelect(index){
        var value=$('#proType option').eq(index).val();
		$('#proType').val(value);
		
		}
	
	//关闭弹窗
	function closeForm(){
		$('.close-btn').on('click',function(){
			$(this).parent().fadeOut();
			});
		}
	
	
	//获取机型
	function getType(){
		return $('#proType').val();
		}
	
	//获取用户名
	function getUserName(){
		return $('#userName').val();
		}
	
	//获取用户手机号
	function getUserTel(){
		return $('#userTel').val();
		}
	
	//获取区域
	function getArea(){
		var prov=$('.prov option:selected').val();
		var city=$('.city option:selected').val();
		
		return prov+' '+city;
		}
	
	//提交
	//function subForm(){
		
	//	$('#submitBtn').on('click',function(){
			
	//		alert(getType()+getUserName()+getUserTel()+getArea());
			
	//		});
		
	//	}
	
	
	
	return orderShow(),closeForm();
	
	
	})(jQuery,document,window);