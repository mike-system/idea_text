<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@include file="common/header.jsp" %>
    <%@include file="common/top.jsp" %>
</head>
<body>
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page="common/sidebar.jsp"></jsp:include>
        <div class="m_right">
            <p></p>
            <div class="mem_tit">${news.title}</div>
            <p style="padding:0 40px; margin:0 auto 20px auto;">
                ${news.content}
            </p>
        </div>
    </div>
    <!--End 用户中心 End-->
    <%@include file="common/tail.jsp" %>
    <!--End Footer End -->
</div>
</body>
</html>
