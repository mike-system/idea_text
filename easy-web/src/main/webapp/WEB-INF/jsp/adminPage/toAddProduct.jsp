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

    <script type="text/javascript">
        function queryProductCategoryList(currentObj, nextType) {
            $.ajax({
                url: "${pageContext.request.contextPath}/Admin/productCategoryModify.do",
                data: {
                    "parentId": $(currentObj).val(),
                    "type": nextType,
                },
                dataType: "Json",
                success: function (data) {
                    if (eval(nextType) == 1) {
                        $("#productCategoryLevel2").html("<option value='0' selected='selected'>请选择...</option>");
                        $("#productCategoryLevel3").html("<option value='0' selected='selected'>请选择...</option>");
                        $.each(data, function (i, e) {
                            $("#productCategoryLevel2").append("<option value=" + e.id + ">" + e.name + "</option>");
                        });
                    }

                    if (eval(nextType) == 2) {
                        $("#productCategoryLevel3").html("<option value='0' selected='selected'>请选择...</option>");
                        $.each(data, function (i, e) {
                            $("#productCategoryLevel3").append("<option value=" + e.id + ">" + e.name + "</option>");
                        });
                    }
                }
            });
        }


        //检查数据的正确性
        function checkProduct() {
            var val1 = $("#productCategoryLevel1").val();
            var val2 = $("#productCategoryLevel2").val();
            var val3 = $("#productCategoryLevel3").val();
            var proName = $("#proName").val();
            var price = $("#price").val();
            var stock = $("#stock").val();
            var re = /[1−9]+[0−9]*]*/;
            var floatRe = /^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/;
            if (!re.test(stock)) {
                alert("请输入整数！");
                return false;
            }

            if (!re.test(stock)) {
                alert("请输入整数！");
                return false;
            }

            if (!floatRe.test(price)) {
                alert("请输入浮点数！");
                return false;
            }

            if (val1 == null || val1 == "" || val1 == undefined || eval(val1) == 0) {
                alert("一级分类不能为空");
                return false;
            }
            if (val2 == null || val2 == "" || val2 == undefined || eval(val2) == 0) {
                alert("二级分类不能为空");
                return false;
            }
            if (val3 == null || val3 == "" || val3 == undefined || eval(val3) == 0) {
                alert("三级分类不能为空");
                return false;
            }
            if (proName == null || proName == "" || val3 == undefined) {
                alert("商品名不能为空");
                return false;
            }
            if (price == null || price == "" || price == undefined) {
                alert("商品价格不能为空");
                return false;
            }
            if (stock == null || stock == "" || stock == undefined || eval(stock) < 0) {
                alert("商品数量不能不能为空或小于0");
                return false;
            }
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
            <div class="mem_tit">
                <c:choose>
                    <c:when test="${empty product.id || product.id==0}">
                        添加商品
                    </c:when>
                    <c:otherwise>
                        修改商品
                    </c:otherwise>
                </c:choose>
            </div>

            <br>
            <form action="${pageContext.request.contextPath }/Admin/productUpdataOrAddHandler.do" method="post"
                  enctype="multipart/form-data" id="productAdd" onsubmit="return checkProduct();">
                <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="135" align="right">一级分类</td>
                        <td colspan="3" style="font-family:'宋体';">
                            <select name="categoryLevel1Id" style="background-color:#f6f6f6;" id="productCategoryLevel1"
                                    onchange="queryProductCategoryList(this,1);">
                                <option value="" selected="selected">请选择...</option>
                                <c:forEach items="${proList }" var="pro1">
                                    <c:if test="${pro1.type == 1 }">
                                        <option value="${pro1.id}"
                                                <c:if test="${product.categoryLevel1Id == pro1.id }">selected='selected'</c:if>>${pro1.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">二级分类</td>
                        <td>
                            <select name="categoryLevel2Id" style="background-color:#f6f6f6;"
                                    id="productCategoryLevel2"
                                    onchange="queryProductCategoryList(this,2);">
                                <option value="0">请选择...</option>
                                <c:forEach items="${proList }" var="pro2">
                                    <c:if test="${pro2.parentId == product.categoryLevel1Id}">
                                        <option value="${pro2.id}"
                                                <c:if test="${product.categoryLevel2Id == pro2.id }">selected='selected'</c:if>>${pro2.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">三级分类</td>
                        <td>
                            <select name="categoryLevel3Id" style="background-color:#f6f6f6;"
                                    id="productCategoryLevel3">
                                <option value="0">请选择...</option>
                                <c:forEach items="${proList }" var="pro3">
                                    <c:if test="${pro3.parentId == product.categoryLevel2Id}">
                                        <option value="${pro3.id}"
                                                <c:if test="${product.categoryLevel3Id == pro3.id }">selected='selected'</c:if>>${pro3.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">商品名称</td>
                        <td>
                            <input type="text" value="${product.name}" class="add_ipt" name="name" id="proName"/>（必填）
                            <input type="hidden" name="id" value="${product.id }" id="id">
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">商品图片</td>
                        <td>
                            <c:if test="${product.fileName!=null && product.fileName!=''}">
                                <img src="${pageContext.request.contextPath }/images/${product.fileName}" width="50"
                                     height="50"/>
                            </c:if>
                            <input type="file" class="text" name="photo"/><span></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">单价</td>
                        <td>
                            <input type="text" value="${product.price}" class="add_ipt" name="price" id="price"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">库存</td>
                        <td>
                            <input type="text" value="${product.stock}" class="add_ipt" name="stock" id="stock"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">描述</td>
                        <td>
                            <textarea name="description">${product.description}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <c:choose>
                                <c:when test="${empty product.id}">
                                    <input type="submit" value="商品上架" class="s_btn">
                                </c:when>
                                <c:otherwise>
                                    <input type="submit" value="确定修改" class="s_btn">
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


