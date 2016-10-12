﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="news_Default" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<%@ Register Src="../ascx/navHotEvents.ascx" TagName="navHotEvents" TagPrefix="uc3" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育-院校列表</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link href="../css/school-index.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/kxbdSuperMarquee.js" type="text/javascript"></script>
    <script src="../js/school-index-slide.js" type="text/javascript"></script>
    <script src="../js/common.js" type="text/javascript"></script>
    <script src="../js/school-list.js" type="text/javascript"></script>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="wrap">
        <div class="wrapMain">
            <div class="clear">
            </div>
            <div class="mbx">
                <a href="#">
                    <img src="../images/icon-home.png"></a> <em></em><a href="/mews/">新闻中心</a><em></em><label>新闻列表</label>
            </div>
            <div class="slideBanner2" <%=HaveBanner %>>
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
            <div class="clear">
            </div>
            <div class="list-left">
                <!--
                <div class="select-search" id="searchlist">
                    <%=GetInfo() %>
                    <div class="con">
                        <%=GetNewsType() %>
                        <%=GetCounty() %>
                        <%=GetCity()%>
                        <%=GetBusiness() %>
                        <%=GetLevels()%>
                        <%=GetCategories() %>
                        <dl class="clearfix">
                            <dt>条件搜索</dt>
                            <dd>
                                <input style="margin-left: 0px" type="text" class="t" onblur="if(this.value=='')this.value='根据新闻标题搜索'"
                                    onfocus="if(this.value=='根据新闻标题搜索')this.value='';" value="<%=Name %>" id="txt_Name"><a
                                        href="javascript:void(0)" class="sure-btn" onclick="SearchSchool()">检索</a>
                                <span class="num">共<em><%=AllCount %></em>条新闻信息 </span>
                            </dd>
                        </dl>
                    </div>
                </div>
            -->
                <div class="news_list">
                    <asp:Repeater runat="server" ID="repList">
                        <ItemTemplate>
                            <dl class="clearfix">
                                <dt><a href="<%#Eval("HtmlName") %>.html" title="<%#Eval("Title") %>" target="_blank">
                                    <img width="207" height="112" alt="<%#Eval("Title") %>" src="<%#Eval("Image") %>"></a>
                                </dt>
                                <dd>
                                    <h3>
                                        <a href="<%#Eval("HtmlName") %>.html" title="<%#Eval("Title") %>" target="_blank">
                                            <%#Eval("Title") %></a></h3>
                                    <p class="tit">
                                        <span>点击数：<%#Eval("Click") %>次</span><em>|</em><span>来源：<%#Eval("SourceName")%></span></p>
                                    <div class="text">
                                        <%#Comm.Help.Substring(Eval("Lead"),160,"..")%></div>
                                    <p class="more">
                                        <a href="<%#Eval("HtmlName") %>.html" target="_blank">查看详情</a></p>
                                </dd>
                            </dl>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="page" <%=HavePage %>>
                        <asp:Literal ID="lit_nodata" Visible="false" Text="<div style='text-align:center; padding-top:10px;'>暂无相关新闻</div>"
                            runat="server"></asp:Literal>
                        <My:AspNetPager UrlPaging="true" runat="server" LastButtonClass="last" PrevButtonClass="pre"
                            FirstButtonClass="first" NextButtonClass="next" ID="pgServer" CurrentPageButtonClass="cur_page"
                            FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" ShowMoreButtons="False"
                            ShowPrevNext="True" class="page" EnableUrlRewriting="true" UrlRewritePattern="/news/?CountryId=%CountryId%&CityId=%CityId%&BusinessId=%BusinessId%&LevelsId=%LevelsId%&CategoriesId=%CategoriesId%&OrderBy=%OrderBy%&NewsType=%NewsType%&Name=%Name%&page={0}#searchlist">
                        </My:AspNetPager>
                        <!--内容部分 end-->
                    </div>
                </div>
            </div>
            <div class="list-right">
                <div class="ad">
                    <a href="javascript:void(0)" onclick="openChat('g')">
                        <img src="/images/ads1.png" /></a></div>
                <uc3:navHotEvents ID="navHotEvents" runat="server" />
            </div>
            <div class="clear">
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
    <script type="text/javascript">
        function SearchSchool() {
            var name = $.trim($("#txt_Name").val());
            if (name == "根据新闻标题搜索") {
                name = "";
            }
            var v = "&Name=" + escape(name);
            var url = "/news/?CountryId=<%=CountryId %>&CityId=<%=CityId %>&NewsType=<%=NewsType %>&BusinessId=<%=BusinessId %>&LevelsId=<%=LevelsId %>&CategoriesId=<%=CategoriesId %>&OrderBy=<%=CountryId %>" + v + "#searchlist";
            window.location.href = url;
        }
    </script>
</body>
</html>