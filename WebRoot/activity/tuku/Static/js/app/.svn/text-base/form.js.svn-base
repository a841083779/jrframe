/**
 * form
 */
define(function(require) {
   var $ = require('$');
	var base=require('base');
	require('./common');

	var Validator=require('modules/validator');
	var datepicker=require('modules/My97DatePicker/WdatePicker');
	
	require.async('modules/sele.css');
	require.async('modules/scroll.css');
	
	//日期选择
	$('#zd_birthday').on('click',function(){
		datepicker()
		})
	//验证码	
	$('#authImg').on('click',function(){
		this.src=$(this).attr('src')+'?now=' + new Date();
		})
	//提交
	$('.dosubmit').on('click',function(event){
		event.preventDefault();
		if(Validator.Validate($(this).parents('from'))){
			var myRand=document.getElementById('rand').value; 
			$.ajax({ 
				url:'/tools/ajax_rand.jsp?rand='+myRand, 
				async:false,
				success:function(data){
					if(date==='false'){
						$.box.remind("请输入正确的验证码",null,{
						title:"验证失败"
						})
						$("#rand").focus(); 
						}else{
							theform.submit(); 
							}
					},
				error:function(error){
					$.box.remind(error,null,{
						title:"验证失败"
						})
					} 
				});
			}
		})

	
})

