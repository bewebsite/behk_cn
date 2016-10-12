<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="AppointmentComment_Add.aspx.cs"
    Inherits="_eyoung_Guide_AppointmentComment_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>招生会报名添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">招生会报名添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Name" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>手机号：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Mobile" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>所在城市：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_City" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学生年龄：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Age" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>所在年级：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Grade" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>意向出国时间：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AbroadTime" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>面试志愿学校一：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_DesireSchool1" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>面试志愿学校二：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_DesireSchool2" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>面试地点：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_InterviewPlace" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>来宾人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_GuestNum" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>客户留言：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Comment" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学生姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StudentName" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学生性别：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StudentSex" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>出生日期：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StudentBirthday" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});"
                                        Width="150" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>业务跟进情况：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_FollowUp" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
			    <tr>
                                <th>
                                    <span>Channel：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Channels" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>提交时间：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="txt_AddTime" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>状态：</span>
                                </th>
                                <td>
                                    <label>
                                        <asp:CheckBox ID="chk_IsReached" Text=" 已回访" runat="server" /></label>
                                    <label>
                                        <asp:CheckBox ID="chk_IsExistingCustomer" Text=" 现有客户" runat="server" /></label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="AppointmentComment_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-28 10:03:21 -->
