/*
* name: proSHow.js
* version: v1.1.0
* update: 修改画布位置问题
* date: 2016-11-28
*/

;
(function($){
	
	var defaults={
		
		id:'proID',//产品ID，每个产品唯一
		
		stageWidth:720,//舞台宽度
		stageHeight:540,//舞台高度
		
		pageWidth:720,//画布宽度
		pageHeight:540,//画布高度
		pageLeft:0,//画布左边距
		pageTop:0,//画布上边距
		
		imgPath:'images/',//产品图片路径
		
		imgCount:50,//图片数目
		fps:10,//图片播放帧数
		
		imgType:'.png',//图片格式，如 .jpg .png .gif
		
		effect:'ef_1',//加载特效
		
		leadingTxt:'16px'//加载文字大小
		
		};
	
	$.fn.proShow=function(options){
		
		var opts=$.extend(defaults,options);
		var obj=this;
		
		//外层盒子
		var wrapper=$('<div id="showWrap_'+opts.id+'" style="position:relative; width:'+opts.stageWidth+'px; height:'+opts.stageHeight+'px;"></div>');
		obj.append(wrapper);
		
		//创建canvas
		var canvasWrap=$('<div class="canvasWrap" style="width:'+opts.pageWidth+'px; height:'+opts.pageHeight+'px; position:absolute; left:'+opts.pageLeft+'px; top:'+opts.pageTop+'px; z-index:8;"></div>');
		var canvas_config=$('<canvas id="canvas_'+opts.id+'" width="'+opts.pageWidth+'" height="'+opts.pageHeight+'"></canvas>');
		canvasWrap.append(canvas_config);
		wrapper.append(canvasWrap);
		var Canvas=document.getElementById('canvas_'+opts.id);
		
		//创建loading
		var txtLineHeight=40;
		var loading=$('<div class="loading" style="position:absolute; left:0; top:0; z-index:9; width:'+opts.stageWidth+'px; height:'+opts.stageHeight+'px; background:rgba(0,0,0,0.8);"><div class="txtBox" style="position:absolute; left:0; top:56%; z-index:99; width:100%; height:'+txtLineHeight+'px; font-size:'+opts.leadingTxt+'; color:#fff; line-height:'+txtLineHeight+'px; text-align:center;">正在加载，请稍后......<span class="loadTxt">0%</span></div></div>');
		wrapper.append(loading);
		
		//loading效果
		var effect_num=parseInt(opts.effect.split('_')[1]);
		if(effect_num===1){
			var ef=$('<div id="effect_'+effect_num+'"><div class="loading-center"><div class="loading-center-absolute"><div class="object"></div></div></div></div>');
			loading.prepend(ef);
			}
		if(effect_num===2){
			var ef=$('<div id="effect_'+effect_num+'"><div class="loading-center"><div class="loading-center-absolute"><div class="object object_one"></div><div class="object object_two"></div><div class="object object_three"></div><div class="object object_four"></div><div class="object object_five"></div><div class="object object_six"></div><div class="object object_seven"></div><div class="object object_eight"></div><div class="object object_big"></div></div></div></div>');
			loading.prepend(ef);
			}
		if(effect_num===3){
			var ef=$('<div id="effect_'+effect_num+'"><div class="loading-center"><div class="loading-center-absolute"><div class="object first_object"></div><div class="object second_object"></div><div class="object third_object"></div></div></div></div>');
			loading.prepend(ef);
			}
		if(effect_num===4){
			var ef=$('<div id="effect_'+effect_num+'"><div class="loading-center"><div class="loading-center-absolute"><div class="object object_one"></div><div class="object object_two"></div><div class="object object_three"></div><div class="object object_four"></div></div></div>');
			loading.prepend(ef);
			}
		
		
		//参数配置
		var step=-1;
		var step_=0;
		var count=opts.imgCount;
		var canvasPro=Canvas.getContext('2d');
		var fpsPro=opts.fps;
		var timer=null;//定时器
		var imgList=[];
		var cvsWidth=opts.pageWidth;
		var cvsHeight=opts.pageHeight;
		var txt=loading.find('.loadTxt');
		
		
		//加载所有资源
		for(var i=0;i<count;i++){
			(function(i){
				var newImg=new Image();
				newImg.onload=function(){
					
					txt.html(Math.ceil(100*step_/count)+'%');
					newImg.onload=null;
					
					var oImg=document.createElement('img');
					oImg.src=this.src;
					
					imgList[i]=oImg;
					if(++step_==count){
						startShow();
						}
					}
				var path=opts.imgPath+i+opts.imgType;
				newImg.src=path;
				})(i);
			}
		
		var startShow=function(){
			//清除定时器
			if(timer!=null){
				clearInterval(timer);
				timer=null;
				}
			//定时器
			timer=setInterval(animation,1000/fpsPro);
			}
		
		var animation=function(){
			for(var i=0;i<count;i++){
				if(!imgList[i]){
					alert('加载资源失败，请刷新重新加载。');
					}
				}
			loading.fadeOut(300);//遮罩消失
			step+=1;
			if(step==count){
				step=0;
				}
			var bg=imgList[step];
			canvasPro.clearRect(0,0,cvsWidth,cvsHeight);
			canvasPro.drawImage(bg,0,0,cvsWidth,cvsHeight);
			}
		}
	
	
	})(jQuery);
