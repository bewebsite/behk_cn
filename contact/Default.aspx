﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="contact_Default" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育|必益介绍</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/about.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>
    <script src="join.js" type="text/javascript"></script>
    <style type="text/css">
        html, body
        {
            margin: 0;
            padding: 0;
        }
        .iw_poi_title
        {
            color: #CC5522;
            font-size: 14px;
            font-weight: bold;
            overflow: hidden;
            padding-right: 13px;
            white-space: nowrap;
        }
        .iw_poi_content
        {
            font: 12px arial,sans-serif;
            overflow: visible;
            padding-top: 4px;
            white-space: -moz-pre-wrap;
            word-wrap: break-word;
        }
    </style>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="about-wrap">
        <div class="clear">
        </div>
        <div class="about-main">
            <div class="ab-crumbs">
                <a href="/">
                    <img src="../images/about/ic-home.png" /></a><em>></em><span>联系我们</span>
            </div>
            <div class="contact">
                <div class="map">
                    <div style="width: 665px; height: 315px; border: #ccc solid 1px;" id="dituContent">
                    </div>
</body>
</div>
<div class="contact-meg">
    <h4>
        上海（总部）</h4>
    <p>
        上海市静安区长寿路1111号悦达889中心9楼02A-05室</p>
    <div class="mesg">
        <p>
            <span>电子邮箱：</span>go@behk.org</p>
        <p>
            <span>联系电话：</span>800-850-4118</p>
        <p>
            <span>官方微博：</span>必益教育</p>
        <p>
            <span>官方微信：</span>BEeducation</p>
        <p>
            <span>助手微信：</span>behk889</p>
        <p>
            <span>邮 编：</span>200042</p>
    </div>
</div>
</div>


<div class="row" style="
    height: 200px;
    /* width: 300px; */
    /* float: left; */
    /* width: 300px; */
">
<div class="span4" style="
    width: 330px;
    float: left;
    padding: 20px;
">
<h2>北京</h2>
<address>北京市朝阳区建外大街1号中国国际贸易中心1塔27层29-31室<br>邮编：100021<br>电话：+86 (0)10 6586 9979<br>            传真：+86 (0)10 6586 5576<br>电子邮件: info.beijing@behk.org</address>
</div>
<div class="span4" style="
    width: 330px;
    float: left;
    padding: 20px;
">
<h2>深圳</h2>
    <address>深圳市罗湖区深南中路与和平路交汇处鸿隆世纪广场B座27E <br> 邮编：518000<br> 电话：+86 (0)755 8277 6061<br>     传真：+86 (0)755 8277 6065<br>电子邮件：info.shenzhen@behk.org</address></div>  
<div class="span4" style="
    width: 330px;
    float: left;
    padding: 20px;
">
<h2>成都</h2>
    <address>四川省成都市锦江区东御街18号百扬大厦3105室<br>邮编：610051<br>电话：+86 (0)28 8618 0180<br>       传真：+86 (0)28 8652 8653<br>电子邮件：info.chengdu@behk.org</address>
</div></div>

<div class="row" style="
    height: 200px;
">
<div class="span6" style="
    padding: 20px;
    float: left;
    width: 500px;
">
    <div class="visible-desktop">
<h2>牛津</h2>
        <address>Emma Vanbergen<br> 伦敦切特豪斯路107号4楼<br>E: evb@behk.org<br><br><br><br></address></div>
</div>
    
     <!---->
     
    <!---->
    
    <div class="span6" style="
    padding: 20px;
    float: left;
    width: 500px;
">
        <div class="visible-desktop">
<h2>天津</h2>
<address>天津市和平区南京路189号津汇广场写字楼2座27楼2705室 <br>  邮编：300051<br> 电话：+86(0)22 2330 2318</address>
        </div></div></div>


        
