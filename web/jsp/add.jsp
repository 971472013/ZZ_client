<%@ page import="model.MainClass" %>
<%@ page import="model.Type" %>
<%@ page import="model.Place" %>
<%@ page import="model.User" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/4/4
  Time: 上午11:28
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

    <script src="../js/vue.min.js"></script>
    <link rel="stylesheet" href="../css/placeIndex.css?v=1">
    <link href="../css/placeInfo.css?v=2" rel="stylesheet">
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
            <form action="/AddPlan" method="post" class="form-horizontal" role="form" accept-charset="UTF-8">
                <div class="container">
                    <div class="row">
                        <div id="img_div" class="col-md-3">
                            <%--<img id="img" src="<%=place.getImg().substring(3)%>">--%>
                            <img id="img" v-bind:src="src" @click="setAvatar">
                            <input type="file" name="avatar" accept="image/gif,image/jpeg,image/jpg,image/png" style="display:none" @change="changeImage($event)" ref="avatarInput">
                            <%--<button type="button" @click="edit">上传</button>--%>
                        </div>
                        <div id="base_info" class="col-md-6">
                            <div class="form-group input-group">
                                <span class="input-group-addon">表演名称:</span>
                                <input type="text" class="form-control" id="name" name="name" value="">
                            </div>
                            <div class="form-group input-group">
                                <span class="input-group-addon">表演类型:</span>
                                <input type="text" class="form-control" id="city" name="city" value="">
                            </div>
                            <div>
                                <table>
                                    <tr>
                                        <td class="form-group-label">
                                            <label> <dt class="form-group-label">表演日期：</dt></label>
                                        </td>
                                        <td class="form-group-content">
                                            <select class="sel" name="birthY" id="birthY"><option value="2019">2019</option><option value="2018">2018</option></select>
                                            &nbsp;年&nbsp;
                                            <select class="sel" name="birthM" id="birthM"><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option></select>
                                            &nbsp;月&nbsp;
                                            <select class="sel" name="birthD" id="birthD"><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option></select>
                                            &nbsp;日&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="form-group input-group">
                                <span class="input-group-addon">表演介绍:</span>
                                <textarea type="text" class="form-control" id="introduction" name="introduction"></textarea>
                            </div>
                            <%--<div class="form-group">--%>
                            <%--<input type="password" class="form-control" id="pass" name="pass" value="<%=place.getPasswd()%>">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                            <%--<input type="password" class="form-control" id="rePass" name="rePass" value="<%=place.getPasswd()%>">--%>
                            <%--</div>--%>
                            <button id="sureBt" type="submit" class="btn btn-success">确 认</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    var v = new Vue({
        el:"#img_div",
        data:{
            src:'/other/暂无图片.jpg'
        },
        methods:{
            setAvatar() {
                this.$refs.avatarInput.click()
            },
            changeImage(e) {
                var file = e.target.files[0];
                var reader = new FileReader();
                var that = this;
                reader.readAsDataURL(file);
                console.log(file.name);
                reader.onload = function(e) {
                    that.src = this.result;
                };
                $.get("/uploadServlet",{t:"2",name:file.name},function () {
                });
            },
//            edit(){
//                if (this.$refs.avatarInput.files.length !== 0) {
//                    $.post("/uploadServlet",{img:this.src},function () {
//
//                    })
//                }
//            }
        }
    });
    $(function () {
        // 为每一个textarea绑定事件使其高度自适应
        $.each($("textarea"), function(i, n){
            autoTextarea($(n)[0]);
        });
    });
    /**
     * 文本框根据输入内容自适应高度
     * {HTMLElement}   输入框元素
     * {Number}        设置光标与输入框保持的距离(默认0)
     * {Number}        设置最大高度(可选)
     */
    var autoTextarea = function (elem, extra, maxHeight) {
        extra = extra || 0;
        var isFirefox = !!document.getBoxObjectFor || 'mozInnerScreenX' in window,
            isOpera = !!window.opera && !!window.opera.toString().indexOf('Opera'),
            addEvent = function (type, callback) {
                elem.addEventListener ?
                    elem.addEventListener(type, callback, false) :
                    elem.attachEvent('on' + type, callback);
            },
            getStyle = elem.currentStyle ?
                function (name) {
                    var val = elem.currentStyle[name];
                    if (name === 'height' && val.search(/px/i) !== 1) {
                        var rect = elem.getBoundingClientRect();
                        return rect.bottom - rect.top -
                            parseFloat(getStyle('paddingTop')) -
                            parseFloat(getStyle('paddingBottom')) + 'px';
                    };
                    return val;
                } : function (name) {
                    return getComputedStyle(elem, null)[name];
                },
            minHeight = parseFloat(getStyle('height'));
        elem.style.resize = 'both';//如果不希望使用者可以自由的伸展textarea的高宽可以设置其他值

        var change = function () {
            var scrollTop, height,
                padding = 0,
                style = elem.style;

            if (elem._length === elem.value.length) return;
            elem._length = elem.value.length;

            if (!isFirefox && !isOpera) {
                padding = parseInt(getStyle('paddingTop')) + parseInt(getStyle('paddingBottom'));
            };
            scrollTop = document.body.scrollTop || document.documentElement.scrollTop;

            elem.style.height = minHeight + 'px';
            if (elem.scrollHeight > minHeight) {
                if (maxHeight && elem.scrollHeight > maxHeight) {
                    height = maxHeight - padding;
                    style.overflowY = 'auto';
                } else {
                    height = elem.scrollHeight - padding;
                    style.overflowY = 'hidden';
                };
                style.height = height + extra+15 + 'px';
                scrollTop += parseInt(style.height) - elem.currHeight;
                document.body.scrollTop = scrollTop;
                document.documentElement.scrollTop = scrollTop;
                elem.currHeight = parseInt(style.height);
            };
        };

        addEvent('propertychange', change);
        addEvent('input', change);
        addEvent('focus', change);
        change();
    };
</script>
</body>
</html>
