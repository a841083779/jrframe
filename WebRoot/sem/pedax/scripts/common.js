//=====查询======
function do_search(str){
var url="../search/search.jsp?findparams="+encodeURIComponent(str);
window.location.href=url;
}
//=======回车按键查询======
function dosearch_keyDown(e) {  
if(event.keyCode==13)
{do_search(find_value.value);
	}
}

//======lTrim()
function lTrim(str) 
 {  
 if(str!=null){
	 if (str.charAt(0) == " ") 
	   {
		 str = str.slice(1);
		 str = lTrim(str);
	   } 
 }else{
	str=""; 
 }
  return str; 
 }
  //====rTrim=======
function rTrim(str) 
{	
	if(str!=null){
		var iLength; 
	  
		iLength = str.length; 
	  
		if(str.charAt(iLength - 1)==" ") 
		{str = str.slice(0, iLength - 1);
		 str = rTrim(str);
		} 
	}else{
		str="";	
	}
	return str; 
}
//=====trim()========
function trim(str) 
{return lTrim(rTrim(str)); 
}
 
 function Trim(str) 
{return lTrim(rTrim(str)); 
} 
//====给明细表中的日期强制赋付值=20061219===
function fz_date(obj_table,rowIndex,date_name,fgf)
{var trs = obj_table.getElementsByTagName("tr");
	var sTr =trs[rowIndex];
   // curtr.cells[0].innerHTML="<input type='text' name='xh' size=3 value='"+curRowIndex+"' readonly>";
    var inputs=sTr.getElementsByTagName("input");
   for(var i=0;i<inputs.length;i++)
    {if(inputs[i].name==date_name)
      inputs[i].value=getdate(inputs[i],fgf);
     // break;
    } 
 } 
//====给明细表中列表项赋付值=20070123===
function fz_mx(obj_table,rowIndex,myname,myvalue)
{var trs = obj_table.getElementsByTagName("tr");
 var return_str="";
 var sTr =trs[rowIndex];
  // curtr.cells[0].innerHTML="<input type='text' name='xh' size=3 value='"+curRowIndex+"' readonly>";
    var inputs=sTr.getElementsByTagName("input");
   for(var i=0;i<inputs.length;i++)
    {if(inputs[i].name==myname)
      {if(myvalue!=null)
      	inputs[i].value=myvalue;
      	return_str=trim(inputs[i].value);
       break;
      }
    }
 return return_str;
 } 
 
//=========isValidEmail=======
function isValidEmail(email)
{
var result=email.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/);
if(result==null) return false;
return true;
}
//isDate
 function isDate(str)
{
var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/); 

if(r==null)
 {
  return false;
 } 
var d= new Date(r[1], r[3]-1, r[4]); 
if(d.getMonth()==0)
     return true;
else	 
{if(!(d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]))
 {return false;
 }
 else
 {return true;}
 }
}
//==================
function mOvr(src,clrOver) { if (!src.contains(event.fromElement)){ src.style.cursor = 'hand'; src.bgColor = clrOver; }}
function mOut(src,clrIn){ if (!src.contains(event.toElement)) { src.style.cursor = 'hand'; src.bgColor = clrIn; }}
function mClk(src) { if(event.srcElement.tagName=='TD'){src.children.tags('A')[0].click();} }

//values
function values(n)
{ var str="" 
 ,i=1;
 for(i=1;i<=n;i++)
  { if(eval("checkbox"+i).checked)
     if(str=="")
	 str=eval("checkbox"+i).value;
	 else
	 str=str+","+eval("checkbox"+i).value; 
  }
return str;
}
//====得到checkbox选中的值
function values(objname,n)
{ 	var str="" 
 ,i=1;
 for(i=1;i<=n;i++)
  { if(eval(objname+i).checked)
     if(str=="")
	 str=eval(objname+i).value;
	 else
	 str=str+","+eval(objname+i).value; 
  }
return str;
}

