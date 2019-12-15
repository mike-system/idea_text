function mySubmit() {
	let flag = false;
	//地址：
	let addr = "";
	//标志建筑：
	let remark = "";
	let $checked = $('input[name="ch"]:checked');
	
	//判断文本框选中的状态
	$("#address_tab tr").each(function (i,e) {
		let a = $(e).children("td");
	})
	/* $( "#checkedInput" ).prop( "checked", true ); */
	//判断该数据的是否是新增地址
 	if($('input[name="ch"]:checked').val() == 'newAddr'){
		flag = true;
		addr = $checked.parent().parent().children("td:eq(1)").children("input").val();
		remark = $checked.parent().parent().children("td:eq(2)").children("input").val();
		/* console.log(addr.val() + "....." + remark.val()); */
	}else{
		/* $checked.parent().parent().children("td:eq(1)").children("d").html(); */
		remark = $checked.parent().parent().children("td:eq(1)").children("b").html();
		addr = $checked.parent().parent().children("td:eq(2)").html();
	}
	
	if(remark == null || $.trim(remark) == "" || remark == undefined || addr == null || $.trim(addr) == "" || addr == undefined){
		alert("地址不能为空");
		return;
	}
	window.location.href= path+"/Order/settleAccountsThree.do?remark="+remark+"&addr="+addr+"&flag="+flag
}    