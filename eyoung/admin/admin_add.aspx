<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin_add.aspx.cs" Inherits="eyoung_admin_admin_add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>管理员添加</title>
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
                    drpKind: { required: true },
                    txt_Realname: { required: true },
                    txt_Username: { required: true },
                    txt_Password: { required: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    drpKind: { required: "职位不能为空" },
                    txt_Realname: { required: "管理员姓名不能为空" },
                    txt_Username: { required: "用户名不能为空" },
                    txt_Password: { required: "密码不能为空" },
                    txt_AddTime: { required: "添加时间不能为空" }
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
                                    职位:
                                </th>
                                <td>
                                    <asp:DropDownList runat="server" ID="drpKind" DataTextField="Name" DataValueField="ID">
                                    </asp:DropDownList>
                                    <em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    用户名:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Username" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    密码:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Password" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    管理员姓名:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Realname" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    邮箱:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Email" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    添加时间:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AddTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"
                                        Width="150px" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    状态:
                                </th>
                                <td>
                                    <label>
                                        <asp:CheckBox ID="chk_IsPass" Text=" 审核" runat="server" /></label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="Admin_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
