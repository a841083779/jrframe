$(function() {
	window.requestAnimFrame = (function() {
		return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
			window.setTimeout(callback, 1000 / 60)
		}
	})();
	var totalDeg = 360 * 3 + 0;
	var steps = [];
	var prizeDeg = [150,90,330,210,270,30];
	var lostDeg = [];
	var prize=0;//0 未中奖；1 模型 ；2 背包；3 毛巾；4 三一杯垫 ；5 礼品杯；  杯30,模型90,谢谢参与150,毛巾210,三一杯垫270,手提包330
	var count = 0;//抽奖次数
	var now = 0;
	var a = 0.01;
	var outter, inner, timer, running = false;

	function countSteps() {
		var t = Math.sqrt(2 * totalDeg / a);
		var v = a * t;
		for (var i = 0; i < t; i++) {
			steps.push((2 * v * i - a * i * i) / 2)
		}
		steps.push(totalDeg)
	}

	function step() {
		outter.style.webkitTransform = 'rotate(' + steps[now++] + 'deg)';
		outter.style.MozTransform = 'rotate(' + steps[now++] + 'deg)';
		if (now < steps.length) {
			requestAnimFrame(step)
		} else {
			running = false;
			setTimeout(function() {
				if(prize==0){
					show_lost();
				}else{
					show_win(prize);
				}
			}, 200)
		}
	}

	function start(deg) {
		deg = deg || lostDeg[parseInt(lostDeg.length * Math.random())];
		running = true;
		clearInterval(timer);
		totalDeg = 360 * 3 + deg;
		steps = [];
		now = 0;
		countSteps();
		requestAnimFrame(step)
	}
	window.start = start;
	outter = document.getElementById('outer');
	inner = document.getElementById('inner');
	i = 10;
	$("#inner").click(function() {
		$.ajax({
			url : 'action/ajax.jsp',
			data : { flag:"game"},
			success : function(data) {

				if($.trim(data)==='noorder'){
					alert("询价产品即可参与活动！");
				}else if($.trim(data)==='nochance'){
					alert("您今天的抽奖机会已经用完了，请明天再来抽奖！");
				}else{
					prize=$.trim(data);
			        start(prizeDeg[prize]);
				}
				
				
	
			}
		});
		/**
		if (running){
			 return;
		}
		running=true;
		prize=5;
		start(prizeDeg[prize]);
		**/
	})
	function show_lost(){
		$('.mask').show();
		alert("谢谢参与。")
	}
	function show_win(prize){
		$('.mask').show();
		//0 未中奖；1 模型 ；2 背包；3 毛巾；4 三一杯垫 ；5 礼品杯；
		var msg="";
		if(prize==1){
			msg="恭喜您获得模型一个！";
		}else if(prize==2){
			msg="恭喜您获得手提包一个！";
		}else if(prize==3){
			msg="恭喜您获得毛巾一个！";
		}else if(prize==4){
			msg="恭喜您获得三一杯垫一个！";
		}else if(prize==5){
			msg="恭喜您获得礼品杯一个！";
		}
		alert(msg)
	}



});
