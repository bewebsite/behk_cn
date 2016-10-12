<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="News_Add.aspx.cs"
    Inherits="_eyoung_News_News_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>新闻添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../fancybox/jquery.fancybox-1.3.1.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="../../js/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript" src="../fancybox/jquery.fancybox-1.3.1.pack.js"></script>
    <script type="text/javascript">
        $(function () {
            //预览图片
            $("a#example").fancybox({
                'titleShow': false,
                'transitionIn': 'elastic',
                'transitionOut': 'elastic'
            });
        });
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
            $("#form1").validate({
                rules: {
                    txt_HtmlName: { required: true, check_HtmlNameValue: true },
                    txt_Title: { required: true },
                    FileUpload1: { uploadimg_validate: true },
                    FileUpload2: { uploadimg_validate: true },
                    drpKind: { required: true, digits: true },
                    txt_Sort: { required: true, digits: true },
                    txt_AddTime: { required: true }
                },
                messages: {
                    txt_HtmlName: { required: "Html名不能为空", check_HtmlNameValue: "该名称已存在，请重新输入" },
                    txt_Title: { required: "新闻标题不能为空" },
                    FileUpload1: { uploadimg_validate: "&nbsp;&nbsp;&nbsp;&nbsp;上传照片格式为：jpg,jpeg,bmp,png,gif" },
                    FileUpload2: { uploadimg_validate: "&nbsp;&nbsp;&nbsp;&nbsp;上传照片格式为：jpg,jpeg,bmp,png,gif" },
                    drpKind: { required: "所属类型不能为空", digits: "所属类型必须为整数" },
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
    <form id="form1" enctype="multipart/form-data" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">
                <asp:Literal ID="Lit_Title" runat="server">新闻添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <%--<ul class="tab" id="tab">
                <li class="current">基本信息 </li>
                <li>新闻章节</li>
            </ul>--%>
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
                                    <span>新闻标题：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Title" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>新闻分类：</span>
                                </th>
                                <td>
                                    <asp:DropDownList runat="server" ID="drpKind" DataTextField="Name" DataValueField="ID">
                                    </asp:DropDownList>
                                    &nbsp; <em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>新闻列表图：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="lit_img_Pic" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传新闻列表图：</span>
                                </th>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="263px" />&nbsp;&nbsp;<span
                                        style="color: Blue">图片规格： 宽度：300px，高度：162px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>新闻列表图路径：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Pic" CssClass="text" runat="server"></asp:TextBox>
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
                                <td>
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
                                <td>
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
                                <td>
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
                                <td>
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
                                <td>
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
                                <th>
                                </th>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>新闻导语：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_Lead" CssClass="text" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>来源名称：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SourceName" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>来源职位：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SourePosition" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>来源图片：</span>
                                </th>
                                <td>
                                    <asp:Literal ID="txt_Pic2" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>上传来源图片：</span>
                                </th>
                                <td>
                                    <asp:FileUpload ID="FileUpload2" runat="server" Width="263px" />&nbsp;&nbsp;<span
                                        style="color: Blue">图片规格： 宽度：128px，高度：176px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>来源图路径：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SourePhone" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>来源简介：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SoureIntor" CssClass="text" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>来源连接：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_SoureLink" CssClass="text" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
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
                                    <span style="color: Blue; padding-left: 5px">只有勾选，内容才能在前台页面显示</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>详细内容：<br />
                                        <span style="color: Red">换行请按：Shift+Enter</span></span>
                                </th>
                                <td>
                                    <CKEditor:CKEditorControl runat="server" ID="txt_Content" Height="400" /><br />
                                    <span style="color: Red">最大宽度：1080px</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <%--  <div class="itemWrap">
                    <asp:HiddenField ID="hid_Count" runat="server" Value="0" />
                    <div class="addItemWrap">
                        <asp:Literal ID="Lit_NewsInfo" runat="server"></asp:Literal>
                        <a href="javascript:void(0)" onclick="AddOne(this)">添加一个新闻章节</a>
                    </div>
                </div>--%>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click"
                        OnClientClick="return CheckInfo()" />
                    <a href="News_List.aspx" class="button">返回列表</a>
                    <input type="hidden" id="hid_regCount" value="<%=Count %>" />
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $(function () {
            $("#hid_Count").val("0");
        })
        function showOr(c) {
            var id = $(c).attr("v");
            var obj = $(c).parents(".itemLabel").find(".con");
            if (obj.is(":hidden")) {
                obj.slideDown();
                $(c).text("收起");
                $("#name_" + id + "").html("");

            } else {
                obj.slideUp();
                $(c).text("展开");
                var title = $.trim($("#title_" + id + "").val());
                $("#name_" + id + "").html(title);
            }
            return;
        }

        function AddOne(obj) {
            var count = $("#hid_Count").val();
            count = parseInt(count) + 1;
            var html = template();
            html = html.replace(new RegExp("{id}", "g"), count);
            $(obj).after(html);
            var regcount = $("#hid_regCount").val();
            var newcount = parseInt(regcount) + parseInt(count);
            $("#reorder_" + count + "").html(newcount);
            $("#hid_Count").val(count);
        }

        function Delete(obj) {
            var id = $(obj).attr("v");
            $("#id_" + id + "").remove();

            var len = $(".addItemWrap .itemLabel");
            var regcount = $("#hid_regCount").val();
            var last = len.length - parseInt(regcount);
            if (len.length == 0) {
                $("#hid_Count").val(0);
            }
            else if (last == 0) {
                $("#hid_Count").val(0);
            }
        }

        //加载静态页面
        function template() {
            var content;
            $.ajax({
                type: "get",
                async: false,
                url: "/eyoung/News/news.html",
                dataType: "html",
                success: function (data) {
                    content = data;
                }
            });
            return content;
        };

        function CheckImage(obj) {
            var name = $(obj).val();
            var upload_reg = /\.(jpg|jpeg|png|gif)/i;
            if (upload_reg.test(name) == false) {
                layer.alert("图片类型只能为gif、png、jpg、jpeg");
                $(obj).val("");
            }

        }

        function CheckInfo() {
            var len = $(".addItemWrap .itemLabel");
            if (len.length == 0) {
                return true;
            }
            for (var i = 0; i < len.length; i++) {
                var item = $(len).eq(i);
                var num = $.trim($(item).find("div").eq(0).html());
                var title = $.trim($(item).find(".list").eq(1).find("input").val());
                if (title == "") {
                    layer.alert("当前标签为" + num + "的新闻章节，新闻标题为空");
                    return false;
                }
                var intor = $.trim($(item).find(".list").eq(5).find("textarea").val());
                if (intor == "") {
                    layer.alert("当前标签为" + num + "的新闻章节，详细内容为空");
                    return false;
                }
            }
        }

        function CheckSort(i) {
            var reg1 = /^\d+$/;
            var value = $(i).val().trim();
            if (isNaN(value) || reg1.test(value) == false) {
                $(i).val("0");
            }
        }

        function DeleteImage(obj) {
            $(obj).parent().prev("span").remove();
            $(obj).next("input").remove();
            $(obj).remove();
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
        
    </script>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-07-30 16:50:48 -->
