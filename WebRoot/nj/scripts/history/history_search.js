/**
*pro_id: 产品id 
*brand_name : 品牌
*pro_name : 产品id 
*price : 价格
* catalog : 机型
* img : 图片
*file_name : 文件名
*/
var addHistory=function(pro_id,brand_name,pro_name,price,catalog,img,file_name){ 
    stringCookie=getCookie('history');
    var stringHistory=""!=stringCookie?stringCookie:"{history:[]}";
    var json=new JSON(stringHistory);
    var pro_ids = '' ;
    jQuery.each(json['history'],function(i,val){
    	pro_ids+=json['history'][i].pro_id+"," ;
    }) ;
    if(jQuery.trim(pro_id)=='' || pro_ids.indexOf(pro_id)==-1){
    	    var e="{pro_id:"+pro_id+",brand_name:'"+brand_name+"',pro_name:'"+pro_name+"',price:'"+price+"',catalog:'"+catalog+"',img:'"+img+"',file_name:'"+file_name+"'}";
		    json['history'].push(e);   //添加一个新的记录
		    setCookie('history',json.toString(),30);
    }
}
//显示历史记录
var DisplayHistory=function(){
    var p_ele=document.getElementById('history');
     while (p_ele.firstChild) {
      p_ele.removeChild(p_ele.firstChild);
     }

    var historyJSON=getCookie('history');
    var json=new JSON(historyJSON);
    var displayNum=6;
    for(i=json['history'].length-1;i>=0;i--){
        addLi(json['history'][i]['pro_id'],json['history'][i]['brand_name'],json['history'][i]['pro_name'],json['history'][i]['price'],json['history'][i]['catalog'],json['history'][i]['img'],json['history'][i]['file_name'],"history");
        displayNum--;
        if(displayNum==0){break;}
    }
}
//添加一个cookie   
var addLi=function(pro_id,brand_name,pro_name,price,catalog,img,file_name,pid){
    var a=document.createElement('a');
    var href='/proDetail/'+file_name;
    a.setAttribute('href',href);
    a.setAttribute("target","_blank") ;
	 a.setAttribute("title",unescape(brand_name+pro_name+catalog)) ;
    jQuery(a).html("<img title='"+unescape(brand_name+pro_name+catalog)+"' alt='"+unescape(brand_name+pro_name+catalog)+"' src='"+unescape(img)+"' onerror="+"this.src='/images/nopic.gif'"+" width='90' height='50' /><h4> "+unescape(brand_name+pro_name+catalog)+"</h4>") ;
    var li=document.createElement('li');
    li.appendChild(a);
    jQuery(li).appendTo("#"+pid) ;
}
//添加cookie
var setCookie=function(c_name,value,expiredays)
{
    var exdate=new Date()
    exdate.setDate(exdate.getDate()+expiredays)
    cookieVal=c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";path=/;expires="+exdate.toGMTString());
    document.cookie=cookieVal;
}
//获取cookie
function getCookie(c_name)
{
    if (document.cookie.length>0)
      {
      c_start=document.cookie.indexOf(c_name + "=")
      if (c_start!=-1)
        { 
        c_start=c_start + c_name.length+1 
        c_end=document.cookie.indexOf(";",c_start)
        if (c_end==-1) c_end=document.cookie.length
        return unescape(document.cookie.substring(c_start,c_end))
        } 
      }
    return ""
}
// 清除cookie 
function DeleteCookie(){
	 setCookie('history',"{history:[]}",30);
}