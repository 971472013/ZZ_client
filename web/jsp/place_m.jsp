<%@ page import="java.util.List" %>
<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/4/3
  Time: 下午7:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>财务状况</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- 可选的Bootstrap主题文件（一般不使用） -->
    <%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>--%>

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../css/placeIndex.css?v=1">
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
            </ul>
        </div>
        <div id="label_div">
            <%MainClass mainClass = (MainClass) session.getAttribute("session");
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

<%List<Change_m> list = (List<Change_m>) session.getAttribute("list");%>
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-warning">
                <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>当前账户余额</th>
                            <th><%=((Place)session.getAttribute("session")).getBalance()%></th>
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
                                <th>关系用户</th>
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
                                <td><%=list.get(i).getBelong_user()%></td>
                                <td><%=list.get(i).getOp()%></td>
                                <td><%=list.get(i).getChange()%></td>
                                <%if(list.get(i).getTotal()!=-1){%>
                                <td><%=list.get(i).getTotal()%></td>
                                <%}else{%>
                                <td></td>
                                <%}%>
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
