<%@ Page Language="C#" AutoEventWireup="true" CodeFile="t-creater.aspx.cs" Inherits="team_t_creater" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育|必益团队-关于创始人</title>
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
                    <img src="../images/about/ic-home.png" /></a><em>></em><a href="/team/">我们的团队 </a><em>></em><span>关于创始人</span>
            </div>
           <div class="ab-creater">
             <h3 class="hd">关于创始人</h3>
             <div class="ab-creater-intr">
               <%=s.Content %>
             </div>
           </div>
            
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
</body>
</html> 


