    	let delId;
    	function clearCar() {
			$.ajax({
				url:path+"/Car/clearCar.do",
				success:function(data){
					if(eval(data)){
						window.location.reload();												
					}
					if(!eval(data)){
						alert("清空购物车失败");
					}
				}
			})
		}
