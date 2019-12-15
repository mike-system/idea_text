<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<head>
</head>
<body>
<span id="remainSeconds"></span>
<script type="text/javascript">
    setInterval(jump,1000);
    var sec = 3;
    function jump(){
        if(sec > 0){
            document.getElementById('remainSeconds').innerHTML = "${ex.message }" + "，页面将在"+sec + "后跳转到首页";
        }else{
            window.location.href = '${pageContext.request.contextPath}/index.do';
        }
        sec--;
    }
</script>

</body>
</html>