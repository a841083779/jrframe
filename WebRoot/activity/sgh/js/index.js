/*
* name: index.js
* version: v1.0.0
* update: no
* date: 2016-07-18
*/
;
(function($,document,window,undefined){
	
	var proImg = imgLoad('static/images/pro.png', function (result){
		var img = result;
		$('.pro-box').prepend(img);
		
		var size = imgSize($(img));
		
		$('.pro-ope').css({
			'width' : size.width,
			'height' : size.height,
			'margin-left' : -size.width/2
			});
		
		
		$('#loading').fadeOut(100);
		});
	
	function imgLoad (src, callback){
		var isLoad = false;
		var newImg = new Image();
		newImg.onload = function (){
			var img = document.createElement('img');
			img.src = this.src;
			img.id = 'pro-img';
			isLoad = true;
			
			if(isLoad){
				callback(img);
				}
			};
		newImg.src = src;
		//parent.append(newImg);
		return newImg;
		}
	
	function imgSize (img){
		if(!img){
			return;
			}
		var size = {
			width : '',
			height : ''
			};
		size.width = img.width();
		size.height = img.height();
		return size;
		}
	
	
	//弹出层
	var mask = {};
	mask.opeFn = {
		init : function (){
			var that = this;
			
			$('.m-pro').on('click', function (e){
				var flag = $(this).data('href');
				that.show(flag);
				});
			
			$('.pro-close-btn').on('click', function (e){
				that.hide();
				e.stopPropagation();
				});
			
			},
		show : function (href){
			$('.show-' + href).css('display', 'block').siblings().css('display', 'none');
			$('.pro-mask').fadeIn(300);
			},
		hide : function (){
			$('.pro-mask').fadeOut(300);
			}
		};
	
	mask.opeFn.init();
	
	
	//activity
	var activity = {
		$btn : $('.activity-tip'),
		$activityBtn : $('#activityBtn'),
		$enlistBtn : $('#enlistBtn'),
		isPart : false, // 是否已经参与过答题
		$partBtn : $('#partBtn'),
		userAnswer : {
			'answer_1' : false,
			'answer_2' : false,
			'answer_3' : false
			}, // 用户提交答题结果
		$answerBtn_1 : $('#answerBtn_1'),
		$answerBtn_2 : $('#answerBtn_2'),
		$subBtn : $('#subBtn'),
		$successBtn : $('#successBtn'),
		$closeBtn : $('.u-close-btn'),
		init : function (){
			var that = this;
			
			this.$btn.on('click', function (){
				that.show(0);
				});
			
			this.$activityBtn.on('click', function (){
				that.show(1);
				});
			
			this.$enlistBtn.on('click', function (){
				that.show(2);
				});
			
			this.$partBtn.on('click', function (){
				if(that.isPart){
					alert('您已经参与过答题，多谢您的参与，欢迎您下次再来！');
					return;
					}
				
			//表单提交
			// 验证手机号
			function isPhoneNo(phone) {
				var pattern = /^((0\d{2,3}-\d{7,8})|(1[34578]\d{9}))$/;
				return pattern.test(phone);
			}
			if($("#userName").val()==""){
				alert("请输入您的姓名！");
				$("#userName").focus();
				return false;
			}else if($("#userPhone").val()==""){
					alert("请输入您的固定电话或手机号！");
					$("#userPhone").focus();
					return false;
			}else if(isPhoneNo($.trim($('#userPhone').val())) == false) {
					alert("请输入正确的固定电话或手机号!");
					$('#userPhone').focus();
					return false;
			}else if($("#jobTime").val()==""){
					alert("请输入您的驾龄！");
					$("#jobTime").focus();
					return false;
			}else if($("#userAdd").val()==""){
					alert("请输入您现所在省份！");
					$("#userAdd").focus();
					return false;
			}
			
			var userName=$('#userName').val();
			var userPhone=$('#userPhone').val();
			var userJob=$('#userJob').val();
			var usedEquip=$('#usedEquip').val();
			var ownEquip=$('#ownEquip').val();
			var jobTime=$('#jobTime').val();
			var userAdd=$('#userAdd').val();

			$.ajax({
					url:'action/action.jsp?userName='+encodeURI(encodeURI(userName))+'&userPhone='+userPhone+'&userJob='+encodeURI(encodeURI(userJob))+'&usedEquip='+encodeURI(encodeURI(usedEquip))+'&ownEquip='+encodeURI(encodeURI(ownEquip))+'&jobTime='+encodeURI(encodeURI(jobTime))+'&userAdd='+encodeURI(encodeURI(userAdd)),
					async:false,
					cache:false,
					success:function(data){
						if(data.indexOf("success")>0){
							alert("提交成功！");
							that.isPart = true; // 防止重复提交数据
							var formId=data.split('_')[1];
							$('#formId').val(formId);
						}else{
							alert("提交失败！");
						}
					}
			});
				
				that.show(3);
			});
			
			//答题			
			$('#question_1').find('li').on('click', function (){
				var self = that;
				
				var index = $(this).index();
				$(this).addClass('selected').siblings().removeClass('selected');
				that.$answerBtn_1.on('click', function (){
					if(index === 2){
						self.userAnswer['answer_1'] = true;
						}
					
					self.show(4);
					});
				});
			
			$('#question_2').find('li').on('click', function (){
				var self = that;
				
				var index = $(this).index();
				$(this).addClass('selected').siblings().removeClass('selected');
				
				that.$answerBtn_2.on('click', function (){
					if(index === 3){
						self.userAnswer['answer_2'] = true;
						}
					
					self.show(5);
					});
				});
			
			$('#question_3').find('li').on('click', function (){
				var self = that;
				
				var index = $(this).index();
				$(this).addClass('selected').siblings().removeClass('selected');
				
				that.$subBtn.on('click', function (){
					if(index === 1){
						self.userAnswer['answer_3'] = true;
						}
					
					var rate = self.testRate(self.userAnswer); // 判断准确率
					
					//更新答题正确率
					$.ajax({
						url:'action/updateAction.jsp?formId='+$('#formId').val()+'&rate='+rate,
						async:false,
						cache:false,
						success:function(data){
							if(data.indexOf("success")>0){
								//alert("更新成功！");
								
							}
						}
					});
					
					self.show(6);
					});
				});
			
			this.$successBtn.on('click', function (){
				that.hide();
				});
			
			this.$closeBtn.on('click', function (){
				that.hide();
				});
			},
		show : function (i){
			$('.activity-mask').fadeIn(300);
			$('.center-box').eq(i).addClass('cur').siblings().removeClass('cur');
			},
		hide : function (){
			$('.activity-mask').fadeOut(300);
			},
		testRate : function (obj){
			var result = 0;
			var len = 0;
			for(var prop in obj){
				if(obj[prop]){
					result += 1;
					}
				len += 1;
				}
			return result/len;
			}
		};
	activity.init();
	
	//视频
	var videoShow = {
		init : function (){
			var that = this;
			$('#videoBtn').on('click', function (){
				that.show();
				});
			$('.close-video').on('click', function (){
				that.hide();
				});
			},
		show : function (){
			$('.video-show').fadeIn(300);
			},
		hide : function (){
			$('.video-show').fadeOut(300);
			}
		};
	videoShow.init();
	
	
	})(jQuery,document,window);