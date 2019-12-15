//删除订单 需要匹配该用户的id和商品的id是否匹配，防止恶意删除
function delOrder(id) {
	if(confirm('确定要取消吗')){
		$.ajax({
			url:path+"/Order/delOrder.do?orderId="+id,
			type:"get",
			success:function(data){
				if(eval(data)){
					alert("取消成功");
					document.location.reload();
				}
				if(!eval(data)){
					alert("取消失败");
				}
			},
		});
	}
}

//合并订单号
function merge(){
	
	let val1;
	let val2;
	$.each($(".jj"),function(i,e){
		if($(e).val() == 0 || $(e).val() == null || $(e).val() == undefined){
			alert("第"+(i+1)+"个不能为空");
			return;
		}else{
			if(i == 0){
				val1 = $(e).val();
			}
			if(i == 1){
				val2 = $(e).val();
			}
		}
	});
	
	if(val1 == null || val2 == null){
		return;
	}
	if(val1 != null && val2 != null && val1 == val2){
		
		alert("合并的两个订单号不能相同");
		return;
		
	}
	
	$.ajax({
		url:path+"/Order/mergeOrder.do",
		type:"post",
		data:{
			"val1":val1,
			"val2":val2
		},
		dataType:"text",
		success:function(data){
			alert(data);
			
			if(data == "操作成功"){
				window.location.reload();
			}
		}
	});
}