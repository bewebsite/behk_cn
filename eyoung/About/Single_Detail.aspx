<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Single_Detail.aspx.cs" Inherits="eyoung_About_Single_Detail" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>关于我们单页添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">关于我们单页添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>页面名称：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="txt_Name" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>中文详情：<br />
                                        <span style="color: Blue">换行请按：Shift+Enter</span></span>
                                </th>
                                <td>
                                    <CKEditor:CKEditorControl runat="server" ID="txt_Content" Height="500" /><br />
                                    <span style="color: Blue">最大宽度：1140px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>英文详情：<br />
                                        <span style="color: Blue">换行请按：Shift+Enter</span></span>
                                </th>
                                <td>
                                    <CKEditor:CKEditorControl runat="server" ID="txt_ENContent" Height="500" /><br />
                                    <span style="color: Blue">最大宽度：1140px</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="Single_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 10:55:02 -->
