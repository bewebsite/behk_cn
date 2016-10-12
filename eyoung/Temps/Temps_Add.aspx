<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="Temps_Add.aspx.cs"
    Inherits="_eyoung_Temp_Temps_Add" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>产品模版添加</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../fancybox/jquery.fancybox-1.3.1.css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/jquery.validate.js" type="text/javascript"></script>
    <script src="../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="../fancybox/jquery.fancybox-1.3.1.pack.js"></script>
    <script src="../../ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="../../ckeditor/adapters/jquery.js" type="text/javascript"></script>
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
                        data: { action: "CheckProductHtml", Name: "/temp/" + value },
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
                    txt_StarYear: { required: true, digits: true },
                    txt_EndYear: { required: true, digits: true }
                },
                messages: {
                    txt_HtmlName: { required: "不能为空", check_HtmlNameValue: "名称已经存在" },
                    txt_CNName: { required: "不能为空" },
                    txt_ENName: { required: "不能为空" },
                    txt_StarYear: { required: "不能为空&nbsp;&nbsp;", digits: "必须为整数&nbsp;&nbsp;" },
                    txt_EndYear: { required: "不能为空", digits: "必须为整数" }
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
                <asp:Literal ID="Lit_Title" runat="server">产品模版添加</asp:Literal><em></em></span>
        </div>
        <div class="mainContent">
            <ul class="tab" id="tab">
                <li class="current">基本信息</li>
                <%--<li>广告图</li>--%>
                <li>产品图</li>
                <li>产品模块</li>
                <li>相关院校</li>
                <li>案例信息</li>
                <li>产品视频</li>
                <li>其他模块</li>
            </ul>
            <div class="editWrap">
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <th>
                                    <span>版本：</span>
                                </th>
                                <td colspan="3">
                                    <asp:DropDownList runat="server" ID="drpLan">
                                        <asp:ListItem Value="1">中文</asp:ListItem>
                                        <asp:ListItem Value="2">英文</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
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
                                    <span>产品中文名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_CNName" CssClass="text" Width="200" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                                <th>
                                    <span>产品英文名：</span>
                                </th>
                                <td>
                                    <asp:TextBox ID="txt_ENName" Width="200" CssClass="text" runat="server"></asp:TextBox>&nbsp;<em
                                        class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>适用人群年龄：</span>
                                </th>
                                <td colspan="3">
                                    从
                                    <asp:TextBox ID="txt_StarYear" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    至
                                    <asp:TextBox ID="txt_EndYear" Width="50px" CssClass="text" runat="server"></asp:TextBox>
                                    岁&nbsp;<em class="em-red">*</em>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
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
                                <td colspan="4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>适用人群介绍：</span>
                                </th>
                                <td colspan="3">
                                    <asp:TextBox Width="600" ID="txt_CategoriesInfo" CssClass="text" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>产品介绍：<br />
                                        <span style="color: Blue">换行请按：Shift+Enter</span></span>
                                </th>
                                <td colspan="3">
                                    <CKEditor:CKEditorControl runat="server" ID="txt_Intor" /><br />
                                    <span style="color: Blue">最大宽度：710px</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>预约方式介绍：<br />
                                        <span style="color: Blue">换行请按：Shift+Enter</span></span>
                                </th>
                                <td colspan="3">
                                    <CKEditor:CKEditorControl runat="server" ID="txt_RegistrationInfo" /><br />
                                    <span style="color: Blue">最大宽度：710px</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <%--<div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hid_Banner_count" Value="1" runat="server" />
                                    <div class="caseImgAdd5 clearfix">
                                        <asp:Literal ID="Lit_BannerList" runat="server"></asp:Literal>
                                        <ul class="addUl5">
                                            <li><span class="em-red">图片尺寸：宽度：260px，高度：140px</span> </li>
                                            <li>广告图片：<input name="file_Banner1" class="text" style="width: 300px;" type="file" /></li>
                                            <li>广告说明：<input name="ialt_Banner1" class="text" style="width: 300px" /></li>
                                            <li>连接地址：<input name="link_Banner1" class="text" style="width: 300px" /></li>
                                            <li>广告排序：<input name="sort_Banner1" onblur="checkproductnum(this);" style="width: 50px;"
                                                class="text" type="text" value="1" /><span style="color: Red; padding-left: 3px">排序越大越靠前</span></li>
                                            <li><a href="javascript:void(0);" onclick="addBanner(this);">[再添加一个]</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>--%>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hid_uploadfile_count" Value="1" runat="server" />
                                    <div class="caseImgAdd2 clearfix">
                                        <asp:Literal ID="lit_Image_List" runat="server"></asp:Literal>
                                        <ul class="addUl2">
                                            <li><span class="em-red">图片尺寸：宽度：1000px，高度：430px</span> </li>
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
                <div class="itemWrap" id="product">
                    <asp:HiddenField ID="Hid_ProductCount" Value="1" runat="server" />
                    <table class="input tabContent" style="display: table;">
                        <tr>
                            <th>
                                &nbsp;
                            </th>
                            <td>
                                <a href="javascript:void(0)" onclick="AddOne()">添加一个产品模块</a>
                            </td>
                        </tr>
                    </table>
                    <asp:Literal ID="Lit_ProductList" runat="server"></asp:Literal>
                </div>
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="Hid_SchoolCount" Value="1" runat="server" />
                                    <div class="caseImgAdd6 clearfix">
                                        <asp:Literal ID="Lit_SchoolList" runat="server"></asp:Literal>
                                        <ul class="addUl6">
                                            <li><span class="em-red">图片尺寸：宽度：100px，高度：100px</span> </li>
                                            <li>LOGO：<input name="file_school1" class="text" style="width: 300px;" type="file" /></li>
                                            <li>中文名称：<input name="name_school1" class="text" style="width: 300px" /></li>
                                            <li>英文名称：<input name="enname_school1" class="text" style="width: 300px" /></li>
                                            <li>连接地址：<input name="link_school1" class="text" style="width: 300px" /></li>
                                            <li>院校说明：<textarea class="text" name="intor_school1" style="height: 30px; width: 300px"></textarea></li>
                                            <li>院校排序：<input name="sort_school1" onblur="checkproductnum(this);" style="width: 50px;"
                                                class="text" type="text" value="1" /><span style="color: Red; padding-left: 3px">排序越大越靠前</span></li>
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
                                    <asp:HiddenField ID="Hid_CaseCount" Value="1" runat="server" />
                                    <div class="caseImgAdd6 clearfix">
                                        <asp:Literal ID="Lit_CaseList" runat="server"></asp:Literal>
                                        <ul class="addUl6">
                                            <li><span class="em-red">图片尺寸：宽度：128px，高度：176px</span> </li>
                                            <li>照片：<input name="file_case1" class="text" style="width: 300px;" type="file" /></li>
                                            <li>姓名：<input name="name_case1" class="text" style="width: 300px" /></li>
                                            <!-- <li>类型：<select name="type_case1"><option>成功案例</option>
                                                <option>课程感言</option>
                                                <option>其他</option>
						<option>Success Story</option>
                                            </select></li> -->
                                            <li>录取学校：<input name="school_case1" class="text" style="width: 300px" /></li>
                                            <li>详情页地址：<input name="url_case1" class="text" style="width: 300px" /></li>
                                            <li>内容：<textarea class="text" name="intor_case1" style="height: 60px; width: 300px"></textarea></li>
                                            <li>排序：<input name="sort_case1" onblur="checkproductnum(this);" style="width: 50px;"
                                                class="text" type="text" value="1" /><span style="color: Red; padding-left: 3px">排序越大越靠前</span></li>
                                            <li><a href="javascript:void(0);" onclick="addImageUpload4(this);">[再添加一个]</a></li>
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
                                            <li><span class="em-red">图片尺寸：宽度：230px，高度：124px</span> </li>
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
                <div class="itemWrap">
                    <table class="input tabContent" style="display: table;" id="other">
                        <tbody>
                            <tr>
                                <th>
                                    &nbsp;
                                </th>
                                <td>
                                    <a href="javascript:void(0)" onclick="AddOther()">添加一个</a>
                                    <asp:HiddenField ID="Hid_OtherCount" Value="0" runat="server" />
                                </td>
                            </tr>
                            <asp:Literal ID="Lit_OtherList" runat="server"></asp:Literal>
                        </tbody>
                    </table>
                </div>
                <div class="sub_btn">
                    <p class="p_error">
                    </p>
                    <asp:Button ID="But_Save" runat="server" Text="保存" CssClass="button" OnClick="But_Save_Click" />
                    <a href="Temps_List.aspx" class="button">返回列表</a>
                </div>
                <!--内容部分 E-->
            </div>
        </div>
    </div>
    <input type="hidden" id="hid_Id" value="<%=ID %>" />
    <script type="text/javascript">
        function AddOne() {
            var count = parseInt($("#Hid_ProductCount").val());
            var newcount = count + 1;
            var html = '<table class="input tabContent" style="display: table;" id="one_' + newcount + '">';
            html += '<tr><th>模块信息：</th>';
            html += '<td>排序：<input class="text" type="text" value="0" name="firstsort' + newcount + '" style="width: 50px"><span style="padding-left: 5px; color: Blue">排序越大越靠前</span>';
            html += '<br/>中文名称：<input type="text" class="text" name="onename' + newcount + '" />';
            html += '&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="AddTwo(this)" v="' + newcount + '">添加一个产品内容</a>&nbsp;&nbsp;&nbsp;&nbsp;';
            html += '<a href="javascript:void(0)" onclick="DeleteOne(this)">[ 删除此模块 ]</a><input type="hidden" id="hidone' + newcount + '" value="0" name="hidone' + newcount + '" />';
            html += '<br/>英文名称：<input type="text" class="text" name="oneenname' + newcount + '" />';
            html += '</td></tr></table>';
            $("#product").append(html);
            $("#Hid_ProductCount").val(newcount);
        }

        function DeleteOne(obj) {
            $(obj).parent().parent().parent().parent().remove();
        }

        function AddTwo(obj) {
            var id = $(obj).attr("v");
            var count = $.trim($("#hidone" + id + "").val());
            var newcount = parseInt(count) + 1;
            var html = '<tr><th></th><td>排序：<input type="text" name="twosort' + id + newcount + '" value="0" onblur="checkproductnum(this);" style="width: 50px" class="text">';
            html += '<span style="padding-left: 5px; color: Blue">排序越大越靠前</span>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="DeleteTwo(this)">删除本条明细</a><br/>';
            html += '标题：<input type="text" name="twotitle' + id + newcount + '" class="text"><br>';
            html += '明细：<textarea style="height: 40px" name="twointor' + id + newcount + '" class="text"></textarea></td></tr>';
            $("#one_" + id + " tbody").append(html);
            $("#hidone" + id + "").val(newcount);
        }

        function checkproductnum(i) {
            var reg1 = /^\d+$/;
            var value = $(i).val().trim();
            if (isNaN(value) || reg1.test(value) == false) {
                $(i).val("1");
            }
        }

        function DeleteTwo(obj) {
            $(obj).parent().parent().remove();
        }

        $(function () {
            //预览图片
            $("a#example").fancybox({
                'titleShow': false,
                'transitionIn': 'elastic',
                'transitionOut': 'elastic'
            });

            var id = $.trim($("#hid_Id").val());
            if (parseInt(id) < 1) {
                $("#Hid_Country").val("");
                $("#Hid_Business").val("");
                $("#Hid_City").val("");
                $("#Hid_Levels").val("");
                $("#Hid_Categories").val("");
                $("#Hid_ProductCount").val("0");
                $("#Hid_SchoolCount").val("1");
                $("#hid_uploadfile_count").val("1");
                $("#hid_Banner_count").val("1");
                $("#Hid_OtherCount").val("0");

            }
            else {
                var l = $("#other").find("textarea");
                for (var i = 0; i < l.length; i++) {
                    var id = $(l).eq(i).attr("id");
                    $("#" + id + "").ckeditor();
                }
            }

        });


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

        //Banner
        function addBanner(aobj) {
            var html = $(aobj).parent().parent().clone();
            if (html.find("a").text() == "[再添加一个]") {
                var count = parseInt($("#hid_Banner_count").val());
                count++;
                html.find("a").text("[删除这个]");
                $(html).html(html.html().replace("file_Banner1", "file_Banner" + count).replace("ialt_Banner1", "ialt_Banner" + count).replace("link_Banner1", "link_Banner" + count).replace("sort_Banner1", "sort_Banner" + count));
                html.appendTo($(aobj).parent().parent().parent());
                $("#hid_Banner_count").val(count);
            }
            else {
                $(aobj).parent().parent().remove();
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

        //添加上传视频控件
        function deleteUpload(obj) {
            $(obj).parent().parent().parent().remove();
        }


        //添加上传视频控件
        function addImageUpload3(aobj) {
            var html = $(aobj).parent().parent().clone();

            if (html.find("a").text() == "[再添加一个]") {
                var count = parseInt($("#Hid_SchoolCount").val());
                count++;
                html.find("a").text("[删除这个]");
                $(html).html(html.html().replace("file_school1", "file_school" + count).replace("name_school1", "name_school" + count).replace("enname_school1", "enname_school" + count).replace("link_school1", "link_school" + count).replace("intor_school1", "intor_school" + count).replace("sort_school1", "sort_school" + count));
                html.appendTo($(aobj).parent().parent().parent());
                $("#Hid_SchoolCount").val(count);
            }
            else {
                $(aobj).parent().parent().remove();
            }
        }

        function addImageUpload4(aobj) {
            var html = $(aobj).parent().parent().clone();

            if (html.find("a").text() == "[再添加一个]") {
                var count = parseInt($("#Hid_CaseCount").val());
                count++;
                html.find("a").text("[删除这个]");
                $(html).html(html.html().replace("file_case1", "file_case" + count).replace("name_case1", "name_case" + count).replace("type_case1", "type_case" + count).replace("intor_case1", "intor_case" + count).replace("sort_case1", "sort_case" + count));
                html.appendTo($(aobj).parent().parent().parent());
                $("#Hid_CaseCount").val(count);
            }
            else {
                $(aobj).parent().parent().remove();
            }
        }

        function AddOther() {
            var count = parseInt($("#Hid_OtherCount").val());
            count = count + 1;
            var html = '<tr><th>&nbsp;</th><td>中文名称：<input type="text" name="otherName' + count + '" class="text">&nbsp;&nbsp;&nbsp;&nbsp;';
            html += '<a href="javascript:void(0)" onclick="DeleteOther(this)">删除此模块</a><br/><p style="height: 8px;">&nbsp;</p>';
            html += '英文名称：<input type="text" name="otherENName' + count + '" class="text"><br/><p style="height: 8px;">&nbsp;</p>';
            html += '模块排序：<input type="text" name="otherSort' + count + '"  onblur="checkproductnum(this);" value="1" class="text" style="width:50px"><br/>';
            html += '<p style="height: 8px;">&nbsp;</p><textarea id="otherinfo' + count + '" name="otherinfo' + count + '"></textarea></td></tr>';
            $("#other").append(html);
            $("#otherinfo" + count + "").ckeditor();
            $("#Hid_OtherCount").val(count);
        }

        function DeleteOther(obj) {
            $(obj).parent().parent().remove();
        }

    </script>
    </form>
</body>
</html>
<!-- 上海弈扬文化传播有限公司版权所有，违者必究。http://www.eyoung.net 开发时间：2015-10-19 09:52:38 -->
