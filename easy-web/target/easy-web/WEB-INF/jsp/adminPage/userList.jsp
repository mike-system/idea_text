<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<link type="text/css" rel="stylesheet"
      href="${pageContext.request.contextPath }/css/style.css"/>
<head>
    <script src="${ctx}/statics/js/backend/backend.js"></script>

    <script type="text/javascript">

        function deleteUserId(id) {
            if (confirm("您确定要删除吗")) {
                $.ajax({
                    url: "${pageContext.request.contextPath }/Admin/delUser.do",
                    type: "post",
                    data: {
                        "id": id
                    },
                    dataType: "text",
                    success: function (data) {
                        alert(data);
                        if (data == "删除成功") {
                            window.location.reload();
                        }
                    }
                })
            }
        }

    </script>

</head>
<body>
<%@include file=".././common/header.jsp" %>
<%@include file=".././common/top.jsp" %>
<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page=".././common/sidebar.jsp"></jsp:include>
        <div class="m_right" id="content">
            <div class="mem_tit">用户列表</div>
            <p align="right">
                <a href="${pageContext.request.contextPath }/Admin/updateUserOrAdd.do" class="add_b">添加用户</a>
                <br>
            </p>
            <br>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;"
                   cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td width="10%">用户名称</td>
                    <td width="10%">真实姓名</td>
                    <td width="5%">性别</td>
                    <td width="5%">类型</td>
                    <td width="5%" colspan="2">操作</td>
                </tr>
                <c:forEach items="${requestScope.pageUser.data }" var="user">
                    <tr>
                        <td>${user.loginName}</td>
                        <td>${user.userName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.sex==1}">
                                    男
                                </c:when>
                                <c:otherwise>
                                    女
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${user.type==1}">
                                    管理员
                                </c:when>
                                <c:otherwise>
                                    用户
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath }/Admin/updateUserOrAdd.do?id=${user.id}">修改</a>
                        </td>
                        <td>
                            <c:if test="${sessionScope.user.id != user.id }">
                                <c:if test="${user.id !=2  }">
                                    <a onclick="deleteUserId('${user.id}');" target="_blank">删除</a>
                                </c:if>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="pages">
                <c:if test="${requestScope.pageUser.currentPage > 1}">
                    <a
                            href="${pageContext.request.contextPath }/Admin/userList.do?currentPage=1"
                            class="p_pre">首页</a>
                    <a
                            href="${pageContext.request.contextPath }/Admin/userList.do?currentPage=${requestScope.pageUser.currentPage - 1 }"
                            class="p_pre">上一页</a>
                </c:if>
                <c:if test="${requestScope.pageUser.currentPage < requestScope.pageUser.totalPage}">
                    <a
                            href="${pageContext.request.contextPath }/Admin/userList.do?currentPage=${requestScope.pageUser.currentPage + 1 }"
                            class="p_pre">下一页</a>
                    <a
                            href="${pageContext.request.contextPath }/Admin/userList.do?currentPage=${requestScope.pageUser.totalPage }"
                            class="p_pre">尾页</a>
                </c:if>
            </div>
            <div class="pages">
                共搜索到${requestScope.pageUser.total }条订单，共${requestScope.pageUser.totalPage }页，当前第${requestScope.pageUser.currentPage }页
            </div>
        </div>
    </div>
    <%@include file=".././common/tail.jsp" %>
</div>
</body>
</html>
