<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="activity_detail" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<%@ Register Src="../ascx/navHotEvents.ascx" TagName="navHotEvents" TagPrefix="uc3" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育-院校列表</title>
    <meta name="Keywords" content="" runat="server" id="Key" />
    <meta name="Description" content="" runat="server" id="Des" />
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="../css/events.css" rel="stylesheet" type="text/css" />
    <link href="../css/v.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/kxbdSuperMarquee.js" type="text/javascript"></script>
    <script src="../js/school-index-slide.js" type="text/javascript"></script>
    <script src="../js/common.js" type="text/javascript"></script>
    <script src="../js/layer/layer.js" type="text/javascript"></script>
    <script src="../js/base.js" type="text/javascript"></script>
    <script src="js/detail.js" type="text/javascript"></script>
    <script src="/temp/js/temp.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=1c9YkfkNeWYx4CPiXKIYiDe6"></script>
    <script>
        $(function () {
            $(".slideBanner3").swBanner({
                w: 202
            });

            //在线咨询
            $_body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body');
            $(".go-Lmeg a").bind("click", function () {
                var nTop = $("#registration").offset().top;
                $_body.stop().animate({ scrollTop: nTop }, "normal");
            })
        })
    </script>


</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="wrap">
        <div class="wrapMain">
            <div class="clear">
            </div>
            <div class="mbx">
                <a href="/">
                    <img src="../images/icon-home.png"></a> <em></em><a href="/events/">精彩活动</a><em></em><label><%=L.CNTitle %></label>
            </div>
            <div class="clear">
            </div>
            <div class="list-left">
                <div class="item-1">
                    <div class="clearfix">
                        <div class="leftImg">
                            <div class="slideBanner3">
                                <div class="imglist">
                                    <ul>
                                        <asp:Repeater runat="server" ID="repImage">
                                            <ItemTemplate>
                                                <li>
                                                    <img width="202" height="214" alt="<%=L.CNTitle %>" src="<%#Eval("Image") %>"></li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                                <div class="popBar">
                                    <h3 class="title">
                                    </h3>
                                    <div class="anniu">
                                        <a href="javascript:;" class="cur"></a><a href="javascript:;"></a><a href="javascript:;">
                                        </a>
                                    </div>
                                </div>
                                <a class="btn btn-left" href="javascript:void(0);"></a><a class="btn btn-right" href="javascript:void(0);">
                                </a>
                            </div>
                        </div>
                        <div class="rightTxt">
                            <h1>
                                <%=L.CNTitle %></h1>
                            <h2>
                                <%=L.ENTitle %>
                            </h2>
                            <p class="even">
                                <span><b>活动日期：</b><%=L.StarDay %></span> <span><b>活动时间：</b><%=L.StarTimer %></span>
                            </p>
                            <p class="odd clearfix">
                                <span><b>活动地点：</b></span><em><%=L.Address %></em>
                            </p>
                            <p class="even">
                                <span><b>活动联络人：</b><%=L.ContactName%></span> <span><b>联络人邮件：</b><%=L.ContactEmail %></span>
                            </p>
                            <p>
                                <b>联络人电话：</b><%=L.ContactMobile %>
                            </p>
                        </div>
                    </div>
                    <div class="text">
                        <%=L.Intor %>
                    </div>
                    <div class="contact">
                        <span>已有 <em>
                            <%=L.RegistrationNumber %></em> 人参与报名了</span> <a onclick="openChat('g')" href="javascript:void(0)">
                                <i>
                                    <img src="../images/icon-a.png" /></i>点击在线报名吧</a>
                    </div>
                </div>
                <div class="item-2">
                    <div class="top-tit-bar">
                        <i>
                            <img src="../images/icon-s.png" /></i>活动亮点
                    </div>
                    <div class="text">
                        <ul>
                            <%=L.Highlights%>
                        </ul>
                    </div>
                </div>
                <div class="item-3">

                    <asp:Repeater runat="server" ID="repGuest">
                        <ItemTemplate>
                            <div class="top-tit-bar">
                                <i>
                                    <img src="/schools/images/icon-6.png" /></i>活动嘉宾
                            </div>
                            <div class="con">
                                <div class="img">
                                    <img src="<%#Eval("Image")%>"></div>
                                <div class="top">
                                    <h3>
                                        <%#Eval("Name")%></h3>
                                    <p>
                                        <%#Eval("En_Name")%></p>
                                    <div class="clearfix">
                                        <span class="t">职衔: </span>
                                        <%#Eval("Position")%>
                                    </div>
                                </div>
                                <div class="bom">
                                   <%#Eval("Introduction")%>
                                </div>
                                <asp:Panel runat="server" Visible='<%#Eval("Cn_Topic") != null %>'>
                                <div class="oque">
                                    <i class="bg1"></i><i class="bg2"></i>
                                    <h3>
                                        讲座题目 Lecture topic</h3>
                                    <div class="txt">
                                        <i class="bg3"></i><i class="bg4"></i>
                                        <ul>
                                            <li>
                                                <p>
                                                    <%#Eval("Cn_Topic")%></p>
                                                <p>
                                                    <%#Eval("En_Topic")%>
                                                </p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                </asp:Panel>
                            </div>
                            <br />
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
                <div class="item-4">
                    <div class="top-tit-bar">
                        <i>
                            <img src="../images/icon-j.png" /></i>活动报名信息 <a href="#registration">立刻报名</a>
                    </div>
                    <div class="con">
                        <p>
                            <span>
                                <img src="../images/iconj.jpg" />报名时间:</span><em><%=L.EnrollStar.Value.ToString("yyyy年MM月dd日") %>
                                    至
                                    <%=L.EnrollEnd.Value.ToString("yyyy年MM月dd日") %></em> <span>
                                        <img src="../images/iconj.jpg" />活动最多报名人数:</span><%=L.AllNum %>人</p>
                        <h3>
                            活动报名说明</h3>
                        <div class="txt">
                            <%=L.EnrollInfo %>
                        </div>
                    </div>
                </div>
                <div class="item-5">
                    <div class="top-tit-bar">
                        <i>
                            <img src="../images/icon-d.png" /></i>活动详情
                    </div>
                    <div class="con">
                        <div class="top">
                            <p>
                                <b>适用城市：</b><%=GetInfo(L.RelevantCity) %></p>
                            <p class="even">
                                <span><b>活动相关留学国家：</b><%=GetInfo(L.RelevantCountry) %></span><span><b>适用人群类别：<%=L.CrowdCategory %></b></span><span><b>必益相关业务：</b><%=GetInfo(L.RelevantBusiness)%></span></p>
                            <p>
                                <span><b>适用学习阶段：</b><%=GetInfo(L.RelevantLevels) %></span><span><b>适用人群年龄：</b><%=L.StarAge %>-<%=L.EndAge %>岁</span><span><b>适用人群类型：</b><%=GetInfo(L.RelevantCategories) %></span></p>
                            <p class="even">
                                <b>适用人群描述：</b><%=L.CategoriesIntroduction%></p>
                        </div>
                        <div class="bg bg1">
                        </div>
                        <div class="txt">
                            <%=L.Content %>
                        </div>
                        <div class="bg bg2">
                        </div>
                    </div>
                </div>
                <div class="block block13" <%=HaveVoide %>>
                    <div class="top">
                        <span>活动视频</span>
                    </div>
                    <div class="list">
                        <ul class="clearfix">
                            <asp:Repeater runat="server" ID="repVoide">
                                <ItemTemplate>
                                    <li><a target="_blank" href="<%#Eval("VoideUrl") %>" title="<%#Eval("Title") %>">
                                        <div class="img">
                                            <p class="popVideo">
                                                <i class="i"></i>
                                            </p>
                                            <img style="width: 260px; height: 140px" src="<%#Eval("Image") %>"></div>
                                        <span>
                                            <%#Eval("Title") %></span> </a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
                
