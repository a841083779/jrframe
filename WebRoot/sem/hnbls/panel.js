function _displayCenterPanel(id)
{
	_resizeMask(id);
	var oo=getPageSize();
	var scroll=getPageScroll();
	var scrollHeight=scroll[1];
	var panel=document.getElementById(id);
	var panel_width=parseInt(panel.style.width);
	var panel_height=parseInt(panel.style.height);
	var w=(oo[0]/2)-(panel_width/2);
	var h=(oo[3]/2)-(panel_height/2);
	panel.style.left=w+"px";
	panel.style.top=(h+scrollHeight)+"px";
	panel.style.display="block";
}
function _displayCenterPanelNoBack(id)
{
	var oo=getPageSize();
	var scroll=getPageScroll();
	var scrollHeight=scroll[1];
	var panel=document.getElementById(id);
	var panel_width=parseInt(panel.style.width);
	var panel_height=parseInt(panel.style.height);
	var w=(oo[0]/2)-(panel_width/2);
	var h=(oo[3]/2)-(panel_height/2);
	panel.style.left=w+"px";
	panel.style.top=(h+scrollHeight)+"px";
	panel.style.display="block";
}
function _resizeMask(objId)
{
 		var arrayPageSize   = getPageSize();//è°ƒç”¨getPageSize()å‡½æ•°   
    	var arrayPageScroll = getPageScroll();//è°ƒç”¨getPageScroll()å‡½æ•°
 		var bodyBack = document.createElement("div");   
        bodyBack.setAttribute("id","_panel_zz")   
        bodyBack.style.position = "absolute";   
        bodyBack.style.width = "100%";   
        bodyBack.style.height = (arrayPageSize[1] + 35 + 'px');   
        bodyBack.style.zIndex = 7;   
        bodyBack.style.top = 0;   
        bodyBack.style.left = 0;   
        bodyBack.style.filter = "alpha(opacity=20)";   
        bodyBack.style.opacity = 0.2;   
        bodyBack.style.background = "#000000";   
        var mybody = document.getElementById(objId);  
        mybody.style.display="block"; 
		insertAfter(bodyBack,mybody);//æ‰§è¡Œå‡½æ•°insertAfter()
} 
function insertAfter(newElement,targetElement)
{   
    var parent = targetElement.parentNode;   
    if(parent.lastChild == targetElement)
    {   
        parent.appendChild(newElement);   
    }   
    else
    {   
        parent.insertBefore(newElement,targetElement.nextSibling);   
    }   
}   
//èŽ·å–æ»šåŠ¨æ¡çš„é«˜åº¦   
function getPageScroll(){   
    var xScroll,yScroll;   
    if (self.pageYOffset) {   
    yScroll = self.pageYOffset;   
    xScroll = self.pageXOffset;   
    } else if (document.documentElement && document.documentElement.scrollTop){   
    yScroll = document.documentElement.scrollTop;   
    }else if (document.documentElement && document.documentElement.scrollLeft){   
    xScroll = document.documentElement.scrollLeft;   
    } else if (document.body) {   
    yScroll = document.body.scrollTop;   
    xScroll = document.body.scrollLeft;   
    }   
    arrayPageScroll = new Array(xScroll,yScroll)   
    return arrayPageScroll;   
}   
//èŽ·å–é¡µé¢å®žé™…å¤§å°   
function getPageSize(){   
    var xScroll,yScroll;   
    if (window.innerHeight && window.scrollMaxY){   
    xScroll = document.body.scrollWidth;   
    yScroll = window.innerHeight + window.scrollMaxY;   
    } else if (document.body.scrollHeight > document.body.offsetHeight){   
    sScroll = document.body.scrollWidth;   
    yScroll = document.body.scrollHeight;   
    } else {   
    xScroll = document.body.offsetWidth;   
    yScroll = document.body.offsetHeight;   
    }   
    var windowWidth,windowHeight;   
    //var pageHeight,pageWidth;   
    if (self.innerHeight) {   
    windowWidth = self.innerWidth;   
    windowHeight = self.innerHeight;   
    } else if (document.documentElement && document.documentElement.clientHeight) {   
    windowWidth = document.documentElement.clientWidth;   
    windowHeight = document.documentElement.clientHeight;   
    } else if (document.body) {   
    windowWidth = document.body.clientWidth;   
    windowHeight = document.body.clientHeight;   
    }   
    var pageWidth,pageHeight   
    if(yScroll < windowHeight){   
    pageHeight = windowHeight;   
    } else {   
    pageHeight = yScroll;   
    }   
    if(xScroll < windowWidth) {   
    pageWidth = windowWidth;   
    } else {   
    pageWidth = xScroll;   
    }   
    arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight)   
    return arrayPageSize;   
}   
function setPageScroll()
{
	 var xScroll,yScroll;   
    if (self.pageYOffset) {   
    yScroll = self.pageYOffset;   
    xScroll = self.pageXOffset;   
    } else if (document.documentElement && document.documentElement.scrollTop)
    {   
    	yScroll = document.documentElement.scrollTop;   
    	document.documentElement.scrollTop=(741+yScroll);
    }else if (document.documentElement && document.documentElement.scrollLeft)
    {   
   	 	xScroll = document.documentElement.scrollLeft;   
    } else if (document.body) 
    {   
    	yScroll = document.body.scrollTop;  
    	document.body.scrollTop=(741+yScroll);
    }    
}
function removeForm(id)
{
	try
	{
		var obj=document.getElementById(id);
		if(obj)
		{
			document.body.removeChild(obj);
		}
	}catch(e){alert(e);}
}
/**隐藏表单**/
function hiddenForm(id)
{
	try
	{
		document.getElementById(id).style.display='none';
	}catch(e){}
}
function closePanel()
{
	removeForm('_panel_zz');hiddenForm('_div_ads_open');
}