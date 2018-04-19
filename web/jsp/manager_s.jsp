<%--
  Created by IntelliJ IDEA.
  User: zhuanggangqing
  Date: 2018/3/28
  Time: 上午10:29
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

    <link href="../css/manager.css" rel="stylesheet">

    <style>
        canvas{
            border: 1px solid #A4E2F9;
        }
    </style>
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
                        <li ><a href="/Manager_info">场馆信息更改确认</a></li>
                        <li><a href="/Manager_pay">金额结算</a> </li>
                        <li class="active"><a href="/Manager_s">统计信息</a> </li>
                        <li><a href="/Manager_m">财务变化</a> </li>
                    </ul>
                </div>
                <div class="panel-body">
                    <div>演出信息统计:</div>
                    <div height="400" width="600" style="margin:50px">
                        <canvas id="chart"> 你的浏览器不支持HTML5 canvas </canvas>
                    </div>
                </div>
                <div class="panel-body">
                    <div>用户信息统计:</div>
                    <div height="400" width="600" style="margin:50px">
                        <canvas id="chart2"> 你的浏览器不支持HTML5 canvas </canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    function goChart(dataArr){

        // 声明所需变量
        var canvas,ctx;
        // 图表属性
        var cWidth, cHeight, cMargin, cSpace;
        // 饼状图属性
        var radius,ox,oy;//半径 圆心
        var tWidth, tHeight;//图例宽高
        var posX, posY, textX, textY;
        var startAngle, endAngle;
        var totleNb;
        // 运动相关变量
        var ctr, numctr, speed;
        //鼠标移动
        var mousePosition = {};

        //线条和文字
        var lineStartAngle,line,textPadding,textMoveDis;

        // 获得canvas上下文
        canvas = document.getElementById("chart");
        if(canvas && canvas.getContext){
            ctx = canvas.getContext("2d");
        }
        initChart();

        // 图表初始化
        function initChart(){
            // 图表信息
            cMargin = 20;
            cSpace = 40;

            canvas.width = canvas.parentNode.getAttribute("width")* 2 ;
            canvas.height = canvas.parentNode.getAttribute("height")* 2;
            canvas.style.height = canvas.height/2 + "px";
            canvas.style.width = canvas.width/2 + "px";
            cHeight = canvas.height - cMargin*2;
            cWidth = canvas.width - cMargin*2;

            //饼状图信息
            radius = cHeight*2/6;  //半径  高度的2/6
            ox = canvas.width/2 + cSpace;  //圆心
            oy = canvas.height/2;
            tWidth = 60; //图例宽和高
            tHeight = 20;
            posX = cMargin;
            posY = cMargin;   //
            textX = posX + tWidth + 15
            textY = posY + 18;
            startAngle = endAngle = 90*Math.PI/180; //起始弧度 结束弧度
            rotateAngle = 0; //整体旋转的弧度

            //将传入的数据转化百分比
            totleNb = 0;
            new_data_arr = [];
            for (var i = 0; i < dataArr.length; i++){
                totleNb += dataArr[i][0];
            }
            for (var i = 0; i < dataArr.length; i++){
                new_data_arr.push( dataArr[i][0]/totleNb );
            }
            totalYNomber = 10;
            // 运动相关
            ctr = 1;//初始步骤
            numctr = 50;//步骤
            speed = 1.2; //毫秒 timer速度

            //指示线 和 文字
            lineStartAngle = -startAngle;
            line=40;         //画线的时候超出半径的一段线长
            textPadding=10;  //文字与线之间的间距
            textMoveDis = 200; //文字运动开始的间距
        }

        drawMarkers();
        //绘制比例图及文字
        function drawMarkers(){
            ctx.textAlign="left";
            for (var i = 0; i < dataArr.length; i++){
                //绘制比例图及文字
                ctx.fillStyle = dataArr[i][1];
                ctx.fillRect(posX, posY + 40 * i, tWidth, tHeight);
                ctx.moveTo(posX, posY + 40 * i);
                ctx.font = 'normal 24px 微软雅黑';    //斜体 30像素 微软雅黑字体
                ctx.fillStyle = dataArr[i][1]; //"#000000";
                var percent = dataArr[i][2] + "：" + parseInt(100 * new_data_arr[i]) + "%";
                ctx.fillText(percent, textX, textY + 40 * i);
            }
        };

        //绘制动画
        pieDraw();
        function pieDraw(mouseMove){

            for (var n = 0; n < dataArr.length; n++){
                ctx.fillStyle = ctx.strokeStyle = dataArr[n][1];
                ctx.lineWidth=1;
                var step = new_data_arr[n]* Math.PI * 2; //旋转弧度
                var lineAngle = lineStartAngle+step/2;   //计算线的角度
                lineStartAngle += step;//结束弧度

                ctx.beginPath();
                var  x0=ox+radius*Math.cos(lineAngle),//圆弧上线与圆相交点的x坐标
                    y0=oy+radius*Math.sin(lineAngle),//圆弧上线与圆相交点的y坐标
                    x1=ox+(radius+line)*Math.cos(lineAngle),//圆弧上线与圆相交点的x坐标
                    y1=oy+(radius+line)*Math.sin(lineAngle),//圆弧上线与圆相交点的y坐标
                    x2=x1,//转折点的x坐标
                    y2=y1,
                    linePadding=ctx.measureText(dataArr[n][2]).width+10; //获取文本长度来确定折线的长度

                ctx.moveTo(x0,y0);
                //对x1/y1进行处理，来实现折线的运动
                yMove = y0+(y1-y0)*ctr/numctr;
                ctx.lineTo(x1,yMove);
                if(x1<=x0){
                    x2 -= line;
                    ctx.textAlign="right";
                    ctx.lineTo(x2-linePadding,yMove);
                    ctx.fillText(dataArr[n][2],x2-textPadding-textMoveDis*(numctr-ctr)/numctr,y2-textPadding);
                }else{
                    x2 += line;
                    ctx.textAlign="left";
                    ctx.lineTo(x2+linePadding,yMove);
                    ctx.fillText(dataArr[n][2],x2+textPadding+textMoveDis*(numctr-ctr)/numctr,y2-textPadding);
                }

                ctx.stroke();

            }

            //设置旋转
            ctx.save();
            ctx.translate(ox, oy);
            ctx.rotate((Math.PI*2/numctr)*ctr/2);

            //绘制一个圆圈
            ctx.strokeStyle = "rgba(0,0,0,"+ 0.5*ctr/numctr +")"
            ctx.beginPath();
            ctx.arc(0, 0 ,(radius+20)*ctr/numctr, 0, Math.PI*2, false);
            ctx.stroke();

            for (var j = 0; j < dataArr.length; j++){

                //绘制饼图
                endAngle = endAngle + new_data_arr[j]* ctr/numctr * Math.PI * 2; //结束弧度

                ctx.beginPath();
                ctx.moveTo(0,0); //移动到到圆心
                ctx.arc(0, 0, radius*ctr/numctr, startAngle, endAngle, false); //绘制圆弧

                ctx.fillStyle = dataArr[j][1];
                if(mouseMove && ctx.isPointInPath(mousePosition.x*2, mousePosition.y*2)){
                    ctx.globalAlpha = 0.8;
                }

                ctx.closePath();
                ctx.fill();
                ctx.globalAlpha = 1;

                startAngle = endAngle; //设置起始弧度
                if( j == dataArr.length-1 ){
                    startAngle = endAngle = 90*Math.PI/180; //起始弧度 结束弧度
                }
            }

            ctx.restore();

            if(ctr<numctr){
                ctr++;
                setTimeout(function(){
                    //ctx.clearRect(-canvas.width,-canvas.width,canvas.width*2, canvas.height*2);
                    ctx.clearRect(-canvas.width, -canvas.height,canvas.width*2, canvas.height*2);
                    drawMarkers();
                    pieDraw();
                }, speed*=1.085);
            }
        }

        //监听鼠标移动
        var mouseTimer = null;
        canvas.addEventListener("mousemove",function(e){
            e = e || window.event;
            if( e.offsetX || e.offsetX==0 ){
                mousePosition.x = e.offsetX;
                mousePosition.y = e.offsetY;
            }else if( e.layerX || e.layerX==0 ){
                mousePosition.x = e.layerX;
                mousePosition.y = e.layerY;
            }

            clearTimeout(mouseTimer);
            mouseTimer = setTimeout(function(){
                ctx.clearRect(0,0,canvas.width, canvas.height);
                drawMarkers();
                pieDraw(true);
            },10);
        });

    }

    var chartData = [[67,"#2dc6c8","演唱会"], [75,"#b6a2dd", "话剧歌剧"], [44,"#5ab1ee","曲苑杂坛"], [39,"#d7797f","音乐会"]];

    goChart(chartData);


