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
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.bxslider_e88acd1b.js"></script>
</head>
<script type="text/javascript">
    var id;
    var isPass = false;

    function toUpdateProductCategoryList(currentObj) {

        $("#message").css("color", "black").html("（必填）");
        $("#inputId").val("");
        //执行之前加载第一个productCategoryLevel1
        id = $(currentObj).val();
        $.ajax({
            url: "${pageContext.request.contextPath}/Admin/productCategoryModify.do",
            data: {
                "parentId": "0",
                "type": "0",
            },
            dataType: "Json",
            success: function (data) {
                $("#productCategoryLevel1").html("<option value='0'>请选择...</option>");
                $("#productCategoryLevel2").html("<option value='0' selected='selected'>请选择...</option>");
                $("#productCategoryLevel3").html("<option value='0' selected='selected'>请选择...</option>");
                $.each(data, function (i, e) {
                    $("#productCategoryLevel1").append("<option value=" + e.id + ">" + e.name + "</option>");
                });
            }
        });

        //模拟改变事件productCategoryLevel1
        /* $("#productCategoryLevel1").trigger("change"); */
        $("#divMoidyOrAddId").show();
        $("#butModifyId").show();
        $("#butAddId").hide();
        $("#rankModifyTdId").show();
        $("#rankAddTdId").hide();
        //获取标签的分类的信息
        //     $.trim($(currentObj).parent("td").next("td").next("td").text())
        //alert($(currentObj).parent("td").next("td").next("td").next(".typeInput").val());

        $("#rank").attr("disabled", "disabled");
        if (eval($(currentObj).next(".typeInput").val()) == 1) {
            $("#rank").val("一级分类");
            $("#flagModify").val("1");
            $(".one").hide();
            $(".two").hide();
            //$("#productCategoryLevel1 option").attr("selected",false);
            $("#productCategoryLevel1 option[value='" + $(currentObj).val() + "']").attr("selected", true);
        }
        if (eval($(currentObj).next(".typeInput").val()) == 2) {
            $("#rank").val("二级分类");
            $("#flagModify").val("2");
            $(".one").show();
            $(".one").show();
            $(".two").hide();
        }
        if (eval($(currentObj).next(".typeInput").val()) == 3) {
            $("#rank").val("三级分类");
            $("#flagModify").val("3");
            $(".one").show();
            $(".two").show();
        }
        //console.log($("#tableId").find(".jj").val());

    }

    //onchange="queryProductCategoryList(this,'productCategoryLevel2')
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

    function saveOrUpdate() {
        var type;
        var data;
        var parentId;
        $("#inputId").trigger("blur");
        if (!isPass) {
            return;
        }
        //alert($("#flagModify").val());
        switch (eval($("#flagModify").val())) {
            case 1:
                //如果是1 只需要获取到标签的中的内容的值，索要修改的id值，
                type = 1;
                data = {
                    "type": type,
                    "id": id,
                    "inputVal": $("#inputId").val(),
                }
                break;
            case 2:
                type = 2;
                if ($("#productCategoryLevel1").val() == null || $("#productCategoryLevel1").val() == undefined || eval($("#productCategoryLevel1").val()) == 0) {
                    alert("请选择父级分类");
                    return;
                }
                data = {
                    "type": type,
                    "id": id,
                    "inputVal": $("#inputId").val(),
                    "parentId": $("#productCategoryLevel1").val()
                }
                break;
            case 3:
                type = 3;
                if ($("#productCategoryLevel2").val() == 0) {
                    alert("请选择父级分类");
                    return;
                }
                data = {
                    "type": type,
                    "id": id,
                    "inputVal": $("#inputId").val(),
                    "parentId": $("#productCategoryLevel2").val()
                }
                break;
            default:
                alert("系统出现异常，请稍后再试");
                return;
        }

        $.ajax({
            "url": "${pageContext.request.contextPath}/Admin/productCategoryModifyInfo.do",
            "data": data,
            "dataType": "text",
            success: function (result) {
                alert(result);
                if (result == "更新成功")
                    window.location.reload();
            }
        });
    }


    //添加分类  初始化
    function toAddProductCategory() {
        $("#divMoidyOrAddId").show();
        $("#butModifyId").hide();
        $("#butAddId").show();
        $("#rankModifyTdId").hide();
        $("#rankAddTdId").show();
        $(".one").show();
        $(".two").show();

        $.ajax({
            url: "${pageContext.request.contextPath}/Admin/productCategoryModify.do",
            data: {
                "parentId": "0",
                "type": "0",
            },
            dataType: "Json",
            success: function (data) {
                $("#productCategoryLevel1").html("<option value='0'>请选择...</option>");
                $("#productCategoryLevel2").html("<option value='0' selected='selected'>请选择...</option>");
                $("#productCategoryLevel3").html("<option value='0' selected='selected'>请选择...</option>");
                $.each(data, function (i, e) {
                    $("#productCategoryLevel1").append("<option value=" + e.id + ">" + e.name + "</option>");
                });
            }
        });

    }

    var addType = 0;
    var addParentId;
    $(function () {

        //添加元素
        $("#addClassify").bind("change", function () {
            switch (eval($("#addClassify").val())) {
                case 0:
                    addType = 0;
                    break;
                case 1:
                    //如果是1 只需要获取到标签的中的内容的值，索要修改的id值，
                    addType = 1;
                    $(".one").hide();
                    $(".two").hide();
                    break;
                case 2:
                    addType = 2;
                    $(".one").show();
                    $(".one").show();
                    $(".two").hide();
                    break;
                case 3:
                    addType = 3;
                    $(".one").show();
                    $(".two").show();
                    break;
            }
        });

        //为文本框注册失去焦点事件
        $("#inputId").bind("blur", function () {

            if ($("#inputId").val() == null || $("#inputId").val() == undefined || $.trim($("#inputId").val()) == "") {
                $("#message").css("color", "red").html("分类名不能为空");
                isPass = false;
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/Admin/checkeProductCategoryName.do",
                type: "get",
                data: {
                    "val": $("#inputId").val()
                },
                dataType: "text",
                success: function (data) {
                    if (eval(data)) {
                        $("#message").css("color", "green").html("分类名可用");
                        isPass = true;
                        return;
                    }
                    if (!eval(data)) {
                        $("#message").css("color", "red").html("分类名已存在");
                        isPass = false;
                        return;
                    }
                }
            });

        });
    });


    function addProductCategory() {
        if (eval(addType) == 0) {
            alert("请选择要添加的类别");
            return;
        }
        $("#inputId").trigger("blur");
        if (!isPass) {
            return;
        }

        if (eval(addType) == 2) {
            addParentId = $("#productCategoryLevel1").val();
        }
        if (eval(addType) == 3) {
            addParentId = $("#productCategoryLevel2").val();
        }

        $.ajax({
            "url": "${pageContext.request.contextPath}/Admin/productCategoryAddInfo.do",
            "data": {
                "type": addType,
                "inputVal": $("#inputId").val(),
                "addParentId": addParentId
            },
            "dataType": "text",
            success: function (result) {
                alert(result);
                if (result == "添加成功")
                    window.location.reload();

            }
        });

    }

    //删除元素    deleteProductCategory(${pro.id},${pro.type});
    function deleteProductCategory(proCatId, proCatType) {

        if (!confirm("您确定好了要删除吗？"))
            return;

        //判断传入过来的数据是否为空
        if (proCatId == null || "" == $.trim(proCatId) || proCatId == undefined) {
            alert("删除失败，获取相关数据失败");
            return;
        }
        if (proCatType == null || "" == $.trim(proCatType) || proCatType == undefined) {
            alert("删除失败，获取相关数据失败");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/Admin/productCategoryDel.do",
            data: {
                "type": proCatType,
                "id": proCatId
            },
            dataType: "text",
            success: function (result) {
                if ("删除成功" == result)
                    window.location.reload();
                alert(result);
            }
        });

    }
