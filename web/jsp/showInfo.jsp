<%@ page import="model.*" %><%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/3/5
  Time: 上午9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>演出信息</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- 可选的Bootstrap主题文件（一般不使用） -->
    <%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>--%>

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="../css/showInfo.css?v=5">
    <link rel="stylesheet" href="../css/seats.css?v=3">

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
<%Show show = (Show)request.getAttribute("Show");%>
<div class="panel panel-success">
    <div class="panel-heading">
        <div>
            <p id="heading_info">
                <a href="/UserIndex">珍珠网</a>
                <span class="arrow"> > </span>
                <span><%=show.getPlace()%></span>
                <span class="arrow"> > </span>
                <span><%=show.getType()%></span>
                <span class="arrow"> > </span>
                <strong><%=show.getName()%></strong>
            </p>
        </div>
    </div>
    <div class="panel-body">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div id="img_div">
                        <img src="<%=show.getImg().substring(3)%>" width="277" height="373">
                    </div>
                </div>
                <div class="col-md-6">
                    <div id="show_info">
                        <h2><%=show.getName()%></h2>
                        <span><%=show.getIntroduction()%></span>
                    </div>
                    <div id="choice" class="choice">
                        <ul class="choice_list">
                            <li id="choice_item_1" class="choice_item">
                                <a href="javascript:" onclick="choose_seat();">选座购票</a>
                            </li>
                            <li id="choice_item_2" class="choice_item">
                                <a href="javascript:" onclick="unChoose();">不选座购票</a>
                            </li>
                        </ul>
                    </div>
                    <div id="unChoose_div">
                        <button  onclick="sub_c();" type="button" class="btn btn-default glyphicon glyphicon-chevron-left" id="sub_c"></button>
                        <span id="c_span">0</span>
                        <button  onclick="add_c();" type="button" class="btn btn-default glyphicon glyphicon-chevron-right" id="add_c"></button>
                        <label id="ll">预付总价: </label>
                        <span id="c_t">0</span>
                        <button id="pp" onclick="pay_u()" class="btn btn-success">确定购买</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <div id="sd">
                        <div id="info_txt">
                            <h3 id="txt"><strong id="info"> 演 出 信 息 </strong></h3>
                        </div>
                        <div class="sd_info">
                            <h4>演出时间</h4>
                            <span class="span_info"><%=show.getTime()%></span>
                        </div>
                        <div class="sd_info">
                            <h4>演出场馆</h4>
                            <a id="place_name" target="_blank" href="/PlaceIndex?place=<%=show.getPlace()%>"><%=show.getPlace()%></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel-body">
        <div id="seat_div">
            <div id="seat-map">
                <div class="front"> 舞 台 </div>
            </div>
            <div id="seat_details">
                <ul id="selected-seats"></ul>
                <p>票数：<span id="counter">0</span></p>
                <p>总计：<b>￥<span id="total">0</span></b></p>
                <button onclick="pay()" class="btn btn-success">确定购买</button>
                <div id="legend"></div>
            </div>
        </div>
    </div>
</div>

