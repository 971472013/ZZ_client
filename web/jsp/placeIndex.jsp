<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/2/22
  Time: 上午10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>场馆信息</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
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
<%Place place = (Place) request.getAttribute("place");
if(place == null){
    place = (Place) session.getAttribute("session");
}%>
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
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-warning">
                <div class="panel-heading">
                    <p id="heading_info">
                        <span>珍珠网</span>
                        <span class="arrow"> > </span>
                        <span><%=place.getCity()%></span>
                        <span class="arrow"> > </span>
                        <strong><%=place.getName()%></strong>
                    </p>
                </div>
                <div id="main_info" class="panel-body">
                    <img id="img" class="img-rounded" src="<%=place.getImg().substring(3)%>">
                    <div id="name_and_city">
                        <h2 class="base-info" id="name"><%=place.getName()%></h2>
                    </div>
                    <span id="introduction"><%=place.getIntroduction()%></span>
                </div>
                <%List<Show> list = (List<Show>) request.getAttribute("showList");
                if(list == null){
                    list = (List<Show>) session.getAttribute("showList");
                }
                if(list == null){
                    list = new ArrayList<>();
                }%>
                <div id="showList" class="panel-body">
                    <span id="list-title">
                        <strong id="list-title-strong">演出列表</strong>
                    </span>
                    <ul>
                        <%for(int i = 0;i<list.size();i++){%>
                        <li class="showListItem">
                            <img class="show-img" width="109" height="144" src="<%=list.get(i).getImg().substring(3)%>" href="/Checkin?name=<%=list.get(i).getName()%>">
                            <div class="show-name-div">
                                <strong><a class="show-name"  href="/Checkin?name=<%=list.get(i).getName()%>"><%=list.get(i).getName()%></a></strong>
                            </div>
                            <div class="show-info">
                                <p class="show-time">演出时间: <%=list.get(i).getTime()%></p>
                                <p class="show-place">演出场馆: <%=list.get(i).getPlace()%></p>
                                <p class="show-type">类型: <%=list.get(i).getType()%></p>
                            </div>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
        </div>
        <div id="check" class="col-md-1">
            <form id="c1" action="/PlaceInfo" method="get">
                <button type="submit" class="btn btn-info">更改信息</button>
            </form>
            <form id="c3" action="/Place_m" method="get">
                <button type="submit" class="btn btn-warning">财务状况</button>
            </form>
            <form id="c2" action="/AddPlan" method="get">
                <button type="submit" class="btn btn-warning">发布计划</button>
            </form>
        </div>


    </div>
</div>

<script>
    $("#check").hide();
    <% MainClass mainClass = (MainClass) session.getAttribute("session");
    if(mainClass!=null &&mainClass.getType() == Type.Place){
        Place P = (Place) mainClass;
        if(P.getId().equals(place.getId())){%>
    $("#check").show();
        <%}}else {%>
        $("#check").hide();
    <%}%>

</script>
</body>
</html>
