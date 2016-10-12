<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="aspx_school_detail" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育-院校详情</title>
    <meta name="Keywords" content="" runat="server" id="Key" />
    <meta name="Description" content="" runat="server" id="Des" />
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="../css/school.css" rel="stylesheet" type="text/css" />

    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/school-solid.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>
    <script src="../js/layer/layer.js" type="text/javascript"></script>
    <script src="../js/base.js" type="text/javascript"></script>
    <script src="js/detail.js" type="text/javascript"></script>
    <script src="/temp/js/temp.js" type="text/javascript"></script>
    <style>
        .titbar{ text-align:center; padding:40px 0; position:relative;}
        .titbar h3{ font-size:22px; color:#545e7c;}
        .titbar span{ position:relative; background:url(../temp/images/b.png) repeat-x 0 50%; display:inline-block; padding:0 100px;}
        .titbar em{ text-transform:uppercase; background:#fff; color:#999999; padding:0 20px; }

        .wrap-9 { padding-bottom:40px; }
        .wrap-9{ background:#f7f8fa;}
        .bookClear{ font-size:14px; width:1000px; margin:0 auto;}
        .bookClear .left{ float:left; width:500px; padding-right:20px; border-right:1px dashed #ccc;}
        .bookClear .left dl{ margin-bottom:20px;}
        .bookClear .left dt{ float:left; width:55px;padding-top:6px;}
        .bookClear .left dd{ float:left; width:440px;}
        .bookClear .left dd .p1{ font-size:16px; color:#002758;}
        .bookClear .right{ float:right; width:444px;}
        .bookClear .right .item input[type="text"]{ width:280px; height:28px; line-height:28px\9; padding:0 10px; background:url(/guide/images/iconInput.png) left top repeat-x #fdfdfe; border-radius:3px; border:1px  solid #dadada;}
        .bookClear .right .item textarea{ width:280px; height:68px; font-size:12px; line-height:18px\9; padding:10px; background:url(/guide/images/iconInput.png) left top repeat-x #fdfdfe; border-radius:3px; border:0;border:1px  solid #dadada;}
        .bookClear .right .item select{ padding:0 10px;}
        .bookClear .right .item { position:relative; padding-left:120px; margin-bottom:7px;}
        .bookClear .right .item span{ position:absolute; left:0;top:0; color:#000;}
        .bookClear .btn a{ background:#f13122; margin-left:120px; color:#fff; margin-top:10px; height:40px; line-height:40px; padding:0 20px; display:inline-block; font-size:14px;}
        .bookClear .btn a:hover{ background:#e5291a;}
        .bookClear .btn a:active{ background:#de2213;}
    </style>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="wrap">
        <div class="wrapMain">
            <div class="clear">
            </div>
            <div class="mbx">
                <a href="#">
                    <img src="../images/icon-home.png" /></a> <em></em><a href="#">院校中心</a> <em>
                </em>
                <label>
                    <%=S.CNName %></label>
            </div>
            <div class="conLeft">
                <div class="block block1">
                    <dl class="clearfix">
                        <dt>
                            <%=S.LOGO %></dt>
                        <dd class="name">
                            <h1 class="h1">
                                <%=S.CNName %></h1>
                            <p class="en">
                                <%=S.ENName %></p>
                            <p class="url">
                                <a href="http://<%=S.Website %>" target="_blank">[ 院校官方网址
                                    <%=S.Website%>]</a></p>
                        </dd>
                        <!-- <dd class="concern">
                            <a href="javascript:void(0)"><i>
                                <img src="images/icon-1.png" /></i>立刻关注</a>
                            <p>
                                关注人数：<em><%=S.Followers%>人</em></p>
                        </dd> -->
                    </dl>
                    <div class="text">
                        <%=S.SchoolIntroduction%>
                    </div>
                    <div class="contact">
                        <span>已有 <em>
                            <%=GetNum() %></em> 人与招生官建立联系</span> <a href="javascript:void(0)" onclick="openChat('g')">
                                <i>
                                    <img src="images/icon-2.png" /></i>招生官期待与你联系</a>
                    </div>
                </div>
                <div class="block block2" <%=HaveImage %>>
                    <div id="tFocus">
                        <div class="prev" id="prev">
                        </div>
                        <div class="next" id="next">
                        </div>
                        <ul id="tFocus-pic">
                            <asp:Repeater runat="server" ID="repImage">
                                <ItemTemplate>
                                    <li>
                                        <img src="<%#Eval("Image") %>" width="840" height="360" alt="<%=S.CNName %>" /></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <div id="tFocusBtn">
                            <a href="javascript:void(0);" id="tFocus-leftbtn">上一张</a>
                            <div id="tFocus-btn">
                                <ul>
                                    <asp:Repeater runat="server" ID="repImage2">
                                        <ItemTemplate>
                                            <li <%# Container.ItemIndex==0?"class='active'":"" %>>
                                                <img src="<%#Eval("Image") %>" width="196" height="84" alt="<%=S.CNName %>" /></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                            <a href="javascript:void(0);" id="tFocus-rightbtn">下一张</a>
                        </div>
                    </div>
                </div>
                <div class="block block3 clearfix">
                    <div class="left">
                        <img src="images/ilogo-1.png" />
                        <span class="bor"></span>
                        <p>
                            荐校理由与<br />
                            申请建议
                        </p>
                    </div>
                    <div class="right">
                        <h3>
                            荐校理由:</h3>
                        <p class="text text1">
                            <%=S.RecommendedReason%>
                        </p>
                        <h3>
                            申请准备及建议:</h3>
                        <p class="text text2">
                            <%=S.ApplicationAdvice%>
                        </p>
                    </div>
                </div>
                <div class="block block4 clearfix" <%=HaveOffice %>>
                    <div class="tit">
                        <i>
                            <img src="images/icon-6.png" /></i>学校官员</div>
                    <div class="img">
                        <img src="<%=S.OfficerPhone %>" /></div>
                    <div class="top">
                        <h3>
                            <%=S.OfficerCNName%></h3>
                        <p>
                            <%=S.OfficerENName%></p>
                    </div>
                    <div class="bom">
                        <div class="clearfix">
                            <span class="t">职衔 : </span>
                            <div class="text">
                                <%=S.OfficerTitle%></div>
                        </div>
                        <div class="clearfix">
                            <span class="t">简介 : </span>
                            <div class="text">
                                <%=S.OfficerProfile%></div>
                        </div>
                    </div>
                </div>
                <div class="block block5 clearfix">
                    <ul class="clearfix">
                        <li><span>
                            <img src="images/g1.png" /></span>
                            <div>
                                <p>
                                    所在国家</p>
                                <h3>
                                    <%=S.CountryName%></h3>
                            </div>
                        </li>
                        <li><span>
                            <img src="images/g2.png" /></span>
                            <div>
                                <p>
                                    成立年份</p>
                                <h3>
                                    <%=S.FoundingTime%><em>年</em></h3>
                            </div>
                        </li>
                        <li class="noma"><span>
                            <img src="images/g3.png" /></span>
                            <div>
                                <p>
                                    学校类型</p>
                                <h3>
                                    <%=S.SchoolType %></h3>
                            </div>
                        </li>
                        <li><span>
                            <img src="images/g4.png" /></span>
                            <div>
                                <p>
                                    招生年龄</p>
                                <h3>
                                    <%=S.AgeStart%>-<%=S.AgeEnd%><em>岁</em></h3>
                            </div>
                        </li>
                        <li><span>
                            <img src="images/g5.png" /></span>
                            <div>
                                <p>
                                    学生人数</p>
                                <h3>
                                    <%=S.StudentNumber.Value == 0 ?  "该校未公开":S.StudentNumber+"<em>人</em>"%></h3>
                            </div>
                        </li>
                        <li class="noma"><span>
                            <img src="images/g6.png" /></span>
                            <div>
                                <p>
                                    寄宿学生人数</p>
                                <h3>
                                    <%=S.BoardingStudent == "0" ? "该校未公开" : S.BoardingStudent + "<em>人</em>"%></h3>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="block block6 clearfix">
                    <table width="100%">
                        <tr class="tr">
                            <td class="td">
                                <table>
                                    <tr>
                                        <td>
                                            学院设置：<span><%=S.SchoolSettings%></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="tr">
                            <td class="td">
                                <table>
                                    <tr>
                                        <td>
                                            入学平均成绩：<span><%=S.MeanScore%></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="tr">
                            <td class="td">
                                <table width="100%">
                                    <tr>
                                        <td width="25%">
                                            学校规模：<span><%=S.AreaSize%>英亩</span>
                                        </td>
                                        <td width="25%">
                                            师生配比：<span><%=S.PeopleRatio%></span>
                                        </td>
                                        <td width="25%">
                                            录取率：<span><%=S.AdmissionRate.Value==0?"该校未公开":S.AdmissionRate+"%"%></span>
                                        </td>
                                        <td>
                                            中国学生人数：<span><%=S.ChineseStudent.Value == 0 ? "该校未公开" : S.ChineseStudent+"人"%></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="tr">
                            <td class="td">
                                <table width="100%">
                                    <tr>
                                        <td width="25%">
                                            国际学生人数：<span><%=S.InternationalStudent.Value == 0 ? "该校未公开" : S.InternationalStudent + "人"%></span>
                                        </td>
                                        <td width="25%">
                                            国际学生比例：<span><%=S.InternationalProportion.Value == 0 ? "该校未公开" : S.InternationalProportion + "%"%></span>
                                        </td>
                                        <td width="25%">
                                            寄宿生比例：<span><%=S.BoardingProportion.Value == 0 ? "该校未公开" : S.BoardingProportion + "%"%></span>
                                        </td>
                                        <td>
                                            每年学费及寄宿费：<span><%=S.AnnualCost.Value == 0 ? "该校未公开" : "£" + S.AnnualCost%></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="block block7">
                    <div class="title">
                        院校概况
                    </div>
                    <div class="con">
                        <dl class="odd clearfix">
                            <dt>学校简介</dt>
                            <dd>
                                <%=S.SchoolIntroduction.Replace("\r\n","<br/>")%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>交通距离</dt>
                            <dd>
                                <%=S.SchoolTravel%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>地理环境</dt>
                            <dd>
                                <%=S.SchoolEnvironment%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>学院设置</dt>
                            <dd>
                                <%=S.SchoolSettings%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>课堂规模</dt>
                            <dd>
                                <%=S.ClassSize%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>学校特色</dt>
                            <dd>
                                <%=S.Highlights%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>教学理念</dt>
                            <dd>
                                <%=S.SchoolMotto%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>入学标准</dt>
                            <dd>
                                <%=S.EntranceRequirements%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>师资力量</dt>
                            <dd>
                                <%=S.TeacherStrength%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>学生关怀</dt>
                            <dd>
                                <%=S.StudentCaring%>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="block block8">
                    <div class="title clearfix">
                        <span class="cur">课程设置</span> <span>学校设施</span>
                    </div>
                    <div class="con" style="display: block;">
                        <dl class="odd clearfix">
                            <dt>学院设置</dt>
                            <dd>
                                <%=S.AcademicUnits%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>专业课程</dt>
                            <dd>
                                <%=S.AcademicCourses%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>特色课程</dt>
                            <dd>
                                <%=S.SpecialCourses%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>体育课程</dt>
                            <dd>
                                <%=S.SchoolSports%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>科技课程</dt>
                            <dd>
                                <%=S.SchoolIT%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>艺术课程</dt>
                            <dd>
                                <%=S.SchoolArts%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>课外活动</dt>
                            <dd>
                                <%=S.Extracurriculum%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>外语辅导课程</dt>
                            <dd>
                                <%=S.LanguageCourses%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>毕业生学术成就</dt>
                            <dd>
                                <%=S.GraduateAchievement%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>升学院校</dt>
                            <dd>
                                <%=S.GraduateDestination%>
                            </dd>
                        </dl>
                    </div>
                    <div class="con">
                        <dl class="odd clearfix">
                            <dt>教学设施</dt>
                            <dd>
                                <%=S.AcademicFacility%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>运动设施</dt>
                            <dd>
                                <%=S.SportsFacility%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>科技设施</dt>
                            <dd>
                                <%=S.ITFacility%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>艺术设施</dt>
                            <dd>
                                <%=S.ArtFacility%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>宿舍</dt>
                            <dd>
                                <%=S.Accommodation%>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>餐厅</dt>
                            <dd>
                                <%=S.Catering%>
                            </dd>
                        </dl>
                        <dl class="odd clearfix">
                            <dt>图书馆</dt>
                            <dd>
                                <%=S.Library%>
                            </dd>
                        </dl>
                    </div>
                </div>
                <%=GetEvent()%>
                <div class="block block10" <%=HavePoint %>>
                    <div class="top">
                        <span>顾问点评</span>
                    </div>
                    <asp:Repeater runat="server" ID="repPoint">
                        <ItemTemplate>
                            <div class="item">
                                <dl>
                                    <dt>
                                        <img src="<%#Eval("Phone") %>" style="width: 82px; height: 82px" /></dt>
                                    <dd>
                                        <h3>
                                            <%#Eval("CNName")%><em>|</em><%#Eval("Title")%></h3>
                                        <p class="name">
                                            <%#Eval("ENName")%></p>
                                        <div class="text">
                                            <i class="l"></i><i class="r"></i>
                                            <%#Eval("Comment")%>
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="block block11">
                    <div class="top">
                        <span>知名校友</span>
                    </div>
                    <div class="tj">
                        <dl class="clearfix">
                            <dt>
                                <img src="<%=S.RepresentativePhone %>" width="98" height="110" /></dt>
                            <dd>
                                <h3>
                                    <%=S.RepresentativeCNName%></h3>
                                <p class="name">
                                    <%=S.RepresentativeENName%></p>
                                <p class="tit">
                                    成就</p>
                                <p class="txt">
                                    <%=S.RepresentativeAchievement%></p>
                            </dd>
                        </dl>
                    </div>
                    <p class="else" <%=HaveOtherPeople %>>
                        其他知名校友</p>
                    <div class="con" <%=HaveOtherPeople %>>
                        <asp:Repeater runat="server" ID="repOtherPeople">
                            <ItemTemplate>
                                <dl>
                                    <dt>
                                        <%#Eval("Title") %></dt>
                                    <dd>
                                        <%#Eval("Info") %>
                                    </dd>
                                </dl>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="block block13" <%=HaveVoide %>>
                    <div class="top">
                        <span>学校视频</span>
                    </div>
                    <div class="list">
                        <ul class="clearfix">
                            <asp:Repeater runat="server" ID="repVoide">
                                <ItemTemplate>
                                    <li><a href="<%#Eval("VoideUrl")%>" target="_blank">
                                        <div class="img">
                                            <p class="popVideo">
                                                <i class="i"></i>
                                            </p>
                                            <img src="<%#Eval("Image")%>" style="width: 260px; height: 140px" /></div>
                                        <span>
                                            <%#Eval("Title")%></span> </a></li>
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




                <!-- <div class="block block12">
                    <div class="top">
                        <span>必益教育免费选校评估服务预约</span>
                    </div>
                    <p class="tist">
                        对这所学校感兴趣？正确填写并提交下面的信息，预约属于您的专属免费学校评估服务。顾问老师将在您提交信息的48个小时内与您联络，为您完成到访预约。</p>
                    <div class="tips2">
                        必益教育是英国 170 余所学校在华的独家或指定考试中心，能够帮助您准确评估学校入学竞争力，并制定相应的学习计划。
                    </div>
                    <div class="elAud clearfix">
                        <div class="l">
                            <div class="item">
                                <span><em>*</em>您的姓名</span>
                                <div>
                                    <input type="text" id="txt_Name">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>联络手机</span>
                                <div>
                                    <input type="text" id="txt_Mobile">
                                </div>
                            </div>
                            <div class="item">
                                <span>邮箱</span>
                                <div>
                                    <input type="text" id="txt_Email">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>所在城市</span>
                                <div>
                                    <input type="text" id="txt_City">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>学生年龄</span>
                                <div>
                                    <input type="text" style="width: 80px;" id="txt_Age">
                                </div>
                            </div>
                            <div class="item">
                                <span><em>*</em>所在年级</span>
                                <div>
                                    <input type="text" style="width: 80px;" id="txt_Grade">
                                </div>
                            </div>
                        </div>
                        <div class="r">
                            <div class="item even">
                                <span><em>*</em>意向出国时间</span>
                                <div>
                                    <input type="text" style="width: 80px;" id="txt_AbroadTime">
                                </div>
                            </div>
                            <div class="item even">
                                <span><em>*</em>当天来宾人数</span>
                                <div>
                                    <input type="text" style="width: 80px;" id="txt_GuestNum">
                                </div>
                            </div>
                            <div class="item even">
                                <span>留言</span>
                                <div class="textarea">
                                    <textarea id="txt_Comment"></textarea>
                                </div>
                            </div>
                            <div class="btn">
                                <a href="javascript:void(0);" onclick="Comment()">点击完成预约</a>
                            </div>
                        </div>
                    </div>
                </div> -->
            </div>
            <div class="conRight">
                <div class="ad" id="slideAd">
                    <a href="javascript:void(0)" onclick="openChat('g')">
                        <img src="/images/ads2.png" />
                        <img src="/images/ads1.png" /></a>
                </div>
                <div class="maps">
                    <h3 class="adds">
                        学校位置</h3>
                    <div class="con">
                        <div id='myMap' style="position: relative; width: 260px; height: 260px;">
                        </div>
                    </div>
                    <div class="list">
                        <dl class="clearfix">
                            <dt>
                                <img src="images/icon-3.png" /></dt>
                            <dd>
                                <p class="tit">
                                    地理坐标</p>
                                <div class="txt">
                                    <%=S.SouthLatitude%>
                                    <%=S.NorthLatitude %>
                                </div>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>
                                <img src="images/icon-4.png" /></dt>
                            <dd>
                                <p class="tit">
                                    地理环境
                                </p>
                                <div class="txt">
                                    <%=S.SchoolEnvironment %>
                                </div>
                            </dd>
                        </dl>
                        <dl class="clearfix">
                            <dt>
                                <img src="images/icon-5.png" /></dt>
                            <dd>
                                <p class="tit">
                                    交通距离</p>
                                <div class="txt">
                                    <%=S.SchoolTravel%>
                                </div>
                            </dd>
                        </dl>
                    </div>
                    <div class="bom">
                        <p>
                            邮政编码：<span><%=S.ZipCode %></span></p>
                        <p>
                            官方网址：<a href="http://<%=S.Website %>" target="_blank"><%=S.Website %></a></p>
                    </div>
                </div>
                <div class="news" <%=HaveNews %>>
                    <h3 class="adds">
                        学校新闻</h3>
                    <div class="con">
                        <asp:Literal ID="Lit_TopNews" runat="server"></asp:Literal>
                    </div>
                    <ul class="list">
                        <asp:Repeater runat="server" ID="repNews">
                            <ItemTemplate>
                                <li><a href="/news/<%#Eval("HtmlName") %>.html" target="_blank" title="<%#Eval("Title") %>">
                                    <%#Comm.Help.Substring(Eval("Title"),34,"..") %></a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                    <div style="height: 5px; display: inline-block">
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
    <div class="popWrapLg">
        <div class="popBor">
            <div class="popWrap">
                <div class="top">
                    <span>活动预约</span> <a href="javascript:;" onclick="openYueClose()" class="close">
                    </a>
                </div>
                <p class="tist">
                     您符合条件吗？填写下边的表单即可免费报名参加活动啦！ </p>
                <div class="tips2" style="display:none">
                    必益教育是英国 170 余所学校在华的独家或指定考试中心，能够帮助您准确评估学校入学竞争力，并制定相应的学习计划。
                </div>
                <div class="elAud clearfix">
                    <div class="l">
                        <input type="hidden" id="Hid_Title" value="" />
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
                            <span><em>*</em>邮箱</span>
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
                                <input type="text" style="width: 80px;" id="txt_Age2">
                            </div>
                        </div>
                        <div class="item">
                            <span><em>*</em>所在年级</span>
                            <div>
                                <input type="text" style="width: 80px;" id="txt_Grade2">
                            </div>
                        </div>
                    </div>
                    <div class="r">
                        <div class="item even">
                            <span><em>*</em>意向出国时间</span>
                            <div>
                                <input type="text" style="width: 80px;" id="txt_AbroadTime2">
                            </div>
                        </div>
                        <div class="item even">
                            <span><em>*</em>当天来宾人数</span>
                            <div>
                                <input type="text" style="width: 80px;" id="txt_GuestNum2">
                            </div>
                        </div>
                        <div class="item even">
                            <span><em>*</em>留言</span>
                            <div class="textarea">
                                <textarea id="txt_Comment2"></textarea>
                            </div>
                        </div>
                        <div class="btn">
                            <a href="javascript:void(0);" onclick="Comment2()">点击完成预约</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
    <script type="text/javascript">
        addLoadEvent(Focus());

        $(function () {
            $(".block6 .tr:odd").css({
                background: "#eceff3"
            })

            $(".block8 .title span").bind("click", function () {
                var _index = $(this).index();

                $(this).siblings("span").removeClass("cur").end().addClass("cur");
                $(".block8 .con").hide().eq(_index).slideDown();
            })
        })

        function openYue(obj) {
            var title = $.trim($(obj).attr("v"));
            $("#Hid_Title").val(title);
            $(".popWrapLg").fadeIn();
        }

        function openYueClose() {
            $("#Hid_Title").val("");
            $(".popWrapLg").fadeOut();
        }
        
    </script>
    <script type="text/javascript">
         $(function () {
             getMap();
         })
         var map = null;

         function getMap() {
             map = new Microsoft.Maps.Map(document.getElementById('myMap'), { credentials: 'ArGitrljfUQp0CsocMmDnjPiHij42NuYWZksCXtXwIyEJJteYAumUbX2_F7XEY4N', zoom: 13, center: new Microsoft.Maps.Location(<%=S.Location_Y %>, <%=S.Location_X %>) });
             var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), null);
             map.entities.push(pushpin);
         }
    </script>
</body>
</html>