<!-- 与产品页一致的注册表 -->
                <div class="wrap-9" id="registration">
            <div class="titbar">
                <em></em>
                <h3>
                    现在免费报名参加</h3>
                <span><em>book your place now</em></span>
            </div>
            <div class="bookClear clearfix" style="width:880px;">
                <div class="left" style="width:400px;margin-top: -50px;">
                    
                    <dl class="clearfix" style="margin-left:20px;">
    
        <dl class="clearfix">
            <dt>
                <img src="/guide/images/ic1.png" /></dt>
            <dd>
                <p class="p1">
                    电话报名:</p>
                <p>
                    现在拨打活动预约专线 400 850 4118预约您和家人的席位</p>
            </dd>
        </dl>
        <dl class="clearfix">
            <dt>
                <img src="/guide/images/ic2.png" /></dt>
            <dd>
                <p class="p1">
                    微信报名:</p>
                <p>
                    添加必益教育微信官号 BEeducation、发送信息 &ldquo;您的姓名<br/>+手机号+假期游学&rdquo;</p>
            </dd>
        </dl>
        <dl class="clearfix">
            <dt>
                <img src="/guide/images/ic3.png" /></dt>
            <dd>
                <p class="p1">
                    联络顾问 :</p>
                <p>
                    联络您熟悉的必益教育顾问，预约您和家人的席位</p>
            </dd>
        </dl>
        <dl class="clearfix">
            <dt>
                <img src="/guide/images/ic4.png" /></dt>
                <dd>
        <p class="p1">
            网站报名 :</p>
        <p>
            正确填写右侧表单信息，预约您和家人的席位</p>
        </dd>
        </dl>
    
