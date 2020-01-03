/*
 * name: count
 * version: v0.1.1
 * update: 去重
 * date: 2014-12-31
 */
define('count',function(require, exports, module) {	
	return function(){
		if(document.getElementById('JEREICOUNT')) return;
		var Body = document.body || document.getElementsByTagName("body")[0] || document.documentElement;
		var countnode = document.createElement("script" );
		countnode.type = 'text/javascript';
		countnode.src = 'http://pv.21-sun.com/http/stat.jsp';
		countnode.id = 'JEREICOUNT';
		Body.appendChild(countnode);
	}

});