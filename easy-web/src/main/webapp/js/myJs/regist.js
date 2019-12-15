let flag1 = true;
let flag2 = true;
let flag3 = true;
let flag4 = true;
let flag5 = true;
let flag6 = true;
let flag7 = true;
let flag8 = true;

$(function() {
	let loginname = $("#formId").find("input[name='loginname']").val();
	let loginnameObj = $("#formId").find("input[name='loginname']");
	let password = $("#formId").find("input[name='password']").val();
	let lastpassword = $("#formId").find("input[name='password']").last().val();
	let email = $("#formId").find("input[name='email']").val();
	let mobile = $("#formId").find("input[name='mobile']").val();
	let userName = $("#formId").find("input[name='userName']").val();
	let identityCode = $("#formId").find("input[name='identityCode']").val();
	let userId = $("#formId").find("input[name='userId']").val();
  
	//当鼠标离开时，判断用户是否存在
$("#formId").find("input[name='loginname']").bind("blur",function(){
	
	loginname = $("#formId").find("input[name='loginname']").val();
	userId = $("#formId").find("input[name='userId']").val();
	if(loginname == null || $.trim(loginname) == "" || loginname == undefined){
		$("#message1").css("color","red").html("用户名不能为空");
		flag1 = false;
		return;
	}
	
	if(loginname.length > 6){
		$("#message1").css("color","red").html("用户名长度不能超过6位");
		flag1 = false;
		return;
	}
	
	$.ajax({
		url:path+"/userAccount/checkUsername.do",
		type:"post",
		data:{
			"loginname":loginname,
			"userId":userId
		},
		dataType:"text",
		success:function(data){
			if(eval(data)){
				$("#message1").css("color","green").html("恭喜你，该用户名可用");	
				flag1 = true;
				return;
			}
			if(!eval(data)){
				$("#message1").css("color","red").html("该用户名已被注册");
				flag1 = false;
				return;
			}
		}
	});
	
});

//判断用户的密码是否符合要求	
$("#formId").find("input[name='password']:first").bind("blur",function(){
		password = $("#formId").find("input[name='password']:first").val();
		if(password == null || $.trim(password) == "" || password == undefined){
			$("#message2").css("color","red").html("用户密码不能为空");
			flag2 = false;
			return;
		}
		if($.trim(password).length < 6 || $.trim(password).length > 10){
			$("#message2").css("color","red").html("密码长度在6到10位之间");
			flag2 = false;
			return;
		}
		$("#message2").css("color","green").html("密码符合要求");
		flag2 = true;
		return;
});

//判断用户的确认密码是否符合要求	
$("#formId").find("input[name='password']:last").bind("blur",function(){
	lastpassword = $("#formId").find("input[name='password']").last().val()
	
	if(lastpassword == null || $.trim(lastpassword) == "" || lastpassword == undefined){
		$("#message3").css("color","red").html("验证密码不能为空");
		flag2 = false;
		return;
	}
	if(lastpassword.length < 6 || lastpassword.length > 10){
		$("#message3").css("color","red").html("密码长度在6到10位之间");
		flag2 = false;
		return;
	}
	
	
	if(lastpassword != password){
		$("#message3").css("color","red").html("两次密码不一致");
		flag3 = false;
		return;
	}
	$("#message3").css("color","green").html("两次密码一致");
	flag3 = true;
	return;
});
//邮箱验证
$("#formId").find("input[name='email']").bind("blur",function(){
	email = $("#formId").find("input[name='email']").val();
	userId = $("#formId").find("input[name='userId']").val();
	
	if(email == null || $.trim(email) == "" || email == undefined){
		$("#message4").css("color","red").html("邮箱不能为空");
		flag4 = false;
		return;
	}
	let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
	if(!reg.test(email)){
		$("#message4").css("color","red").html("邮箱格式不正确");
		flag4 = false;
		return;
	}
	
	$.ajax({
		
		url:path+"/userAccount/checkEmail.do",
		type:"post",
		data:{
			"email":email,
			"userId":userId
		},
		dataType:"text",
		success:function(data){
			
			if(!eval(data)){
				$("#message4").css("color","red").html("该邮箱已被注册");
				flag4 = false;
				return;
			}
		}
	});
	
	$("#message4").css("color","green").html("邮箱可用!");
	flag4 = true;
	return;
});

//手机号码验证
$("#formId").find("input[name='mobile']").bind("blur",function(){
	mobile = $("#formId").find("input[name='mobile']").val();
	userId = $("#formId").find("input[name='userId']").val();
	if(mobile == null || $.trim(mobile) == "" || mobile == undefined){
		$("#message5").css("color","red").html("手机号码不能为空");
		flag5 = false;
		return;
	}
	let reg = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/;
	if(!reg.test(mobile)){
		$("#message5").css("color","red").html("手机格式不正确");
		flag5 = false;
		return;
	}
	
	$.ajax({
		url:path+"/userAccount/checkMobile.do",
		type:"post",
		data:{
			"mobile":mobile,
			"userId":userId
		},
		dataType:"text",
		success:function(data){
			if(!eval(data)){
				$("#message5").css("color","red").html("该手机号已被注册");
				flag5 = false;
				return;
			}
		}
	});
	
	$("#message5").css("color","green").html("手机号可用");
	flag5 = true;
	return;
});
//姓名非空验证
$("#formId").find("input[name='userName']").bind("blur",function(){
	userName = $("#formId").find("input[name='userName']").val();
	if(userName == null || $.trim(userName) == "" || userName == undefined){
		$("#message7").css("color","red").html("姓名不能为空");
		flag7 = false;
		return;
	}
	$("#message7").css("color","green").html("姓名可用");
	flag7 = true;
	return;
});
//身份证验证
$("#formId").find("input[name='identityCode']").bind("blur",function(){
	identityCode = $("#formId").find("input[name='identityCode']").val();
	userId = $("#formId").find("input[name='userId']").val();
	if(identityCode == null || $.trim(identityCode) == "" || identityCode == undefined){
		$("#message8").css("color","red").html("身份证不能为空");
		flag8 = false;
		return;
	}
	let reg = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
	if(!reg.test(identityCode)){
		$("#message8").css("color","red").html("身份证格式不正确");
		flag8 = false;
		return;
	}
	
	$.ajax({
		url:path+"/userAccount/checkIdentityCode.do",
		type:"post",
		data:{
			"identityCode":identityCode,
			"userId":userId
		},
		dataType:"text",
		success:function(data){
			if(!eval(data)){
				$("#message8").css("color","red").html("身份证号已被注册");
				flag8 = false;
				return;
			}
		}
	});
	
	$("#message8").css("color","green").html("身份证可用");
	flag8 = true;
	return;
});

//验证码验证
$("#codeId").bind("blur",function(){
	let codeVal = $("#codeId").val();
	if(codeVal.length != 4){
		$("#message6").css("color","red").html("验证码的长度必须在4位");
		return;
	}
	$.ajax({
		url:path+"/userAccount/checkImgCode.do",
			type:"post",
			data:{
				"codeVal":codeVal,
			},
			dataType:"text",
			success:function(data){
				if(!eval(data)){
					getNewPicCode();
					$("#message6").css("color","red").html("验证码不正确");
					flag6 = false;
					return;
				}
				$("#message6").css("color","green").html("验证通过");
					flag6 = true;
						return;
				}
			});
	});
})