</script>
<body>
<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <jsp:include page=".././common/sidebar.jsp"></jsp:include>
        <div class="m_right" id="content">
            <div class="mem_tit">分类列表</div>
            <p align="right">
                <a href="javascript:void(0);" style="display: inline-block;" onclick="toAddProductCategory();"
                   class="btn_u">添加分类</a> <br>
            </p>
            <br>

            <div style="height: 600px;">
                <table border="0" class="order_tab"
                       style="width: 930px; text-align: center; margin-bottom: 30px;"
                       cellspacing="0" cellpadding="0">
                    <tbody>
                    <tr>
                        <td width="5%">选择</td>
                        <td width="20%">分类名称</td>
                        <td width="25%">分类级别</td>
                        <td width="25%">父级分类</td>
                        <td width="25%">操作</td>
                    </tr>
                    <c:forEach items="${requestScope.pagingList.data }" var="pro">
                        <tr>
                            <td width="5%">
                                <input type="radio" value="${pro.id}" name="select"
                                       onclick="toUpdateProductCategoryList(this);"/>
                                <input type="hidden" value="${pro.type }" class="typeInput">
                            </td>
                            <td>${pro.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${pro.type==1}">一级分类</c:when>
                                    <c:when test="${pro.type==2}">二级分类</c:when>
                                    <c:when test="${pro.type==3}">三级分类</c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${pro.parentId == 0 }">
                                    无
                                </c:if>
                                <c:forEach items="${proList}" var="proPraent">
                                    <c:if test="${pro.parentId == proPraent.id }">
                                        ${proPraent.name }
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <a href="javascript:void(0);"
                                   onclick="deleteProductCategory(${pro.id},${pro.type});">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="pages">
                    <c:if test="${requestScope.pagingList.currentPage != 1}">
                        <a
                                href="${pageContext.request.contextPath }/Admin/productCategoryHandlerAdmin.do?currentPage=1"
                                class="p_pre">首页</a>
                        <a
                                href="${pageContext.request.contextPath }/Admin/productCategoryHandlerAdmin.do?currentPage=${requestScope.pagingList.currentPage - 1 }"
                                class="p_pre">上一页</a>
                    </c:if>
                    <c:if
                            test="${requestScope.pagingList.currentPage != requestScope.pagingList.totalPage}">
                        <a
                                href="${pageContext.request.contextPath }/Admin/productCategoryHandlerAdmin.do?currentPage=${requestScope.pagingList.currentPage + 1 }"
                                class="p_pre">下一页</a>
                        <a
                                href="${pageContext.request.contextPath }/Admin/productCategoryHandlerAdmin.do?currentPage=${requestScope.pagingList.totalPage }"
                                class="p_pre">尾页</a>
                    </c:if>
                </div>
                <div class="pages">
                    共搜索到${requestScope.pagingList.total }条订单，共${requestScope.pagingList.totalPage }页，当前第${requestScope.pagingList.currentPage }页
                </div>
            </div>
            <%-- <%@ include file="/common/pre/pagerBar.jsp" %> --%>

            <div style="display: none" id="divMoidyOrAddId">

                <table id="tableId" border="0" class="add_tab" style="width: 930px;"
                       cellspacing="0" cellpadding="0">
                    <input type="hidden" id="flagModify" value=""/>
                    <tr>
                        <td width="135" align="right">分类级别</td>
                        <td id="rankModifyTdId" style="display: none;" colspan="3" style="font-family: '宋体';">
                            <input type="text" id="rank">
                        </td>
                        <td id="rankAddTdId" style="display: none;" colspan="3" style="font-family: '宋体';">
                            <select id="addClassify">
                                <option value="0" selected="selected">请选择...</option>
                                <option value="1">一级分类</option>
                                <option value="2">二级分类</option>
                                <option value="3">三级分类</option>
                            </select>
                        </td>
                    </tr>

                    <tr class="one">
                        <td align="right">一级分类</td>
                        <td colspan="3" style="font-family: '宋体';">
                            <select class="jj" name="productCategoryLevel1" style="background-color: #f6f6f6;"
                                    id="productCategoryLevel1" onchange="queryProductCategoryList(this,1);">

                                <option value="0" selected="selected">请选择...</option>

                                <option value="0" selected="selected">请选择...</option>
                            </select>
                        </td>
                    </tr>

                    <tr class="two">
                        <td align="right">二级分类</td>
                        <td>
                            <select class="jj" name="productCategoryLevel2" id="productCategoryLevel2"
                                    onchange="queryProductCategoryList(this,2);"
                                    style="background-color: #f6f6f6;" id="productCategoryLevel2">
                                <option value="0" selected="selected">请选择...</option>
                            </select>
                        </td>
                    </tr>

                    <!-- 					<tr class="three">
                                            <td width="135" align="right">三级分类</td>
                                            <td><select class="jj" name="productCategoryLevel3" id="productCategoryLevel3"
                                                style="background-color: #f6f6f6;" id="productCategoryLevel2">
                                                    <option value="0" selected="selected">请选择...</option>
                                                </select>
                                            </td>
                                        </tr>
                     -->
                    <tr>
                        <td align="right">分类名称</td>
                        <td style="font-family: '宋体';">
                            <input type="text" value="" class="add_ipt" id="inputId"/><span id="message">（必填）</span>
                        </td>
                    </tr>
                </table>
                <p align="right" id="butModifyId" style="display: none">
                    <br> <a onclick="saveOrUpdate();" style="display: inline-block;" class="btn_u">确认修改</a>
                </p>
                <p align="right" id="butAddId" style="display: none">
                    <br> <a onclick="addProductCategory();" style="display: inline-block;" class="btn_u">确认添加</a>
                </p>
            </div>

        </div>
    </div>
    <%@include file=".././common/tail.jsp" %>
</div>
</body>
</html>


