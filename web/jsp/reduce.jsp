<%@ page import="model.*" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/4/3
  Time: 下午8:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- 可选的Bootstrap主题文件（一般不使用） -->
    <%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>--%>

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/UserIndex">HI , 欢迎来到珍珠网</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <%if(session.getAttribute("session")==null){%>
                <div id="login-register">
                    [<a class="zz-login" title="登录" href="/Login">登录</a>,
                    <a class="zz-register" title="注册" href="/Register">注册</a>,
                    <a class="zz-place-register" title="场馆注册" href="/Place_Register">场馆注册</a>]
                </div>
                <%}%>
                <%if(session.getAttribute("session") != null){%>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        我的珍珠 <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="/UserInfo">个人信息</a></li>
                        <li><a href="/Order_normal">我的订单</a></li>
                        <li><a href="/Statistics">统计信息</a> </li>
                        <li><a href="/Exchange">兑换中心</a> </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div id="label_div">
            <%
                MainClass mainClass = (MainClass) session.getAttribute("session");
                if(mainClass.getType()== Type.Place){%>
            <label class="u-label">欢迎回来，<%=((Place)mainClass).getName()%></label>
            <%}%>
            <%if(mainClass.getType()== Type.User){%>
            <label class="u-label">欢迎回来，<%=((User)mainClass).getNickname()%></label>
            <%}%>
        </div>
        <div>
            <form action="/Logout">
                <button id="logout" type="submit" class="btn-danger" value="Logout">退 出</button>
            </form>
        </div>
        <%}%>
    </div>
</nav>
<%User user = (User) session.getAttribute("session");%>
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div id="tt"  class="panel panel-info">
                <div class="panel-body">
                    <form role="form" action="/Exchange" method="post">
                        <table  class="table">
                            <tr>
                                <td>当前用户积分:</td>
                                <td><%=user.getCredit()%></td>
                                <td>每300积分兑换一张满100减10优惠卷</td>
                                <td><button type="submit" class="btn-success">兑换</button></td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="panel-body">
                    <table  class="table">
                       <thead>
                       <th>优惠券id</th>
                       <th>优惠券描述</th>
                       </thead>
                        <tbody>
                        <%List<Reduce> list = (List<Reduce>) session.getAttribute("reduce");
                            for(int i=0;i<list.size();i++){%>
                        <tr>
                            <td><%=list.get(i).getId()%></td>
                            <td><%=list.get(i).getDe()%></td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
