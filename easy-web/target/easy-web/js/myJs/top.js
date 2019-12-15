    $(function () {
        function loadCar() {
            //发送Ajax请求返回的购物车的数据
            $.ajax({
                url: path+"/Car/getCar.do",
                type: "post",
                dataType: "Json",
                success: function (data) {
                	$(".cars").html("");
                    let money = 0;//计算总价格
                    let count = 0; //计数 多少种
                    let k = 0;
                    if (data == null || data == "" || data == "false") {
                        $(".car_t").html("购物车为空");
                        $(".price_sum span").html("0.00");
                    } else {
                        $(data).each(function (i, e) {
                            money += eval(e.price) * eval(e.quantity);
                            count += eval(e.quantity);
                            $(".cars").append("<li><div class='img'><a href='#'><img src='.././images/" + e.imgPath + "' width='58' height='58' /></a></div><div class='name'><a href='#'>" + e.name + "</a></div><div class='price'><font color='#ff4e00'>￥" + e.price + "</font> X" + e.quantity + "</div></li>")
                            $(".car_t").html("购物车 [ <span>" + data.length + "</span> ]");
                        });
                        $(".price_sum span").html(money.toFixed(2));
                    };
					if($("#MyDiv1").length > 0){
						$("#MyDiv1 .notice_c td:eq(1)").children("span").eq(1).html(data.length);
						$("#MyDiv1 .notice_c td:eq(1)").children("span").eq(2).html(count);
						$("#MyDiv1 .notice_c td:eq(1)").children("span").eq(3).html(money.toFixed(2));
					}
                }
            });
        }

        $(".i_car").click(function () {
            loadCar();
            return;
        });
        loadCar();
    });