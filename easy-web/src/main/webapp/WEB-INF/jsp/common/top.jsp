<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script type="text/javascript">
    var path = "${pageContext.request.contextPath }";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/top.js	"></script>

<script type="text/javascript">
    function seek() {
        var $val =  $("#ipt").val();
        if($val == null || $val == undefined || $.trim($val) == ""){
            return false;
        }
    }
</script>

<div class="top">
    <div class="logo"><a href="${pageContext.request.contextPath }/index.do"><img
            src="${pageContext.request.contextPath }/images/logo.png" /></a></div>
    <div class="search">
        <form action="${pageContext.request.contextPath }/Product/seekProductList.do" method="get" onsubmit="return seek()">
            <input type="text" id="ipt" name="ipt" value="${queryString}" class="s_ipt" />
            <input type="submit" value="搜索" class="s_btn" />
        </form>
    </div>
    <div class="i_car">
        <div class="car_t"></div>
        <div class="car_bg">
            <shiro:guest>
                <div class="un_login">还未登录！<a href="${pageContext.request.contextPath }/userAccount/loginUI.do"
                                              style="color:#ff4e00;">马上登录</a> 查看购物车！</div>
            </shiro:guest>
            <shiro:user>
                <div class="un_login">我的购物车<a href="${pageContext.request.contextPath }/Order/memberOrder.do"
                                              style="color:#ff4e00;">去我的订单</a></div>
            </shiro:user>
            <ul class="cars"></ul>
            <div class="price_sum">共计&nbsp; <font color="#ff4e00">￥</font><span></span></div>
            <div class="price_a"><a href="${pageContext.request.contextPath }/Car/settleAccountsOne.do">去购物车结算</a></div>
            <!--End 购物车已登录 End-->
        </div>
    </div>
</div>