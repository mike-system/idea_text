<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>

<html>
<head>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath }/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script src="${pageContext.request.contextPath }/statics/js/backend/backend.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/regist.js"></script>
    <script>
        var path = "${pageContext.request.contextPath }";
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
            <div class="mem_tit">
                <c:choose>
                    <c:when test="${empty requestScope.user.id || requestScope.user.id==0}">
                        添加用户
                    </c:when>
                    <c:otherwise>
                        修改用户
                    </c:otherwise>
                </c:choose>
            </div>
            <br>
            <form method="post" id="formId">
                <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="135" align="right">用户姓名</td>
                        <td colspan="3" style="font-family:'宋体';">
                            <input type="text" value="${requestScope.user.loginName }" class="add_ipt"
                                   name="loginname"/>
                            <input type="hidden" value="${user.id}" name="userId"/>
                            <span id="message1" class="checkMess"></sapn>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">真实姓名</td>
                        <td>
                            <input type="text" value="${requestScope.user.userName}" class="add_ipt" name="userName"/>
                            <span id="message7" class="checkMess"></sapn>
                        </td>
                    </tr>
                    <c:if test="${empty requestScope.user.id ||  requestScope.user.id==0}">
                        <tr>
                            <td width="135" align="right">密码</td>
                            <td>
                                <input type="password" value="" class="add_ipt" name="password"/>
                                <span id="message2" class="checkMess"></sapn>
                            </td>
                        </tr>
                        <tr>
                            <td width="135" align="right">确认密码</td>
                            <td>
                                <input type="password" value="" class="add_ipt" name="password"/>
                                <span id="message3" class="checkMess"></sapn>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td width="135" align="right">身份证号</td>
                        <td>
                            <input type="text" value="${requestScope.user.identityCode}" class="add_ipt"
                                   name="identityCode"
                                   id="identityCode"/>
                            <span id="message8" class="checkMess"></sapn>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">电子邮箱</td>
                        <td>
                            <input type="text" value="${user.email}" class="add_ipt" name="email" id="email"/>
                            <span id="message4" class="checkMess"></sapn>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">手机</td>
                        <td>
                            <input type="text" value="${requestScope.user.mobile}" class="add_ipt" name="mobile"
                                   id="mobile"/>
                            <span id="message5" class="checkMess"></sapn>
                        </td>
                    </tr>
                    <c:if test="${requestScope.user.id!=2}">
                        <tr>
                            <td width="135" align="right">用户类型</td>
                            <td>
                                <select name="type">
                                    <option value="1"
                                            <c:if test="${requestScope.user.type==1}">selected="selected"</c:if>>管理员
                                    </option>
                                    <option value="0"
                                            <c:if test="${requestScope.user.type==0}">selected="selected"</c:if>>普通用户
                                    </option>
                                </select>
                            </td>
                        </tr>
                    </c:if>

                    <tr>
                        <td></td>
                        <td>
                            <c:choose>
                                <c:when test="${empty requestScope.user.id || requestScope.user.id==0}">
                                    <input type="button" value="添加用户" class="s_btn" onclick="addUser()">
                                </c:when>
                                <c:otherwise>
                                    <input type="button" value="修改信息" class="s_btn" onclick="addUser()">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <%@include file=".././common/tail.jsp" %>
</div>
</body>
</html>