//刷新图片验证码
function getNewPicCode() {
	$("#codeImg").attr("src",path+"/PictureCodeServlet.do?flag="+Date.now());
}

//验证码验证 //检查是否能提交
function checkForm(){
	//模拟用户鼠标失去焦点事件
	$("#formId").find("input[name='loginname']").trigger("blur");
	$("#formId").find("input[name='password']:first").trigger("blur");
	$("#formId").find("input[name='password']:last").trigger("blur");
	$("#formId").find("input[name='email']").trigger("blur");
	$("#formId").find("input[name='mobile']").trigger("blur");
	$("#codeId").trigger("blur");
	return flag1 && flag2 && flag3 && flag4 && flag5 && flag6;
};

function addUser() {
	//模拟用户鼠标失去焦点事件
	$("#formId").find("input[name='loginname']").trigger("blur");
	$("#formId").find("input[name='password']:first").trigger("blur");
	$("#formId").find("input[name='password']:last").trigger("blur");
	$("#formId").find("input[name='email']").trigger("blur");
	$("#formId").find("input[name='mobile']").trigger("blur");
	$("#formId").find("input[name='userName']").trigger("blur");
	$("#formId").find("input[name='identityCode']").trigger("blur");
	$("#codeId").trigger("blur");
	let flagSub = flag1 && flag2 && flag3 && flag4 && flag5 && flag6 && flag7 && flag8;
	if(flagSub){
		$.ajax({
			url:path+"/Admin/updateUserOrAddHandler.do",
			data:$('#formId').serialize(),
		    success: function(data) {  
		        //接收后台返回的结果  
		        alert(data);
		        if(data == "操作成功"){
		        	window.location.href=path+"/Admin/userList.do";
		        }
		    }
		})
	}
}
