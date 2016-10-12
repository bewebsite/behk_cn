<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="school_list" %>

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
                    <img src="../images/icon-home.png"></a> <em></em><a href="#">院校中心</a><em></em><label>院校列表</label>
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
                <div class="select-search" id="searchlist">
                    <%=GetInfo() %>
                    <div class="con">
                        <%=GetCounty() %>
                        <%=GetCity()%>
                        <%=GetBusiness() %>
                        <%=GetLevels()%>
                        <%=GetCategories() %>
                        <%=GetShcoolType() %>
                        <dl class="clearfix">
                            <dt>条件搜索</dt>
                            <dd>
                                入学年龄
                                <input type="text" id="txt_StarAge" value="<%=Stars %>" />
                                -
                                <input type="text" id="txt_EndAge" value="<%=Ends %>" />
                                <input type="text" class="t" onblur="if(this.value=='')this.value='请输入院校名称'" onfocus="if(this.value=='请输入院校名称')this.value='';"
                                    value="<%=Name %>" id="txt_Name"><a href="javascript:void(0)" class="sure-btn" onclick="SearchSchool()">确定</a>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="conlist">
                    <div class="top">
                        <a <%=GetOrderBy(0) %>>默认排序</a> <a <%=GetOrderBy(1) %>>入学率<i></i></a> <a <%=GetOrderBy(2) %>>
                            人气<i></i></a> <a <%=GetOrderBy(3) %>>建校时间<i></i></a> <span>共<em><%=AllCount %></em>所院校</span>
                    </div>
                    <div class="con">
                        <div class="item">
                            <asp:Repeater runat="server" ID="repList">
                                <ItemTemplate>
                                    <dl class="clearfix">
                                        <dt><a href="<%#Eval("HtmlName") %>.html" title="<%#Eval("CNName") %>">
                                            <img src="<%#Eval("LOGO") %>" width="100" height="100" /></a> </dt>
                                        <dd>
                                            <h3>
                                                <a href="<%#Eval("HtmlName") %>.html" title="<%#Eval("CNName") %>" class="t"><span>
                                                    <%#Eval("CNName") %></span> <em>
                                                        <%#Eval("ENName") %></em></a> <a class="a" href="<%#Eval("HtmlName") %>.html" title="<%#Eval("CNName") %>">
                                                            查看详情</a></h3>
                                            <div class="span">
                                                <span>所在国家：<%#Eval("CountryName")%></span><span>成立年份：<%#Eval("FoundingTime")%>年</span>
                                                <span>学校类型：<%#Eval("SchoolType")%></span><br />
                                                <span>学生人数：<%#HaveInfo(Eval("StudentNumber"))%></span><span>入学年龄：<%#Eval("AgeStart")%>-<%#Eval("AgeEnd")%>岁</span>
                                                <span>寄宿人数：<%#HaveInfo(Eval("BoardingStudent"))%></span></div>
                                        </dd>
                                    </dl>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="page">
                            <asp:Literal ID="lit_nodata" Visible="false" Text="<div style='text-align:center; padding-top:20px;'>暂无学校信息</div>"
                                runat="server"></asp:Literal>
                            <My:AspNetPager UrlPaging="true" runat="server" LastButtonClass="last" PrevButtonClass="pre"
                                FirstButtonClass="first" NextButtonClass="next" ID="pgServer" CurrentPageButtonClass="cur_page"
                                FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" ShowMoreButtons="False"
                                ShowPrevNext="True" class="page" EnableUrlRewriting="true" UrlRewritePattern="/schools/list.html?CountryId=%CountryId%&CityId=%CityId%&BusinessId=%BusinessId%&LevelsId=%LevelsId%&CategoriesId=%CategoriesId%&TypeId=%TypeId%&StarAge=%StarAge%&EndAge=%EndAge%&OrderBy=%OrderBy%&Name=%Name%&page={0}#searchlist">
                            </My:AspNetPager>
                            <!--内容部分 end-->
                        </div>
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
        $(function () {
            $("#txt_StarAge,#txt_EndAge").keypress(function (event) {
                var keyCode = event.which;

                if ((keyCode >= 48 && keyCode <= 57) || keyCode == 8 || keyCode == 0)
                    return true;
                else
                    return false;
            }).focus(function () {
                this.style.imeMode = 'disabled';
            });


            $("#txt_StarAge").bind("keyup", function () {
                var reg = /^[1-9]\d*$/;
                var value = $.trim($(this).val());
                if (value != "" && reg.test(value) == false) {
                    $(this).val("");
                }
            })

            $("#txt_EndAge").bind("keyup", function () {
                var reg = /^[1-9]\d*$/;
                var value = $.trim($(this).val());
                if (value != "" && reg.test(value) == false) {
                    $(this).val("");
                }
            })
            $("#txt_EndAge").bind("blur", function () {
                var value = $.trim($(this).val());
                var star = $.trim($("#txt_StarAge").val());
                if (star != "" && value != "" && parseInt(star) >= parseInt(value)) {
                    $(this).val("");
                }
            })
        })

        function SearchSchool() {
            var star = $.trim($("#txt_StarAge").val());
            var end = $.trim($("#txt_EndAge").val());
            var name = $.trim($("#txt_Name").val());
            if (name == "请输入院校名称") {
                name = "";
            }
            var v = "&Name=" + escape(name);
            v += "&StarAge=" + star;
            v += "&EndAge=" + end;
            var url = "/schools/list.html?CountryId=<%=CountryId %>&CityId=<%=CityId %>&BusinessId=<%=BusinessId %>&LevelsId=<%=LevelsId %>&CategoriesId=<%=CategoriesId %>&TypeId=<%=TypeId %>&OrderBy=<%=CountryId %>" + v + "#searchlist";
            window.location.href = url;
        }
    </script>
</body>
</html>
