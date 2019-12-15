<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/n_nav.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/num.js">
        var jq = jQuery.noConflict();
    </script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/shade.js"></script>

    <title>尤洪</title>
</head>
<%@include file="common/header.jsp" %>
<%@include file="common/top.jsp" %>
<%@include file="common/nav.jsp" %>
<!--End Menu End-->
<div class="i_bg">
    <div class="content mar_20">
        <img src="images/img3.jpg"/>
    </div>

    <!--Begin 第三步：提交订单 Begin -->
    <div class="content mar_20">


        <c:choose>
            <c:when test="${requestScope.order.status == 4 }">
                <div class="warning">
                    <table border="0" style="width: 1000px; text-align: center;"
                           cellspacing="0" cellpadding="0">
                        <tr height="35">
                            <td style="font-size: 18px;">感谢您在本店购物！您的订单已提交成功，请记住您的订单号: <font
                                    color="#ff4e00">${requestScope.order.serialNumber }</font>
                            </td>
                        </tr>
                        <tr>
                            <td
                                    style="font-size: 14px; font-family: '宋体'; padding: 10px 0 20px 0; border-bottom: 1px solid #b6b6b6;">
                                您选定的配送方式为: <font color="#ff4e00">申通快递</font>； &nbsp;
                                &nbsp;您选定的支付方式为: <font color="#ff4e00">支付宝</font>； &nbsp;
                                &nbsp;您的应付款金额为: <font color="#ff4e00">￥<fmt:formatNumber
                                    pattern="0.00" minFractionDigits="2"
                                    value="${requestScope.order.cost }"/></font>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 20px 0 30px 0; font-family: '宋体';">银行名称
                                收款人信息：全称 ${requestScope.order.loginname } ；帐号或地址
                                    ${requestScope.order.userAddress } ；开户行 ×××。 <br/>
                                注意事项：办理电汇时，请在电汇单“汇款用途”一栏处注明您的订单号。
                            </td>
                        </tr>
                        <tr>
                            <td><a href="${pageContext.request.contextPath }/index.do">首页</a> &nbsp; &nbsp; <a
                                    href="#">用户中心</a></td>
                        </tr>
                    </table>
                </div>
            </c:when>

            <c:when test="${requestScope.order.status == 2 }">

                <div class="warning">

                    <table border="0" style="width: 1000px; text-align: center;"
                           cellspacing="0" cellpadding="0">
                        <tr height="35">
                            <td style="font-size: 18px;">感谢您在本店购物！您的订单已提交成功，请记住您的订单号: <font
                                    color="#ff4e00">${requestScope.order.serialNumber }</font>
                            </td>
                        </tr>
                        <tr>
                            <td
                                    style="font-size: 14px; font-family: '宋体'; padding: 10px 0 20px 0; border-bottom: 1px solid #b6b6b6;">
                                您选定的配送方式为: <font color="#ff4e00">申通快递</font>； &nbsp;
                                &nbsp;您选定的支付方式为: <font color="#ff4e00">银行卡</font>； &nbsp;
                                &nbsp;您的应付款金额为: <font color="#ff4e00">￥<fmt:formatNumber
                                    pattern="0.00" minFractionDigits="2"
                                    value="${requestScope.order.cost }"/></font>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 20px 0 30px 0; font-family: '宋体';">
                                支付宝网站(www.alipay.com) 是国内先进的网上支付平台。<br/>
                                支付宝收款接口：在线即可开通，零预付，免年费，单笔阶梯费率，无流量限制。<br/> <a href="#"
                                                                             style="color: #ff4e00;">立即在线申请</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="btn_u"
                                     style="margin: 0 auto; padding: 0 20px; width: 120px;">
                                    <a href="#">立即使用支付宝支付</a>
                                </div>
                                <a href="#">首页</a> &nbsp; &nbsp; <a href="#">用户中心</a>
                            </td>
                        </tr>
                    </table>
                </div>

            </c:when>
            <c:when test="${requestScope.order.status == 1 }">
                <div class="warning">
                    <table border="0" style="width: 1000px; text-align: center;"
                           cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <p style="font-size: 22px;">提示 !</p> <b
                                    style="color: #ff4e00; font-size: 16px; font-family: '宋体';">您的余额不足以支付整个订单，请选择其他支付方式</b>
                                <div class="backs">
                                    <a href="#">返回上一页</a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </c:when>
        </c:choose>
    </div>
    <!--End 第三步：提交订单 End-->
    <%@include file="common/tail.jsp" %>
</div>

</body>

</html>