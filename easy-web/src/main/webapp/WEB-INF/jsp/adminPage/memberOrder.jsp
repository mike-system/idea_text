<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <title>订单处理</title>
    <script>
        var path = "${pageContext.request.contextPath }";

        function targetPage(currentPage) {
            if (currentPage == null || $.trim(currentPage) == "" || currentPage == undefined) {
                currentPage = "1";
            }
            window.location.href = "${pageContext.request.contextPath }/Admin/orderhandleAdmin.do?currentPage="
                + currentPage;
        }

        //发货  需要判断当前操作哦是否是管理员 <font color="#ff4e00">已确认</font>
        function sendOrder(orderId, currentObj) {
            $.ajax({
                url: path + "/Admin/sendOrder.do",
                data: {
                    "orderId": orderId,
                },
                dataType: "text",
                success: function (data) {
                    if (eval(data) == 0) {
                        alert("发货成功");
                        $(currentObj).parent("td").html("<font color='#ff4e00'>已确认</font>");
                        return;
                    }
                    if (eval(data) == 1) {
                        alert("系统错误，请稍后再试");
                        return;
                    }
                    if (eval(data) == 2) {

                        if (confirm("您还未登录，确认登录吗？")) {
                            window.location.href = path + "/index.jsp";
                        }

                        return;
                    }
                    if (eval(data) == 3) {
                        alert("权限不足，请联系管理员");
                        return;
                    }
                    if (eval(data) == 4) {

                        alert("系统错误，请联系系管理员");
                        return;
                    }
                }
            });
        }
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/memberOrder.js"></script>
</head>
<body>
<input type="hidden" id="path"
       value="${pageContext.request.contextPath }"/>
<!--Begin Header Begin-->
<%@include file=".././common/header.jsp" %>
<%@include file=".././common/top.jsp" %>

<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page=".././common/sidebar.jsp"></jsp:include>
        <div class="m_right">
            <div style="height: 300px">
                <div class="mem_tit">我的订单</div>
                <table border="0" class="order_tab"
                       style="width: 930px; text-align: center; margin-bottom: 30px;"
                       cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="20%">订单号</td>
                        <td width="25%">下单时间</td>
                        <td width="15%">订单总金额</td>
                        <td width="25%">订单状态</td>
                        <td width="15%">操作</td>
                    </tr>
                    <c:forEach items="${requestScope.pageOrders.data }" var="order">
                        <tr>
                            <td><font color="#ff4e00"><a
                                    href="javascript:window.location.href='${pageContext.request.contextPath }/Order/orderShow.do?orderId=${order.id }'">${order.serialNumber }</a></font>
                            </td>
                            <td><fmt:formatDate value="${order.createTime }"
                                                pattern="yyyy-MM-dd HH:mm:ss"/></td>

                            <td align="right"><fmt:formatNumber pattern="0.00" maxFractionDigits="2"
                                                                value="${order.cost }" type="number"/></td>
                            <td><c:choose>
                                <c:when test="${order.status == 0}">
                                    已确定,未付款,未发货
                                </c:when>
                                <c:when test="${order.status == 2}">
                                    已确定,已付款,未发货
                                </c:when>
                                <c:when test="${order.status == 4}">
                                    已确定,已付款,已发货
                                </c:when>
                            </c:choose></td>
                            <td align="left"><c:if test="${order.status == 4}">
                                <font color="#ff4e00">已确认</font>
                            </c:if> <c:if test="${order.status != 4}">
                                <a href="javascript:delOrder(${order.id })">取消</a>&nbsp;&nbsp;
                                <c:if test="${order.status == 2}">
                                    <a onclick="sendOrder(${order.id },this)">发货</a>
                                </c:if>
                            </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="pages">
                <c:if test="${requestScope.pageOrders.currentPage != 1}">
                    <a href="javascript:targetPage(1)" class="p_pre">首页</a>
                    <a
                            href="javascript:targetPage(${requestScope.pageOrders.currentPage - 1 })"
                            class="p_pre">上一页</a>
                </c:if>
                <c:if
                        test="${requestScope.pageOrders.currentPage != requestScope.pageOrders.totalPage}">
                    <a
                            href="javascript:targetPage(${requestScope.pageOrders.currentPage + 1 })"
                            class="p_pre">下一页</a>
                    <a
                            href="javascript:targetPage(${requestScope.pageOrders.totalPage })"
                            class="p_pre">尾页</a>
                </c:if>
            </div>
            <div class="pages">
                共搜索到${requestScope.pageOrders.total }条订单，共${requestScope.pageOrders.totalPage }页，当前第${requestScope.pageOrders.currentPage }页
            </div>

        </div>
        <%@include file=".././common/tail.jsp" %>
    </div>
</div>
</body>

</html>
