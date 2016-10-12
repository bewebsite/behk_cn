<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="SchoolPageListActivity_Add.aspx.cs"
    Inherits="_eyoung_Schools_SchoolPageListActivity_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>院校最新活动添加</title>
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
                    txt_Title: { required: true },
                    txt_StarDay: { required: true },
                    txt_StarTimer: { required: true, digits: true },
                    txt_StarTimer2: { digits: true },
                    txt_EndTimer: { digits: true },
                    txt_EndTimer2: { digits: true },
                    txt_Address: { required: true },
                    txt_GetUrl: { required: true },
                    txt_Sort: { required: true, digits: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    txt_Title: { required: "活动标题不能为空" },
                    txt_StarDay: { required: "开始日期不能为空" },
                    txt_StarTimer: { required: "开始时间小时不能为空", digits: "开始时间小时必须为整数" },
                    txt_StarTimer2: { digits: "&nbsp;&nbsp;开始时间分钟必须为整数" },
                    txt_EndTimer: { digits: "&nbsp;&nbsp;结束时间分钟必须为整数" },
                    txt_EndTimer2: { digits: "&nbsp;&nbsp;结束时间分钟必须为整数" },
                    txt_Address: { required: "活动地点不能为空" },
                    txt_GetUrl: { required: "连接地址不能为空" },
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
                <asp:Literal ID="Lit_Title" runat="server">院校最新活动添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                </th>
                                <td style="color: Red">
                                    院校列表页中，院校最新活动最多只能显示4个
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动标题：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Title" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动日期：</span>
                                </th>
                                <td>
                                    从&nbsp;&nbsp;<asp:TextBox ID="txt_StarDay" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});"
                                        Width="100px" CssClass="text" runat="server"></asp:TextBox>&nbsp;&nbsp;至&nbsp;&nbsp;<asp:TextBox
                                            ID="txt_EndDay" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" Width="100px"
                                            CssClass="text" runat="server"></asp:TextBox>&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                             <tr>
                                <th>
                                </th>
                                <td style="color: Blue">
                                    如果只有当天，结束日期可以不填写
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动时间：</span>
                                </th>
                                <td>
                                    从&nbsp;&nbsp;<asp:TextBox ID="txt_StarTimer" CssClass="text" runat="server" Width="40"></asp:TextBox>&nbsp;点&nbsp;<asp:TextBox
                                        ID="txt_StarTimer2" CssClass="text" runat="server" Width="40"></asp:TextBox>分&nbsp;至&nbsp;&nbsp;<asp:TextBox
                                            ID="txt_EndTimer" CssClass="text" runat="server" Width="40"></asp:TextBox>&nbsp;点&nbsp;<asp:TextBox
                                                ID="txt_EndTimer2" CssClass="text" runat="server" Width="40"></asp:TextBox>&nbsp;分&nbsp;<em
                                                    class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                </th>
                                <td style="color: Blue">
                                    如果为正点，分钟可以不填写。如果没有结束时间，可以不填写
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动地点：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Address" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>连接地址：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_GetUrl" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
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
                                    <span style="color: Red; padding-left: 5px">只有勾选，内容才能在前台页面显示</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="SchoolPageListActivity_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 10:17:23 -->
