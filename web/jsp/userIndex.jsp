<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/2/11
  Time: 下午12:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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
<div class="panel panel-default">
    <div id="items" class="panel-body">
        <ul class="item_list">
            <%List<Show> list = (List<Show>) request.getAttribute("showList");%>
            <%for(int i = 0;i<list.size();i++ ){%>
            <div class="item" style="display: block">
                <div class="item_img">
                    <a href="/ShowInfo?name=<%=list.get(i).getName()%>" target="_blank">
                        <img src="<%=list.get(i).getImg().substring(3)%>" class="img-rounded">
                    </a>
                </div>
                <div class="item_txt">
                    <h3>
                        <a href="/ShowInfo?name=<%=list.get(i).getName()%>" target="_blank">
                            <%=list.get(i).getName()%>
                        </a>
                    </h3>
                    <p class="item_show_time">
                        <%=list.get(i).getTime()%>
                    </p>
                </div>
            </div>
            <%}%>
        </ul>
    </div>
    <div class="panel-body">
        <div class="page_box">
            <ul class="pagination" style="text-align: center">
                <li
                        <c:if test="${requestScope.pageBean.currentPage == 1}">style="display:none"</c:if>
                        <c:if test="${requestScope.pageBean.currentPage != 1}">style="display:block"</c:if>>
                    <a href="/UserIndex?page=${requestScope.pageBean.currentPage-1}">上一页</a>
                </li>
                <c:if test="${requestScope.pageBean.totalPage <= 5}">
                    <c:forEach begin="1" end="${requestScope.pageBean.totalPage}" var="i">
                        <li <c:if test="${requestScope.pageBean.currentPage == i}">class="active" </c:if>>
                            <a href="/UserIndex?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </c:if>
                <%--总页数大于5--%>
                <c:if test="${requestScope.pageBean.totalPage >5}">
                    <c:if test="${requestScope.pageBean.currentPage<=3}">
                        <c:forEach begin="1" end="5" var="i">
                            <li <c:if test="${requestScope.pageBean.currentPage == i}">class="active" </c:if>>
                                <a href="/UserIndex?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li>...</li>
                        <li>
                            <a href="/UserIndex?page=${requestScope.pageBean.totalPage}">${requestScope.pageBean.totalPage}</a>
                        </li>
                    </c:if>
                    <c:if test="${requestScope.pageBean.currentPage}>4">
                        <c:if test="${requestScope.pageBean.currentPage<requestScope.pageBean.totalPage-3}">
                            <li>
                                <a href="/UserIndex?page=1">1</a>
                            </li>
                            <li>...</li>
                            <c:forEach begin="${requestScope.pageBean.currentPage-2}" end="${requestScope.pageBean.currentPage+2}" var="i">
                                <li <c:if test="${requestScope.pageBean.currentPage==i}">class="active" </c:if>>
                                    <a href="/UserIndex?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li>...</li>
                            <li >
                                <a href="/UserIndex?page=${requestScope.pageBean.totalPage}">${requestScope.pageBean.totalPage}</a>
                            </li>
                        </c:if>
                    </c:if>
                    <c:if test="${requestScope.pageBean.currentPage>requestScope.pageBean.totalPage-4}">
                        <li>
                            <a href="/UserIndex?page=1">1</a>
                        </li>
                        <li>...</li>
                        <c:forEach begin="${requestScope.pageBean.totalPage-5}" end="${requestScope.pageBean}" var="i">
                            <li <c:if test="${requestScope.pageBean.currentPage==i}">class="active" </c:if>>
                                <a href="/UserIndex?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                </c:if>
                <%--下一页--%>
                <li <c:if test="${requestScope.pageBean.currentPage == requestScope.pageBean.totalPage||requestScope.totalPage==1}">class="disabled" </c:if>>
                    <a href="/UserIndex?page=${requestScope.pageBean.currentPage+1}">下一页</a>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
