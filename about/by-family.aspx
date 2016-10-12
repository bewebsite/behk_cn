<%@ Page Language="C#" AutoEventWireup="true" CodeFile="by-family.aspx.cs" Inherits="about_by_family" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育|必益家庭</title>
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
                    <img src="../images/about/ic-home.png" /></a><em>></em><a href="/about/">关于必益</a><em>></em><span>必益家庭</span>
            </div>
            <div class="ab-brief">
                <div class="ab-ban">
                    <%=GetBanner() %></div>
            </div>
            <div class="ab-practice">
                <%=s.Content %>
            </div>
            <%-- <div class="apply clearfix">
                <div class="apply-c">
                  <a href="#">
                    <h4>我是实习生</h4>
                    <p>完成表格，开始申请</p>
                    <span class="ic-tri"></span>
                  </a>
                </div>
                <div class="apply-c apply-c2">
                   <a href="#">
                    <h4>我是公司职工</h4>
                    <p>完成表格，寻找合格雇员</p>
                    <span class="ic-tri"></span>
                  </a>
                
                </div>
            </div>--%>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
</body>
</html>
