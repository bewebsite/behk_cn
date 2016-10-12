<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="school_Default" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育-院校首页</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="../css/school-index.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/kxbdSuperMarquee.js" type="text/javascript"></script>
    <script src="../js/school-index-slide.js" type="text/javascript"></script>
    <script src="../js/common.js" type="text/javascript"></script>
    <script src="../js/school-index.js" type="text/javascript"></script>
    <script src="../js/layer/layer.js" type="text/javascript"></script>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="wrap">
        <div class="wrapMain">
            <div class="clear">
            </div>
            <div class="mbx">
                <a href="#">
                    <img src="../images/icon-home.png"></a> <em></em><a href="/schools/">院校中心</a>
            </div>
            <div class="conLeft">
                <div class="slideBanner" <%=HaveBanner %>>
                    <div class="imglist">
                        <ul>
                            <asp:Literal ID="Lit_Banner" runat="server"></asp:Literal>
                        </ul>
                    </div>
                    <div class="popBar">
                        <h3 class="title">
                        </h3>
                        <div class="anniu">
                            <asp:Repeater runat="server" ID="repBanner">
                                <ItemTemplate>
                                    <a href="javascript:;" <%# Container.ItemIndex==0?"class='cur'":"" %>></a>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <%=MoreBanner %>
                </div>
                <div class="school-houdong">
                    <div class="bar">
                        <h3>
                            院校最新活动</h3>
                        <a href="/activity/">更多</a>
                    </div>
                    <div class="con clearfix">
                        <asp:Repeater runat="server" ID="repActivity">
                            <ItemTemplate>
                                <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("Title") %>">
                                    <h3>
                                        <%#Eval("Title") %></h3>
                                    <div class="text">
                                        <p>
                                            <span><i>
                                                <img src="images/icon-si-1.png" /></i>活动日期 :
                                                <%#DateTime.Parse( Eval("StarDay").ToString()).ToString("M月d日") %><%#GetInfo2(Eval("EndDay"))%></span>
                                            <span><i>
                                                <img src="images/icon-si-2.png" /></i>活动时间 :
                                                <%#Eval("StarTimer")%><%#GetInfo(Eval("EndTimer"))%>
                                            </span>
                                        </p>
                                        <p>
                                            <i>
                                                <img src="images/icon-si-3.png" /></i>活动地点 :
                                            <%#Comm.Help.Substring(Eval("Address"),42,"..") %></p>
                                    </div>
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="school-houdong">
                    <div class="bar">
                        <h3>
                            院校最新资讯</h3>
                        <a href="/news/">更多</a>
                    </div>
                    <div class="news-con">
                        <ul class="clearfix">
                            <asp:Repeater runat="server" ID="repNews">
                                <ItemTemplate>
                                    <li>
                                        <h3>
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("Title") %>" target="_blank">
                                                <%#Eval("Title") %></a></h3>
                                        <p class="time">
                                            <%#Eval("AddTime","{0:dd/MM/yyyy}") %></p>
                                        <p class="text">
                                            <%#Comm.Help.Substring(Eval("Intor"),80,"...")%><a href="<%#Eval("GetUrl") %>" target="_blank">more</a></p>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="conRight">
                <div class="ad">
                    <a href="javascript:void(0)" onclick="openChat('g')">
                        <img src="/images/ads1.png"></a>
                </div>
                <div class="search-school">
                    <h3>
                        筛选符合您的院校</h3>
                    <table width="100%">
                        <tr>
                            <td width="80">
                                院校类型：
                            </td>
                            <td>
                                <select id="drpType">
                                    <option value="">--请选择--</option>
                                    <option value="1">男校</option>
                                    <option value="2">女校</option>
                                    <option value="3">男女混校</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                入学年龄：
                            </td>
                            <td>
                                <input style="width: 36px; text-align: center;" type="text" id="StarAge" />
                                -
                                <input style="width: 36px; text-align: center;" type="text" id="EndAge" />
                                岁
                            </td>
                        </tr>
                        <tr>
                            <td>
                                院校名称：
                            </td>
                            <td>
                                <input type="text" id="SchoolName" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="button" value="立刻筛选" id="SearchSchoolButton" />
                            </td>
                        </tr>
                    </table>
                </div>
                <%=GetSmallBanner() %>
            </div>
            <div class="clear">
            </div>
        </div>
        <div class="mql-wrap">
            <div class="bar">
                <h3>
                    全球著名院校推荐</h3>
                <div class="nav">
                    <span class="cur">英国</span> <span>美国</span> <span>瑞士</span>
                </div>
                <a href="list.html" class="ubtn">查看更多院校</a>
            </div>
            <div class="con">
                <div class="item" style="display: block;">
                    <div class="left">
                        <a href="javascript:void(0)" class="cur"><i>
                            <img src="../schools/images/icon-nan.png" /></i>男校</a> <a href="javascript:void(0)">
                                <i>
                                    <img src="../schools/images/icon-nv.png" /></i>女校</a> <a href="javascript:void(0)"><i>
                                        <img src="../schools/images/icon-nannv.png" /></i>男女混校</a>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-1-1">
                                <ul>
                                    <asp:Repeater runat="server" ID="repCountry11">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a class="more_school" href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-1-2">
                                <ul>
                                    <asp:Repeater runat="server" ID="repCountry12">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a class="more_school" href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-1-3">
                                <ul>
                                    <asp:Repeater runat="server" ID="repCountry13">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a class="more_school" href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="left">
                        <a href="javascript:void(0)"><i>
                            <img src="../schools/images/icon-nan.png" /></i>男校</a> <a href="javascript:void(0)"><i>
                                <img src="../schools/images/icon-nv.png" /></i>女校</a> <a href="javascript:void(0)"><i>
                                    <img src="../schools/images/icon-nannv.png" /></i>男女混校</a>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-2-1">
                                <ul>
                                    <asp:Repeater runat="server" ID="repCountry21">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a class="more_school" href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-2-2">
                                <ul>
                                   <asp:Repeater runat="server" ID="repCountry22">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a class="more_school" href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-2-3">
                                <ul>
                                   <asp:Repeater runat="server" ID="repCountry23">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a class="more_school" href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="left">
                        <a href="javascript:void(0)"><i>
                            <img src="../schools/images/icon-nan.png" /></i>男校</a> <a href="javascript:void(0)"><i>
                                <img src="../schools/images/icon-nv.png" /></i>女校</a> <a href="javascript:void(0)"><i>
                                    <img src="../schools/images/icon-nannv.png" /></i>男女混校</a>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-3-1">
                                <ul>
                                     <asp:Repeater runat="server" ID="repCountry31">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-3-2">
                                <ul>
                                    <asp:Repeater runat="server" ID="repCountry32">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="right-con">
                        <div class="mql">
                            <div class="clearfix oh" id="slide-3-3">
                                <ul>
                                     <asp:Repeater runat="server" ID="repCountry33">
                                        <ItemTemplate>
                                            <li>
                                                <div class="img">
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                        <img src="<%#Eval("Image") %>" width="100" height="100" /></a>
                                                </div>
                                                <div class="text">
                                                    <h3>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("CNName") %>">
                                                            <%#Eval("CNName") %></a></h3>
                                                    <p>
                                                        <a href="<%#Eval("GetUrl") %>" target="_blank" title="<%#Eval("ENName") %>">
                                                            <%#Eval("ENName")%></a></h3></p>
                                                    <a href="<%#Eval("GetUrl") %>" target="_blank">查看详情</a>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="video-index">
            <div class="top">
                <span>学校视频</span> <a class="ubtn" href="/news/">更多</a>
            </div>
            <div class="list" id="videolist">
                <ul class="clearfix">
                    <asp:Repeater runat="server" ID="repVoide">
                        <ItemTemplate>
                            <li><a target="_blank" href="<%#Eval("GetUrl") %>" title="<%#Eval("Title") %>">
                                <div class="img">
                                    <p class="popVideo">
                                        <i class="i"></i>
                                    </p>
                                    <img style="width: 260px; height: 140px" src="<%#Eval("Image") %>"></div>
                                <span>
                                    <%#Eval("Title") %></span><em><%#Eval("SchoolName") %></em> </a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <%=MoreVoide%>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
    <script type="text/javascript">
        $(function () {
            $("#StarAge,#EndAge").keypress(function (event) {
                var keyCode = event.which;

                if ((keyCode >= 48 && keyCode <= 57) || keyCode == 8 || keyCode == 0)
                    return true;
                else
                    return false;
            }).focus(function () {
                this.style.imeMode = 'disabled';
            });



            $("#StarAge").bind("keyup", function () {
                var reg = /^[1-9]\d*$/;
                var value = $.trim($(this).val());
                if (value != "" && reg.test(value) == false) {
                    $(this).val("");
                }
            })
            $("#StarAge").bind("blur", function () {
                var value = $.trim($(this).val());
                var end = $.trim($("#EndAge").val());
                if (end != "" && value != "" && parseInt(end) <= parseInt(value)) {
                    $(this).val("");
                }
            })

            $("#EndAge").bind("keyup", function () {
                var reg = /^[1-9]\d*$/;
                var value = $.trim($(this).val());
                if (value != "" && reg.test(value) == false) {
                    $(this).val("");
                }
            })
            $("#EndAge").bind("blur", function () {
                var value = $.trim($(this).val());
                var star = $.trim($("#StarAge").val());
                if (star != "" && value != "" && parseInt(star) >= parseInt(value)) {
                    $(this).val("");
                }
            })


            $("#SearchSchoolButton").bind("click", function () {
                var types = $("#drpType").val();
                var StarAge = $.trim($("#StarAge").val());
                var EndAge = $.trim($("#EndAge").val());
                var Name = $.trim($("#SchoolName").val());
                window.location.href = "/schools/list.html?TypeId=" + types + "&Name=" + Name + "&StarAge=" + StarAge + "&EndAge=" + EndAge + "#searchlist";
            })
        })
    </script>
</body>
</html>