</dl>
<p style="margin-left: 55px; color: rgb(153, 153, 153);">
    注：请遵守国家法规，自觉使用文明用语。</p>

                </div>
            
                <div class="right">
                    <div class="clearfix">
                        <div class="item">
                            <span><em style="color:red">*</em>&nbsp;学生姓名：</span>
                            <div>
                                <input type="text" maxlength="10" id="txt_Name2">
                            </div>
                        </div>
                        <div class="item">
                            <span><em style="color:red">*</em>&nbsp;联络手机：</span>
                            <div>
                                <input type="text" maxlength="11" id="txt_Mobile2">
                            </div>
                        </div>
                        <div class="item">
                            <span>&nbsp;&nbsp;所在城市：</span>
                            <div>
                                <input type="text" maxlength="15" id="txt_City2">
                            </div>
                        </div>
                        <div class="item">
                            <span>&nbsp;&nbsp;学生年龄：</span>
                            <div>
                                <input type="text" maxlength="10" id="txt_Age2">
                            </div>
                        </div>
                        <div class="item">
                            <span>&nbsp;&nbsp;电子邮箱：</span>
                            <div>
                                <input type="text" maxlength="100" id="txt_Grand2">
                            </div>
                        </div>
                        <div class="item even">
                            <span>&nbsp;&nbsp;备注：</span>
                            <div>
                                <textarea id="txt_Intor2"></textarea>
                            </div>
                        </div>
                        <div class="btn">
                            <a onclick="AddComment2()" href="javascript:void(0)">点击完成预约</a>
                        </div>
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>


               <!--  <div class="block block12" id="registration">
                    <div class="top">
                        <span>免费报名参加活动</span>
                    </div>
                    <div class="tips2">
                        您符合条件吗？填写下边的表单即可免费报名参加活动啦！
                    </div>
                    <div class="elAud clearfix">
                        <div class="l">
                            <div class="item">
                                <span><em>*</em>您的姓名</span>
                                <div>
                                    <input type="text" id="txt_Name2">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>联络手机</span>
                                <div>
                                    <input type="text" id="txt_Mobile2">
                                </div>
                            </div>
                            <div class="item">
                                <span>邮箱</span>
                                <div>
                                    <input type="text" id="txt_Email2">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>所在城市</span>
                                <div>
                                    <input type="text" id="txt_City2">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>学生年龄</span>
                                <div>
                                    <input type="text" id="txt_Age2" style="width: 80px;">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>所在年级</span>
                                <div>
                                    <input type="text" id="txt_Grade2" style="width: 80px;">
                                </div>
                            </div>
                        </div>
                        <div class="r">
                            <div class="item even">
                                <span><em>*</em>意向出国时间</span>
                                <div>
                                    <input type="text" id="txt_AbroadTime2" style="width: 80px;">
                                </div>
                            </div>
                            <div class="item even">
                                <span><em>*</em>当天来宾人数</span>
                                <div>
                                    <input type="text" id="txt_GuestNum2" style="width: 80px;">
                                </div>
                            </div>
                            <div class="item even">
                                <span>留言</span>
                                <div class="textarea">
                                    <textarea id="txt_Comment2"></textarea>
                                </div>
                            </div>
                            <div class="btn">
                                <a onclick="Comment2()" href="javascript:void(0);">点击完成预约</a>
                            </div>
                        </div>
                    </div>
                </div> -->
            </div>
            <div class="list-right">
                <div class="ad">
                    <a href="javascript:void(0)" onclick="openChat('g')">
                        <img src="/images/ads1.png" /></a></div>
                <div class="maps">
                    <h3 class="adds">
                        活动位置</h3>
                    <div class="con">
                        <div id='allmap' style="position: relative; width: 260px; height: 260px;">
                        </div>
                    </div>
                    <div class="list">
                        <dl class="clearfix">
                            <dt>
                                <img src="../schools/images/icon-3.png" /></dt>
                            <dd>
                                <p class="tit">
                                    地理坐标</p>
                                <div class="txt">
                                    <%=L.Latitude %>
                                </div>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>
                                <img src="../schools/images/icon-4.png" /></dt>
                            <dd>
                                <p class="tit">
                                    活动地址
                                </p>
                                <div class="txt">
                                    <%=L.Address %>
                                </div>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>
                                <img src="../images/icon-riq.png" /></dt>
                            <dd>
                                <p class="tit">
                                    活动日期</p>
                                <div class="txt">
                                    <%=L.StarDay %>
                                </div>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>
                                <img src="../images/icon-time.png" /></dt>
                            <dd>
                                <p class="tit">
                                    活动时间</p>
                                <div class="txt">
                                    <%=L.StarTimer %>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
                <uc3:navHotEvents ID="navHotEvents" runat="server" />
            </div>
            <div class="clear">
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="go-Lmeg"><a href="#registration">在线报名</a></div>
    <uc2:footer ID="footer1" runat="server" />
    <div class="popBg">
        <div class="popbor">
            <div class="popBox">
                <a href="javascript:closePop()" class="close"></a>
                <p class="p1">
                    <img src="/guide/images/textpop.png" alt="恭喜！您已成功完成面试的初步预约" /></p>
                <div class="txt">
                    必益教育客服人员将于48小时内与您联络，为学生安排初试，<br />
                    并确定具体面试时间。请保持手机畅通！在面试前，将为您和学生发送正式邀请函。<br />
                    如有任何疑问，欢迎致电 <strong>400 850 4118</strong>，或在必益教育官方微信留言。
                    <br />
                    感谢您关注本次活动！</div>
            </div>
        </div>
    </div>
    <input type="hidden" id="Hid_Title" value="<%=L.CNTitle %>" />
    <script type="text/javascript">
        // 百度地图API功能
        var map = new BMap.Map("allmap");
        var point = new BMap.Point(<%=L.Location_X %>, <%=L.Location_Y %>);
        map.centerAndZoom(point, 18);
        var marker = new BMap.Marker(point);  // 创建标注
        map.addOverlay(marker);               // 将标注添加到地图中
        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    </script>
</body>
</html>
