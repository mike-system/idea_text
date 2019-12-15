<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>
<script type="text/javascript">

    String.prototype.endWith = function (endStr) {
        var d = this.length - endStr.length;
        return (d >= 0 && this.lastIndexOf(endStr) == d);
    }
    //控制布局
    $(function () {
        var zjI = 0;
        $(".zj").each(function () {
            $(this).css("top", (zjI * 40) + "px");
            zjI = zjI - 1;
        })

        var url = window.location.pathname;
        if (url.endWith("index.do")) {

            $("#navId").removeClass("none");

        }

    })
</script>

<div class="menu_bg">

    <div class="menu">
        <div class="nav">
            <div class="nav_t">全部商品分类</div>
            <div id="navId" class="leftNav none">
<%--                <div id="navId" class="leftNav none">--%>
                <ul>
                    <c:forEach items="${proList }" var="pro1" step="1" begin="0" varStatus="sta">

                        <c:if test="${pro1.parentId == 0 and pro1.type==1 }">
                            <li>
                                <div class="fj">
                                    <span class="n_img"><span></span><img src="images/nav2.png"/></span>
                                    <span class="fl">${pro1.name }</span>
                                </div>
                                <div class="zj">
                                    <div class="zj_l">
                                        <c:forEach items="${proList }" var="pro2">
                                            <c:if test="${pro2.type == 2 and pro2.parentId == pro1.id}">
                                                <div class="zj_l_c">
                                                    <h2>${pro2.name }</h2>
                                                    <c:forEach items="${proList }" var="pro3">
                                                        <c:if test="${pro3.type == 3 and pro3.parentId == pro2.id}">
                                                            <a href="${pageContext.request.contextPath }/Product/showListProductByCategoryLevel3Id.do?id=${pro3.id }">${pro3.name
                                                                    }</a>|
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="zj_r">
                                        <a href="#"><img src="images/n_img1.jpg" width="236" height="200"/></a>
                                        <a href="#"><img src="images/n_img2.jpg" width="236" height="200"/></a>
                                    </div>
                                </div>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <ul class="menu_r">
            <li><a href="${pageContext.request.contextPath }/index.do">首页</a></li>
            <c:forEach items="${proList }" var="pro1">
                <c:if test="${pro1.type == 1 }">
                    <li>
                        <a href="${pageContext.request.contextPath }/Product/showListProductByCategoryLevel1Id.do?id=${pro1.id }">${pro1.name }</a>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
        <div class="m_ad">中秋送好礼！</div>
    </div>
</div>