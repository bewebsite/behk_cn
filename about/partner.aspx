<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partner.aspx.cs" Inherits="about_partner" %>

<%@ Register Src="../ascx/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../ascx/footer.ascx" TagName="footer" TagPrefix="uc2" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="UTF-8">
    <title>必益教育|合作伙伴</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/about.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/layer/layer.js" type="text/javascript"></script>
    <script src="join.js" type="text/javascript"></script>
</head>
<body>
    <uc1:header ID="header1" runat="server" />
    <div class="about-wrap">
        <div class="clear">
        </div>
        <div class="about-main">
            <div class="ab-crumbs">
                <a href="/">
                    <img src="../images/about/ic-home.png" /></a><em>></em><a href="/about/">关于必益</a><em>></em><span>合作伙伴</span>
            </div>
            <div class="ab-coop">
                <h3 class="coop-hd">
                    合作机会</h3>
                <div class="coop-table">
                    <div class="coop-table-h">
                        必益教育一直在寻找长期合作的伙伴，如果您有兴趣与必益教育合作，请联系肖娟（Jenny Xiao），邮箱 jenny.xiao@behk.org</div>
                    <div class="coop-l clearfix">
                        <p class="tips" style="display: none">
                            请输入姓名有邮箱</p>
                        <div class="tb-item">
                            <label>
                                <em>*</em>您的姓名</label><input type="text" id="p_Name" /></div>
                        <div class="tb-item l-fr">
                            <label>
                                <em></em>公司名称</label><input type="text" id="p_CommpanyName" /></div>
                        <div class="tb-item">
                            <label>
                                <em></em>手机号码</label><input type="text" id="p_Mobile" /></div>
                        <div class="tb-item l-fr">
                            <label>
                                <em>*</em>邮箱地址</label><input type="text" id="p_Email" /></div>
                    </div>
                    <div class="tb-btn">
                        <a href="javascript:void(0);" onclick="JoinComment()">点击完成申请</a></div>
                </div>
            </div>
            <div class="coop-sch">
                <h3 class="coop-sch-h">
                    合作学校<em></em></h3>
                <div class="sch-list">
                    <div class="sch-row clearfix">
                        <%=GetKind1() %>
                    </div>
                </div>
            </div>
            <div class="coop-comp">
                <h3 class="coop-sch-h">
                    合作公司<em></em></h3>
                <div class="comp-row clearfix">
                    <%=GetKind2() %>
                </div>
            </div>
            <div class="coop-tips">
                <h4>
                    合作伙伴</h4>
                <p>
                    我们的合作伙伴为我们提供了巨大的帮助，将更好的教育提供给更多的学生。 请了解更多关于必益合作伙伴的信息。</p>
            </div>
        </div>
    </div>
    <uc2:footer ID="footer1" runat="server" />
</body>
</html>
