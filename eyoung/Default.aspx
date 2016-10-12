<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="eyoung_Default" %>

<%@ Register Src="ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="css/reset.css" type="text/css">
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
</head>
<body>
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<span class="lab">首页</span>
        </div>
        <div class="mainContent">
            <!--内容部分 S-->
            <table class="input">
                <tbody>
                    <tr>
                        <th>
                            系统名称:
                        </th>
                        <td>
                            上海弈扬后台管理系统
                        </td>
                        <th>
                            系统版本:
                        </th>
                        <td>
                            3.0 RELEASE
                        </td>
                    </tr>
                    <tr>
                        <th>
                            官方网站:
                        </th>
                        <td>
                            <a target="_blank" href="http://www.eyoung.net">http://www.eyoung.net</a>
                        </td>
                        <th>
                            公司地址:
                        </th>
                        <td>
                            <a target="_blank" href="http://j.map.baidu.com/aNBM0">上海市吴中路1050号盛世莲花广场A幢916-918</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <th>
                            ASP.NET版本:
                        </th>
                        <td>
                           framework 4.0
                        </td>
                        <th>
                            数据库:
                        </th>
                        <td>
                            MS SQLSEVER 2005以上
                        </td>
                    </tr>
                    <tr>
                        <th>
                            操作系统名称:
                        </th>
                        <td>
                            Windows2008/2003
                        </td>
                        <th>
                            IIS:
                        </th>
                        <td>
                            6.0以上
                        </td>
                    </tr>
                </tbody>
            </table>
            <!--内容部分 E-->
        </div>
    </div>
</body>
</html>
