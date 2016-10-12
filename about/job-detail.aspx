<%@ Page Language="C#" AutoEventWireup="true" CodeFile="job-detail.aspx.cs" Inherits="about_job_detail" %>

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
                            工作地点
                        </th>
                        <th>
                            直线经理
                        </th>
                        <th>
                            所属部门
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <%=j.Name %>
                        </td>
                        <td>
                            <%=j.Place %>
                        </td>
                        <td>
                            <%=j.Manager %>
                        </td>
                        <td>
                            <%=j.Report %>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="job-detail">
                <%=j.Content %>
                <%--<div class="job-item">
                    <h4 class="jitem-h">
                        OB CONTENT</h4>
                    <div class="jitem-c">
                        <p>
                            Supported by the local Marketing & Admissions team in addition to the Shanghaibased
                            Headquarters Marketing team, the Marketn to being able
                        </p>
                        <br />
                        <ul class="ad-ul-1">
                            <li>Supported by the local Marketing</li>
                            <li>Supported by the local Marketing</li>
                        </ul>
                        <p>
                            Supported by the local Marketing & Admissions team in addition to the Shanghaibased
                            Headquarters Marketing team, the Marketn to being able Supported by the local Marketing
                            & Admissions team in addition to the Shanghaibased Headquarters Marketing team,
                            the Marketn to being able
                        </p>
                    </div>
                </div>
                <div class="job-item">
                    <h4 class="jitem-h">
                        OB CONTENT</h4>
                    <div class="jitem-c">
                        <p>
                            Supported by the local Marketing & Admissions team in addition to the Shanghaibased
                            Headquarters Marketing team, the Marketn to being able
                        </p>
                        <br />
                        <ul class="ad-ul-1">
                            <li>Supported by the local Marketing</li>
                            <li>Supported by the local Marketing</li>
                        </ul>
                        <p>
                            Supported by the local Marketing & Admissions team in addition to the Shanghaibased
                            Headquarters Marketing team, the Marketn to being able Supported by the local Marketing
                            & Admissions team in addition to the Shanghaibased Headquarters Marketing team,
                            the Marketn to being able
                        </p>
                    </div>
                </div>--%>
                <div class="job-tips">
                    <b>申请材料：</b>
1.CV(中英文双语简历优先)
2. 相关工作或项目的组合与介绍 (Portfolio)
初审材料通过后，我们会尽快通过邮件/电话的方式联系你进行面试！
</div>
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
</body>
</html>
