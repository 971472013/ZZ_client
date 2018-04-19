<%@ page import="java.util.List" %>
<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/2/22
  Time: 上午10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>财务变化</title>
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

<%List<Change_m> list = (List<Change_m>) session.getAttribute("list");%>
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-warning">
                <div class="panel-heading">
                    <ul class="nav nav-tabs">
                        <li ><a href="/Manager_p_r">场馆注册确认</a></li>
                        <li><a href="/Manager_info">场馆信息更改确认</a></li>
                        <li > <a href="/Manager_pay">金额结算</a> </li>
                        <li><a href="/Manager_s">统计信息</a> </li>
                        <li class="active"><a href="/Manager_m">财务变化</a> </li>
                    </ul>
                </div>
                <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>当前账户余额</th>
                            <th><%=((Manager)session.getAttribute("session")).getBalance()%></th>
                        </tr>
                    </table>
                </div>
                <div class="panel-body">
                    <div id="div">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>时间</th>
                                <th>表演名称</th>
                                <th>演出场馆</th>
                                <th>操作</th>
                                <th>变化</th>
                                <th>变化后总额</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%for(int i =0;i<list.size();i++){%>
                            <tr>
                                <td><%=list.get(i).getTime()%></td>
                                <td><%=list.get(i).getShow_name()%></td>
                                <td><%=list.get(i).getPlace_name()%></td>
                                <td><%=list.get(i).getOp()%></td>
                                <td><%=list.get(i).getChange()%></td>
                                <td><%=list.get(i).getTotal()%></td>
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
</body>
</html>
