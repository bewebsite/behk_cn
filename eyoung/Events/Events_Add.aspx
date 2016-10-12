<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="Events_Add.aspx.cs"
    Inherits="_eyoung_Events_Events_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>精彩活动添加</title>
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
                        data: { action: "CheckProductHtml", Name: "/events/" + value },
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
                    txt_CNTitle: { required: true },
                    txt_ENTitle: { required: true },
                    drpType: { required: true },
                    txt_StarAge: { required: true, digits: true },
                    txt_EndAge: { required: true, digits: true },
                    txt_StarDay: { required: true },
                    txt_StarTimer: { required: true, digits: true },
                    txt_StarTimer2: { digits: true },
                    txt_EndTimer: { digits: true },
                    txt_EndTimer2: { digits: true },
                    txt_AllNum: { required: true, digits: true },
                    txt_RegistrationNumber: { required: true, digits: true },
                    txt_EnrollStar: { required: true },
                    txt_EnrollEnd: { required: true },
                    txt_Address: { required: true },
                    txt_Location_X: { required: true },
                    txt_Location_Y: { required: true },
                    txt_Latitude: { required: true },
                    txt_ContactName: { required: true },
                    txt_ContactEmail: { required: true },
                    txt_ContactMobile: { required: true },
                    txt_VIPCNName: { required: true },
                    txt_VIPENName: { required: true },
                    txt_VIPTitle: { required: true },
                    txt_VIPCNTopic: { required: true },
                    txt_VIPENTopic: { required: true },
                    txt_Sort: { required: true, digits: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    txt_HtmlName: { required: "不能为空", check_HtmlNameValue: "伪静态名称已经存在" },
                    txt_CNTitle: { required: "不能为空" },
                    txt_ENTitle: { required: "不能为空" },
                    drpType: { required: "不能为空" },
                    txt_StarAge: { required: "不能为空", digits: "必须为整数" },
                    txt_EndAge: { required: "&nbsp;&nbsp;不能为空", digits: "&nbsp;&nbsp;必须为整数" },
                    txt_StarDay: { required: "活动开始日期不能为空" },
                    txt_StarTimer: { required: "活动开始时间不能为空", digits: "必须为整数" },
                    txt_StarTimer2: { digits: "&nbsp;&nbsp;必须为整数" },
                    txt_EndTimer: { digits: "&nbsp;&nbsp;必须为整数" },
                    txt_EndTimer2: { digits: "&nbsp;&nbsp;必须为整数" },
                    txt_AllNum: { required: "不能为空", digits: "必须为整数" },
                    txt_RegistrationNumber: { required: "不能为空", digits: "必须为整数" },
                    txt_EnrollStar: { required: "不能为空" },
                    txt_EnrollEnd: { required: "&nbsp;&nbsp;不能为空" },
                    txt_Address: { required: "不能为空" },
                    txt_Location_X: { required: "不能为空" },
                    txt_Location_Y: { required: "&nbsp;&nbsp;不能为空" },
                    txt_Latitude: { required: "不能为空" },
                    txt_ContactName: { required: "不能为空" },
                    txt_ContactEmail: { required: "不能为空" },
                    txt_ContactMobile: { required: "不能为空" },
                    txt_VIPCNName: { required: "不能为空" },
                    txt_VIPENName: { required: "不能为空" },
                    txt_VIPTitle: { required: "不能为空" },
                    txt_VIPCNTopic: { required: "不能为空" },
                    txt_VIPENTopic: { required: "不能为空" },
                    txt_Sort: { required: "不能为空", digits: "必须为整数" },
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
    <form id="form1" enctype="multipart/form-data" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">精彩活动添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <ul class="tab" id="tab">
                <li class="current">基本信息</li>
                <li>活动图片</li>
                <li>活动视频</li>
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
                                <td>
                                    <asp:TextBox ID="txt_PaegKey" CssClass="text" runat="server"></asp:TextBox>
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
                                    <span>中文标题：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_CNTitle" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>英文标题：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ENTitle" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动类型：</span>
                                </th>
                                <td>
                                    <asp:DropDownList runat="server" ID="drpType" DataTextField="Name" DataValueField="ID">
                                    </asp:DropDownList>
                                    <em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>适用人群年龄：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StarAge" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    &nbsp;&nbsp;-&nbsp;&nbsp;
                                    <asp:TextBox ID="txt_EndAge" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    岁&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动日期：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StarDay" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" Width="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                    &nbsp;&nbsp;-&nbsp;&nbsp;
                                    <asp:TextBox ID="txt_EndDay" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" Width="100"
                                        CssClass="text" runat="server"></asp:TextBox>
                                    &nbsp;<em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>活动时间：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_StarTimer" Width="30" CssClass="text" runat="server"></asp:TextBox>
                                    &nbsp;时&nbsp;<asp:TextBox ID="txt_StarTimer2" Width="30" CssClass="text" runat="server"></asp:TextBox>
                                    分 &nbsp;&nbsp;-&nbsp;&nbsp;
                                    <asp:TextBox ID="txt_EndTimer" CssClass="text" Width="30" runat="server"></asp:TextBox>&nbsp;时&nbsp;
                                    <asp:TextBox ID="txt_EndTimer2" CssClass="text" Width="30" runat="server"></asp:TextBox>
                                    分&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>报名日期：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_EnrollStar" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" Width="100px"
                                        CssClass="text" runat="server"></asp:TextBox>&nbsp;&nbsp;-&nbsp;&nbsp;
                                    <asp:TextBox ID="txt_EnrollEnd" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" Width="100px"
                                        CssClass="text" runat="server"></asp:TextBox>&nbsp;<em class="em-red">*</em>
                                </td>
                                <th>
                                    <span>活动地址：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Address" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>纬度：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Latitude" CssClass="text" Width="200" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>坐标：</span>
                                </th>
                                <td>
                                    X坐标：
                                    <asp:TextBox ID="txt_Location_X" CssClass="text" runat="server" Width="100"></asp:TextBox>&nbsp;
                                    Y坐标：<asp:TextBox ID="txt_Location_Y" CssClass="text" runat="server" Width="100"></asp:TextBox>&nbsp;<em
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
                                    <a href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">点击获取坐标</a>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动最多报名人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_AllNum" Width="50px" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>活动当前报名人数：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_RegistrationNumber" Width="50px" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动联络人：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ContactName" Width="150" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>活动联络方电邮：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ContactEmail" Width="150" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动联络方电话：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ContactMobile" Width="150" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>适用人群类别：</span>
                                </th>
                                <td>
                                    <asp:TextBox Width="200" ID="txt_CrowdCategory" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动报名说明：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_EnrollInfo" CssClass="text" Width="600" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>适用人群描述：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_CategoriesIntroduction" Width="600" CssClass="text" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动简介：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_Intor" Width="600" CssClass="text" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>活动详情：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Content" Width="600" Height="150" CssClass="text" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>特别亮点：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_Highlights" Height="100" Width="600" CssClass="text" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                    <br />
                                    <span style="color: Blue">一行为一个亮点，自动换行不算</span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>嘉宾中文姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_VIPCNName" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>嘉宾英文姓名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_VIPENName" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>嘉宾演讲题目中文：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_VIPCNTopic" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>嘉宾演讲题目英文：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_VIPENTopic" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>嘉宾中文职衔：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_VIPTitle" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>照片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:Literal ID="Lit_OfficerPhone" runat="server"></asp:Literal>
                                    <asp:HiddenField ID="hid_OfficerPhone" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传照片：</span>
                                </th>
                                <td colspan="3">
                                    <asp:FileUpload ID="FileUpload2" runat="server" /><span style="color: Red">图片尺寸：宽度：122px；高度：129px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>嘉宾简介：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_VIPIntor" Width="600" CssClass="text" TextMode="MultiLine" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                </th>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>相关留学国家</span>
                                </th>
                                <td colspan="3">
                                    <div id="countryId" class="freight_info">
                                        <asp:Literal ID="Lit_CountryList" runat="server"></asp:Literal>
                                    </div>
                                    <asp:HiddenField runat="server" ID="Hid_Country" />
                                    <asp:DropDownList runat="server" ID="drpCountry" DataTextField="Name" DataValueField="ID"
                                        onchange="GetCountry()">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>相关城市：</span>
                                </th>
                                <td colspan="3">
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
                                <th>
                                    <span>相关学校：</span>
                                </th>
                                <td colspan="3">
                                    <div id="infos" class="freight_info">
                                        <asp:Literal ID="Lit_Area" runat="server"></asp:Literal>
                                    </div>
                                    <asp:HiddenField runat="server" ID="Hid_Area" />
                                    <asp:DropDownList runat="server" ID="drpSchool" DataTextField="CNName" DataValueField="ID"
                                        onchange="GetSchool()">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
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
                                    <span>状态：</span>
                                </th>
                                <td>
                                    <label>
                                        <asp:CheckBox ID="chk_IsPass" Text=" 显示" runat="server" /></label>
                                    <label>
                                        <asp:CheckBox ID="chk_IsHot" Text=" 推荐" runat="server" /></label>
                                    <span style="color: Red; padding-left: 5px">只有勾选显示，内容才能在前台页面显示</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>添加时间：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox ID="txt_AddTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"
                                        Width="150px" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    &nbsp;
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
                                            <li><span class="em-red">图片尺寸：宽度：202px，高度：214px</span> </li>
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
                    <a href="Events_List.aspx" class="button">返回列表</a>
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


        });

        function checkproductnum(i) {
            var reg1 = /^\d+$/;
            var value = $(i).val().trim();
            if (isNaN(value) || reg1.test(value) == false) {
                $(i).val("1");
            }
        }

        function GetSchool() {
            var id = $("#drpSchool").val();
            if (id == "") {
                return;
            }
            var text = $("#drpSchool").find("option:selected").text();

            $("#infos").append("<a href='javascript:void(0)' v=" + id + " t=" + text + " onclick='removeAreaId(this)' title='点击可移除'>" + text + " X</a>");
            $("#drpSchool option:selected").remove();
            var value = $("#Hid_Area").val();
            if (value == "") {
                $("#Hid_Area").val("," + id + ",");
            }
            else {
                value += id + ",";
                $("#Hid_Area").val(value);
            }
        }

        function removeAreaId(obj) {
            var id = $(obj).attr("v");
            var text = $(obj).attr("t");
            $("#drpSchool").append("<option value=" + id + ">" + text + "</option>");
            $(obj).remove();
            var value = $("#Hid_Area").val();
            if (value != "") {
                value = value.replace("," + id + ",", ",");
                if (value == ",") {
                    $("#Hid_Area").val("");
                }
                else {
                    $("#Hid_Area").val(value);
                }
            }
        }

        function GetCountry() {
            var id = $("#drpCountry").val();
            if (id == "") {
                return;
            }
            var text = $("#drpCountry").find("option:selected").text();

            $("#countryId").append("<a href='javascript:void(0)' v=" + id + " t=" + text + " onclick='removeCountryId(this)' title='点击可移除'>" + text + " X</a>");
            $("#drpCountry option:selected").remove();
            var value = $("#Hid_Country").val();
            if (value == "") {
                $("#Hid_Country").val("," + id + ",");
            }
            else {
                value += id + ",";
                $("#Hid_Country").val(value);
            }
        }

        function removeCountryId(obj) {
            var id = $(obj).attr("v");
            var text = $(obj).attr("t");
            $("#drpCountry").append("<option value=" + id + ">" + text + "</option>");
            $(obj).remove();
            var value = $("#Hid_Country").val();
            if (value != "") {
                value = value.replace("," + id + ",", ",");
                if (value == ",") {
                    $("#Hid_Country").val("");
                }
                else {
                    $("#Hid_Country").val(value);
                }
            }
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

        function deleteUpload(obj) {
            $(obj).parent().parent().parent().remove();
        }

    </script>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-08-31 17:53:24 -->
