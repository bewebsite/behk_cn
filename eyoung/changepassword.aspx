<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changepassword.aspx.cs" Inherits="changepassword" %>

<%@ Register Src="ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>修改密码</title>
    <link rel="stylesheet" href="css/reset.css" type="text/css" />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script src="js/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $.validator.addMethod(
            "chk_length",
            function (value, element) {
                var v1 = $.trim($("#txt_NewPassWord").val());
                if (v1.length < 6) {
                    return false;
                }
                return true;
            },
            "密码长度为6位数以上"
        );
        $.validator.addMethod(
            "chk_Value",
            function (value, element) {
                var v1 = $.trim($("#txt_NewPassWord").val());
                var v2 = $.trim($("#txt_NewPassWord2").val());
                if (v1 != v2) {
                    return false;
                }
                return true;
            },
            "两次密码不一致"
        );
        $().ready(function () {
            $("#form1").validate({
                rules: {
                    txt_OldPassWord: { required: true },
                    txt_NewPassWord: { required: true, chk_length: true },
                    txt_NewPassWord2: { required: true, chk_Value: true }
                },
                messages: {
                    txt_OldPassWord: { required: "旧密码不能为空" },
                    txt_NewPassWord: { required: "新密码不能为空", chk_length: "密码长度为6位数以上" },
                    txt_NewPassWord2: { required: "请再次输入新密码", chk_Value: "两次密码不一致" }
                },
                errorElement: "span",
                errorPlacement: function (error, element) {
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
                <asp:Literal ID="Lit_Title" runat="server">管理员添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <!--选项卡部分 S-->
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    旧密码:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_OldPassWord" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    新密码:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_NewPassWord" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    确认密码:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_NewPassWord2" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="/eyoung/" class="button">返回首页</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
