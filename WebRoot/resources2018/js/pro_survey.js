$(function() {
    var product_id=	jQuery("#product_id").val();
	//获取产品得分和星星 
	function getAllComment() {
				jQuery.getJSON("/action/ajax.jsp?flag=get_all_comment&callback=?&pid="+product_id, function(data) {
	 		    var s1 = (parseInt(data.score1, 10) / 20);
				var s2 = (parseInt(data.score2, 10) / 20);
				var s3 = (parseInt(data.score3, 10) / 20);
			    var s4 = (parseInt(data.score4, 10) / 20);

 
		var sall = ((s1 * 5) + (s2 * 5) + (s3 * 5) + (s4 * 5));
		jQuery("#totalScoreId").html(sall);
		jQuery("#score_koubei").html(sall);
		jQuery("#pricescore_koubei").raty({
			half: true,
			readOnly: true,
			score: s1
		});
		jQuery("#abilityscore_koubei").raty({
			half: true,
			readOnly: true,
			score: s2
		});
		jQuery("#qualityscore_koubei").raty({
			half: true,
			readOnly: true,
			score: s3
		});
		jQuery("#servicescore_koubei").raty({
			half: true,
			readOnly: true,
			score: s4
		});
		// 基于准备好的dom，初始化echarts图表
		var myChart = echarts.init(document.getElementById('main'));
		var option = {
			title: {
				text: "",
				subtext: ""
			},
			tooltip: {
				trigger: ""
			},
			legend: {
				orient: "vertical",
				x: "right",
				y: "bottom",
				data: [""]
			},
			toolbox: {
				show: false,
				feature: {
					mark: {
						show: false,
						readOnly: true
					},
					dataView: {
						show: false,
						readOnly: true
					},
					restore: {
						show: false,
						readOnly: true
					},
					saveAsImage: {
						show: false,
						readOnly: true
					}
				}
			},
			polar: [{
				indicator: [{
						text: "价格",
						min: 0,
						max: 100
					},
					{
						text: "质量",
						min: 0,
						max: 100
					},
					{
						text: "售后",
						min: 0,
						max: 100
					},
					{
						text: "性能",
						min: 0,
						max: 100
					}
				],
				type: "circle",
				center: ["50%", "50%"]
			}],
			calculable: false,
			series: [{
				type: "radar",
				name: "",
				data: [{
					value: [parseInt(s1) * 20, parseInt(s3) * 20, parseInt(s4) * 20, parseInt(s2) * 20],
					name: "卡特彼勒307E2"
				}],
				symbolSize: 4
			}],
			calculableColor: "rgba(255,165,0,0.6)",
			calculableHolderColor: "#ccc",
			animation: false,
			animationThreshold: 2000,
			animationDuration: 2000,
			animationEasing: "ExponentialOut"
		}
		// 为echarts对象加载数据 
		myChart.setOption(option);
	 	});
	}
	getAllComment();

	/**
	 * 图片部分切换效果
	 */

	$('.pic_tips').on('mouseover', '.pic_tip', function() {
		console.log($(this).index());
		$(this).addClass('on').siblings().removeClass('on');
		$('.pic_sboxs').find('.pic_sbox').eq($(this).index()).addClass('on').siblings().removeClass('on')
	})
	
	//口碑评论数
	jQuery.ajax({
		url:"/action/ajax.jsp",
		type:"post",
		data:{"id":product_id,"flag":"commentCount"},
		success:function(data){
		    jQuery("#koubei_top").html($.trim(data));
		    jQuery("#koubei_bottom").html($.trim(data));
		}
	});


})