<%@ page import="model.Show" %>
<%@ page import="model.User" %><%--
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

    <link rel="stylesheet" href="../css/showInfo.css?v=4">
    <link rel="stylesheet" href="../css/checkin_seats.css?v=3">

</head>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/UserIndex">HI , 欢迎来到珍珠网</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                [<a class="zz-login" title="登录" href="/Login">登录</a>
                <a class="zz-register" title="注册" href="/Register">注册</a>]
                <%if(session.getAttribute("session") != null){%>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        我的珍珠 <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="/UserInfo">个人信息</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div>
            <button style="border-radius: 20px;" class="btn-danger" value="Logout">退 出</button>
        </div>
        <%}%>
    </div>
</nav>
<%Show show = (Show)session.getAttribute("checkShow");%>
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
                    <div class="choice">
                        <ul class="choice_list">
                            <li id="choice_item_1" class="choice_item">
                                <a href="javascript:" onclick="checkin();">入场检票与现场买票</a>
                            </li>
                        </ul>
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
                <button onclick="cin()" class="btn btn-success">确定入场</button>

                <div id="now_check">
                    <div class="input-group">
                        <span class="input-group-addon">用户名</span>
                        <input id="n" type="text" class="form-control" value="">
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon">密码</span>
                        <input id="p" type="password" class="form-control" value="">
                    </div>
                    <br>
                    <div class="input-group">
                        <span id="spa">总价:</span>
                        <span id="spa2">0</span>
                        <button onclick="xcin()" class="btn btn-warning">现场购买</button>
                    </div>
                </div>
                <div id="legend"></div>
            </div>
        </div>
    </div>
</div>

