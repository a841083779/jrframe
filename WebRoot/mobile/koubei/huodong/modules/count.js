/*
 * count
 * v0.1
 * 2014-08-07
 */
define(function(require, exports, module) {	
	return function(){
		var Body = document.body || document.getElementsByTagName("body")[0] || document.documentElement;
		var countnode = document.createElement("script" );
		countnode.type = 'text/javascript';
		countnode.src = 'http://pv.21-sun.com/http/stat.jsp';
		Body.appendChild(countnode);
	}

});