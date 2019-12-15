<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath }/css/style.css"/>
    <%@include file=".././common/header.jsp" %>
    <%@include file=".././common/top.jsp" %>
    <script src="/statics/js/backend/backend.js"></script>
</head>
<body>
<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page=".././common/sidebar.jsp"></jsp:include>
        <div class="m_right" id="content">
            <p></p>
            <div class="mem_tit">订单明细列表</div>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;"
                   cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td width="20%">商品名称</td>
                    <td width="20%">商品图片</td>
                    <td width="25%">数量</td>
                    <td width="25%">价格</td>
                </tr>
                <c:forEach items="${requestScope.listOrderDetailShow }" var="orderDetailShow">
                    <tr>
                        <td>
                            <a href="/Product?action=queryProductDeatil&id=" target="_blank">
                                    ${orderDetailShow.name}
                            </a>
                        </td>
                        <td>
                            <img src="/files/${orderDetailShow.fileName}" width="50" height="50">
                        </td>
                        <td>${orderDetailShow.quantity}</td>
                        <td>${orderDetailShow.cost}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <%@include file=".././common/tail.jsp" %>
</div>
</body>
</html>


