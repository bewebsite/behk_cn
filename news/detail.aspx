<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="news_detail" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育</title>
    <meta name="Keywords" content="" runat="server" id="Key" />
    <meta name="Description" content="" runat="server" id="Des" />
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/news.css?v1" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script src="../js/common.js" type="text/javascript"></script>
    <%--<script src="../js/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js/news.js"></script>
    <script src="../js/qrcode.js" type="text/javascript"></script>
    <script src="../js/jquery.qrcode.js" type="text/javascript"></script>--%>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="news-wrap">
        <div class="centerB">
            <div class="mbx">
                <a href="/">
                    <img src="../images/icon-home.png" /></a> <em></em><a href="/news/">新闻中心</a>
                <em></em>
                <label>
                    <%=N.Title %></label>
            </div>
            <div class="all-box">
                <div class="all-Chapeter">
                    <div class="chapter chapter1 newsC">
                        <div class="artical-h">
                            <h3>
                                <%=N.Title %></h3>
                            <p class="artical-m">
                                <span class="ar-date">收录日期
                                    <%=N.AddTime.Value.ToString("yyyy-MM-dd") %></span><span class="ar-share">分享至：<a
                                        class="ic-sweix" href="javascript:void(0)" onclick="Getqrcode()"></a><a href="http://v.t.sina.com.cn/share/share.php?title=<%=N.Title %>&url=http://192.168.5.150:8728/news/<%=N.HtmlName %>.html"
                                            target="_blank" class="ic-ssina"></a><a href="http://v.t.qq.com/share/share.php?title=<%=N.Title %>&url=http://192.168.5.150:8728/news/<%=N.HtmlName %>.html"
                                                target="_blank" class="ic-sqq"></a></span></p>
                            <div class="ar-j">
                                <p>
                                    <%=N.Lead %></p>
                            </div>
                        </div>
                        <div class="artical-info">
                            <%=Comm.Help.getContentBysystenkeyword(N.Content) %>
                        </div>
                        <%=GetSoure()%>
                    </div>
                    <!--newsC chapter1 end-->
                </div>
            </div>
            <div class="rBarCon">
                <div class="rBar">
                    <a class="ar-menu"></a>
                    <div class="list" id="left_list">
                        <ul>
                            <asp:Repeater runat="server" ID="repChapter">
                                <ItemTemplate>
                                    <li><a class="ar-zj <%# Container.ItemIndex==0?"cur":"" %>" href="#<%#Container.ItemIndex+1 %>">
                                        第<%#GetZhange(Container.ItemIndex+1)%>章</a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                    <a href="javascript:void(0)" class="prev-btn" id="scl-prev"></a><a href="javascript:void(0)"
                        class="next-btn" id="scl-next"></a><a class="share-btn share-weix" href="javascript:void(0)"
                            onclick="Getqrcode()"></a><a class="share-btn share-sina" target="_blank" href="http://v.t.sina.com.cn/share/share.php?title=<%=N.Title %>&url=http://192.168.5.150:8728/news/<%=N.HtmlName %>.html">
                            </a><a class="share-btn share-qq" href="http://v.t.qq.com/share/share.php?title=<%=N.Title %>&url=http://192.168.5.150:8728/news/<%=N.HtmlName %>.html"
                                target="_blank"></a>
                </div>
                <div class="catalog" id="catalog" style="display: none">
                    <ul>
                        <asp:Repeater runat="server" ID="repChapter2">
                            <ItemTemplate>
                                <li><a <%# Container.ItemIndex==0?"class='cur'":"" %> href="#<%#Container.ItemIndex+1 %>"
                                    title="第 <%#Container.ItemIndex+1 %> 章   <%#Eval("Title") %>">第
                                    <%#Container.ItemIndex+1 %>
                                    章
                                    <%#Eval("Title") %></a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
    <input type="hidden" id="hid_Id" value="<%=N.ID %>" />
</body>
</html>
