function checkForm() {
	let username = $("#formId").find("input[name='username']").val();
	let password = $("#formId").find("input[name='password']").val();
	if(username == null || username == "" || username == undefined){
		$("#messageId").html("用户名不能为空");
		return false;
	}
	if(password == null || password == "" || password == undefined){
		$("#messageId").html("用户密码不能为空");
		return false;
	}
	return true;
}
