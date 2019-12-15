<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>


    <script>
        var path = "${pageContext.request.contextPath }";
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/select.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/form-js.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/myJs/MemberSafe.js"></script>

    <title>账户安全</title>
</head>
<body>
<%@include file="common/header.jsp" %>
<%@include file="common/top.jsp" %>
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page="./common/sidebar.jsp"></jsp:include>
        <div class="m_right">
            <p></p>
            <div class="mem_tit">账户安全</div>
            <div class="m_des">
                <form action="${pageContext.request.contextPath }/userAccount/updateMobile.do" method="post"
                      id="modifyMobile" onsubmit="return updateMobile()">
                    <table border="0" style="width:880px;" cellspacing="0" cellpadding="0">
                        <tr height="45">
                            <td width="80" align="right">原手机 &nbsp; &nbsp;</td>
                            <td><input type="text" value="" id="oldMobile" name="oldMobile" class="add_ipt"
                                       style="width:180px;"/>&nbsp; <font color="#ff4e00" id="message1">*</font></td>
                        </tr>
                        <tr height="45">
                            <td align="right">新手机 &nbsp; &nbsp;</td>
                            <td><input type="text" name="newMobile" id="newMobile" value="" class="add_ipt"
                                       style="width:180px;"/>&nbsp; <font color="#ff4e00" id="message2">*</font></td>
                        </tr>
                        <tr height="50">
                            <td>&nbsp;</td>
                            <td><input type="submit" value="确认修改" class="btn_tj"/>&nbsp;&nbsp;&nbsp;&nbsp;<button
                                    type="reset" class="btn_tj">取消
                            </button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

            <div class="m_des">
                <form action="${pageContext.request.contextPath }/userAccount/updateEmail.do" method="post"
                      id="modifyEmail" onsubmit="return updateEmail()">
                    <table border="0" style="width:880px;" cellspacing="0" cellpadding="0">
                        <tr height="45">
                            <td width="80" align="right">原邮箱 &nbsp; &nbsp;</td>
                            <td><input type="text" value="" name="oldEmail" id="oldEmail" class="add_ipt"
                                       style="width:180px;"/>&nbsp; <font color="#ff4e00" id="message3">*</font></td>
                        </tr>
                        <tr height="45">
                            <td align="right">新邮箱 &nbsp; &nbsp;</td>
                            <td><input type="text" value="" name="newEmail" id="newEmail" class="add_ipt"
                                       style="width:180px;"/>&nbsp; <font color="#ff4e00" id="message4">*</font></td>
                        </tr>
                        <tr height="50">
                            <td>&nbsp;</td>
                            <td><input type="submit" value="确认修改" class="btn_tj"/>&nbsp;&nbsp;&nbsp;&nbsp;<button
                                    type="reset" class="btn_tj">取消
                            </button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

            <div class="m_des">
                <form action="#" method="post" id="modifyPassword">
                    <table border="0" style="width:880px;" cellspacing="0" cellpadding="0">
                        <tr height="45">
                            <td width="80" align="right">原密码 &nbsp; &nbsp;</td>
                            <td><input type="password" value="" class="add_ipt" id="oldPassword" name="oldPassword"
                                       style="width:180px;"/>&nbsp; <font color="#ff4e00" id="message5">*</font></td>
                        </tr>
                        <tr height="45">
                            <td align="right">新密码 &nbsp; &nbsp;</td>
                            <td><input type="password" value="" class="add_ipt" id="newPassword" name="newPassword"
                                       style="width:180px;"/>&nbsp; <font color="#ff4e00" id="message6">*</font></td>
                        </tr>
                        <tr height="45">
                            <td align="right">确认密码 &nbsp; &nbsp;</td>
                            <td><input type="password" value="" class="add_ipt" id="checkPassword" name="checkPassword"
                                       style="width:180px;"/>&nbsp; <font color="#ff4e00" id="message7">*</font></td>
                        </tr>
                        <tr height="50">
                            <td>&nbsp;</td>
                            <td><input value="确认修改" id="subPassword" onclick="submitForm()" class="btn_tj"
                                       style="width: 85px"/>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset" class="btn_tj">
                                取消
                            </button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
    <%@include file="./common/tail.jsp" %>
</div>
</body>
</html>
