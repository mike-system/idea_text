//修改地址
function modifyAddr(id) {
    $("#addType").css("display","none");
    // 打开表格
    $("#modifyType").css("display","block");
	$.ajax({
      	url:path+"/Address/getAddressById.do",
		type:"post",
		data:{
			"id":id,
		},
      		dataType:"json",
      		success:function(data){
      			// 将获取返回来的值，放入表格中
      			$("#modifyType tr :eq(2)").children().eq(1).children("input:first").val(data.address);
      			$("#modifyType tr :eq(2)").children().eq(3).children("input:first").val(data.remark);
      			$("#addrId").val(data.id);
      		},
      	});
};
     	
// 隐藏修改或者编辑
function hidModifyOrUpdate(id){
	$("#"+id).css("display","none");
}

// 添加地址
function addAddr() {
    $("#modifyType").css("display","none");
	$("#addType").css("display","block");
}

$(function () {
	
	// 获取地址，省市联动
	$(".area").each(function (i,e) {
		
		let addrFlag = false;
		let usernameFlag = false;
		let mobileFlag = false;
		let emailFlag = false;
		
		let $province = $(e).children(".jj:first");
		let $city = $(e).children(".jj:eq(1)");
		let $area = $(e).children(".jj:eq(2)");
		
		$province.html("<option value='0' selected='selected'>请选择...</option>");
		
			// 从数据中获取省份的地址，并且遍历
			$.ajax({
				url:path+"/Address/getAreaByParentId.do",
				type:"get",
				data:{
					parentId:1,
				},
				dataType:"json",
				success:function(data){
					 $.each(data, function (n, eara) {
						 $province.append("<option value="+eara.areaId+">"+eara.name+"</option>");
			         });
				}
		});
			
		$province.bind("change",function(){
			$city.html("<option value='0' selected='selected'>请选择...</option>");
			$area.html("<option value='0' selected='selected'>请选择...</option>");
			$.ajax({
				url:path+"/Address/getAreaByParentId.do",
				type:"get",
				data:{
					parentId:$(this).val(),
				},
				dataType:"json",
				success:function(data){
					 $.each(data, function (n, eara) {
						 $city.append("<option value="+eara.areaId+">"+eara.name+"</option>");
			         });
				}
			});
		});
		
		$city.bind("change",function(){
			$area.html("<option value='0' selected='selected'>请选择...</option>");
			$.ajax({
				url:path+"/Address/getAreaByParentId.do",
				type:"get",
				data:{
					parentId:$(this).val(),
				},
				dataType:"json",
				success:function(data){
					 $.each(data, function (n, eara) {
						 $area.append("<option value="+eara.areaId+">"+eara.name+"</option>");
			         });
				}
			});
		});
		
		// 为用户名注册失去焦点事件
		$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(1).children("input").first().bind("blur",function(){
			let $val = $(e).parent("tr").nextAll("tr").eq(0).children("td").eq(1).children("input").first().val();
			if($val == null || "" == $.trim($val) || $val == undefined){
				$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(1).children("span").first().css("color","red").html("不能为空");
				usernameFlag == false;
				return;
			}
			$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(1).children("span").first().css("color","green").html(" 可用");
			usernameFlag = true;
		});
		
		// 为邮箱注册失去焦点事件
		$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(3).children("input").first().bind("blur",function(){
			if($(this).val() == null || $(this).val() == "" || $(this).val() == undefined){
				$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(3).children("span").first().css("color","red").html("不能为空");
				return;
			}
			let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
			if(!reg.test($(this).val())){
				$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(3).children("span").first().css("color","red").html("格式不正确");
				return;
			}
			$.ajax({
				url:path+"/userAccount/checkEmail.do",
				type:"get",
				data:{
					"email":$(this).val(),
					"userId":thisId
				},
				dataType:"json",
				success:function(data){
					
					if(!eval(data)){
						// 该邮箱号不可用
						$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(3).children("span").first().css("color","red").html("该邮箱换号已被注册");
						emailFlag = false;
						return;
					}
					if(eval(data)){
						// 该号可用
						$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(3).children("span").first().css("color","green").html("可用");
						emailFlag = true;
						return;
					}
					
				}
			});
		
		});
		
		// 为手机注册失去焦点事件
		$(e).parent("tr").nextAll("tr").eq(2).children("td").eq(1).children("input").first().bind("blur",function(){
			if($(this).val() == null || $(this).val() == "" || $(this).val() == undefined){
				$(e).parent("tr").nextAll("tr").eq(2).children("td").eq(1).children("span").first().css("color","red").html("不能为空");
				return;
			}
			let reg = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/;
			if(!reg.test($(this).val())){
				$(e).parent("tr").nextAll("tr").eq(2).children("td").eq(1).children("span").first().css("color","red").html("手机格式不正确");
				return;
			}
			$.ajax({
				url:path+"/userAccount/checkMobile.do",
				type:"get",
				data:{
					mobile:$(this).val(),
					"userId":thisId
				},
				dataType:"json",
				success:function(data){
					if(!eval(data)){
						// 该手机号不可用
						$(e).parent("tr").nextAll("tr").eq(2).children("td").eq(1).children("span").first().css("color","red").html("该手机换号已被注册");
						mobileFlag = false;
						return;
					}
					if(eval(data)){
						// 该手机号可用
						$(e).parent("tr").nextAll("tr").eq(2).children("td").eq(1).children("span").first().css("color","green").html("可用");
						mobileFlag = true;
						return;
					}
				}
			});
		});
		
		// 为地址注册失去焦点事件
		$(e).parent("tr").nextAll("tr").eq(1).children("td").eq(1).children("input").first().bind("blur",function(){
			if($(this).val() == null || $(this).val() == "" || $(this).val() == undefined)
				$(e).parent("tr").nextAll("tr").eq(1).children("td").eq(1).children("span").first().css("color","red").html("不能为空");
			let $val = $(this).val();
			if($val.indexOf("-") >= 0){
				$(e).parent("tr").nextAll("tr").eq(1).children("td").eq(1).children("span").first().css("color","red").html("不能含有‘-’");
				addrFlag = false;
				return;
			}
			$.ajax({
				url:path+"/Address/checkAddr.do",
				type:"get",
				data:{
					addrc:$(this).val(),
				},
				dataType:"json",
				success:function(data){
					if(!eval(data)){
						$(e).parent("tr").nextAll("tr").eq(1).children("td").eq(1).children("span").first().css("color","red").html("不能为空");
						addrFlag = false;
						return;
					}
					if(eval(data)){
						$(e).parent("tr").nextAll("tr").eq(1).children("td").eq(1).children("span").first().css("color","green").html("  可用");
						addrFlag = true;
						return;
					}
				}
				
			});
		});
		
	 	if(i==0){
			// 为form注册submit事件
			$("#modifyType").submit( function () {
				// 模拟鼠标离开事件
				$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(1).children("input").first().trigger("blur");
				$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(3).children("input").first().trigger("blur");
				$(e).parent("tr").nextAll("tr").eq(2).children("td").eq(1).children("input").first().trigger("blur");
				$(e).parent("tr").nextAll("tr").eq(1).children("td").eq(1).children("input").first().trigger("blur");
				let flag = addrFlag && usernameFlag && mobileFlag && emailFlag;
				if($area.val() == 0){
					$(e).children("span").first().css("color","red").html("必填项");
					return false;
				}
				return flag;
			});
		}
		
		if(i==1){
			// 为form注册submit事件
			$("#addType").submit(function () {

				// 模拟鼠标离开事件
				$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(1).children("input").first().trigger("blur");
				$(e).parent("tr").nextAll("tr").eq(0).children("td").eq(3).children("input").first().trigger("blur");
				$(e).parent("tr").nextAll("tr").eq(2).children("td").eq(1).children("input").first().trigger("blur");
				$(e).parent("tr").nextAll("tr").eq(1).children("td").eq(1).children("input").first().trigger("blur");
				let flag = addrFlag && usernameFlag && mobileFlag && emailFlag;
				
				if($area.val() == 0){
					$(e).children("span").first().css("color","red").html("必填项");
					return false;
				}
				return flag;
			});
		} 
	});
})

/* 设置地址的默认值 */
function setDefault(id){
	$.ajax({
		url:path+"/Address/setDefaultAddr.do?addrId="+id,
		type:"get",
		success:function(data){
			if(eval(data)){
				alert("修改成功");
			}else{
				alert("修改失败");
			}
		}
	});
}

/* 删除地址 */
function delAddr(id) {
	$.ajax({
		url:path+"/Address/delAddress.do?addrId="+id,
		type:"get",
		success:function(data){
			if(eval(data)){
				alert("删除成功");
				document.location.reload();
			}else{
				alert("删除失败");
			}
		}
	});
}