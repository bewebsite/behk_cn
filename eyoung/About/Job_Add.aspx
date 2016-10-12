<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="Job_Add.aspx.cs"
    Inherits="_eyoung_About_Job_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>招聘信息添加</title>
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
                    repLan: { required: true, digits: true },
                    txt_Name: { required: true },
                    txt_Sort: { required: true, digits: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    repLan: { required: "版本不能为空", digits: "版本必须为整数" },
                    txt_Name: { required: "职位名称不能为空" },
                    txt_Sort: { required: "排序不能为空", digits: "排序必须为整数" },
                    txt_AddTime: { required: "发布时间不能为空" }
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
    <form id="form1" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">招聘信息添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>版本：</span>
                                </th>
                                <td>
                                    <asp:DropDownList runat="server" ID="repLan">
                                        <asp:ListItem Value="">--语言版本--</asp:ListItem>
                                        <asp:ListItem Value="1">中文</asp:ListItem>
                                        <asp:ListItem Value="2">英文</asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>职位名称：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Name" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>工作地点：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Place" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>直线经理：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Manager" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>所属部门：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Report" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>排序：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Sort" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox><span
                                        style="padding-left: 5px; color: Blue">排序越大越靠前</span>&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>详细内容：<br />
                                        <span style="color: Blue">换行请按：Shift+Enter</span></span>
                                </th>
                                <td>
                                    <CKEditor:CKEditorControl runat="server" ID="txt_Content" /><br />
                                    <span style="color: Blue">最大宽度：710px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>发布时间：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AddTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"
                                        Width="150px" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="Job_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-06 15:11:34 -->