function init() 
{
  document.onkeydown=keyDown; 
  //document.oncontextmenu = function() { return false;} 
} 

function keyDown(e) {  
if((event.keyCode==13) &&(event.srcElement.type != 'textarea')&&(event.srcElement.type != 'submit'))
  {event.keyCode=9;}
  else if(event.keyCode==34)
   {if(theform.b_yisubmit!=null)
	theform.b_yisubmit.click();}
	else if(event.keyCode==8)
	{if(event.srcElement.readOnly==true)
	event.keyCode=0;
	}
}
//======out_str===
function out_str(mystr)
{ var str='';
  str=trim(mystr);
  while(str.indexOf("'")>=0)
   {str=str.replace("'","");
   }
   return str;
 }
 //======allreplace_str==
function allreplace_str(mystr,old_str,new_str)
{ var str='';
  str=trim(mystr);
  while(str.indexOf(old_str)>=0)
   {str=str.replace(old_str,new_str);
   }
   return str;
 }

//=====page_updown=======
function page_updown(my_flag,url)
{var i=document.theform.parampage.selectedIndex;
if(my_flag==0)
  {if(document.theform.parampage!=null)
  	document.theform.parampage.selectedIndex=i-1;
   document.theform.action=url;
   document.theform.method="post";
   document.theform.submit();
   }
  if(my_flag==1)
  {if(document.theform.parampage!=null)
  	document.theform.parampage.selectedIndex=i+1;
   document.theform.action=url;
   document.theform.method="post";
   document.theform.submit();
   }
 }
 //======row_select======
 function row_select(n)
 {eval("window.checkbox"+n).checked=!(eval("window.checkbox"+n).checked);
 }
 //======selectall======
function selectall(form)  
 {
  for (var i=0;i<form.elements.length;i++) 
   { var e = form.elements[i];
     if((e.name != 'allcheck')&&(e.type=="checkbox"))    
        {e.checked = form.allcheck.checked; 
		}
   }
 }

//=====取checkbox中的值======
function fetch_checkvalue(form)  
 {var s="";
  for (var i=0;i<form.elements.length;i++) 
   { var e = form.elements[i];
     if ((e.name != 'allcheck')&&(e.type=="checkbox"))    
        if(e.checked)
		   {if(s=="")
		    s=e.value;
			else
			s=s+","+e.value;
		   }
    }
 return s;  
 }
//=====通过转换取checkbox中的值======
function fetch_allvalue(form)  
 {var s="";
  for (var i=0;i<form.elements.length;i++) 
   { var e = form.elements[i];
      if ((e.name != 'allcheck')&&(e.type=="checkbox"))    
          {if(s=="")
		    {if(e.checked)
			s=e.name+"-1";
			else
			s=e.name+"-0";
			}
			else
			{if(e.checked)
			s=s+","+e.name+"-1";
			else
			s=s+","+e.name+"-0";
			}
		 }
    }
 return s;  
 } 
//=====�����������������������======
function fetch_qxlist_value(form)  
 {var s="";
  var pre_str="";
  for (var i=0;i<form.elements.length;i++) 
   { var e = form.elements[i];
     var str=e.name.substr(0,e.name.indexOf('_'));
      if ((e.name != 'allcheck')&&(e.type=="checkbox"))    
          {if(s=="")
		    {if(e.checked)
			s=str+"-1";
			else
			s=str+"-0";
			}
			else
			{if(pre_str==str)
				{if(e.checked)
			      s=s+"-1";
			    else
			    s=s+"-0";
				}
			  else
			  {if(e.checked)
			   s=s+","+str+"-1";
			   else
			   s=s+","+str+"-0";
			   }
			}
		 }
	pre_str=e.name.substr(0,e.name.indexOf('_'));
	
    }
 return s;
 } 
//=====全部选中========
function selectall() {  
 for(var i=0;i<document.all.length;i++)
    {var mycheck=document.all(i);
      if((mycheck.type=='checkbox')&&(mycheck.name!='allcheck'))
        mycheck.checked=document.all("allcheck").checked;}
   }

