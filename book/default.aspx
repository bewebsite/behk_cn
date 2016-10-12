<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <link href="/book/css/liquid-green.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/book/js/liquid.js"></script>
    <script type="text/javascript" src="/book/js/swfobject.js"></script>
    <script type="text/javascript" src="/book/js/flippingbook.js"></script>
    <script type="text/javascript">
        flippingBook.pages = ['/book/1_01.jpg', '/book/1_01.jpg', '/book/1_02.jpg', '/book/2_01.jpg', '/book/2_02.jpg', '/book/3_01.jpg', '/book/3_02.jpg', '/book/4_01.jpg', '/book/4_02.jpg'];
    </script>
    <script type="text/javascript" src="/book/js/bookSettings.js"></script>
</head>
<body>
    <div id="fbContainer">
        <a class="altlink" href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash">
            <div id="altmsg">
                Download Adobe Flash Player.</div>
        </a>
    </div>
    <div id="fbFooter">
        <div id="fbContents">
            <select id="fbContentsMenu" name="fbContentsMenu">
            </select>
            <span class="fbPaginationMinor">p.&nbsp;</span> <span id="fbCurrentPages">1</span>
            <span id="fbTotalPages" class="fbPaginationMinor"></span>
        </div>
        <div id="fbMenu">
            <img src="/book/img/btnZoom.gif" width="36" height="40" border="0" id="fbZoomButton" /><img
                src="/book/img/btnPrint.gif" width="36" height="40" border="0" id="fbPrintButton" />
            <img src="/book/img/btnDiv.gif" width="13" height="40" border="0" /><img src="/book/img/btnPrevious.gif"
                width="36" height="40" border="0" id="fbBackButton" /><img src="/book/img/btnNext.gif"
                    width="36" height="40" border="0" id="fbForwardButton" /></div>
    </div>
</body>
</html>
