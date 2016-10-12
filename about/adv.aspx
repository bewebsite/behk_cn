<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adv.aspx.cs" Inherits="about_adv" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育|我们的优势</title>
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
                    <img src="../images/about/ic-home.png" /></a><em>></em><a href="/about/">关于必益</a><em>></em><span>我们的优势</span>
            </div>
            <div class="ab-brief">
                <div class="ab-ban">
                    <%=GetBanner()%></div>
            </div>
            <div class="ab-adv">
                <%=s.Content %>
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
</body>
</html>
