<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet"
      href="${pageContext.request.contextPath }/css/style.css"/>
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
            <div class="mem_tit">资讯列表</div>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;"
                   cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td width="20%">文章标题</td>
                    <td width="25%">创建时间</td>
                </tr>
                <c:forEach items="${requestScope.pageNews.data}" var="news">
                    <tr>
                        <td>
                            <a href="${pageContext.request.contextPath }/News/newsShow.do?id=${news.id}">${news.title}</a>
                        </td>
                        <td>${news.createTime}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="pages">
                <c:if test="${requestScope.pageNews.currentPage > 1}">
                    <a
                            href="${pageContext.request.contextPath }/News/newsList.do?currentPage=1"
                            class="p_pre">首页</a>
                    <a
                            href="${pageContext.request.contextPath }/News/newsList.do?currentPage=${requestScope.pageNews.currentPage - 1 }"
                            class="p_pre">上一页</a>
                </c:if>
                <c:if test="${requestScope.pageNews.currentPage < requestScope.pageNews.totalPage}">
                    <a
                            href="${pageContext.request.contextPath }/News/newsList.do?currentPage=${requestScope.pageNews.currentPage + 1 }"
                            class="p_pre">下一页</a>
                    <a
                            href="${pageContext.request.contextPath }/News/newsList.do?currentPage=${requestScope.pageNews.totalPage }"
                            class="p_pre">尾页</a>
                </c:if>
            </div>
            <div class="pages">
                共搜索到${requestScope.pageNews.total }条订单，共${requestScope.pageNews.totalPage }页，当前第${requestScope.pageNews.currentPage }页
            </div>

        </div>
    </div>
    <%@include file="common/tail.jsp" %>
</div>
</body>

</html>
