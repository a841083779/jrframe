/*
* name: index.js
* version: v1.0.0
* update: 点击效果
* date: 2016-07-19
*/
;
(function(){
	
	//点击效果
    document.addEventListener('touchstart', function (){});
	
	function getLocation(){
        if (navigator.geolocation){
            navigator.geolocation.getCurrentPosition(showPosition);
        }else{
            x.innerHTML="Geolocation is not supported by this browser.";
        }
    }
    function showPosition(position){
		var map = new BMap.Map("allmap");
		var point = new BMap.Point(position.coords.longitude,position.coords.latitude);
		var gc = new BMap.Geocoder();
		gc.getLocation(point, function(rs){
		   var addComp = rs.addressComponents;
		   var prov=addComp.province;//山东省
		   var cityv=addComp.city;//烟台市
		   
		   alert("所在位置："+prov+";"+cityv);
		   //citySelect
			$('#citySelect').citySelect({
				prov:prov.substr(0,prov.length-1),//山东
				city:cityv.substr(0,prov.length-1),//烟台
				required:false
				}); 
		});
    }
	getLocation();
	
	//citySelect
	//$('#citySelect').citySelect({
		//nodata:'none',
	//	prov:remote_ip_info.province,
	//	city:remote_ip_info.city,
	//	required:false
	//	}); 
	
	//询价
	function orderShow(){
		$('.pro-list').find('.order-btn').on('touchstart',function(ev){
			var index=$(this).parent().parent().index();
			$('.alert-bg').fadeIn();
			
			//初始化机型
			//typeSelect(index);
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
					url:'/activity/ymt_sy_m/tools/return_form.jsp?id='+proId,
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
			
			ev.stopPropagation();
			return false;
			});
		}
	
	//机型选择
	function typeSelect(index){
        var value=$('#proType option').eq(index).val();
		$('#proType').val(value);
		
		}
	
	//关闭弹窗
	function closeForm(){
		$('.close-btn').on('touchstart',function(){
			$('.alert-bg').fadeOut();
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
		
	//	$('#submitBtn').on('touchstart',function(){
			
	//		alert(getType()+getUserName()+getUserTel()+getArea());
			
	//		});
		
	//	}
	
	
	
	
	
	
	
	return orderShow(),closeForm();
	
	
	})();