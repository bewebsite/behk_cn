<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="NewsType_Add.aspx.cs"
    Inherits="_eyoung_News_NewsType_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>新闻分类添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        //判断伪是否存在
        $.validator.addMethod(
                "check_HtmlNameValue",
                function (value, element) {
                    var value = $.trim($("#txt_HtmlName").val());
                    var value2 = $("#t_HtmlName").val();
                    if (value == value2) {
                        return true;
                    }
                    var x = 0;
                    $.ajax({
                        type: "post",
                        url: "../ajax/AjaxInfo.ashx",
                        data: { action: "CheckProductHtml", Name: "/news/" + value },
                        cache: false,
                        async: false,
                        dataType: "json",
                        success: function (text) {
                            if (text != null && text == "1") {
                                x = 1;
                            }
                        }
                    });
                    if (x == 0) {
                        return false;
                    }
                    return true;
                },
                "该名称已存在，请重新输入"
            );
        $().ready(function () {
            $("#form1").validate({
                rules: {
                    txt_HtmlName: { required: true, check_HtmlNameValue: true },
                    txt_Name: { required: true },
                    txt_Sort: { required: true, digits: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    txt_HtmlName: { required: "Html名不能为空", check_HtmlNameValue: "该名称已存在，请重新输入" },
                    txt_Name: { required: "分类名称不能为空" },
                    txt_Sort: { required: "排序不能为空", digits: "排序必须为整数" },
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
    <form id="form1" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">新闻分类添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>伪静态名称：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_HtmlName" CssClass="text" runat="server" Width="150"></asp:TextBox>.html&nbsp;<em
                                        class="em-red">*</em>
                                    <asp:HiddenField ID="t_HtmlName" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>页面标题：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_PageTitle" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>页面关键词：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_PageKey" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>页面描述：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_PageDes" CssClass="text" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>分类名称：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Name" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>排序：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Sort" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox><span
                                        style="padding-left: 5px; color: Red">排序越大越靠前</span>&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>添加时间：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AddTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"
                                        Width="150px" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>状态：</span>
                                </th>
                                <td>
                                    <label>
                                        <asp:CheckBox ID="chk_IsPass" Text=" 显示" runat="server" /></label>
                                    <span style="color: Red; padding-left: 5px">勾选，内容才能在前台页面显示</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="NewsType_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-28 12:59:00 -->
