<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <meta name="baidu-site-verification" content="GpTR7BVU7q" />
    <title>必益教育-首页</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="../css/school.css" rel="stylesheet" type="text/css" />
    <link href="css/default-n.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="js/index-banner.js" type="text/javascript"></script>
    <script src="../js/common.js" type="text/javascript"></script>
    <script src="js/index.js" type="text/javascript"></script>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="index-wrap">
        <%=GetBanner()%>
        <%--  <div class="swBanner">
            <div class="banContain">
                <ul class="banList clearfix">
                    <li>
                        <img src="images/default/ban1.jpg" alt="留美玩DOTA也给奖学金？1"/></li>
                    <li>
                        <img src="images/default/ban1.jpg" alt="留美玩DOTA也给奖学金？2"/></li>
                        <li>
                        <img src="images/default/ban1.jpg" alt="留美玩DOTA也给奖学金？3"/></li>
                </ul>
            </div>
            <div class="banBot">
                <h4 class="imgtit">
                    留美玩DOTA也给奖学金？</h4>
                <div class="small-d">
                    <a class="curr" href="javascript:void(0);"></a><a href="javascript:void(0);"></a>
                    <a href="javascript:void(0);"></a>
                </div>
            </div>
            <a class="banB leftB" href="javascript:void(0);"></a><a class="banB rightB" href="javascript:void(0);">
            </a>
        </div>--%>
        <div class="index-main">
            <div class="sort-contain">
                <div class="sort-hd">
                    <ul class="clearfix">
                        <li><a class="cur" href="javascript:void(0)">学在英国</a></li>
                        <li><a href="javascript:void(0)">学在美国</a></li>
                        <li><a href="javascript:void(0)">短期游学</a></li>
                        <li><a href="javascript:void(0)">英美入学辅导</a></li>
                        <li><a href="javascript:void(0)">牛津国际公学</a></li>
                    </ul>
                </div>
                <div class="sortBody">
                    <div class="sort-it" style="display: block">
                        <ul class="sortList">
                            <asp:Repeater runat="server" ID="repList">
                                <ItemTemplate>
                                    <li class="l-odd"><a href="<%#Eval("GetUrl") %>" title="<%#Eval("Title") %>" target="_blank">
                                        <div class="imgC">
                                            <img src="<%#Eval("Image") %>" width="275" height="148" alt="<%#Eval("Title") %>" /></div>
                                        <div class="imgT">
                                            <div class="itit">
                                                <h4>
                                                    <%#Eval("Title") %></h4>
                                                <em class="i-data">
                                                    <%#Eval("AddTime","{0:dd/MM/yyyy}") %></em></div>
                                            <div class="imgD">
                                                <p>
                                                    <%#Eval("Intor") %>
                                                </p>
                                                <p class="d-btn">
                                                    <span>阅读全文</span></p>
                                            </div>
                                        </div>
                                    </a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <div class="other clearfix">
                            <div class="other-item" style="width: 50%">
                                <a href="/news/?NewsType=3#searchlist">
                                    <img src="images/default/ic-other1.png" /><div class="otxt">
                                        <h6>
                                            总监专栏</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                            <!-- <div class="other-item">
                                <a href="#">
                                    <img src="images/default/ic-other2.png" /><div class="otxt">
                                        <h6>
                                            服务详情</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                            <div class="other-item">
                                <a href="#">
                                    <img src="images/default/ic-other3.png" /><div class="otxt">
                                        <h6>
                                            录取榜单</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div> -->
                            <div class="other-item" style="width: 50%">
                                <a href="/news/">
                                    <img src="images/default/ic-other4.png" /><div class="otxt">
                                        <h6>
                                            更多动态</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--item1-->
                    <div class="sort-it">
                        <ul class="sortList">
                            <asp:Repeater runat="server" ID="repList2">
                                <ItemTemplate>
                                    <li class="l-odd"><a href="<%#Eval("GetUrl") %>" title="<%#Eval("Title") %>" target="_blank">
                                        <div class="imgC">
                                            <img src="<%#Eval("Image") %>" width="275" height="148" alt="<%#Eval("Title") %>" /></div>
                                        <div class="imgT">
                                            <div class="itit">
                                                <h4>
                                                    <%#Eval("Title") %></h4>
                                                <em class="i-data">
                                                    <%#Eval("AddTime","{0:dd/MM/yyyy}") %></em></div>
                                            <div class="imgD">
                                                <p>
                                                    <%#Eval("Intor") %>
                                                </p>
                                                <p class="d-btn">
                                                    <span>阅读全文</span></p>
                                            </div>
                                        </div>
                                    </a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <div class="other clearfix">
                            <div class="other-item" style="width: 50%">
                                <a href="/news/?NewsType=3#searchlist">
                                    <img src="images/default/ic-other1.png" /><div class="otxt">
                                        <h6>
                                            总监专栏</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                            <!-- <div class="other-item">
                                <a href="#">
                                    <img src="images/default/ic-other2.png" /><div class="otxt">
                                        <h6>
                                            服务详情</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                            <div class="other-item">
                                <a href="#">
                                    <img src="images/default/ic-other3.png" /><div class="otxt">
                                        <h6>
                                            录取榜单</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div> -->
                            <div class="other-item" style="width: 50%">
                                <a href="/news/">
                                    <img src="images/default/ic-other4.png" /><div class="otxt">
                                        <h6>
                                            更多动态</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--item2-->
                    <div class="sort-it">
                        <ul class="sortList">
                            <asp:Repeater runat="server" ID="repList3">
                                <ItemTemplate>
                                    <li class="l-odd"><a href="<%#Eval("GetUrl") %>" title="<%#Eval("Title") %>" target="_blank">
                                        <div class="imgC">
                                            <img src="<%#Eval("Image") %>" width="275" height="148" alt="<%#Eval("Title") %>" /></div>
                                        <div class="imgT">
                                            <div class="itit">
                                                <h4>
                                                    <%#Eval("Title") %></h4>
                                                <em class="i-data">
                                                    <%#Eval("AddTime","{0:dd/MM/yyyy}") %></em></div>
                                            <div class="imgD">
                                                <p>
                                                    <%#Eval("Intor") %>
                                                </p>
                                                <p class="d-btn">
                                                    <span>阅读全文</span></p>
                                            </div>
                                        </div>
                                    </a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <div class="other clearfix">
                            <div class="other-item" style="width: 50%">
                                <a href="/news/?NewsType=3#searchlist">
                                    <img src="images/default/ic-other1.png" /><div class="otxt">
                                        <h6>
                                            总监专栏</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                            <div class="other-item" style="width: 50%">
                                <a href="/news/">
                                    <img src="images/default/ic-other2.png" /><div class="otxt">
                                        <h6>
                                            服务详情</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--item3-->
                    <div class="sort-it">
                        <ul class="sortList">
                            <asp:Repeater runat="server" ID="repList4">
                                <ItemTemplate>
                                    <li class="l-odd"><a href="<%#Eval("GetUrl") %>" title="<%#Eval("Title") %>" target="_blank">
                                        <div class="imgC">
                                            <img src="<%#Eval("Image") %>" width="275" height="148" alt="<%#Eval("Title") %>" /></div>
                                        <div class="imgT">
                                            <div class="itit">
                                                <h4>
                                                    <%#Eval("Title") %></h4>
                                                <em class="i-data">
                                                    <%#Eval("AddTime","{0:dd/MM/yyyy}") %></em></div>
                                            <div class="imgD">
                                                <p>
                                                    <%#Eval("Intor") %>
                                                </p>
                                                <p class="d-btn">
                                                    <span>阅读全文</span></p>
                                            </div>
                                        </div>
                                    </a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <div class="other clearfix">
                            <div class="other-item" style="width: 50%">
                                <a href="/news/?NewsType=3#searchlist">
                                    <img src="images/default/ic-other1.png" /><div class="otxt">
                                        <h6>
                                            总监专栏</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                            <div class="other-item" style="width: 50%">
                                <a href="/news/">
                                    <img src="images/default/ic-other2.png" /><div class="otxt">
                                        <h6>
                                            服务详情</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--item4-->
                    <div class="sort-it">
                        <ul class="sortList">
                            <asp:Repeater runat="server" ID="repList5">
                                <ItemTemplate>
                                    <li class="l-odd"><a href="<%#Eval("GetUrl") %>" title="<%#Eval("Title") %>" target="_blank">
                                        <div class="imgC">
                                            <img src="<%#Eval("Image") %>" width="275" height="148" alt="<%#Eval("Title") %>" /></div>
                                        <div class="imgT">
                                            <div class="itit">
                                                <h4>
                                                    <%#Eval("Title") %></h4>
                                                <em class="i-data">
                                                    <%#Eval("AddTime","{0:dd/MM/yyyy}") %></em></div>
                                            <div class="imgD">
                                                <p>
                                                    <%#Eval("Intor") %>
                                                </p>
                                                <p class="d-btn">
                                                    <span>阅读全文</span></p>
                                            </div>
                                        </div>
                                    </a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <div class="other clearfix">
                            <div class="other-item" style="width: 50%">
                                <a href="/news/?NewsType=3#searchlist">
                                    <img src="images/default/ic-other1.png" /><div class="otxt">
                                        <h6>
                                            总监专栏</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                            <div class="other-item" style="width: 50%">
                                <a href="http://www.czoic.com/zh-hans">
                                    <img src="images/default/ic-other2.png" /><div class="otxt">
                                        <h6>
                                            学校动态</h6>
                                        <span>点击进入</span></div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--item5-->
                </div>
            </div>
            <div class="tj-school">
                <div class="tj-hd">
                    <h4>
                        知名院校推荐</h4>
                    <div class="area-sort">
                        <a class="cur" href="javascript:void(0)">英国</a><a href="javascript:void(0)">美国</a><a
                            href="javascript:void(0)">瑞士</a></div>
                </div>
                <div class="tj-main">
                    <div class="t-Item" style="display: block">
                        <div class="sex-sort">
                            <ul class="sex-ul cearfix">
                                <li class="cur"><a href="javascript:void(0)"><i class="ic-male"></i>男校</a></li><li><a
                                    href="javascript:void(0)"><i class="ic-female"></i>女校</a></li><li><a href="javascript:void(0)">
                                        <i class="ic-mixed"></i>男女混校</a></li></ul>
                            <a class="more-B" href="http://www.schoolsguide.com.cn/">查看更多院校</a>
                        </div>
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repOne1">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--1-->
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repOne2">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--2-->
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repOne3">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--3-->
                    </div>
                    <!--it-->
                    <div class="t-Item">
                        <div class="sex-sort">
                            <ul class="sex-ul cearfix">
                                <li class="cur"><a href="javascript:void(0)"><i class="ic-male"></i>男校</a></li><li><a
                                    href="javascript:void(0)"><i class="ic-female"></i>女校</a></li><li><a href="javascript:void(0)">
                                        <i class="ic-mixed"></i>男女混校</a></li></ul>
                            <a class="more-B" href="http://www.schoolsguide.com.cn/">查看更多院校</a></div>
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repTwo1">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--1-->
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repTwo2">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--2-->
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repTwo3">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--3-->
                    </div>
                    <!--it-->
                    <div class="t-Item">
                        <div class="sex-sort">
                            <ul class="sex-ul cearfix">
                                <li class="cur"><a href="javascript:void(0)"><i class="ic-male"></i>男校</a></li><li><a
                                    href="javascript:void(0)"><i class="ic-female"></i>女校</a></li><li><a href="javascript:void(0)">
                                        <i class="ic-mixed"></i>男女混校</a></li></ul>
                            <a class="more-B" href="http://www.schoolsguide.com.cn/">查看更多院校</a></div>
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repThree1">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--1-->
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repThree2">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--2-->
                        <div class="sexItem">
                            <div class="sch-row clearfix">
                                <asp:Repeater runat="server" ID="repThree3">
                                    <ItemTemplate>
                                        <div class="sch-item">
                                            <a href="<%#Eval("GetUrl") %>" title="<%#Eval("CNName") %>" target="_blank">
                                                <div class="sch-logo">
                                                    <img src="<%#Eval("Image") %>" width="100" /></div>
                                                <div class="sch-intr">
                                                    <h4 class="name-cn">
                                                        <%#Eval("CNName") %></h4>
                                                    <h6 class="name-en">
                                                        <%#Eval("ENName") %></h6>
                                                    <p class="btn-detial">
                                                        <span>查看详情</span></p>
                                                </div>
                                            </a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!--3-->
                    </div>
                    <!--it-->
                </div>
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
    <script type="text/javascript">
        $(function () {


        })
    
    </script>




</body>
</html>
