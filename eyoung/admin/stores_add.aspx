<%@ Page Language="C#" AutoEventWireup="true" CodeFile="stores_add.aspx.cs" Inherits="eyoung_admin_stores_add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>职位添加</title>
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
                    txt_Name: { required: true }
                },
                messages: {
                    txt_Name: { required: "职位名称不能为空" }
                },
                errorElement: "span",
                errorPlacement: function (error, element) {
                    $(".sub_btn .p_error").html("信息填写不完善，请修改");
                    error.appendTo(element.parent());
                }
            });
        });

        $(function () {
            $(".name-c input").bind("click", function () {
                var _this = $(this);
                var chk = _this.attr("checked");
                if (chk == null || chk == "undefined") {
                    _this.parents(".name-c").next(".name-l").find("input").attr("checked", false);
                } else {
                    _this.parents(".name-c").next(".name-l").find("input").attr("checked", "checked");
                }
            })

            $("#allCheck").bind("click", function () {
                var _this = $(this);
                var chk = _this.attr("checked");
                if (chk == null || chk == "undefined") {
                    $("#chk_ids").find("input").attr("checked", false);
                } else {
                    $("#chk_ids").find("input").attr("checked", "checked");
                }
            })
        })
    </script>
</head>
<body>
    <form runat="server" id="form1">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">职位添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <!--选项卡部分 S-->
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    职位名称:
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Name" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    权限:
                                </th>
                                <td>
                                    <p style="padding: 6px 20px;">
                                        <label>
                                            <input type="checkbox" id="allCheck" />
                                            全选</label></p>
                                    <div id="chk_ids">
                                        <asp:Repeater ID="rpList" runat="server">
                                            <ItemTemplate>
                                                <ul class="clearfix competence">
                                                    <li class="name-w">
                                                        <%#Eval("Name")%>：</li>
                                                    <%# getRoleList(Eval("PermmissionList"),Eval("ID"))%>
                                                </ul>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
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
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="stores_list.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
