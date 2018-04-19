<%@ page import="java.util.List" %>
<%@ page import="model.Place" %>
<%@ page import="service.ManagerService" %>
<%@ page import="factory.EJBFactory" %><%--
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


    <script src="../js/vue.min.js"></script>

    <link href="../css/manager.css?v=1" rel="stylesheet">
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
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-warning">
                <div class="panel-heading">
                    <ul class="nav nav-tabs">
                        <li><a href="/Manager_p_r">场馆注册确认</a></li>
                        <li class="active"><a href="/Manager_info">场馆信息更改确认</a></li>
                        <li><a href="/Manager_pay">金额结算</a> </li>
                        <li><a href="/Manager_s">统计信息</a> </li>
                        <li><a href="/Manager_m">财务变化</a> </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<%List<Place> list = (List<Place>) request.getSession(false).getAttribute("list");%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-warning">
                <div class="panel-body">
                    <div  id="info">
                        <table id="table1" class="table table-hover">
                            <caption>当前信息</caption>
                            <thead>
                            <tr>
                                <th>图片</th>
                                <th>名称</th>
                                <th>城市</th>
                                <th>简介</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><img style="width: 222px;height: 222px;" class="img-rounded" src="<%=list.get(0).getImg().substring(3)%>"></td>
                                <td width="150px"><%=list.get(0).getName()%></td>
                                <td width="90px"><%=list.get(0).getCity()%></td>
                                <td><%=list.get(0).getIntroduction()%></td>
                            </tr>
                            </tbody>
                        </table>
                        <table id="table2" class="table table-hover">
                            <caption>修改信息</caption>
                            <thead>
                            <tr>
                                <th>图片</th>
                                <th>名称</th>
                                <th>城市</th>
                                <th>简介</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><img style="width: 222px;height: 222px;" class="img-rounded" src="<%=list.get(1).getImg().substring(3)%>"></td>
                                <td width="150px"><%=list.get(1).getName()%></td>
                                <td width="90px"><%=list.get(1).getCity()%></td>
                                <td><%=list.get(1).getIntroduction()%></td>
                            </tr>
                            </tbody>
                        </table>
                        <button id="sure" class="btn-success" onclick="sure()" >同意</button>
                        <button id="unSure" class="btn-danger" onclick="unSure()">驳回</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    <%List<Place> list1 = (List<Place>) request.getSession(false).getAttribute("list");%>
//    $("#sure").click(function () {
    function sure () {
        $.post("/Manager_info_sure",{method:'sure',id:<%=list1.get(0).getId()%>},function () {
            alert("修改成功");
            window.location.href="/Manager_info";
        },"text");

    }
//    $("#unSure").click(function () {
    function unSure () {
        $.post("/Manager_info_sure",{method:'unSure',id:<%=list1.get(0).getId()%>},function () {
            alert("已驳回");
            window.location.href="/Manager_info";
        },"text");
    }
</script>
</body>
</html>