</script>
<script type="text/javascript">
    function goChart(dataArr){

        // 声明所需变量
        var canvas2,ctx;
        // 图表属性
        var cWidth, cHeight, cMargin, cSpace;
        // 饼状图属性
        var radius,ox,oy;//半径 圆心
        var tWidth, tHeight;//图例宽高
        var posX, posY, textX, textY;
        var startAngle, endAngle;
        var totleNb;
        // 运动相关变量
        var ctr, numctr, speed;
        //鼠标移动
        var mousePosition = {};

        //线条和文字
        var lineStartAngle,line,textPadding,textMoveDis;

        // 获得canvas上下文
        canvas2 = document.getElementById("chart2");
        if(canvas2 && canvas2.getContext){
            ctx = canvas2.getContext("2d");
        }
        initChart();

        // 图表初始化
        function initChart(){
            // 图表信息
            cMargin = 20;
            cSpace = 40;

            canvas2.width = canvas2.parentNode.getAttribute("width")* 2 ;
            canvas2.height = canvas2.parentNode.getAttribute("height")* 2;
            canvas2.style.height = canvas2.height/2 + "px";
            canvas2.style.width = canvas2.width/2 + "px";
            cHeight = canvas2.height - cMargin*2;
            cWidth = canvas2.width - cMargin*2;

            //饼状图信息
            radius = cHeight*2/6;  //半径  高度的2/6
            ox = canvas2.width/2 + cSpace;  //圆心
            oy = canvas2.height/2;
            tWidth = 60; //图例宽和高
            tHeight = 20;
            posX = cMargin;
            posY = cMargin;   //
            textX = posX + tWidth + 15
            textY = posY + 18;
            startAngle = endAngle = 90*Math.PI/180; //起始弧度 结束弧度
            rotateAngle = 0; //整体旋转的弧度

            //将传入的数据转化百分比
            totleNb = 0;
            new_data_arr2= [];
            for (var i = 0; i < dataArr.length; i++){
                totleNb += dataArr[i][0];
            }
            for (var i = 0; i < dataArr.length; i++){
                new_data_arr2.push( dataArr[i][0]/totleNb );
            }
            totalYNomber = 10;
            // 运动相关
            ctr = 1;//初始步骤
            numctr = 50;//步骤
            speed = 1.2; //毫秒 timer速度

            //指示线 和 文字
            lineStartAngle = -startAngle;
            line=40;         //画线的时候超出半径的一段线长
            textPadding=10;  //文字与线之间的间距
            textMoveDis = 200; //文字运动开始的间距
        }

        drawMarkers();
        //绘制比例图及文字
        function drawMarkers(){
            ctx.textAlign="left";
            for (var i = 0; i < dataArr.length; i++){
                //绘制比例图及文字
                ctx.fillStyle = dataArr[i][1];
                ctx.fillRect(posX, posY + 40 * i, tWidth, tHeight);
                ctx.moveTo(posX, posY + 40 * i);
                ctx.font = 'normal 24px 微软雅黑';    //斜体 30像素 微软雅黑字体
                ctx.fillStyle = dataArr[i][1]; //"#000000";
                var percent = dataArr[i][2] + "：" + parseInt(100 * new_data_arr2[i]) + "%";
                ctx.fillText(percent, textX, textY + 40 * i);
            }
        };

        //绘制动画
        pieDraw();
        function pieDraw(mouseMove){

            for (var n = 0; n < dataArr.length; n++){
                ctx.fillStyle = ctx.strokeStyle = dataArr[n][1];
                ctx.lineWidth=1;
                var step = new_data_arr2[n]* Math.PI * 2; //旋转弧度
                var lineAngle = lineStartAngle+step/2;   //计算线的角度
                lineStartAngle += step;//结束弧度

                ctx.beginPath();
                var  x0=ox+radius*Math.cos(lineAngle),//圆弧上线与圆相交点的x坐标
                    y0=oy+radius*Math.sin(lineAngle),//圆弧上线与圆相交点的y坐标
                    x1=ox+(radius+line)*Math.cos(lineAngle),//圆弧上线与圆相交点的x坐标
                    y1=oy+(radius+line)*Math.sin(lineAngle),//圆弧上线与圆相交点的y坐标
                    x2=x1,//转折点的x坐标
                    y2=y1,
                    linePadding=ctx.measureText(dataArr[n][2]).width+10; //获取文本长度来确定折线的长度

                ctx.moveTo(x0,y0);
                //对x1/y1进行处理，来实现折线的运动
                yMove = y0+(y1-y0)*ctr/numctr;
                ctx.lineTo(x1,yMove);
                if(x1<=x0){
                    x2 -= line;
                    ctx.textAlign="right";
                    ctx.lineTo(x2-linePadding,yMove);
                    ctx.fillText(dataArr[n][2],x2-textPadding-textMoveDis*(numctr-ctr)/numctr,y2-textPadding);
                }else{
                    x2 += line;
                    ctx.textAlign="left";
                    ctx.lineTo(x2+linePadding,yMove);
                    ctx.fillText(dataArr[n][2],x2+textPadding+textMoveDis*(numctr-ctr)/numctr,y2-textPadding);
                }

                ctx.stroke();

            }

            //设置旋转
            ctx.save();
            ctx.translate(ox, oy);
            ctx.rotate((Math.PI*2/numctr)*ctr/2);

            //绘制一个圆圈
            ctx.strokeStyle = "rgba(0,0,0,"+ 0.5*ctr/numctr +")"
            ctx.beginPath();
            ctx.arc(0, 0 ,(radius+20)*ctr/numctr, 0, Math.PI*2, false);
            ctx.stroke();

            for (var j = 0; j < dataArr.length; j++){

                //绘制饼图
                endAngle = endAngle + new_data_arr2[j]* ctr/numctr * Math.PI * 2; //结束弧度

                ctx.beginPath();
                ctx.moveTo(0,0); //移动到到圆心
                ctx.arc(0, 0, radius*ctr/numctr, startAngle, endAngle, false); //绘制圆弧

                ctx.fillStyle = dataArr[j][1];
                if(mouseMove && ctx.isPointInPath(mousePosition.x*2, mousePosition.y*2)){
                    ctx.globalAlpha = 0.8;
                }

                ctx.closePath();
                ctx.fill();
                ctx.globalAlpha = 1;

                startAngle = endAngle; //设置起始弧度
                if( j == dataArr.length-1 ){
                    startAngle = endAngle = 90*Math.PI/180; //起始弧度 结束弧度
                }
            }

            ctx.restore();

            if(ctr<numctr){
                ctr++;
                setTimeout(function(){
                    //ctx.clearRect(-canvas.width,-canvas.width,canvas.width*2, canvas.height*2);
                    ctx.clearRect(-canvas2.width, -canvas2.height,canvas2.width*2, canvas2.height*2);
                    drawMarkers();
                    pieDraw();
                }, speed*=1.085);
            }
        }

        //监听鼠标移动
        var mouseTimer = null;
        canvas2.addEventListener("mousemove",function(e){
            e = e || window.event;
            if( e.offsetX || e.offsetX==0 ){
                mousePosition.x = e.offsetX;
                mousePosition.y = e.offsetY;
            }else if( e.layerX || e.layerX==0 ){
                mousePosition.x = e.layerX;
                mousePosition.y = e.layerY;
            }

            clearTimeout(mouseTimer);
            mouseTimer = setTimeout(function(){
                ctx.clearRect(0,0,canvas2.width, canvas2.height);
                drawMarkers();
                pieDraw(true);
            },10);
        });

    }

    var chartData2 = [[3,"#2dc6c8","一级会员"], [1,"#b6a2dd", "二级会员"], [1,"#5ab1ee","三级会员"], [1,"#d7797f","四级会员"]];

    goChart(chartData2);


</script>
</body>
</html>