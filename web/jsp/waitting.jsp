<%@ page import="java.util.List" %>
<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/4/1
  Time: 下午7:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>正常订单</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- 可选的Bootstrap主题文件（一般不使用） -->
    <%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>--%>

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script src="../js/vue.min.js"></script>
    <link rel="stylesheet" href="../css/userIndex.css?v=1">
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
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-info">
                <div class="panel-heading"></a></li>
                    <ul class="nav nav-tabs">
                        <li ><a href="/Order_normal">正常订单</a></li>
                        <li><a href="/Order_cancel">已撤销的订单
                        <li class="active"><a href="/Ordering">等待分配位置的订单</a></li>
                    </ul>
                </div>
                <div class="panel-body">
                    <table id="t" class="table">
                        <thead>
                        <tr>
                            <th>演出名称</th>
                            <th>演出地点</th>
                            <th>座位数量</th>
                            <th>总价</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="i in data">
                            <td width="250px">{{i.showName}}</td>
                            <td width="150px">{{i.place}}</td>
                            <td width="100px">{{i.count}}</td>
                            <td width="100px">{{i.total}}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var data=[];
    <%List<Un_Order> list = (List<Un_Order>) session.getAttribute("orderList");%>
    <%for(int i=0 ;i<list.size();i++){%>
    data[<%=i%>]={showName:"<%=list.get(i).getShow_name()%>",place:"<%=list.get(i).getPlace_name()%>",count:"<%=list.get(i).getCount()%>"
        ,total:"<%=list.get(i).getTotal()%>"};
    <%}%>
    var v = new Vue({
        el:"#t",
        data:{
            data:data
        },
    });
</script>
</body>
</html>
