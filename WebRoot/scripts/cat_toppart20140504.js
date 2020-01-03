// JScript 文件
var Sys = {};
var ua = navigator.userAgent.toLowerCase();
var s;
 (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
 (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
 (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
 (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
 (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
 
function TopAd()
{
    var strTopAd="";
	if(!Sys.safari)
	//定义小图片内容
    {var topSmallBanner="<img src=\"/images/lp_xcat.jpg\" width=\"1000\" height=\"75\" />";
	}
	else
	{var topSmallBanner="<img src=\"/images/lp_xcat.jpg\" width=\"1000\" height=\"75\" />";
	}
	//判断在那些页面上显示大图变小图效果，非这些地址只显示小图（或FLASH）
    if (location == "#" || location == "#" || location == "#" || true)
    {
		//定义大图内容
        strTopAd="<div id=adimage style=\"width:1000px\">";
		if(!Sys.safari)
		{strTopAd=strTopAd+"<div id=adBig><img src=\"/images/lp_dcat.jpg\" width=\"1000\" height=\"408\" /></div>";}
	  else 
		{strTopAd=strTopAd+"<div id=adBig><img src=\"/images/lp_dcat.jpg\" width=\"1000\" height=\"408\" /></div>";}
		
		strTopAd=strTopAd+"<div id=adSmall style=\"display: none\">";
        //strTopAd+=  topFlash;     
		strTopAd+=  topSmallBanner;  
        strTopAd+=  "</div></div>";
    }
    else
    {
        //strTopAd+=topFlash;
		strTopAd+=  topSmallBanner;  
    }
    strTopAd+="<div style=\"height:0px; clear:both;overflow:hidden\"></div>";
    return strTopAd;
}
//document.write(TopAd());

$("#topads").html(TopAd());


$(function(){
	//过两秒显示 showImage(); 内容
    setTimeout("showImage();",7000);
    //alert(location);
});
function showImage()
{
    $("#adBig").slideUp(1000,function(){$("#adSmall").slideDown(1000);});
}

