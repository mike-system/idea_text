<%--
  Created by IntelliJ IDEA.
  User: nongfu
  Date: 2019/11/6
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
<html>
<head>

    <script>
        var path = "${pageContext.request.contextPath }";
        var typeId;
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/n_nav.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/num.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/shade.js">
        var jq = jQuery.noConflict();
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/shade.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/ByCarOne.js"></script>
    <title>结算</title>
</head>
<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath }"/>
<!--Begin Header Begin-->
<%@include file="common/header.jsp" %>
<%@include file="common/top.jsp" %>
<jsp:include page="common/nav.jsp"/>
<!--Begin Menu Begin-->
<!--End Menu End-->
<div class="i_bg">
    <div class="content mar_20">
        <img src="${pageContext.request.contextPath }/images/img1.jpg"/>
    </div>
    <!--Begin 第一步：查看购物车 Begin -->
    <div class="content mar_20">
        <table border="0" class="car_tab" style="width:1200px; margin-bottom:50px;" cellspacing="0" cellpadding="0">
            <tr>
                <td class="car_th" width="490">商品名称</td>
                <td class="car_th" width="140">属性</td>
                <td class="car_th" width="150">购买数量</td>
                <td class="car_th" width="130">小计</td>
                <td class="car_th" width="140">返还积分</td>
                <td class="car_th" width="150">操作</td>
            </tr>
            <c:forEach items="${requestScope.cars }" var="car">
                <tr style="font-size: 12px">
                    <td>
                        <div class="c_s_img"><img src="${pageContext.request.contextPath }/images/${car.imgPath }"
                                                  width="73" height="73"/></div>
                            ${car.name }
                    </td>
                    <td align="center">颜色：${car.quantity }</td>
                    <td align="center">
                        <div class="c_num">
                            <input type="button" value="" onclick="jianUpdate1(this,${car.id });" class="car_btn_1"/>
                            <input type="text" value="${car.quantity }" name="" class="car_ipt"
                                   onchange="changeUpdate(this,${car.id },this.value)"/>
                            <input type="button" value="" onclick="addUpdate1(this,${car.id });" class="car_btn_2"/>
                        </div>
                    </td>
                    <td align="center" style="color:#ff4e00;">
                        ￥<span class="subtotal">
		            	<fmt:formatNumber pattern="0.00" value="${car.subtotal }" minFractionDigits="2" type="text"/>
		            </span>
                        <input type="hidden" class="price" value="${car.price }">
                    </td>
                    <td align="center">26R</td>
                    <td align="center"><a onclick="delId =${car.id };ShowDiv('MyDiv','fade',${car.id })" href="#">删除</a>&nbsp;
                        &nbsp; <a href="#">加入收藏</a></td>
                </tr>
            </c:forEach>
            <tr height="70">
                <td colspan="6" style="font-family:'Microsoft YaHei'; border-bottom:0;">
                    <label class="r_rad"><a class="r_txt"
                                            href="javascript:if(confirm('确定要清空购物车吗')){ clearCar()}">清空购物车</a></label>
                    <span class="fr">商品总价：<b style="font-size:22px; color:#ff4e00;">￥<span id="money"><fmt:formatNumber
                            pattern="0.00" value="${requestScope.money }" minFractionDigits="2" type="text"/></span></b></span>
                </td>
            </tr>
            <tr valign="top" height="150">
                <td colspan="6" align="right">
                    <a href="javascript:history.go(-2);location.reload();"><img
                            src="${pageContext.request.contextPath }/images/close.gif"/></a>&nbsp; &nbsp; <a
                        href="${pageContext.request.contextPath }/Car/settleAccountsTwoHandler.do"><img
                        src="${pageContext.request.contextPath }/images/buy2.gif"/></a>
                </td>
            </tr>
        </table>
    </div>
    <!--End 第一步：查看购物车 End-->
    <!--Begin 弹出层-删除商品 Begin-->
    <div id="fade" class="black_overlay"></div>
    <div id="MyDiv" class="white_content">
        <div class="white_d">
            <div class="notice_t">
                <span class="fr" style="margin-top:10px; cursor:pointer;" onclick="CloseDiv('MyDiv','fade')"><img
                        src="${pageContext.request.contextPath }/images/close.gif"/></span>
            </div>
            <div class="notice_c">
                <table border="0" align="center" style="font-size:16px;" cellspacing="0" cellpadding="0">
                    <tr valign="top">

                        <td>您确定要把该商品移除购物车吗？</td>
                    </tr>
                    <tr height="50" valign="bottom">
                        <td><a href="javascript:delThisCar()" class="b_sure">确定</a><a
                                href="javascript:CloseDiv('MyDiv','fade')" class="b_buy">取消</a></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <!--End 弹出层-删除商品 End-->
    <!-- 底部 -->
    <%@include file="common/tail.jsp" %>
</div>

</body>

</html>

