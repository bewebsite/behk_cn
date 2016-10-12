<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="Schools_Add.aspx.cs"
    Inherits="_eyoung_Schools_Schools_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>院校添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../fancybox/jquery.fancybox-1.3.1.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="../fancybox/jquery.fancybox-1.3.1.pack.js"></script>
    <script type="text/javascript">
        $().ready(function () {
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
                        data: { action: "CheckProductHtml", Name: "/schools/" + value },
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
            $("#form1").validate({
                rules: {
                    txt_HtmlName: { required: true, check_HtmlNameValue: true },
                    txt_CNName: { required: true },
                    txt_ENName: { required: true },
                    txt_BoardingStudent: { required: true, number: true },
                    txt_FoundingTime: { required: true, number: true },
                    drpCountry: { required: true },
                    txt_SouthLatitude: { required: true },
                    txt_NorthLatitude: { required: true },
                    txt_Location_X: { required: true, number: true },
                    txt_Location_Y: { required: true, number: true },
                    txt_SchoolType: { required: true },
                    txt_AreaSize: { required: true, digits: true },
                    txt_AgeStart: { required: true, digits: true },
                    txt_AgeEnd: { required: true, digits: true },
                    txt_Followers: { required: true, digits: true },
                    txt_StudentNumber: { required: true, digits: true },
                    txt_BoardingProportion: { required: true, digits: true },
                    txt_InternationalStudent: { required: true, digits: true },
                    txt_InternationalProportion: { required: true, digits: true },
                    txt_ChineseStudent: { required: true, digits: true },
                    txt_AdmissionRate: { required: true, digits: true },
                    txt_AnnualCost: { required: true, number: true },
                    txt_Sort: { required: true, digits: true },
                    txt_Click: { required: true, digits: true },
                    txt_GuideSort: { required: true, digits: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    txt_HtmlName: { required: "不能为空", check_HtmlNameValue: "伪静态名称已经存在" },
                    txt_CNName: { required: "不能为空" },
                    txt_ENName: { required: "不能为空" },
                    txt_BoardingStudent: { required: "不能为空", number: "不正确" },
                    txt_FoundingTime: { required: "不能为空", number: "必须为整数" },
                    drpCountry: { required: "不能为空" },
                    txt_SouthLatitude: { required: "不能为空" },
                    txt_NorthLatitude: { required: "&nbsp;&nbsp;不能为空" },
                    txt_Location_X: { required: "不能为空", number: "不正确" },
                    txt_Location_Y: { required: "&nbsp;&nbsp;不能为空", number: "&nbsp;&nbsp;不正确" },
                    txt_SchoolType: { required: "不能为空" },
                    txt_AreaSize: { required: "不能为空", digits: "必须为整数" },
                    txt_AgeStart: { required: "不能为空", digits: "必须为整数" },
                    txt_AgeEnd: { required: "&nbsp;&nbsp;不能为空", digits: "&nbsp;&nbsp;必须为整数" },
                    txt_Followers: { required: "不能为空", digits: "必须为整数" },
                    txt_StudentNumber: { required: "不能为空", digits: "必须为整数" },
                    txt_BoardingProportion: { required: "不能为空", digits: "必须为整数" },
                    txt_InternationalStudent: { required: "不能为空", digits: "必须为整数" },
                    txt_InternationalProportion: { required: "不能为空", digits: "必须为整数" },
                    txt_ChineseStudent: { required: "不能为空", digits: "必须为整数" },
                    txt_AdmissionRate: { required: "不能为空", digits: "必须为整数" },
                    txt_AnnualCost: { required: "不能为空", number: "格式不正确" },
                    txt_Sort: { required: "不能为空", digits: "必须为整数" },
                    txt_Click: { required: "不能为空", digits: "必须为整数" },
                    txt_GuideSort: { required: "不能为空", digits: "必须为整数" },
                    txt_AddTime: { required: "不能为空" }
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
    <form id="form1" enctype="multipart/form-data" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">院校添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <ul class="tab" id="tab">
                <li class="current">院校基本信息</li>
                <li>荐校及申请建议</li>
                <li>院校概况</li>
                <li>学院及课程设置</li>
                <li>学校设施</li>
                <li>顾问点评</li>
                <li>院校照片</li>
                <li>院校视频</li>
            </ul>
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>伪静态名称：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_HtmlName" CssClass="text" runat="server" Width="150"></asp:TextBox>.html&nbsp;<em
                                        class="em-red">*</em>
                                    <asp:HiddenField ID="t_HtmlName" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>页面标题：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_PageTitle" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>页面关键词：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_PageKey" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>页面描述：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_PageDes" CssClass="text" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>院校中文名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_CNName" CssClass="text" runat="server" Width="200"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>院校英文名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ENName" CssClass="text" runat="server" Width="200"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>成立年份：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_FoundingTime" CssClass="text" runat="server" Width="50"></asp:TextBox>
                                    年&nbsp;<em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>所在国家：</span>
                                </th>
                                <td>
                                    <asp:DropDownList runat="server" ID="drpCountry" DataTextField="Name" DataValueField="ID">
                                    </asp:DropDownList>
                                    <em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学校类型：</span>
                                </th>
                                <td>
                                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True">男校</asp:ListItem>
                                        <asp:ListItem>女校</asp:ListItem>
                                        <asp:ListItem>男女混合</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <th>
                                    <span>学校规模：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AreaSize" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    英亩&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>入学起止年龄：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AgeStart" Width="50px" CssClass="text" runat="server"></asp:TextBox>&nbsp;岁&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;
                                    <asp:TextBox ID="txt_AgeEnd" Width="50px" CssClass="text" runat="server"></asp:TextBox>&nbsp;岁
                                    <em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>关注人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Followers" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    人&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学校网址：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Website" CssClass="text" runat="server" Width="300"></asp:TextBox>
                                </td>
                                <th>
                                    <span>邮政编码：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ZipCode" CssClass="text" runat="server" Width="100"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>北西坐标：</span>
                                </th>
                                <td>
                                    北坐标：<asp:TextBox ID="txt_SouthLatitude" CssClass="text" runat="server" Width="60"></asp:TextBox>&nbsp;&nbsp;
                                    西坐标：<asp:TextBox ID="txt_NorthLatitude" CssClass="text" runat="server" Width="60"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>横纵坐标：</span>
                                </th>
                                <td>
                                    横坐标：<asp:TextBox ID="txt_Location_X" CssClass="text" runat="server" Width="60"></asp:TextBox>&nbsp;&nbsp;
                                    纵坐标：<asp:TextBox ID="txt_Location_Y" CssClass="text" runat="server" Width="60"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>&nbsp;</span>
                                </th>
                                <td style="color: Red">
                                    示例：北：51°53′34″N &nbsp;&nbsp;&nbsp;&nbsp; 西：2°6′18″W
                                </td>
                                <th>
                                    <span>&nbsp;</span>
                                </th>
                                <td style="color: Red">
                                    示例：横：116.382997，纵：39.935076
                                </td>
                            </tr>
                            <tr>
                                <th>
                                </th>
                                <td colspan="3" style="color: Blue">
                                    以下信息如果填写：0，前台页面将显示：院校未公开
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>师生配比：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_PeopleRatio" CssClass="text" runat="server" Width="200"></asp:TextBox>
                                </td>
                                <th>
                                    <span>录取率：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AdmissionRate" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    %&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学生人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StudentNumber" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    人&nbsp;<em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>中国学生人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ChineseStudent" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    人&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>寄宿学生人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_BoardingStudent" CssClass="text" runat="server" Width="50"></asp:TextBox>
                                    人&nbsp;<em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>寄宿生比例：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_BoardingProportion" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    %&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>国际学生人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_InternationalStudent" Text="0" Width="50px" CssClass="text"
                                        runat="server"></asp:TextBox>
                                    人&nbsp;<em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>国际学生比例：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_InternationalProportion" Text="0" Width="50px" CssClass="text"
                                        runat="server"></asp:TextBox>
                                    %&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>入学平均成绩：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_MeanScore" CssClass="text" runat="server" Width="200"></asp:TextBox>
                                </td>
                                <th>
                                    <span>每年学费及寄宿费：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AnnualCost" CssClass="text" runat="server" Width="50"></asp:TextBox>
                                    £&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>院校LOGO：</span>
                                </th>
                                <td colspan="3">
                                    <asp:Literal ID="Lit_LOGO" runat="server"></asp:Literal>
                                    <asp:HiddenField ID="Hid_LOGO" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传院校LOGO：</span>
                                </th>
                                <td colspan="3">
                                    <asp:FileUpload ID="FileUpload1" runat="server" /><span style="color: Red">图片尺寸：宽度：200px；高度：200px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    &nbsp;
                                </th>
                                <td colspan="3" style="color: Red">
                                    上传图片时，请上传png的图片，以保障手机推广页LOGO不会有瑕疵
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>推广页图片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:Literal ID="Lit_LOGO22" runat="server"></asp:Literal>
                                    <asp:HiddenField ID="Hid_LOGO22" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传推广页图片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:FileUpload ID="FileUpload22" runat="server" /><span style="color: Red">图片尺寸：宽度：185px；高度：373px</span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>相关城市：</span>
                                </th>
                                <td>
                                    <div id="cityId" class="freight_info">
                                        <asp:Literal ID="Lit_CityList" runat="server"></asp:Literal>
                                    </div>
                                    <asp:HiddenField runat="server" ID="Hid_City" />
                                    <asp:DropDownList runat="server" ID="drpCity" DataTextField="Name" DataValueField="ID"
                                        onchange="GetCity()">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>必益相关业务：</span>
                                </th>
                                <td colspan="3">
                                    <div id="BusinessId" class="freight_info">
                                        <asp:Literal ID="Lit_BusinessList" runat="server"></asp:Literal>
                                    </div>
                                    <asp:HiddenField runat="server" ID="Hid_Business" />
                                    <asp:DropDownList runat="server" ID="drpBusiness" DataTextField="Name" DataValueField="ID"
                                        onchange="GetBusiness()">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>适用学习阶段：</span>
                                </th>
                                <td colspan="3">
                                    <div id="LevelsId" class="freight_info">
                                        <asp:Literal ID="Lit_LevelsList" runat="server"></asp:Literal>
                                    </div>
                                    <asp:HiddenField runat="server" ID="Hid_Levels" />
                                    <asp:DropDownList runat="server" ID="drpLevels" DataTextField="Name" DataValueField="ID"
                                        onchange="GetLevels()">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>适用人群类别：</span>
                                </th>
                                <td colspan="3">
                                    <div id="CategoriesId" class="freight_info">
                                        <asp:Literal ID="Lit_CategoriesList" runat="server"></asp:Literal>
                                    </div>
                                    <asp:HiddenField runat="server" ID="Hid_Categories" />
                                    <asp:DropDownList runat="server" ID="drpCategories" DataTextField="Name" DataValueField="ID"
                                        onchange="GetCategories()">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="padding-left: 100px; color: Blue; font-weight: 700; font-size: 16px">
                                    &nbsp;院校官员
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学校官员中文译名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_OfficerCNName" CssClass="text" runat="server" Width="200"></asp:TextBox>
                                </td>
                                <th>
                                    <span>学校官员英文名称：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_OfficerENName" CssClass="text" runat="server" Width="200"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学校官员职衔：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_OfficerTitle" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>官员照片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:Literal ID="Lit_OfficerPhone" runat="server"></asp:Literal>
                                    <asp:HiddenField ID="hid_OfficerPhone" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传官员照片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:FileUpload ID="FileUpload2" runat="server" /><span style="color: Red">图片尺寸：宽度：122px；高度：129px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学校官员简介：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_OfficerProfile" Height="80" Width="500" CssClass="text" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="padding-left: 100px; color: Blue; font-weight: 700; font-size: 16px">
                                    &nbsp;显示信息
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
                                <th>
                                    <span>预览数：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="txt_Click" runat="server">0</asp:Literal>
                                    次
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>状态：</span>
                                </th>
                                <td>
                                    <label>
                                        <asp:CheckBox ID="chk_IsGuide" Text=" 推广页显示" runat="server" /></label>
                                </td>
                                <th>
                                    <span>推广页排序：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_GuideSort" Text="0" Width="50px" CssClass="text" runat="server"></asp:TextBox><span
                                        style="padding-left: 5px; color: Red">排序越大越靠前</span>&nbsp;<em class="em-red">*</em>
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
                                <th>
                                    <span>添加时间：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="txt_AddTime" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="padding-left: 100px; color: Blue; font-weight: 700; font-size: 16px">
                                    &nbsp;知名校友
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>代表校友中文姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_RepresentativeCNName" CssClass="text" runat="server" Width="200"></asp:TextBox>
                                </td>
                                <th>
                                    <span>代表校友英文姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_RepresentativeENName" CssClass="text" runat="server" Width="200"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>校友照片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:Literal ID="Lit_RepresentativePhone" runat="server"></asp:Literal>
                                    <asp:HiddenField ID="hid_RepresentativePhone" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传校友照片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:FileUpload ID="FileUpload3" runat="server" /><span style="color: Red">图片尺寸：宽度：98px；高度：110px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>代表校友成就：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_RepresentativeAchievement" CssClass="text" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="padding-left: 170px;">
                                    <asp:HiddenField ID="other_count" Value="0" runat="server" />
                                    <a href="javascript:void(0)" style="color: Red; font-weight: 700" onclick="AddOtherAlumnus(this)">
                                        点击添加一个其他校友</a>
                                    <asp:Literal ID="Lit_OtherPer" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <th>
                                    <span>其他知名校友：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_RepresentativeOther" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>推荐理由：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_RecommendedReason" Width="600" Height="100" CssClass="text"
                                        TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>申请准备及建议：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ApplicationAdvice" Width="600" Height="100" CssClass="text"
                                        TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>学校简介：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolIntroduction" CssClass="text" Width="600" Height="100"
                                        TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>交通距离：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolTravel" CssClass="text" Width="600" Height="100" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>地理环境：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolEnvironment" CssClass="text" Width="600" Height="100"
                                        TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学院设置：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolSettings" CssClass="text" Width="600" Height="100" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>课堂规模：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ClassSize" CssClass="text" Width="600" Height="100" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学校特色：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Highlights" TextMode="MultiLine" Width="600" Height="100" CssClass="text"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>教学理念：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolMotto" TextMode="MultiLine" Width="600" Height="100" CssClass="text"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>入学标准：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_EntranceRequirements" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>师资力量：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_TeacherStrength" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>学生关怀：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StudentCaring" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>学院设置：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AcademicUnits" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>专业课程：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AcademicCourses" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>特色课程：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SpecialCourses" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>体育课程：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolSports" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>科技课程：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolIT" TextMode="MultiLine" Width="600" Height="100" CssClass="text"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>艺术课程：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SchoolArts" TextMode="MultiLine" Width="600" Height="100" CssClass="text"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>课外活动：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Extracurriculum" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>外语辅导课程：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_LanguageCourses" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>毕业生学术成就：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_GraduateAchievement" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>升学院校：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_GraduateDestination" TextMode="MultiLine" Width="600" Height="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>教学设施：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AcademicFacility" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>运动设施：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SportsFacility" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>科技设施：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ITFacility" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>艺术设施：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ArtFacility" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>宿舍：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Accommodation" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>餐厅：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Catering" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>图书馆：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Library" TextMode="MultiLine" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hid_Consultant_Count" Value="1" runat="server" />
                                    <div class="caseImgAdd4 clearfix">
                                        <asp:Literal ID="Lit_ConsultantInfo" runat="server"></asp:Literal>
                                        <ul class="addUl4">
                                            <li><span class="em-red">图片尺寸：宽度：82px，高度：82px</span> </li>
                                            <li>上传图片：<input name="file_Consultant_1" class="text" style="width: 300px;" type="file" /></li>
                                            <li>中文姓名：<input name="ConsultantCNName_1" class="text" style="width: 300px" /></li>
                                            <li>英文姓名：<input name="ConsultantENName_1" class="text" style="width: 300px" /></li>
                                            <li>顾问职衔：<input name="Position_1" class="text" style="width: 300px" /></li>
                                            <li>顾问排序：<input name="ConsultantSort_1" onblur="checkproductnum(this);" style="width: 50px;"
                                                class="text" type="text" value="1" /><span style="color: Red; padding-left: 3px">排序越大越靠前</span></li>
                                            <li>点评内容：<textarea name="Info_1" cols="20" rows="2" class="text" style="width: 300px;
                                                height: 80px"></textarea></li>
                                            <li><a href="javascript:void(0);" onclick="addImageUpload3(this);">[再添加一个]</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hid_uploadfile_count" Value="1" runat="server" />
                                    <div class="caseImgAdd2 clearfix">
                                        <asp:Literal ID="lit_Image_List" runat="server"></asp:Literal>
                                        <ul class="addUl2">
                                            <li><span class="em-red">图片尺寸：宽度：840px，高度：360px</span> </li>
                                            <li>上传图片：<input name="file_uploadimage_1" class="text" style="width: 200px;" type="file" /></li>
                                            <li>图片排序：<input name="txt_ImgOrdinal_1" onblur="checkproductnum(this);" style="width: 50px;"
                                                class="text" type="text" value="1" /><span style="color: Red; padding-left: 3px">排序越大越靠前</span></li>
                                            <li><a href="javascript:void(0);" onclick="addImageUpload(this);">[再添加一个]</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hid_Voide" Value="1" runat="server" />
                                    <div class="caseImgAdd3 clearfix">
                                        <asp:Literal ID="Lit_VoideList" runat="server"></asp:Literal>
                                        <ul class="addUl3">
                                            <li><span class="em-red">图片尺寸：宽度：260px，高度：140px</span> </li>
                                            <li>视频图片：<input name="file_voide_1" class="text" style="width: 300px;" type="file" /></li>
                                            <li>视频名称：<input name="voide_1" class="text" style="width: 300px" /></li>
                                            <li>连接地址：<input name="link_1" class="text" style="width: 300px" /></li>
                                            <li>视频排序：<input name="voide_sort1" onblur="checkproductnum(this);" style="width: 50px;"
                                                class="text" type="text" value="1" /><span style="color: Red; padding-left: 3px">排序越大越靠前</span></li>
                                            <li><a href="javascript:void(0);" onclick="addImageUpload2(this);">[再添加一个]</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="Schools_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            //预览图片
            $("a#example").fancybox({
                'titleShow': false,
                'transitionIn': 'elastic',
                'transitionOut': 'elastic'
            });
            $("#other_count").val(0);
        });

        //添加上传图片控件
        function addImageUpload(aobj) {
            var html = $(aobj).parent().parent().clone();

            if (html.find("a").text() == "[再添加一个]") {
                var count = parseInt($("#hid_uploadfile_count").val());
                count++;
                html.find("a").text("[删除这个]");
                $(html).html(html.html().replace("file_uploadimage_1", "file_uploadimage_" + count).replace("txt_ImgOrdinal_1", "txt_ImgOrdinal_" + count));
                html.appendTo($(aobj).parent().parent().parent());
                $("#hid_uploadfile_count").val(count);
            }
            else {
                $(aobj).parent().parent().remove();
            }
        }

        //添加上传视频控件
        function addImageUpload2(aobj) {
            var html = $(aobj).parent().parent().clone();

            if (html.find("a").text() == "[再添加一个]") {
                var count = parseInt($("#hid_Voide").val());
                count++;
                html.find("a").text("[删除这个]");
                $(html).html(html.html().replace("file_voide_1", "file_voide_" + count).replace("voide_1", "voide_" + count).replace("link_1", "link_" + count).replace("voide_sort1", "voide_sort" + count));
                html.appendTo($(aobj).parent().parent().parent());
                $("#hid_Voide").val(count);
            }
            else {
                $(aobj).parent().parent().remove();
            }
        }

        //添加顾问控件
        function addImageUpload3(aobj) {
            var html = $(aobj).parent().parent().clone();

            if (html.find("a").text() == "[再添加一个]") {
                var count = parseInt($("#hid_Consultant_Count").val());
                count++;
                html.find("a").text("[删除这个]");
                $(html).html(html.html().replace("file_Consultant_1", "file_Consultant_" + count).replace("ConsultantCNName_1", "ConsultantCNName_" + count).replace("ConsultantENName_1", "ConsultantENName_" + count).replace("Position_1", "Position_" + count).replace("Info_1", "Info_" + count).replace("ConsultantSort_1", "ConsultantSort_" + count));
                html.appendTo($(aobj).parent().parent().parent());
                $("#hid_Consultant_Count").val(count);
            }
            else {
                $(aobj).parent().parent().remove();
            }
        }

        function deleteUpload(obj) {
            $(obj).parent().parent().parent().remove();
        }

        function checkproductnum(i) {
            var reg1 = /^\d+$/;
            var value = $(i).val().trim();
            if (isNaN(value) || reg1.test(value) == false) {
                $(i).val("1");
            }
        }

        function AddOtherAlumnus(obj) {
            var count = $("#other_count").val();
            var news = parseInt(count) + 1;
            count = news;
            var html = '<div>校友类型：<input type="text" name="Other_Title' + count + '" class="text" style="width: 150px" />&nbsp;&nbsp;&nbsp;&nbsp;相关人员：<input type="text" name="Other_Info' + count + '" class="text" style="width: 450px" />&nbsp;<a href="javascript:void(0)" onclick="deleteAlumnus(this)">[删除这个]</a></div>'
            $("#other_count").val(count);
            $(obj).parent().append(html);
        }

        function deleteAlumnus(obj) {
            $(obj).parent().remove();
        }



        function GetCity() {
            var id = $("#drpCity").val();
            if (id == "") {
                return;
            }
            var text = $("#drpCity").find("option:selected").text();

            $("#cityId").append("<a href='javascript:void(0)' v=" + id + " t=" + text + " onclick='removeCityId(this)' title='点击可移除'>" + text + " X</a>");
            $("#drpCity option:selected").remove();
            var value = $("#Hid_City").val();
            if (value == "") {
                $("#Hid_City").val("," + id + ",");
            }
            else {
                value += id + ",";
                $("#Hid_City").val(value);
            }
        }

        function removeCityId(obj) {
            var id = $(obj).attr("v");
            var text = $(obj).attr("t");
            $("#drpCity").append("<option value=" + id + ">" + text + "</option>");
            $(obj).remove();
            var value = $("#Hid_City").val();
            if (value != "") {
                value = value.replace("," + id + ",", ",");
                if (value == ",") {
                    $("#Hid_City").val("");
                }
                else {
                    $("#Hid_City").val(value);
                }
            }
        }

        function GetBusiness() {
            var id = $("#drpBusiness").val();
            if (id == "") {
                return;
            }
            var text = $("#drpBusiness").find("option:selected").text();

            $("#BusinessId").append("<a href='javascript:void(0)' v=" + id + " t=" + text + " onclick='removeBusiness(this)' title='点击可移除'>" + text + " X</a>");
            $("#drpBusiness option:selected").remove();
            var value = $("#Hid_Business").val();
            if (value == "") {
                $("#Hid_Business").val("," + id + ",");
            }
            else {
                value += id + ",";
                $("#Hid_Business").val(value);
            }
        }

        function removeBusiness(obj) {
            var id = $(obj).attr("v");
            var text = $(obj).attr("t");
            $("#drpBusiness").append("<option value=" + id + ">" + text + "</option>");
            $(obj).remove();
            var value = $("#Hid_Business").val();
            if (value != "") {
                value = value.replace("," + id + ",", ",");
                if (value == ",") {
                    $("#Hid_Business").val("");
                }
                else {
                    $("#Hid_Business").val(value);
                }
            }
        }

        function GetLevels() {
            var id = $("#drpLevels").val();
            if (id == "") {
                return;
            }
            var text = $("#drpLevels").find("option:selected").text();

            $("#LevelsId").append("<a href='javascript:void(0)' v=" + id + " t=" + text + " onclick='removeLevels(this)' title='点击可移除'>" + text + " X</a>");
            $("#drpLevels option:selected").remove();
            var value = $("#Hid_Levels").val();
            if (value == "") {
                $("#Hid_Levels").val("," + id + ",");
            }
            else {
                value += id + ",";
                $("#Hid_Levels").val(value);
            }
        }

        function removeLevels(obj) {
            var id = $(obj).attr("v");
            var text = $(obj).attr("t");
            $("#drpLevels").append("<option value=" + id + ">" + text + "</option>");
            $(obj).remove();
            var value = $("#Hid_Levels").val();
            if (value != "") {
                value = value.replace("," + id + ",", ",");
                if (value == ",") {
                    $("#Hid_Levels").val("");
                }
                else {
                    $("#Hid_Levels").val(value);
                }
            }
        }

        function GetCategories() {
            var id = $("#drpCategories").val();
            if (id == "") {
                return;
            }
            var text = $("#drpCategories").find("option:selected").text();

            $("#CategoriesId").append("<a href='javascript:void(0)' v=" + id + " t=" + text + " onclick='removeLevels(this)' title='点击可移除'>" + text + " X</a>");
            $("#drpCategories option:selected").remove();
            var value = $("#Hid_Categories").val();
            if (value == "") {
                $("#Hid_Categories").val("," + id + ",");
            }
            else {
                value += id + ",";
                $("#Hid_Categories").val(value);
            }
        }
        function removeCategories(obj) {
            var id = $(obj).attr("v");
            var text = $(obj).attr("t");
            $("#drpCategories").append("<option value=" + id + ">" + text + "</option>");
            $(obj).remove();
            var value = $("#Hid_Categories").val();
            if (value != "") {
                value = value.replace("," + id + ",", ",");
                if (value == ",") {
                    $("#Hid_Categories").val("");
                }
                else {
                    $("#Hid_Categories").val(value);
                }
            }
        }
        
    </script>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-31 16:42:27 -->
