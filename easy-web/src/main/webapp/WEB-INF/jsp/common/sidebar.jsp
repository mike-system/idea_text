<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<div class="m_left">
    <div class="left_n">管理中心</div>
    <div class="left_m">
        <div class="left_m_t t_bg1">订单中心</div>
        <ul>
            <li><a
                    href="${pageContext.request.contextPath }/Order/memberOrder.do">我的订单</a></li>
            <li><a
                    href="${pageContext.request.contextPath }/Address/memberAddress.do">收货地址</a></li>
        </ul>
    </div>
    <div class="left_m">
        <div class="left_m_t t_bg2">会员中心</div>
        <ul>
            <li><a href="${pageContext.request.contextPath }/UserHome/userCenter.do">用户信息</a></li>
        </ul>
    </div>
    <div class="left_m">
        <div class="left_m_t t_bg3">账户中心</div>
        <ul>
            <li><a
                    href="${pageContext.request.contextPath }/UserHome/userMemberSafe.do">账户安全</a></li>
        </ul>
    </div>
    <div class="left_m">
        <div class="left_m_t t_bg4">新闻中心</div>
        <ul>
            <li><a href="${pageContext.request.contextPath }/News/newsList.do">新闻中心</a></li>
        </ul>
    </div>
    <c:if test="${sessionScope.user.type == 1 }">
        <div class="left_m">
            <div class="left_m_t t_bg4">网站管理</div>
            <ul>
                <li><a href="${pageContext.request.contextPath }/Admin/productHandlerAdmin.do">商品管理</a></li>
                <li><a href="${pageContext.request.contextPath }/Admin/updateOrAddProduct.do">添加商品</a></li>
                <li>
                    <a href="${pageContext.request.contextPath }/Admin/productCategoryHandlerAdmin.do">分类管理</a>
                </li>
                <li><a href="${pageContext.request.contextPath }/Admin/orderhandleAdmin.do">订单处理</a></li>
                <li><a href="${pageContext.request.contextPath }/Admin/userList.do">用户管理</a></li>
            </ul>
        </div>
    </c:if>

</div>