<script src="../js/jquery.seat-charts.min.js"></script>
<script type="text/javascript">
    $c_span = $('#c_span');
    $c_t = $('#c_t');
    sub_c = function () {
        if(parseInt($c_span.text())>0){
            $c_span.text(parseInt($c_span.text())-1);
            $c_t.text(parseInt($c_span.text())*580);
        }
    };
    add_c = function () {
        if(parseInt($c_span.text())<20) {
            $c_span.text(parseInt($c_span.text()) + 1);
            $c_t.text(parseInt($c_span.text()) * 580);
        }
    };
    $(document).ready(function() {
        $.post("/ShowInfo",{name:'<%=((Show)request.getAttribute("Show")).getName()%>'},function (data) {
            map_s = data;
            map_t = stringToMap(map_s);
        })
    });
    $('#seat_div').hide();
    $('#unChoose_div').hide();
    var seats = new Set();
    unChoose = function(){
        if($('#seat_div').is(':visible')){
            $('#choice_item_1').removeClass('choice_item_sel');
            $('#seat_div').toggle();
        };

        $('#unChoose_div').toggle();
        if($('#unChoose_div').is(':visible')){
            $('#choice_item_2').addClass('choice_item_sel');
        }
        else {
            $('#choice_item_2').removeClass('choice_item_sel');
        }
    };
    choose_seat = function () {
        if($('#unChoose_div').is(':visible')){
            $('#choice_item_2').removeClass('choice_item_sel');
            $('#unChoose_div').toggle();
        };

        $('#seat_div').toggle();
        if($('#seat_div').is(':visible')){
            $('#choice_item_1').addClass('choice_item_sel');
        }
        else {
            $('#choice_item_1').removeClass('choice_item_sel');
        }
        var $cart = $('#selected-seats');
        $count = $('#counter');
        $total = $('#total');
        sc = $('#seat-map').seatCharts({
            map:stringToMap(map_s),
            seats:{
                a: {
                    price: 540,
                    classes: 'a',
                    category: '一等座'
                },
                b:{
                    price:360,
                    classes: 'b',
                    category: '二等座'
                },
                c:{
                    price:180,
                    classes: 'c',
                    category: '三等座'
                },
                d:{
                    price:80,
                    classes: 'd',
                    category: '四等座'
                },
                u:{
                    price:-1,
                    classes: 'u',
                    category: '不可选'
                },
                s:{
                    price:-1,
                    classes: 's',
                    category: '已出售'
                }
            },
            legend:{
                node:$('#legend'),
                items:[
                    ['a','available','一等座'],
                    ['b','available','二等座'],
                    ['c','available','三等座'],
                    ['d','available','四等座'],
                    ['u','unavailable','不可选'],
                    ['s','sold','已出售']
                ]
            },
            click:function(){
                if(this.status() == 'selected'){
                    $count.text(sc.find('selected').length-1);
                    $('#cart-item-'+this.settings.id).remove();
                    $total.text(getTotal(sc) - this.data().price);
                    var temp = map_t[this.settings.row];
                    var temp2 = temp.split('');
                    if(this.settings.row < 3){
                        temp2.splice(this.settings.label-1,1,'a');
                    }
                    else if(this.settings.row < 6){
                        temp2.splice(this.settings.label-1,1,'b');
                    }
                    else if(this.settings.row < 9){
                        temp2.splice(this.settings.label-1,1,'c');
                    }
                    else {
                        temp2.splice(this.settings.label-1,1,'d');
                    }
                    temp = temp2.join('');
                    map_t[this.settings.row] = temp;
                    seats.delete((this.settings.row+1)+'排'+this.settings.label+'座');
                    return 'available';
                }
                if(sc.find('selected').length == 6){
                    alert('选座购买每单仅限6张票');
                    return this.style();
                }
                if(this.status() == 'available'){
                    $('<li>'+(this.settings.row+1)+'排'+this.settings.label+'座</li>').attr('id','cart-item-'+this.settings.id)
                        .data('seatId',this.settings.id).appendTo($cart);
                    $count.text(sc.find('selected').length+1);
                    $total.text(getTotal(sc) + this.data().price);
                    var temp = map_t[this.settings.row];
                    var temp2 = temp.split('');
                    temp2.splice(this.settings.label-1,1,'s');
                    temp = temp2.join('');
                    map_t[this.settings.row] = temp;
                    seats.add((this.settings.row+1)+'排'+this.settings.label+'座');
                    return 'selected';
                }else if(this.status() == 'unavailable'){
                    return 'unavailable';
                }
                else if(this.status() == 'sold'){
                    return 'sold';
                }
                else{
                    return this.style();
                }
            }
        });
        sc.find('u.available').status('unavailable');
        sc.find('s.available').status('sold');
    };
    getTotal = function(sc){
        var total = 0;
        sc.find('selected').each(function(){
            total += this.data().price;
        });
        return total;
    };
    function pay() {
        var seat_s = '';
        for(var v of seats){
            seat_s = seat_s + v + '*';
        }
        seat_s =  seat_s.substring(0,seat_s.length-1);
        console.log(seat_s);
        $.post("/UserPay",{t:'choose',total:getTotal(sc),map:mapToString(map_t),seat_s:encodeURI(seat_s)},function (data) {
                    alert(data);
                    location.reload();
                },'text');
    };
    function pay_u() {
        $.post("/UserPay",{t:'unChoose',count:$c_span.text(),total:$c_t.text()},function (data) {
            alert(data);
            location.reload();
        },'text');
    }
    mapToString = function (map) {
        var s='';
        for(var i=0;i<map.length;i++){
            s = s + map[i] + '*';
        }
        return s.substring(0,s.length-1);
    };
    stringToMap = function (s) {
        var ss = s.split('*');
        return ss;
    }
</script>
</body>
</html>
