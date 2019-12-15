let mobileFlag1 = false;
let mobileFlag2 = false;

let emailFlag1 = false;
let emailFlag2 = false;


let passwordFlag1 = false;
let passwordFlag2 = false;
let passwordFlag3 = false;

	$(function () {
		//定义鼠标离开事件
		$("#oldMobile").bind("blur",function(){
			//判断手机格式是否正确
			let mobile = $("#oldMobile").val();
			if(mobile == null || $.trim(mobile) == "" || mobile == undefined){
				$("#message1").css("color","red").html("手机号码不能为空");
				mobileFlag1 = false;
				return;
			}
			let reg = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/;
			if(!reg.test(mobile)){
				$("#message1").css("color","red").html("手机格式不正确");
				mobileFlag1 = false;
				return;
			}
			
			$.ajax({
				url:path+"/userAccount/getMobileByUserId.do",
				data:{
					"mobile":mobile
				},
				dataType:"text",
				success:function(data){
					if(eval(data)){
						$("#message1").css("color","green").html("输入正确");
						mobileFlag1 = true;
						return;
					}
					if(!eval(data)){
						$("#message1").css("color","red").html("输入有误");
						mobileFlag1 = false;
						return;
					}
				}
			});
				
		});
		
		//定义鼠标离开事件
		$("#newMobile").bind("blur",function(){
			//判断手机格式是否正确
			let mobile = $("#newMobile").val();
			if(mobile == null || $.trim(mobile) == "" || mobile == undefined){
				$("#message2").css("color","red").html("手机号码不能为空");
				mobileFlag2 = false;
				return;
			}
			let reg = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/;
			if(!reg.test(mobile)){
				$("#message2").css("color","red").html("手机格式不正确");
				mobileFlag2 = false;
				return;
			}
			
			$.ajax({
				url:path+"/userAccount/checkMobile.do",
				type:"get",
				data:{
					"mobile":mobile,
				},
				dataType:"text",
				success:function(data){
					if(!eval(data)){
						// 该手机号不可用
						$("#message2").css("color","red").html("该手机换号已被注册");
						mobileFlag2 = false;
						return;
					}
					if(eval(data)){
						// 该手机号可用
						$("#message2").css("color","red").css("color","green").html("可用");
						mobileFlag2 = true;
						return;
					}
				}
			});
		});
		
		
		
		
		
		
		
		
		
		
		
		
		//定义鼠标离开事件  邮箱   
		$("#oldEmail").bind("blur",function(){
			//判断邮箱格式是否正确
			let email = $("#oldEmail").val();
			if(email == null || $.trim(email) == "" || email == undefined){
				$("#message3").css("color","red").html("邮箱号码不能为空");
				emailFlag1 = false;
				return;
			}
			let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
			if(!reg.test(email)){
				$("#message3").css("color","red").html("邮箱格式不正确");
				emailFlag1 = false;
				return;
			}
			
			$.ajax({
				url:path+"/userAccount/getEmailByUserId.do",
				data:{
					"email":email,
				},
				dataType:"text",
				success:function(data){
					if(eval(data)){
						$("#message3").css("color","green").html("输入正确");
						emailFlag1 = true;
						return;
					}
					if(!eval(data)){
						$("#message3").css("color","red").html("输入有误");
						emailFlag1 = false;
						return;
					}
				}
			});
				
		});
		
		//定义鼠标离开事件  邮箱
		$("#newEmail").bind("blur",function(){
			//判断邮箱格式是否正确
			let email = $("#newEmail").val();
			if(email == null || $.trim(email) == "" || email == undefined){
				$("#message4").css("color","red").html("邮箱号码不能为空");
				emailFlag2 = false;
				return;
			}
			let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
			if(!reg.test(email)){
				$("#message4").css("color","red").html("邮箱格式不正确");
				emailFlag2 = false;
				return;
			}
			
			$.ajax({
				url:path+"/userAccount/checkEmail.do",
				type:"post",
				data:{
					"email":email,
				},
				dataType:"text",
				success:function(data){
					if(!eval(data)){
						// 该邮箱号不可用
						$("#message4").css("color","red").html("该邮箱已被注册");
						emailFlag2 = false;
						return;
					}
					if(eval(data)){
						// 该邮箱号可用
						$("#message4").css("color","red").css("color","green").html("可用");
						emailFlag2 = true;
						return;
					}
				}
			});
		});
		
		
		
		//定义鼠标离开事件  密码
		$("#oldPassword").bind("blur",function(){
			let password = $("#oldPassword").val();
			if(password == null || $.trim(password) == "" || password == undefined){
				$("#message5").css("color","red").html("密码不能为空");
				passwordFlag1 = false;
				return;
			}
			
			if($.trim(password).length < 6 || $.trim(password).length > 10){
				$("#message5").css("color","red").html("密码长度在6到10位之间");
				passwordFlag1 = false;
				return;
			}
			
			$("#message5").css("color","green").html("密码符合要求");
			passwordFlag1 = true;
			return;
		});
		
		
		
		//判断用户的密码是否符合要求	
		$("#newPassword").bind("blur",function(){
				let password = $("#newPassword").val();
				if(password == null || $.trim(password) == "" || password == undefined){
					$("#message6").css("color","red").html("用户密码不能为空");
					passwordFlag2 = false;
					return;
				}
				if($.trim(password).length < 6 || $.trim(password).length > 10){
					$("#message6").css("color","red").html("密码长度在6到10位之间");
					passwordFlag2 = false;
					return;
				}
				$("#message6").css("color","green").html("密码符合要求");
				passwordFlag2 = true;
				return;
		});

		
		

		//判断用户的确认密码是否符合要求	
		$("#checkPassword").bind("blur",function(){
			let lastpassword = $("#checkPassword").val()
			let password = $("#newPassword").val();
			if(lastpassword == null || $.trim(lastpassword) == "" || lastpassword == undefined){
				$("#message7").css("color","red").html("验证密码不能为空");
				passwordFlag3 = false;
				return;
			}
			if($.trim(lastpassword).length < 6 || $.trim(lastpassword).length > 10){
				$("#message7").css("color","red").html("密码长度在6到10位之间");
				passwordFlag3 = false;
				return;
			}
			
			
			if(lastpassword != password){
				$("#message7").css("color","red").html("两次密码不一致");
				passwordFlag3 = false;
				return;
			}
			$("#message7").css("color","green").html("密码可用");
			passwordFlag3 = true;
			return;
		});
		
/*		 $("#subPassword").on("click",function(){
			 	alert("陈宫");
		        $('#modifyPassword').ajaxSubmit({
		            url: path+'/userAccount/updatePassword.do',
		            type: 'post',
		            data: jQuery("form").serialize(),
		            dataType: 'text',
		            beforeSubmit: function () {},
		            success: function (data) {
		                console.log(data);
		            },
		            clearForm: false,
		            resetForm: false 
		        });
		    });*/

	})
	
	function updateEmail() {
		//模拟鼠标离开事件
		$("#oldEmail").trigger("blur");
		$("#newEmail").trigger("blur");
		return emailFlag1 && emailFlag2;
	}
	function updateMobile() {
		//模拟鼠标离开事件
		$("#oldMobile").trigger("blur");
		$("#newMobile").trigger("blur");
		return mobileFlag1 && mobileFlag2;
	}
	/*function updatePassword() {
		//模拟鼠标离开事件
		$("#oldPassword").trigger("blur");
		$("#newPassword").trigger("blur");
		$("#checkPassword").trigger("blur");
		return passwordFlag1 && passwordFlag2 && passwordFlag3;
	}*/
			
	function submitForm(){
		$("#oldPassword").trigger("blur");
		$("#newPassword").trigger("blur");
		$("#checkPassword").trigger("blur");
		
		if(passwordFlag1 && passwordFlag2 && passwordFlag3){
			 $.ajax({  
		            type: "POST",  
		            url:path+'/userAccount/updatePassword.do', 
		            data:$('#modifyPassword').serialize(),
		            async: false,  
		            error: function(request) {  
		                alert("异常");  
		            },  
		            success: function(data) { 
		              if(data=="true"){
		            	  alert("修改成功，请重新登录");
		            	  window.location.href=path+"/userAccount/loginUI.do";
		              }
		              else{
		            	  alert(data);
		              }
		            }  
		        });
			 return;
		}
		
       
        
    }