<script src="../js/jquery.seat-charts.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $.post("/CheckinHelp",{name:'<%=((Show)session.getAttribute("checkShow")).getName()%>'},function (data) {
            map_s = data;
            map_t = stringToMap(map_s);
        })
    });
    var mark = 0;
    $span2 = $('#spa2');
    $name = $("#n");
    $pass = $("#p");
    $('#seat_div').hide();
    var seats = new Set();
    checkin = function () {
        $('#seat_div').toggle();
        if($('#seat_div').is(':visible')){
            $('#choice_item_1').addClass('choice_item_sel');
        }
        else {
            $('#choice_item_1').removeClass('choice_item_sel');
        }
        var $cart = $('#selected-seats');
        $count = $('#counter');
        sc = $('#seat-map').seatCharts({
            map:stringToMap(map_s),
            seats:{
                a: {
                    price: 540,
                    classes: 'a',
                    category: '一等座未售'
                },
                b:{
                    price:360,
                    classes: 'b',
                    category: '二等座未售'
                },
                c:{
                    price:180,
                    classes: 'c',
                    category: '三等座未售'
                },
                d:{
                    price:80,
                    classes: 'd',
                    category: '四等座未售'
                },
                u:{
                    price:-1,
                    classes: 'u',
                    category: '不可选未售'
                },
                s:{
                    price:-1,
                    classes: 's',
                    category: '未入场'
                },
                i:{
                    price:-1,
                    classes: 'i',
                    category: '已入场'
                }
            },
            legend:{
                node:$('#legend'),
                items:[
                    ['a','available','一等座未售'],
                    ['b','available','二等座未售'],
                    ['c','available','三等座未售'],
                    ['d','available','四等座未售'],
                    ['u','unavailable','不可选'],
                    ['s','sold','未入场'],
                    ['i','in','已入场']
                ]
            },
            click:function(){
                if(this.status() == 'selected'){
                    $count.text(sc.find('selected').length-1);
                    $('#cart-item-'+this.settings.id).remove();
                    var temp = map_t[this.settings.row];
                    var temp2 = temp.split('');
                    temp2.splice(this.settings.label-1,1,'s');
                    temp = temp2.join('');
                    map_t[this.settings.row] = temp;
                    seats.delete((this.settings.row+1)+'排'+this.settings.label+'座');
                    if((sc.find('selected').length-1)===0){
                        sc.find('a.unavailable').status('available');
                        sc.find('b.unavailable').status('available');
                        sc.find('c.unavailable').status('available');
                        sc.find('d.unavailable').status('available');
                        mark=0;
                    }
                    return 'sold';
                }
                if(this.status() == 'sold'){
                    mark=1;
                    $('<li>'+(this.settings.row+1)+'排'+this.settings.label+'座</li>').attr('id','cart-item-'+this.settings.id)
                        .data('seatId',this.settings.id).appendTo($cart);
                    $count.text(sc.find('selected').length+1);
                    var temp = map_t[this.settings.row];
                    var temp2 = temp.split('');
                    temp2.splice(this.settings.label-1,1,'i');
                    temp = temp2.join('');
                    map_t[this.settings.row] = temp;
                    seats.add((this.settings.row+1)+'排'+this.settings.label+'座');
                    if((sc.find('selected').length+1)===1){
                        sc.find('a.available').status('unavailable');
                        sc.find('b.available').status('unavailable');
                        sc.find('c.available').status('unavailable');
                        sc.find('d.available').status('unavailable');
                    }
                    return 'selected';
                }else if(this.status() == 'unavailable'){
                    return 'unavailable';
                }
                else if(this.status() == 'available'){
                    mark=2;
                    $('<li>'+(this.settings.row+1)+'排'+this.settings.label+'座</li>').attr('id','cart-item-'+this.settings.id)
                        .data('seatId',this.settings.id).appendTo($cart);
                    $count.text(sc.find('temp').length+1);
                    $span2.text(getTotal(sc) + this.data().price);
                    var temp = map_t[this.settings.row];
                    var temp2 = temp.split('');
                    temp2.splice(this.settings.label-1,1,'i');
                    temp = temp2.join('');
                    map_t[this.settings.row] = temp;
                    seats.add((this.settings.row+1)+'排'+this.settings.label+'座');
                    if((sc.find('temp').length+1)===1){
                        sc.find('s.sold').status('unavailable');
                    }
                    return 'temp';
                }
                else if(this.status() == 'in'){
                    return 'in';
                }
                else if(this.status() == 'temp'){
                    $count.text(sc.find('temp').length-1);
                    $span2.text(getTotal(sc) - this.data().price);
                    $('#cart-item-'+this.settings.id).remove();
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
                    if((sc.find('temp').length-1)===0){
                        sc.find('s.unavailable').status('sold');
                        mark=0;
                    }
                    return 'available';
                }
                else{
                    return this.style();
                }
            }
        });
        sc.find('u.available').status('unavailable');
        sc.find('s.available').status('sold');
        sc.find('i.available').status('in');
    };
    function cin(){
        if(mark===0){
            alert("请先选座");
        }
        else if(mark===2){
            alert("请选择已出售的座位再入场")
        }
        else {
            var seat_s = '';
            for(var v of seats){
                seat_s = seat_s + v + ',';
            }
            seat_s =  seat_s.substring(0,seat_s.length-1);
            console.log(map_t);
            $.post("/Checkin",{map:mapToString(map_t)},function () {
                alert(seat_s+' 已入场');
                location.reload();
            },'text');
        }
    };
    function xcin() {
        if(mark===0){
            alert("请先选座");
        }
        else if(mark===1){
            alert("请选择未出售的座位再购买")
        }
        else {
            var seat_s = '';
            for(var v of seats){
                seat_s = seat_s + v + '*';
            }
            seat_s =  seat_s.substring(0,seat_s.length-1);
            $.get("/CheckinHelp",{total:getTotal(sc),email:$name.val(),pass:$pass.val(),seats:encodeURI(seat_s),map:mapToString(map_t)},function (data) {
                alert(data);
                location.reload();
            },'text');

        }
    };
    getTotal = function(sc){
        var total = 0;
        sc.find('temp').each(function(){
            total += this.data().price;
        });
        return total;
    };
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
