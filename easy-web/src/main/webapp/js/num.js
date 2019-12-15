// JavaScript Document
function addUpdate(jia){		
	var c = $(jia).parent().find(".n_ipt").val();
	c=parseInt(c)+1;	
	jia.parent().find(".n_ipt").val(c);
}

function jianUpdate(jian){    
	var c = jian.parent().find(".n_ipt").val();
	if(c==1){    
		c=1;    
	}else{    
		c=parseInt(c)-1;    
		jian.parent().find(".n_ipt").val(c);
	}
}

function reg(x){
    return new RegExp("^[1-9]\\d*$").test(x);
}

//改变数量值  
function changeUpdate(current,productId,quantity){
	var money = 0.0;
	//当用户输入的是非数字类型
	var re = /^[1-9]+[0-9]*]*$/;
	if(!reg($(current).val()) || !re.test(parseInt($(current).val()))){
		$.ajax({
			url:path+"/Car/carAdd.do",
			data:{
				"quantity":0,
				"productId":productId
			},
			dataType:"Json",
			success:function(data){
				alert("不能使用非数字类型");
				$.each(data,function(i,e){
					money += parseFloat(e.price) * parseInt(e.quantity);
					if(e.id == productId){
						$(current).parent().parent().parent().find(".subtotal").html(parseFloat(e.price) * parseInt(e.quantity));
						$(current).parent().children(".car_ipt").val(e.quantity);
						$(".i_car").trigger("click");
					}
				});
				$("#money").html(money.toFixed(2));
			}
		});
		return false;
	}
	
	
	//当用户输入数字类型
	$.ajax({
		url:path+"/Car/inputUpdate.do",
		data:{
			"quantity":quantity,
			"productId":productId
		},
		dataType:"Json",
		success:function(data){
			$.each(data,function(i,e){
				money += parseFloat(e.price) * parseInt(e.quantity);
				if(e.id == productId){
					$(current).parent().parent().parent().find(".subtotal").html((parseFloat(e.price) * parseInt(e.quantity)).toFixed(2));
					$(current).parent().children(".car_ipt").val(e.quantity);
					$(".i_car").trigger("click");
				}
			});
			$("#money").html(money.toFixed(2));
		}
	});
}

function addUpdate1(jia,productId){
	//单价 
	var price = $(jia).parent().parent().parent().find(".price").val();
	var money = 0.0;
	
	$.ajax({
		url:path+"/Car/carAdd.do",
		data:{
			"quantity":1,
			"productId":productId
		},
		dataType:"Json",
		success:function(data){
			$.each(data,function(i,e){
				money += parseFloat(e.price) * parseInt(e.quantity);
				if(e.id == productId){
					$(jia).parent().parent().parent().find(".subtotal").html((parseFloat(e.price) * parseInt(e.quantity)).toFixed(2));
					$(jia).parent().children(".car_ipt").val(e.quantity);
					$(".i_car").trigger("click");
				}
			});
			$("#money").html(money.toFixed(2));
		}
	});
}
  
function jianUpdate1(jian,productId){    
	var c = $(jian).parent().find(".car_ipt").val();
	//单价 
	var price = $(jian).parent().parent().parent().find(".price").val();
	if(c==1){  
		if(!confirm("您确认要商品该商品吗")){
			//删除当前标签
			return;
		}else{
			$(jian).parent().parent().parent().remove();
		}
	}
	
	//总价格
	$.ajax({
		url:path+"/Car/carAdd.do",
		data:{
			"quantity":-1,
			"productId":productId
		},
		dataType:"Json",
		success:function(data){
			var money = 0.0;
			$.each(data,function(i,e){
				money += parseFloat(e.price) * parseInt(e.quantity);
				if(e.id == productId){
					$(jian).parent().parent().parent().find(".subtotal").html((parseFloat(e.price) * parseInt(e.quantity)).toFixed(2));
					$(jian).parent().children(".car_ipt").val(e.quantity);
					$(".i_car").trigger("click");
				}
			});
			$("#money").html(money.toFixed(2));
			$(".i_car").trigger("click");
		}
	});
/*	$(".i_car").trigger("click");
 * 
 */
}  