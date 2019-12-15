<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page isELIgnored="false" %>
<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
    	var path = "${pageContext.request.contextPath }";
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/n_nav.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/select.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/num.js">
        var jq = jQuery.noConflict();
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/shade.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/BuyCarTwo.js"></script>
    <title>提交订单2</title>
</head>
<body>
    <!--Begin Header Begin-->
    <%@include file="common/header.jsp" %>
    <%@include file="common/top.jsp" %>
    <%@include file="common/nav.jsp" %>
    <!--End Menu End-->
    <div class="i_bg">
        <div class="content mar_20">
            <img src="${pageContext.request.contextPath }/images/img2.jpg" />
        </div>
        <!--Begin 第二步：确认订单信息 Begin -->
        <%--  <form action="${pageContext.request.contextPath }/Order/settleAccountsThree.do" method="post"> --%>
        <div class="content mar_20">
            <div class="two_bg">
                <div class="two_t">
                    <span class="fr">商品列表</span>
                </div>
                <table border="0" class="car_tab" style="width:1110px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="car_th" width="550">商品名称</td>
                        <td class="car_th" width="140">属性</td>
                        <td class="car_th" width="150">购买数量</td>
                        <td class="car_th" width="130">小计</td>
                        <td class="car_th" width="140">返还积分</td>
                    </tr>
                    <c:forEach items="${requestScope.cars }" var="car">
                        <tr>
                            <td>
                                <div class="c_s_img"><img
                                        src="${pageContext.request.contextPath }/images/${car.imgPath }" width="73"
                                        height="73" /></div><span>${car.name }</span>
                            </td>
                            <td align="center"><span>${car.properties }</span></td>
                            <td align="center"><span>${car.quantity }</span></td>
                            <td align="center" style="color:#ff4e00;">￥<span>
                                    <fmt:formatNumber pattern="0.00" value="${car.subtotal }" /></span></td>
                            <td align="center">26R</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="5" align="right" style="font-family:'Microsoft YaHei';">
                            商品总价：￥
                            <fmt:formatNumber pattern="0.00" value="${requestScope.money }" />；返还积分 56R
                        </td>
                    </tr>
                </table>

                <table border="0" class="peo_tab" style="width:1110px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="p_td" width="160">收货人姓名</td>
                        <td width="395"><span>${requestScope.user.loginName }</span></td>
                        <td class="p_td" width="160">电子邮件</td>
                        <td width="395">${requestScope.user.email }</td>
                    </tr>
                    <tr>
                        <td class="p_td">手机</td>
                        <td>${requestScope.user.mobile }</td>
                        <td class="p_td">最佳送货时间</td>
                        <td></td>
                    </tr>
                </table>
                <div class="two_t">
                    收获地址
                </div>
                <table border="0" class="car_tab" id="address_tab" style="width:1110px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="car_th" width="80"></td>
                        <td class="car_th" width="200">标志建筑</td>
                        <td class="car_th" width="370">详细地址</td>
                    </tr>
                   <c:forEach items="${requestScope.addrs }" var="addr">
                   		<tr>
	                        <td align="center"><input value="${addr.id }" type="radio" name="ch"/></td>
	                        <td align="center"><b>${addr.remark }</b></td>
	                        <td>${addr.address }</td>
                    	</tr>
                   </c:forEach>
                    <tr>
                 <td align="center"><input value="newAddr" type="radio" name="ch"/></td>
                        <td align="center"><input type="text" name="newRemark"  width="220px"></td>
                        <td ><input type="text" name="newAddr"></td>
                   </tr>
                </table>

                <table border="0" style="width:900px; margin-top:20px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="right">
                            该订单完成后，您将获得 <font color="#ff4e00">1815</font> 积分 ，以及价值 <font color="#ff4e00">￥0.00</font>
                            的红包 <br />
                            商品总价: <font color="#ff4e00">￥
                                <fmt:formatNumber pattern="0.00" value="${requestScope.money }" />
                            </font> + 配送费用: <font color="#ff4e00">￥15.00</font>
                        </td>
                    </tr>
                    <tr height="70">
                        <td align="right">
                            <b style="font-size:14px;">应付款金额：<span style="font-size:22px; color:#ff4e00;">￥
                                    <fmt:formatNumber pattern="0.00" value="${requestScope.money }" /></span></b>
                        </td>
                    </tr>
                    <tr height="70">
                        <td align="right"><a href="javascript:mySubmit()"><img
                            src="${pageContext.request.contextPath }/images/btn_sure.gif" /></a></td>
                    </tr>
                    </table>
            </div>
        </div>
        <%@include file="common/tail.jsp" %>
        <!--End Footer End -->
    </div>
</body>
</html>