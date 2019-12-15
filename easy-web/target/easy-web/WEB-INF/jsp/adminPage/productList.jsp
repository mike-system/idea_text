<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@include file=".././common/header.jsp" %>
    <%@include file=".././common/top.jsp" %>
    <script src="${pageContext.request.contextPath }/statics/js/backend/backend.js"></script>

    <script type="text/javascript">
        function deleteById(id) {
            //删除 判断传入过来的id是否为空
            if (id == null || id == undefined || id == "") {
                alert("数据出错,删除失败");
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath }/Admin/productDel.do",
                type: "get",
                data: {
                    "id": id
                },
                dataType: "text",
                success: function (data) {

                    if (data == "删除成功") {
                        alert("删除成功");
                        window.location.reload();
                        return;
                    }

                    alert(data);
                }
            });
        }
    </script>

</head>
<body>
<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page=".././common/sidebar.jsp"></jsp:include>
        <div class="m_right" id="content">
            <div class="mem_tit">商品列表</div>
            <br>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;"
                   cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td width="10%">商品名称</td>
                    <td width="10%">商品图片</td>
                    <td width="5%">库存</td>
                    <td width="10%">价格</td>
                    <td width="10%" colspan="2">操作</td>
                </tr>
                <c:forEach items="${pageProduct.data }" var="pro">
                    <tr>
                        <td>${pro.name}</td>
                        <td>
                            <img src="${pageContext.request.contextPath }/images/${pro.fileName}" width="50"
                                 height="50"/>
                        </td>
                        <td>${pro.stock}</td>
                        <td>${pro.price}</td>
                        <td>
                            <a href="${pageContext.request.contextPath }/Admin/updateOrAddProduct.do?id=${pro.id}">修改</a>
                        </td>
                        <td><a href="javascript:void(0);" onclick="deleteById('${pro.id}');">删除</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="pages">
                <c:if test="${requestScope.pageProduct.currentPage > 1}">
                    <a
                            href="${pageContext.request.contextPath }/Admin/productHandlerAdmin.do?currentPage=1"
                            class="p_pre">首页</a>
                    <a
                            href="${pageContext.request.contextPath }/Admin/productHandlerAdmin.do?currentPage=${requestScope.pageProduct.currentPage - 1 }"
                            class="p_pre">上一页</a>
                </c:if>
                <c:if test="${requestScope.pageProduct.currentPage < requestScope.pageProduct.totalPage}">
                    <a
                            href="${pageContext.request.contextPath }/Admin/productHandlerAdmin.do?currentPage=${requestScope.pageProduct.currentPage + 1 }"
                            class="p_pre">下一页</a>
                    <a
                            href="${pageContext.request.contextPath }/Admin/productHandlerAdmin.do?currentPage=${requestScope.pageProduct.totalPage }"
                            class="p_pre">尾页</a>
                </c:if>
            </div>
            <div class="pages">
                共搜索到${requestScope.pageProduct.total }条订单，共${requestScope.pageProduct.totalPage }页，当前第${requestScope.pageProduct.currentPage }页
            </div>

        </div>
    </div>
    <%@include file=".././common/tail.jsp" %>
</div>
</body>
</html>


