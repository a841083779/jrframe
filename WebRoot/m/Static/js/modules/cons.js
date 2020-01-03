/*
* conScrolll
* v0.9
*/
define(function(require, exports, module) {
   var $ = require('$');
	require('./cons.css');

	$.fn.conScroll=function(){
		var _this=$(this),
			 Ul=_this.find('ul'),
			 Li=Ul.find('li'),
			 BtnL=_this.find('.BtnL'),
			 BtnR=_this.find('.BtnR'),
			 Default={
				speed:1,
				dir:true//默认横向
				},
			 dataOpt=_this.data('cons')||{},
			 opt=$.extend({},Default,dataOpt),
			 _liTotal=0,
			 _ulTotal=0,
			 _dir,
			 _T,
			 _speed=opt.speed;
		if(opt.dir){
			_ulTotal=_this.width();
			for(var i=0;i<Li.length;i++){_liTotal+=Li.eq(i).outerWidth(true)}
		}else{
			_ulTotal=_this.height();
			for(var i=0;i<Li.length;i++){_liTotal+=Li.eq(i).outerHeight(true)}
			};
		if(_liTotal<_ulTotal) return;
		Ul.append(Ul.html());
		if(opt.dir){
			_dir="left";
			Ul.width(_liTotal*2)
		}else{
			_dir="top";
			Ul.height(_liTotal*2)
			};
	function goRoll(){
		_T=setInterval(function(){
			Ul.css(_dir,parseInt(Ul.css(_dir))-_speed+'px');
			if(parseInt(Ul.css(_dir))<-parseInt(_liTotal)){
				Ul.css(_dir,'0')
				}else if(parseInt(Ul.css(_dir))>=0){
					Ul.css(_dir,-parseInt(_liTotal))
					}
			},30);
		};
		Ul.mouseover(function() {clearInterval(_T)});
		Ul.mouseout(function() {goRoll()});
		BtnL.mouseover(function() {_speed = -Math.abs(_speed)});
		BtnR.mouseover(function() {_speed = Math.abs(_speed)});
		goRoll();
		};
		

})