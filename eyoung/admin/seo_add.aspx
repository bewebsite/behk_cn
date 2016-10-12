﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="seo_add.aspx.cs" Inherits="eyoung_admin_seo_add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>页面关键词添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function () {
            $("#form1").validate({
                rules: {
                    txt_LookExpression: { required: true },
                    txt_Ordinal: { required: true, digits: true }
                },
                messages: {
                    txt_LookExpression: { required: "Url地址不能为空" },
                    txt_Ordinal: { required: "排序不能为空", digits: "排序必须为整数" }
                },
                errorElement: "span",
                errorPlacement: function (error, element) {
                    $(".sub_btn .p_error").html("信息填写不完善，请修改");
                    error.appendTo(element.parent());
                }
            });
        });
    </script>
</head>
<body>
    <form runat="server" id="form1">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">页面关键词添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <!--选项卡部分 S-->
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    Url地址:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_LookExpression" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    网页标题(title):
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Title" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    网页关键词(keyword):
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Keyword" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    网页描述(description):
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Description" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    排序:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Ordinal" Width="50" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="but_save_Click" />
                    <a href="seo_list.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>