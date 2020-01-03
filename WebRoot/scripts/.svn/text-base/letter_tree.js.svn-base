function treeHref(curLitterNum)
{
	var hideItemAllHeight = 0;
	for(var i=1; i<curLitterNum; i++)
	{
		var hideItem = document.getElementById("letter" + i);
		if(!hideItem)
			continue;
		var hideItemHeight = hideItem.offsetHeight-1;
		hideItemAllHeight += hideItemHeight;
	}
	var treeBox = document.getElementById("treev1");
	treeBox.scrollTop = hideItemAllHeight;
}

jQuery(function(){
	jQuery(".root ul li").click(function(){
		//jQuery(".root ul li").removeClass("rootCur");
		var thisClass = jQuery(this).attr("class");
		if(undefined == thisClass || ""==thisClass){
			jQuery(".root ul li").removeClass("rootCur");
			jQuery(this).addClass("rootCur");
			openLeftSub(jQuery(this).attr("id"),jQuery(this).attr("title"),jQuery(this).attr("url"));//厂家ID;厂家名称
		}else{
			jQuery(this).removeClass("rootCur");
		}
	});
});

function openLeftSub(id,name,url){
	jQuery.ajax({
			url:"/include/left_sub.jsp",
			type:"post",
			data:{"factoryid":id,"factoryname":name,"url":url},
			success:function(data){
				jQuery("#"+id+"_sub").html(data);	
			}
		})
}