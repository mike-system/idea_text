<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!DOCTYPE >
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/shade.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/lrscroll_1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/n_nav.js"></script>

    <title>商品展示</title>
</head>
<body>
<%@include file="common/header.jsp" %>
<%@include file="common/top.jsp" %>
<%@include file="common/nav.jsp" %>
<script type="text/javascript">

    //将当前的页面的页码传入过去
    function targetPage(currentPage) {


        //判断当前的页面和服务器计算出来的页面
        if (eval(currentPage) > eval("${requestScope.pagingInfo.totalPage }")) {
            return;
        }

        if (eval(currentPage) <= 0) {
            return;
        }
        <c:if test="${!empty param.id}">
            window.location.href = "${url}?currentPage=" + currentPage + "&id=" + ${param.id};
        </c:if>
        <c:if test="${!empty queryString}">
            window.location.href = "${url}?currentPage=" + currentPage + "&ipt=" + "${queryString}";
        </c:if>
    }
</script>

<input type="hidden" id="path" value="${pageContext.request.contextPath }"/>
<div class="i_bg">
    <!--Begin 筛选条件 Begin-->
    <!--End 筛选条件 End-->
    <div class="content mar_20">
        <div class="l_history">
            <div class="his_t">
                <span class="fl">浏览历史</span>
                <span class="fr"><a href="#">清空</a></span>
            </div>
            <ul>
                <li>
                    <div class="img"><a href="#"><img src="${pageContext.request.contextPath }/images/his_1.jpg"
                                                      width="185" height="162"/></a></div>
                    <div class="name"><a href="#">Dior/迪奥香水2件套装</a></div>
                    <div class="price">
                        <font>￥<span>368.00</span></font> &nbsp; 18R
                    </div>
                </li>
                <li>
                    <div class="img"><a href="#"><img src="${pageContext.request.contextPath }/images/his_2.jpg"
                                                      width="185" height="162"/></a></div>
                    <div class="name"><a href="#">Dior/迪奥香水2件套装</a></div>
                    <div class="price">
                        <font>￥<span>768.00</span></font> &nbsp; 18R
                    </div>
                </li>
            </ul>
        </div>
        <div class="l_list">
            <div class="list_t">
            	<span class="fl list_or">
                	<a href="#" class="now">默认</a>
                    <a href="#">
                    	<span class="fl">销量</span>                        
                        <span class="i_up">销量从低到高显示</span>
                        <span class="i_down">销量从高到低显示</span>                                                     
                    </a>
                    <a href="#">
                    	<span class="fl">价格</span>                        
                        <span class="i_up">价格从低到高显示</span>
                        <span class="i_down">价格从高到低显示</span>     
                    </a>
                    <a href="#">新品</a>
                </span>
                <span class="fr">共发现${requestScope.pagingInfo.data.size() }件</span>
            </div>

            <div class="list_c">
                <ul class="cate_list">
                    <c:forEach items="${requestScope.pagingInfo.data }" var="product">
                        <li>
                            <input type="hidden" class="n_ipt" value="1"/>
                            <div class="img"><a
                                    href="${pageContext.request.contextPath }/Product/showProduct.do?id=${product.id }"><img
                                    src="${pageContext.request.contextPath }/images/${product.fileName }" width="210"
                                    height="185"/></a></div>
                            <div class="price">
                                <font>￥<span>
	                            	<fmt:formatNumber pattern="0.00" type="text" minFractionDigits="2"
                                                      value="${product.price }"></fmt:formatNumber>
	                            </span></font> &nbsp; 26R ${product.id }
                            </div>
                            <div class="name"><a href="#">${product.name }</a></div>
                            <div class="carbg">
                                <a href="#" class="ss">收藏</a>
                                <a onclick="ShowDiv_1('MyDiv1','fade1',${product.id })" class="j_car">加入购物车</a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="pages">
                    <c:if test="${requestScope.pagingInfo.currentPage != 1}">
                        <a href="javascript:targetPage(1)" class="p_pre">首页</a><a
                            href="javascript:targetPage(${requestScope.pagingInfo.currentPage - 1 })"
                            class="p_pre">上一页</a>
                    </c:if>
                    <c:if test="${requestScope.pagingInfo.currentPage != requestScope.pagingInfo.totalPage}">
                        <a href="javascript:targetPage(${requestScope.pagingInfo.currentPage + 1 })"
                           class="p_pre">下一页</a>
                        <a href="javascript:targetPage(${requestScope.pagingInfo.totalPage })" class="p_pre">尾页</a>
                    </c:if>
                </div>
                <div class="pages">
                    共搜索到${requestScope.pagingInfo.total }件商品，共${requestScope.pagingInfo.totalPage }页，当前第${requestScope.pagingInfo.currentPage }页
                </div>
            </div>
        </div>
    </div>
    <%@include file="./common/tail.jsp" %>
</div>
<%@include file="common/black_overlay.jsp" %>
</body>
</html>
    