//======给select赋值======
function select_value(sel_obj,str)
{ for(var i=0;i<sel_obj.length;i++)
    {if(sel_obj.options[i].value==str)
          sel_obj.selectedIndex=i;
     }
 }
//=====dis_myfind====
function dis_myfind()
{if(myfind.style.visibility=="visible")
   {myfind.style.visibility = "hidden";	
    myfind.style.display = "none";
   }
 else
 {myfind.style.visibility = "visible";	
  myfind.style.display = "block";
 }
  }


function callDialog(url,flag,width,height) {
 if(width==null)
   width=780;
    if(height==null)
    height=650;
var sFeatures="dialogWidth:"+width+"px;dialogHeight:"+height+"px;status:0;center:1;help:0;edge:sunken;resizable:yes";
var return_value;
if(flag==0)
 return_value=showModalDialog(url,"",sFeatures);
 else
 return_value=showModelessDialog(url,"",sFeatures);
 if(return_value==null||return_value=="undefined")
 return_value="";
 return return_value;
}

function openck(url,width,height)
{//var winWidth=screen.availWidth/-100 ; 
 var winWidth,winHeight;
 
 if(width==null)
  winWidth=800;
  else
  winWidth=width;
  
  if(height==null)
   winHeight=550; 
   else
   winHeight=height; 
 var result=window.open(url,"ckwindow","toolbar=no,width="+ winWidth  +",height="+ winHeight  +",top=150,left=150,scrollbars=yes,resizable=no,center:yes,statusbars=yes"); 
 return result;
}

//=======上传窗口====
function uploadwindow(url,width,height)
{//var winWidth=screen.availWidth/-100 ; 
 var winWidth,winHeight;
 
 if(width==null)
  winWidth=800;
  else
  winWidth=width;
  
  if(height==null)
   winHeight=550; 
   else
   winHeight=height; 
 var result=window.open(url,"uploadwin","toolbar=no,width="+ winWidth  +",height="+ winHeight  +",top=150,left=150,scrollbars=yes,resizable=no,center:yes,statusbars=yes"); 
 return result;
}

//======insert_row======
function insert_row(obj_table,rowIndex,cols,fieldname,fetch_col)
{  if(rowIndex==0)
	var objRow = obj_table.insertRow();
	else
	var objRow = obj_table.insertRow(rowIndex);
 var obj_sl,obj_dj,obj_hjje;
 var arr_fieldname=fieldname.split(",");
 for(i=0;i<cols;i++)
  {var objCell = objRow.insertCell();
   objCell.align="center";
     if(i>0&&i<=arr_fieldname.length-1)
        {var myinput =document.createElement("input");
          myinput.name=arr_fieldname[i-1];
          myinput.value=myinput.name;
        //=====hjje======
         if(myinput.name=="sl")
         obj_sl=myinput;
         else if(myinput.name=="dj")
         obj_dj=myinput;
         else if(myinput.name=="hjje")
         obj_hjje=myinput;
        if(fetch_col==i)
          myinput.onkeydown=function(){check_exists(this,objCell.parentElement.rowIndex)};
          myinput.width="70";
          //myinput.value=arr_fieldname[i-1];
           if(i==arr_fieldname.length-1)
              {var myinput1 =document.createElement("input");
                 myinput1.name=arr_fieldname[i];
               //myinput1.value=arr_fieldname[i];
               //myinput1.value=arr_fieldname[i+1];
               myinput1.type="hidden";
               myinput1.value="0";
              }
           objRow.cells[i].appendChild(myinput);
          if(i==arr_fieldname.length-1)
            objRow.cells[i].appendChild(myinput1);
         }
       else
        {if(i==cols-1)
        objRow.cells[i].innerHTML="<a href=\"javascript:form_submit(1,"+objCell.parentElement.rowIndex+",0)\">��������</a>";
        else if(i==0)
        objRow.cells[i].innerHTML=objCell.parentElement.rowIndex;
        else 
        objRow.cells[i].innerHTML="&nbsp;";
  
        }
     }
  //=====hjje======
   if(obj_sl!=null)
    obj_sl.onkeydown=function(){js_hjje(obj_sl,obj_dj,obj_hjje)};
   if(obj_dj!=null)
    obj_dj.onkeydown=function(){js_hjje(obj_sl,obj_dj,obj_hjje)};
 }
 //====del_row20061205====
