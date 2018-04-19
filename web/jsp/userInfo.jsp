<%@ page import="model.User" %>
<%@ page import="model.MainClass" %>
<%@ page import="model.Type" %>
<%@ page import="model.Place" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/2/23
  Time: 下午8:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人信息</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <link rel="stylesheet" href="../css/userInfo.css?v=1">
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
        <div class="col-md-6 col-md-offset-3">
            <form class="form-horizontal" role="form" action="/UserInfo" method="post">
                <table>
                    <tr>
                        <td class="form-group-label">
                            <label><dt>昵  称：</dt></label>
                        </td>
                        <td class="form-group-content">
                            <input class="form-group" name="nickname" type="text" value="<%=((User)session.getAttribute("session")).getNickname()%>">
                        </td>
                    </tr>
                    <tr>
                        <td class="form-group-label">
                            <label> <dt>真实姓名：</dt></label>
                        </td>
                        <td class="form-group-content">
                            <input class="form-group" name="real_name" type="text" value="<%=((User)session.getAttribute("session")).getReal_name()%>">
                        </td>
                    </tr>
                    <tr>
                        <td class="form-group-label">
                            <label><dt>性  别：</dt></label>
                        </td>
                        <td class="form-group-content">
                            <select class="sel" name="gender" id="gender"><option value="male">男</option><option value="female">女</option> </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-group-label">
                            <label> <dt class="form-group-label">生  日：</dt></label>
                        </td>
                        <td class="form-group-content">
                            <select class="sel" name="birthY" id="birthY"><option value="2018">2018</option><option value="2017">2017</option><option value="2016">2016</option><option value="2015">2015</option><option value="2014">2014</option><option value="2013">2013</option><option value="2012">2012</option><option value="2011">2011</option><option value="2010">2010</option><option value="2009">2009</option><option value="2008">2008</option><option value="2007">2007</option><option value="2006">2006</option><option value="2005">2005</option><option value="2004">2004</option><option value="2003">2003</option><option value="2002">2002</option><option value="2001">2001</option><option value="2000">2000</option><option value="1999">1999</option><option value="1998">1998</option><option value="1997">1997</option><option value="1996">1996</option><option value="1995">1995</option><option value="1994">1994</option><option value="1993">1993</option><option value="1992">1992</option><option value="1991">1991</option><option value="1990">1990</option><option value="1989">1989</option><option value="1988">1988</option><option value="1987">1987</option><option value="1986">1986</option><option value="1985">1985</option><option value="1984">1984</option><option value="1983">1983</option><option value="1982">1982</option><option value="1981">1981</option><option value="1980">1980</option><option value="1979">1979</option><option value="1978">1978</option><option value="1977">1977</option><option value="1976">1976</option><option value="1975">1975</option><option value="1974">1974</option><option value="1973">1973</option><option value="1972">1972</option><option value="1971">1971</option><option value="1970">1970</option><option value="1969">1969</option><option value="1968">1968</option><option value="1967">1967</option><option value="1966">1966</option><option value="1965">1965</option><option value="1964">1964</option><option value="1963">1963</option><option value="1962">1962</option><option value="1961">1961</option><option value="1960">1960</option><option value="1959">1959</option><option value="1958">1958</option><option value="1957">1957</option><option value="1956">1956</option><option value="1955">1955</option><option value="1954">1954</option><option value="1953">1953</option><option value="1952">1952</option><option value="1951">1951</option><option value="1950">1950</option><option value="1949">1949</option><option value="1948">1948</option><option value="1947">1947</option><option value="1946">1946</option><option value="1945">1945</option><option value="1944">1944</option><option value="1943">1943</option><option value="1942">1942</option><option value="1941">1941</option><option value="1940">1940</option><option value="1939">1939</option><option value="1938">1938</option><option value="1937">1937</option><option value="1936">1936</option><option value="1935">1935</option><option value="1934">1934</option><option value="1933">1933</option><option value="1932">1932</option><option value="1931">1931</option><option value="1930">1930</option><option value="1929">1929</option><option value="1928">1928</option><option value="1927">1927</option><option value="1926">1926</option><option value="1925">1925</option><option value="1924">1924</option><option value="1923">1923</option><option value="1922">1922</option><option value="1921">1921</option><option value="1920">1920</option><option value="1919">1919</option><option value="1918">1918</option><option value="1917">1917</option><option value="1916">1916</option><option value="1915">1915</option><option value="1914">1914</option><option value="1913">1913</option><option value="1912">1912</option><option value="1911">1911</option><option value="1910">1910</option><option value="1909">1909</option><option value="1908">1908</option><option value="1907">1907</option><option value="1906">1906</option><option value="1905">1905</option><option value="1904">1904</option><option value="1903">1903</option><option value="1902">1902</option><option value="1901">1901</option><option value="1900">1900</option></select>
                            &nbsp;年&nbsp;
                            <select class="sel" name="birthM" id="birthM"><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option></select>
                            &nbsp;月&nbsp;
                            <select class="sel" name="birthD" id="birthD"><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option></select>
                            &nbsp;日&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="form-group-label">
                            <label> <dt>家庭地址：</dt></label>
                        </td>
                        <td class="form-group-content">
                            <input class="form-group" name="home_place" type="text" value="<%=((User)session.getAttribute("session")).getHome_place()%>">
                        </td>
                    </tr>
                </table>
                <button class="btn-info" id="button"  type="submit">保&nbsp;&nbsp;存</button>
            </form>
            <form action="/XU" role="form" method="post">
                <button class="btn-danger" id="buttonx"  type="submit">销&nbsp;&nbsp;户</button>
            </form>
        </div>
    </div>
</div>


<script>
    $("#gender").find("option[value=<%=((User)session.getAttribute("session")).getGender()%>]").attr("selected","selected");
    $("#birthY").find("option[value=<%=((User)session.getAttribute("session")).getY()%>]").attr("selected","selected");
    $("#birthM").find("option[value=<%=((User)session.getAttribute("session")).getM()%>]").attr("selected","selected");
    $("#birthD").find("option[value=<%=((User)session.getAttribute("session")).getD()%>]").attr("selected","selected");
</script>
</body>
</html>
