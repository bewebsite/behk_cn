<%@ Page Language="C#" AutoEventWireup="true" CodeFile="systemkeyword_list.aspx.cs"
    Inherits="eyoung_seo_systemkeyword_list" %>

<%@ Register Src="../ascx/header.ascx" TagName="nav" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>全文关键词列表</title>
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
            所在位置：<a href="/eyoung/">首页</a> <em class="fenge">»</em> <span class="lab">全文关键词列表<em>(共<%=AllCount %>条记录)</em></span>
        </div>
        <div class="mainContent">
            <!--内容部分 S-->
            <div class="bar clearfix">
                <a class="iconButton" href="systemkeyword_add.aspx" id="info_add" runat="server"><span
                    class="addIcon">&nbsp;</span>添加 </a>
            </div>
            <div>
                <table class="list" id="listTable">
                    <tbody>
                        <tr>
                            <th class="check">
                                <input type="checkbox" id="selectAll" onclick="select_all(this);">
                            </th>
                            <th>
                                <span>关键词</span>
                            </th>
                            <th>
                                <span>说明文字</span>
                            </th>
                            <th>
                                <span>链接地址</span>
                            </th>
                            <th>
                                <span>排序</span>
                            </th>
                            <th>
                                <span>操作</span>
                            </th>
                        </tr>
                        <asp:Repeater ID="rpList" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <input type="checkbox" value="<%# Eval("GID") %>" name="ids">
                                    </td>
                                    <td>
                                        <%# Eval("LookExpression")%>
                                    </td>
                                    <td>
                                        <%# Eval("Title")%>
                                    </td>
                                    <td>
                                        <%# Eval("Link")%>
                                    </td>
                                    <td>
                                        <%# Eval("Ordinal")%>
                                    </td>
                                    <td>
                                        <a href="systemkeyword_add.aspx?id=<%# Eval("GID") %>">编辑</a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div class="bar footer-bar clearfix">
                <div class="fl">
                    <asp:Button ID="But_Delete" runat="server" Text="删除" CssClass="button" OnClientClick="return check_post('确定要删除吗？');"
                        OnClick="But_Delete_Click" />
                </div>
            </div>
            <!--内容部分 E-->
        </div>
    </div>
    </form>
</body>
</html>
