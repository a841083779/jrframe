/*
* name: youku.js
* version: v0.1.1
* update: 没把id传进来。。。
* date: 2014-12-22
*/
define(function(require, exports, module) {
	module.exports = function(youkuID,width,height){
		var w = width ? width : 480,
			h = height ? height : 320;
		return '<iframe height='+ h +' width='+ w +' src="http://player.youku.com/embed/'+youkuID+'" frameborder=0 allowfullscreen></iframe>'
		
	}

})