<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="GuideGuest_Add.aspx.cs"
    Inherits="_eyoung_Guide_GuideGuest_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>重磅嘉宾添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function () {
            var upload_reg = /\.(jpg|jpeg|bmp|png|gif)/i;
            //方法
            $.validator.addMethod(
            "uploadimg_validate",
            function (value, element) {
                if ($.trim(value) == "") {
                    return true;
                }
                return upload_reg.test($.trim(value));
            },
            "上传图片格式为：jpg,jpeg,bmp,png,gif"
        );
            $("#form1").validate({
                rules: {
                    txt_Name: { required: true },
                    FileUpload1: { uploadimg_validate: true },
                    txt_Position: { required: true },
                    txt_Introduction: { required: true },
                    //txt_Highlights: { required: true },
                    txt_Sort: { required: true, digits: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    txt_Name: { required: "姓名不能为空" },
                    FileUpload1: { uploadimg_validate: "&nbsp;&nbsp;&nbsp;&nbsp;上传照片格式为：jpg,jpeg,bmp,png,gif" },
                    txt_Position: { required: "职称不能为空" },
                    txt_Introduction: { required: "嘉宾介绍不能为空" },
                    //txt_Highlights: { required: "讲座亮点不能为空" },
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

        function GetEvents() {
            var id = $("#drpEvents").val();
            if (id == "") {
                return;
            }
            var text = $("#drpEvents").find("option:selected").text();

            $("#EventId").append("<a href='javascript:void(0)' v=" + id + " t=" + text + " onclick='removeEvent(this)' title='点击可移除'>" + text + " X</a>");
            $("#drpEvents option:selected").remove();
            var value = $("#Hid_Event").val();
            if (value == "") {
                $("#Hid_Event").val("," + id + ",");
            }
            else {
                value += id + ",";
                $("#Hid_Event").val(value);
            }
        }

        function removeEvent(obj) {
            var id = $(obj).attr("v");
            var text = $(obj).attr("t");
            $("#drpEvents").append("<option value=" + id + ">" + text + "</option>");
            $(obj).remove();
            var value = $("#Hid_Event").val();
            if (value != "") {
                value = value.replace("," + id + ",", ",");
                if (value == ",") {
                    $("#Hid_Event").val("");
                }
                else {
                    $("#Hid_Event").val(value);
                }
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">重磅嘉宾添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>照片：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="lit_img_Pic" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传照片：</span>
                                </th>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="263px" />&nbsp;&nbsp;<span
                                        style="color: Blue">图片规格： 宽度：197px，高度：245px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>照片路径：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Pic" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Name" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>职称：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Position" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>嘉宾介绍：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Introduction" CssClass="text" TextMode="MultiLine" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>讲座亮点：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Highlights" CssClass="text" TextMode="MultiLine" runat="server"
                                        Height="100" Width="550"></asp:TextBox>&nbsp;<em class="em-red">*</em>
                                    <br />
                                    <span style="color: Blue">一个回车为一个亮点，自动换行不算在范围之内</span>
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
                                    <span style="color: Blue; padding-left: 5px">只有通过审核，内容才能在前台页面显示</span>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <span>英文姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_En_Name" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <span>中文题目：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Cn_Topic" CssClass="text" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <span>英文题目：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_En_Topic" CssClass="text" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <th>
                                    <span>活动：</span>
                                </th>
                                <td colspan="3">
                                    <div id="EventId" class="freight_info">
                                        <asp:Literal ID="Lit_EventsList" runat="server"></asp:Literal>
                                    </div>
                                    <asp:HiddenField runat="server" ID="Hid_Event" />
                                    <asp:DropDownList runat="server" ID="drpEvents" DataTextField="PageTitle" DataValueField="ID"
                                        onchange="GetEvents()">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="GuideGuest_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-30 11:09:28 -->
