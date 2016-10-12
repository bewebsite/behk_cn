<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminlog.aspx.cs" Inherits="eyoung_admin_adminlog" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>操作日志列表</title>
    <link rel="stylesheet" href="../css/reset.css" type="text/css" />
    <link rel="stylesheet" href="../css/common.css" type="text/css" />
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script src="../js/default.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <uc1:nav ID="nav1" runat="server" />
    <div class="mainWrap">
        <div class="smail-nav">
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">操作日志列表<em>(共<%=AllCount %>条记录)</em></span>
        </div>
        <div class="mainContent">
            <!--内容部分 S-->
            <div class="bar clearfix">
                <div class="buttonWrap">
                    <asp:DropDownList ID="drpClass" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="--操作类型--" Value=""></asp:ListItem>
                        <asp:ListItem Text="登录" Value="0"></asp:ListItem>
                        <asp:ListItem Text="添加" Value="1"></asp:ListItem>
                        <asp:ListItem Text="编辑" Value="2"></asp:ListItem>
                        <asp:ListItem Text="删除" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="drpSort" runat="server">
                        <asp:ListItem Text="--排序--" Value=""></asp:ListItem>
                        <asp:ListItem Text="添加时间由近到远" Value="0"></asp:ListItem>
                        <asp:ListItem Text="添加时间由远到近" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox runat="server" ID="searchValue" CssClass="text" placeholder="根据用户搜索"></asp:TextBox>
                    <input type="button" value="搜索" class="button" onclick="search();">
                </div>
            </div>
            <div>
                <table class="list" id="listTable">
                    <tbody>
                        <tr>
                            <th class="check">
                                <input type="checkbox" id="selectAll" onclick="select_all(this);">
                            </th>
                            <th>
                                <span>用户名</span>
                            </th>
                            <th>
                                <span>操作描述</span>
                            </th>
                            <th>
                                <span>类型</span>
                            </th>
                            <th>
                                <span>IP</span>
                            </th>
                            <th>
                                <span>添加时间</span>
                            </th>
                        </tr>
                        <asp:Repeater ID="rpList" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <input type="checkbox" value="<%# Eval("ID") %>" name="ids">
                                    </td>
                                    <td>
                                        <%# Eval("UserName")%>
                                    </td>
                                    <td>
                                        <%# Eval("ODescription")%>
                                    </td>
                                    <td>
                                        <%# getTypeName(Eval("OperationTypes"))%>
                                    </td>
                                    <td>
                                        <%# Eval("IP")%>
                                    </td>
                                    <td>
                                        <%# Eval("AddTime","{0:yyyy-MM-dd HH:mm:ss}")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div class="bar footer-bar clearfix">
                <div class="fl">
                    <asp:Button ID="But_Excel" runat="server" Text="导出Excel" CssClass="button" OnClick="but_excel_Click" />
                    <span style="color: Red">注：日志有效<asp:Literal ID="lit_day" runat="server"></asp:Literal>天</span>
                </div>
                <div class="fr">
                    <asp:DropDownList runat="server" ID="drpPage" onchange="search()">
                        <asp:ListItem Value="">每页显示</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                        <asp:ListItem Value="150">150</asp:ListItem>
                        <asp:ListItem Value="200">200</asp:ListItem>
                    </asp:DropDownList>
                    <My:AspNetPager class="pages" PageSize="20" UrlPaging="true" runat="server" ID="pgServer"
                        FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页">
                    </My:AspNetPager>
                </div>
            </div>
            <!--内容部分 E-->
        </div>
    </div>
    </form>
</body>
</html>
