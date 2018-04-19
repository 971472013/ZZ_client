<%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/2/5
  Time: 上午11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>

        <!-- 新 Bootstrap 核心 CSS 文件 -->
        <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

        <!-- 可选的Bootstrap主题文件（一般不使用） -->
        <%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>--%>

        <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
        <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

        <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
        <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


        <link rel="stylesheet" href="../css/login.css">
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <title>登录</title>
    </head>
  <body>
  <nav class="navbar navbar-default" role="navigation">
      <div class="container-fluid">
          <div class="navbar-header">
              <a class="navbar-brand" href="/Login">ZZ</a>
          </div>
          <div>
              <h1 id="header_title">欢迎登录</h1>
          </div>
      </div>
  </nav>
  <div class="container">
      <div class="row">
          <div class="col-md-6 col-md-offset-3">
              <form action="/Login" method="post" class="form-horizontal">
                  <span class="heading">用户登录</span>
                  <div class="form-group">
                      <input type="text" class="form-control" name="email" placeholder="电子邮件/场馆账户">
                      <i class="fa fa-user"></i>
                  </div>
                  <div class="form-group help">
                      <input type="password" class="form-control" name="password" placeholder="密　码">
                      <i class="fa fa-lock"></i>
                      <a href="#" class="fa fa-question-circle"></a>
                  </div>
                  <div class="form-group">
                      <div class="main-checkbox">
                          <input type="checkbox" value="None" id="checkbox1" name="check"/>
                          <label for="checkbox1"></label>
                      </div>
                      <span class="text">Remember me</span>
                      <button type="submit" class="btn btn-default">登录</button>
                  </div>
              </form>
          </div>
      </div>
  </div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  </body>
</html>
