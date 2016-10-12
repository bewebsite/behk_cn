﻿<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="ENHomeImage_Add.aspx.cs"
    Inherits="_eyoung_ENHome_ENHomeImage_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>照片添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
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

        $.validator.addMethod(
            "chk_image",
            function (value, element) {
                var v = $.trim($("#txt_Pic").val());
                if (v == "" && value == "") {
                    return false;
                }
                else {
                    return true;
                }
            },
            ""
        );
        $().ready(function () {
            $("#form1").validate({
                rules: {
                    FileUpload1: { uploadimg_validate: true, chk_image: true },
                    txt_Name: { required: true },
                    txt_Sort: { required: true, digits: true }
                },
                messages: {
                    FileUpload1: { uploadimg_validate: "上传照片格式为：jpg,jpeg,bmp,png,gif", chk_image: "请上传图片" },
                    txt_Name: { required: "图片名称不能为空" },
                    txt_Sort: { required: "排序不能为空", digits: "排序必须为整数" }
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
                <asp:Literal ID="Lit_Title" runat="server">照片添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>图片名称：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Name" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>图片：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="lit_img_Pic" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传图片：</span>
                                </th>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="263px" />&nbsp;&nbsp;<span
                                        style="color: Blue">图片规格： 宽度：320px，高度：175px</span>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <th>
                                    <span>新闻列表图路径：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Pic" CssClass="text" runat="server"></asp:TextBox>
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
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_AsSave_Click" />
                    <a href="ENHomeImage_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-11-09 11:08:36 -->