function deleteRow(obj_table,rowIndex)
{if(rowIndex==0)
	obj_table.deleteRow();
	else
	obj_table.deleteRow(rowIndex);
	//====������������======
	var cols=obj_table.cells.length/obj_table.rows.length;
	for(var i=1;i<obj_table.rows.length;i++)
	{obj_table.rows[i].cells[0].innerText=i;
	 //=======��������id====
	 var tr_input=obj_table.rows[i].getElementsByTagName("input");
	 for(var j=0;j<tr_input.length;j++){
	 	if(tr_input[j].name=='id')
	 	myid=tr_input[j].value;
	  }
     //====
	 obj_table.rows[i].cells[cols-1].innerHTML="<a href=\"javascript:form_submit(1,"+(myid==0?i:0)+","+myid+")\">��������</a>";
	}
}

//====增加行,最新的修改20061219====
//====my_flag 0:表示加序号,1:表示不加序号第一个是顺序号
function insert_row_new(obj_table,my_flag)
{var trs = obj_table.getElementsByTagName("tr");
	var sTr =trs[1];
  	var tr =sTr.cloneNode(true);
	tr.style.display="block";
    // curtr.cells[0].innerHTML="<input type='text' name='xh' size=3 value='"+curRowIndex+"' readonly>";
   	obj_table.firstChild.appendChild(tr);
   	if(my_flag=="0")
   	tr.cells[0].innerHTML=trs.length-2;
  var inputs=tr.getElementsByTagName("input");
   for(var i=0;i<inputs.length;i++)
    {if(my_flag=="1")
     inputs[0].value=trs.length-2;
    if(inputs[i].name=="zd_id")
    inputs[i].value="0";
    }
var colnums=obj_table.cells.length/obj_table.rows.length;
tr.cells[colnums-1].innerHTML="<a href='javascript:delete_row_new("+obj_table.id+","+tr.rowIndex+","+my_flag+");'>删除</a>";
} 

//====删除行,最新的修改20061219====
//====my_flag 0:表示加序号,1:表示不加序号第一个是顺序号
function delete_row_new(obj_table,rowIndex,my_flag)
{if(rowIndex==0)
	obj_table.deleteRow();
	else
	obj_table.deleteRow(rowIndex);
  var colnums=obj_table.cells.length/obj_table.rows.length;
  var myid=0;
  for(var i=2;i<obj_table.rows.length;i++)
	{if(my_flag=="0")
	obj_table.rows[i].cells[0].innerText=i-1;
	else if(my_flag=="1")
	obj_table.rows[i].cells[0].children(0).value=i-1;
	 //=======��������id====
	 var tr_input=obj_table.rows[i].getElementsByTagName("input");
	 for(var j=0;j<tr_input.length;j++){
	 	if(tr_input[j].name=='zd_id')
	 	 {myid=tr_input[j].value;
	 	 break;
	 	 }
	  }
   if(myid=="0")
	obj_table.rows[i].cells[colnums-1].innerHTML="<a href='javascript:delete_row_new("+obj_table.id+","+i+","+my_flag+")'>删除</a>";
  }
	//zrxishu();
}

