// JavaScript Document
function ShowDiv(show_div,bg_div,id){
	document.getElementById(show_div).style.display='block';
	document.getElementById(bg_div).style.display='block' ;
	var bgdiv = document.getElementById(bg_div);
	bgdiv.style.width = document.body.scrollWidth;
	// bgdiv.style.height = $(document).height();
	$("#"+bg_div).height($(document).height());
	typeId = id;
};


//删除购物车中某一种产品
function delThisCar() {
	$.ajax({
	
		url:path+"/Car/inputUpdate.do?quantity=0&productId="+typeId,
		success:function(data){
			window.location.reload();
		}
		
	});
}

function CloseDiv(show_div,bg_div)
{
	document.getElementById(show_div).style.display='none';
	document.getElementById(bg_div).style.display='none';
};

function ShowDiv_1(show_div,bg_div,id){
	
	if(!Number.isInteger(parseInt($(".n_ipt").val()))){
		alert("请输入整数！");
		return false;
	}
	
	var curPath = $("#path").val();
	//通过ajax.发送请求
	$.ajax({
		url:curPath+"/Car/carAdd.do",
		type:"get",
		data:{
			"quantity":parseInt($(".n_ipt").val()), //数量
			"productId":id //商品id
		},
		dataType:"text",
		success:function(data){
			document.getElementById(show_div).style.display='block';
			document.getElementById(bg_div).style.display='block' ;
			var bgdiv = document.getElementById(bg_div);
			bgdiv.style.width = document.body.scrollWidth;
//				bgdiv.style.height = $(document).height();
			$("#"+bg_div).height($(document).height());
			$(".i_car").trigger("click");
		}
	});
};

function CloseDiv_1(show_div,bg_div)
{
	document.getElementById(show_div).style.display='none';
	document.getElementById(bg_div).style.display='none';
};