<div class="leaveMeg">
    <h3 class="leaveMeg-h">
        留言板</h3>
    <div class="leaveMeg-c">
        <p class="meg-tips">
            请致电 400-850-4118 或填写以下表格，我们将于24小时内及时与您联系。</p>
        <div class="clear">
        </div>
        <div class="online-c online-l">
            <div class="online-item">
                <label>
                    <em>*</em>您的姓名</label><input type="text" id="p_Name" /></div>
            <div class="online-item">
                <label>
                    <em>*</em>联络手机</label><input type="text" id="p_Mobile" /></div>
            <div class="online-item">
                <label>
                    <em>*</em>邮箱地址</label><input type="text" id="p_Email" /></div>
        </div>
        <div class="online-c online-r">
            <div class="online-item">
                <label>
                    <em></em>所在城市</label><input type="text" id="p_City" /></div>
            <div class="online-item">
                <label>
                    <em></em>留言</label><textarea id="p_Intor"></textarea></div>
        </div>
        <div class="clear">
        </div>
        <div class="getM">
            <h3>
                我对以下服务或免费资料感兴趣</h3>
            <ul class="mlist clearfix" id="infolist">
                <li>
                    <label>
                        <input type="checkbox" value="教育咨询" />教育咨询</label></li>
                <li>
                    <label>
                        <input type="checkbox" value="必益学院辅导" />必益学院辅导</label></li>
                <li>
                    <label>
                        <input type="checkbox" value="短期游学" />短期游学</label></li>
                <li>
                    <label>
                        <input type="checkbox" value="必益线上课程" />必益线上课程</label></li>
                
                <li>
                    <label>
                        <input type="checkbox" value="牛津国际公学" />牛津国际公学</label></li>
                <li>
                    <label>
                        <input type="checkbox" value="Application for a British School Guide" />Application for a British School Guide</label></li>
                <li>
                    <label>
                        <input type="checkbox" value="申请一份英文版名校指南" />申请一份英文版名校指南
                    </label>
                </li>
                
                <li>
                    <label>
                        <input type="checkbox" value="申请一份美国名校指南" />申请一份美国名校指南</label></li>
                
            </ul>
        </div>
        <p class="l-btn">
            <a href="javascript:void(0)" onclick="JoinComment()">点击完成申请</a></p>
    </div>
</div>
</div> </div>
<uc2:footer ID="footer1" runat="server" />
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap() {
        createMap(); //创建地图
        setMapEvent(); //设置地图事件
        addMapControl(); //向地图添加控件
        addMarker(); //向地图中添加marker
    }

    //创建地图函数：
    function createMap() {
        var map = new BMap.Map("dituContent"); //在百度地图容器中创建一个地图
        var point = new BMap.Point(121.434455, 31.236345); //定义一个中心点坐标
        map.centerAndZoom(point, 17); //设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map; //将map变量存储在全局
    }

    //地图事件设置函数：
    function setMapEvent() {
        map.enableDragging(); //启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
        map.enableDoubleClickZoom(); //启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard(); //启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl() {
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE });
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        var ctrl_ove = new BMap.OverviewMapControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 0 });
        map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT });
        map.addControl(ctrl_sca);
    }

    //标注点数组
    var markerArr = [{ title: "必益教育", content: "上海市静安区长寿路1111号悦达889中心9楼02A-05室", point: "121.434482|31.236068", isOpen: 1, icon: { w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5} }
		 ];
    //创建marker
    function addMarker() {
        for (var i = 0; i < markerArr.length; i++) {
            var json = markerArr[i];
            var p0 = json.point.split("|")[0];
            var p1 = json.point.split("|")[1];
            var point = new BMap.Point(p0, p1);
            var iconImg = createIcon(json.icon);
            var marker = new BMap.Marker(point, { icon: iconImg });
            var iw = createInfoWindow(i);
            var label = new BMap.Label(json.title, { "offset": new BMap.Size(json.icon.lb - json.icon.x + 10, -20) });
            marker.setLabel(label);
            map.addOverlay(marker);
            label.setStyle({
                borderColor: "#808080",
                color: "#333",
                cursor: "pointer"
            });

            (function () {
                var index = i;
                var _iw = createInfoWindow(i);
                var _marker = marker;
                _marker.addEventListener("click", function () {
                    this.openInfoWindow(_iw);
                });
                _iw.addEventListener("open", function () {
                    _marker.getLabel().hide();
                })
                _iw.addEventListener("close", function () {
                    _marker.getLabel().show();
                })
                label.addEventListener("click", function () {
                    _marker.openInfoWindow(_iw);
                })
                if (!!json.isOpen) {
                    label.hide();
                    _marker.openInfoWindow(_iw);
                }
            })()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i) {
        var json = markerArr[i];
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>" + json.content + "</div>");
        return iw;
    }
    //创建一个Icon
    function createIcon(json) {
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w, json.h), { imageOffset: new BMap.Size(-json.l, -json.t), infoWindowOffset: new BMap.Size(json.lb + 5, 1), offset: new BMap.Size(json.x, json.h) })
        return icon;
    }

    initMap(); //创建和初始化地图
</script>
</body>
</html>