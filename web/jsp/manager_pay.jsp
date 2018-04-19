<%@ page import="java.util.List" %>
<%@ page import="model.Place" %>
<%@ page import="model.Order" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/2/22
  Time: 上午10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>金额结算</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- 可选的Bootstrap主题文件（一般不使用） -->
    <%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>--%>

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <script src="../js/vue.min.js"></script>

    <link href="../css/manager.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <h2 class="navbar-text">管理员模式</h2>
        <div id="logout_div">
            <form action="/Logout">
                <button id="logout" type="submit" class="btn-danger" value="Logout">退 出</button>
            </form>
        </div>
    </div>
</nav>

<%List<Order> list = (List<Order>) session.getAttribute("orderList");%>
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-warning">
                <div class="panel-heading">
                    <ul class="nav nav-tabs">
                        <li ><a href="/Manager_p_r">场馆注册确认</a></li>
                        <li><a href="/Manager_info">场馆信息更改确认</a></li>
                        <li class="active"> <a href="/Manager_pay">金额结算</a> </li>
                        <li><a href="/Manager_s">统计信息</a> </li>
                        <li><a href="/Manager_m">财务变化</a> </li>
                    </ul>
                </div>
                <div class="panel-body">
                    <div id="div">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>表演名称</th>
                                <th>演出场馆</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <%for(int i =0;i<list.size();i++){%>
                            <tr>
                                <td><%=list.get(i).getShow_name()%></td>
                                <td><%=list.get(i).getPlace_name()%></td>
                                <td><input style="border-radius: 10px;" type="button" value="结算" class="btn-success" onclick="ck('<%=list.get(i).getBelong_user()%>','<%=list.get(i).getShow_name()%>','<%=list.get(i).getPlace_name()%>')"></td>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function ck (user,show,place) {
        $.post("/Manager_pay", {user: encodeURI(user),show:encodeURI(show),place:encodeURI(place)}, function () {
            alert("结算成功");
            window.location.reload();
        }, "text");
    }
</script>
</body>
</html>