//=====����������������������==按照分隔符得到当前日期=====
function getdate(obj,gs)
{today=new Date();
var str=today.getYear()+gs+(today.getMonth()+1)+gs+today.getDate();
if(obj!=null)
obj.value=str;
return str;
}
//==========���������������=====
function FormatNumber(srcStr,nAfterDot){ 
   var srcStr,nAfterDot; 
   var resultStr,nTen; 
    srcStr = ""+srcStr+""; 
    strLen = srcStr.length; 
    dotPos = srcStr.indexOf(".",0); 
    if (dotPos == -1){ 
       resultStr = srcStr+"."; 
          for (i=0;i<nAfterDot;i++){ 
           resultStr = resultStr+"0"; 
           } 
       return resultStr; 
      } 
    else{ 
       if ((strLen - dotPos - 1) >= nAfterDot){ 
        nAfter = dotPos + nAfterDot + 1; 
        nTen =1; 
        for(j=0;j<nAfterDot;j++){ 
        nTen = nTen*10; 
       } 
      resultStr = Math.round(parseFloat(srcStr)*nTen)/nTen;
   resultStr=""+resultStr+"";
   //====
   dotPos=resultStr.indexOf(".",0);
    if (dotPos == -1) 
   {resultStr = resultStr+"."; 
   i=0;
   }
   else
   i=resultStr.length-dotPos-1;
          for (;i<nAfterDot;i++){ 
           resultStr = resultStr+"0"; 
           }
   
    //======
      return resultStr; 
      } 
    else{ 
      resultStr = srcStr; 
    for (i=0;i<(nAfterDot - strLen + dotPos + 1);i++){ 
     resultStr = resultStr+"0"; 
     } 
     return resultStr; 
     } 
   } 
}

//========取tr中文本框的值�������������������������=======
function fetch_value_intr(obj_table,rowIndex) {
	var trs = obj_table.getElementsByTagName("tr");
    var tr =trs[rowIndex];
    var tinput=tr.getElementsByTagName("input");
    for(var i=0;i<tinput.length;i++)
    if(tinput[i].name=="sxh")
	alert("tr:==="+tinput[i].value);
	//tr.getElementById("sxh").value="1111";
	//tr.getElementById("jh_fkrq").value="2222";

}


function insert_row1(obj_table,rowIndex,cols,fieldname)
{  
	if(rowIndex==0)
	var objRow = obj_table.insertRow();
	else
	var objRow = obj_table.insertRow(rowIndex); 
 var arr_fieldname=fieldname.split(",");
 for(i=0;i<cols;i++)
  {var objCell = objRow.insertCell();
     if(i<=arr_fieldname.length-2)
        {var myinput =document.createElement("input");
          myinput.name=arr_fieldname[i];
          myinput.width="70";
          if(i==1||i==3){
          	myinput.readOnly="true";
          }
          //myinput.value=arr_fieldname[i];
           if(i==arr_fieldname.length-2)
              {
              var myinput1 =document.createElement("input");
                myinput1.name=arr_fieldname[i+1];
                //myinput1.value=arr_fieldname[i+1];
                myinput1.type="hidden";
                myinput1.value="0";
              }
           
           objRow.cells[i].appendChild(myinput);
           if(i==0)
           {var sel_button=document.createElement("input");
            sel_button.type="button";
            sel_button.value="选择";
            sel_button.onclick=function(){getSelect(1);}
           	objRow.cells[i].appendChild(sel_button);
           }
           if(i==arr_fieldname.length-2)
            objRow.cells[i].appendChild(myinput1);
         }
       else
        objRow.cells[i].innerHTML="&nbsp;"
     }
}
//只能输入数字的方法
function onlyNum() 
{ 
 if (!(((event.keyCode>=48)&&(event.keyCode<=57))||(event.keyCode==13))) 
 { 
  event.keyCode=0; 
 } 
 //alert(event.keyCode);
}

//==清空form中的数据信息
function clearForm(myForm)
{//----表单内对象清空------
       for(var j=0;j<myForm.elements.length;j++)
       {
         var curObj=myForm.elements[j];
         if(curObj.type=='text'){
           curObj.value ="";
         }
       if(curObj.type=='select-one'){
           //curObj.options[curObj.selectedIndex].text ="";
            curObj.selectedIndex="0";
         }
       } 
}
function do_tz(form)
{form.submit();
}