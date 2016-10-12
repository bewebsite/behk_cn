<%@ Page Language="C#" AutoEventWireup="true" CodeFile="job.aspx.cs" Inherits="about_job" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育|必益招聘</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/about.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="about-wrap">
        <div class="clear">
        </div>
        <div class="about-main">
            <div class="ab-crumbs">
                <a href="/">
                    <img src="../images/about/ic-home.png" /></a><em>></em><a href="/about/">关于必益</a><em>></em><span>招聘</span>
            </div>
            <div class="job-hd">
                <div class="job-ban">
                    <img src="../images/about/ab-img4.jpg" /></div>
                <div class="job-banTxt">
                    <h3>
                        招聘</h3>
                    <p>
                        必益教育现面向社会诚聘英才，你将会得到良好的职业发展机会。<br />
                        现在就加入我们，共启成功旅程。请联系我们：john.hussey@be.co&nbsp;或电话：008615026724920 | 职位发布</p>
                </div>
            </div>
            <div class="jobList">
                <table class="job-tab">
                    <tr>
                        <th>
                            招聘职位
                        </th>
                        <th>
                            地点
                        </th>
                        <th class="job-data">
                            发布日期
                        </th>
                    </tr>
                    <asp:Repeater runat="server" ID="repList">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <a href="/about/job-detail<%#Eval("ID") %>.html" title="<%#Eval("Name") %>">
                                        <%#Eval("Name") %></a>
                                </td>
                                <td>
                                    <%#Eval("Place") %>
                                </td>
                                <td class="job-data">
                                    <%#Eval("AddTime","{0:dd/MM/yyyy}") %>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
            <div class="yg-comment">
                <h4 class="yg-comment-h">
                    看看我们的职员是怎么评价必益教育的<em></em></h4>
                <ul class="comm-List clearfix">
                    <asp:Repeater runat="server" ID="repPing">
                        <ItemTemplate>
                            <li class="<%# Container.ItemIndex%2==1?"comm-even":"" %>">
                                <div class="comm-item">
                                    <div class="c-hd">
                                        <h4>
                                            <%#Eval("Title") %></h4>
                                    </div>
                                    <div class="comm-c">
                                        <p class="p1">
                                            <em class="dou-l"></em>
                                            <%#Eval("Intor").ToString().Replace("\r\n","<br/>")%><em class="dou-r"></em></p>
                                        <p class="pfr">
                                            <em>——</em><%#Eval("Name") %></p>
                                    </div>
                                </div>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
</body>
</html>
