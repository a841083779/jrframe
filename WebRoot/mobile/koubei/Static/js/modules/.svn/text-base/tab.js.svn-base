/*
J_tab

v0.9

*/
define(function(require, exports, module) {
   var $ = require('$');
	require('./tab.css');
	
	$.fn.tab=function(){
	var defaults={
			average:false,
			left:0,
			margin:0,
			action:'click',
			fn:null
			},
		$this=$(this),
		$tab_t=$this.find('.tab_t'),
		$tab_more=$this.find('.tab_b').find('.more'),
		tiemout,data_opts,opts;
	data_opts=$this.data('tab')||{};
	opts=$.extend({},defaults,data_opts);
	tiemout=(opts.action==='mouseover') ? 240 : 0;
	if(opts.average){$tab_t.width(Math.floor(1/$tab_t.length*100)+'%')};
	$tab_t.each(function(index) {
		$(this).css('right',opts.average?Math.floor(1/$tab_t.length*100)*index+'%':$(this).width()*index+opts.left+opts.margin*index).css('visibility','visible');
		if(!index){$(this).addClass('first');$tab_more.attr('href',$(this).find('a').attr('href'))};
		$(this).on(opts.action,function(event){
			var _this=$(this);
			if(event.timeStamp){
				last = event.timeStamp;
				setTimeout(function(){
					if(last-event.timeStamp==0){toggletab(_this)}
					},tiemout);
				}else{toggletab(_this)}
			if($tab_more.length){$tab_more.attr('href',$(this).find('a').attr('href'))}
			function toggletab(me){$(me).parent().addClass('cur').siblings().removeClass('cur')}
			})
		});
		if(opts.fn){eval(opts.fn+'(this,$tab_t,opts.action)')}
};

})